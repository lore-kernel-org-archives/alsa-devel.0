From: Nicole Otsuka <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Grant hw_params()
 permission to reprogram FLL
Date: Tue, 7 Jan 2014 13:57:45 +0800
Message-ID: <CAGoOwPS4S_oHUAkCieAiKG5ordwHV1pCxTb-WiR3BRCO8gbKxw@mail.gmail.com>
References: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id AF01A26164D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 06:57:45 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id u14so92688bkz.25
 for <alsa-devel@alsa-project.org>; Mon, 06 Jan 2014 21:57:45 -0800 (PST)
In-Reply-To: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ping


On Wed, Dec 25, 2013 at 6:37 PM, Nicolin Chen <Guangyu.Chen@freescale.com>wrote:

> From: Nicolin Chen <b42378@freescale.com>
>
> Previously, we couldn't use hw_params() to reclock FLL becuase there might
> be a race between two simmultaneous substreams so the FLL reprogramming
> would be changed and accordingly mulfunction. Also it wouldn't make sense
> for analogue bypass path feature of WM8962. So we adopted the DAPM way to
> control it. However, if we want to playback a different sample rate file,
> we need to wait for DAPM to change its bias_level and reconfigure FLL.
>
> After we introduced full symmetry protection in the soc-pcm, we don't need
> to worry about the race any more. And the instance by using hw_params() to
> reprogram FLL will allow us to support flexible use cases -- for example:
> 'aplay -Dhw:0 44k16bit.wav 48k24bit.wav 32k16bit.wav'.
>
> Thus this patch mainly adds FLL reprogramming code to hw_params() so as to
> enchance the sound card's capability. Meanwhile in order not to break the
> analogue bypass path feature, we make both set_bias_level() and hw_params()
> ways coexist by only reclocking FLL if requiring a different frequency and
> meanwhile not running any analogue bypass path in the background.
>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  sound/soc/fsl/imx-wm8962.c | 167
> ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 121 insertions(+), 46 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
> index 3fd76bc..9621909 100644
> --- a/sound/soc/fsl/imx-wm8962.c
> +++ b/sound/soc/fsl/imx-wm8962.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/clk.h>
>  #include <sound/soc.h>
>  #include <sound/pcm_params.h>
> @@ -35,6 +36,8 @@ struct imx_wm8962_data {
>         char platform_name[DAI_NAME_SIZE];
>         struct clk *codec_clk;
>         unsigned int clk_frequency;
> +       unsigned int fll_frequency;
> +       spinlock_t fll_lock;
>  };
>
>  struct imx_priv {
> @@ -50,15 +53,125 @@ static const struct snd_soc_dapm_widget
> imx_wm8962_dapm_widgets[] = {
>  };
>
>  static int sample_rate = 44100;
> +static unsigned int fll_frequency = 44100 * 256;
>  static snd_pcm_format_t sample_format = SNDRV_PCM_FORMAT_S16_LE;
>
> +static inline u32 imx_wm8962_calculate_fll(u32 rate, snd_pcm_format_t
> format)
> +{
> +       switch (format) {
> +       case SNDRV_PCM_FORMAT_S24_LE:
> +               return rate * 384;
> +       default:
> +               return rate * 256;
> +       }
> +}
> +
> +static int imx_wm8962_enable_fll(struct snd_soc_dai *codec_dai)
> +{
> +       struct imx_priv *priv = &card_priv;
> +       struct device *dev = &priv->pdev->dev;
> +       struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> +       u32 ret = 0;
> +
> +       spin_lock(&data->fll_lock);
> +
> +       /* Protect FLL if it has not been disabled */
> +       if (data->fll_frequency)
> +               goto err_unlock;
> +
> +       ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL, WM8962_FLL_MCLK,
> +                                 data->clk_frequency, fll_frequency);
> +       if (ret) {
> +               dev_err(dev, "failed to start FLL: %d\n", ret);
> +               goto err_unlock;
> +       }
> +
> +       ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_FLL,
> +                                    fll_frequency, SND_SOC_CLOCK_IN);
> +       if (ret)
> +               dev_err(dev, "failed to set SYSCLK: %d\n", ret);
> +
> +       data->fll_frequency = fll_frequency;
> +
> +err_unlock:
> +       spin_unlock(&data->fll_lock);
> +
> +       return ret;
> +}
> +
> +static int imx_wm8962_disable_fll(struct snd_soc_dai *codec_dai)
> +{
> +       struct imx_priv *priv = &card_priv;
> +       struct device *dev = &priv->pdev->dev;
> +       struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> +       int ret = 0;
> +
> +       spin_lock(&data->fll_lock);
> +
> +       if (!data->fll_frequency)
> +               goto err_unlock;
> +
> +       /* Switch to MCLK as sysclk once so as to disable FLL */
> +       ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
> +                                    0, SND_SOC_CLOCK_IN);
> +       if (ret) {
> +               dev_err(dev, "failed to switch away from FLL: %d\n", ret);
> +               goto err_unlock;
> +       }
> +
> +       /* Disable FLL so that we can reset its output freq later */
> +       ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
> +                                 WM8962_FLL_MCLK, 0, 0);
> +       if (ret)
> +               dev_err(dev, "failed to stop FLL: %d\n", ret);
> +
> +       data->fll_frequency = 0;
> +
> +err_unlock:
> +       spin_unlock(&data->fll_lock);
> +
> +       return ret;
> +}
> +
> +static int imx_wm8962_reprogram_fll(struct snd_pcm_substream *substream)
> +{
> +       struct imx_priv *priv = &card_priv;
> +       struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +       struct snd_soc_codec *codec = rtd->codec;
> +       u32 mask, ret = 0;
> +
> +       mask = WM8962_MIXINL_TO_HPMIXL_MASK | WM8962_MIXINR_TO_HPMIXL_MASK
> |
> +               WM8962_IN4L_TO_HPMIXL_MASK | WM8962_IN4R_TO_HPMIXL_MASK;
> +       ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_1) & mask;
> +       ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_2) & mask;
> +       ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_1) & mask;
> +       ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_2) & mask;
> +
> +       spin_lock(&data->fll_lock);
> +       /* Do not reprogram FLL if not changed or running analogue bypass
> */
> +       if (fll_frequency == data->fll_frequency || ret) {
> +               spin_unlock(&data->fll_lock);
> +               return 0;
> +       }
> +       spin_unlock(&data->fll_lock);
> +
> +       ret = imx_wm8962_disable_fll(codec_dai);
> +       if (ret)
> +               return ret;
> +
> +       return imx_wm8962_enable_fll(codec_dai);
> +}
> +
>  static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
>                 struct snd_pcm_hw_params *params)
>  {
>         sample_rate = params_rate(params);
>         sample_format = params_format(params);
> +       fll_frequency = imx_wm8962_calculate_fll(sample_rate,
> sample_format);
>
> -       return 0;
> +       return imx_wm8962_reprogram_fll(substream);
>  }
>
>  static struct snd_soc_ops imx_hifi_ops = {
> @@ -70,60 +183,19 @@ static int imx_wm8962_set_bias_level(struct
> snd_soc_card *card,
>                                         enum snd_soc_bias_level level)
>  {
>         struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
> -       struct imx_priv *priv = &card_priv;
> -       struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> -       struct device *dev = &priv->pdev->dev;
> -       unsigned int pll_out;
> -       int ret;
>
>         if (dapm->dev != codec_dai->dev)
>                 return 0;
>
>         switch (level) {
>         case SND_SOC_BIAS_PREPARE:
> -               if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
> -                       if (sample_format == SNDRV_PCM_FORMAT_S24_LE)
> -                               pll_out = sample_rate * 384;
> -                       else
> -                               pll_out = sample_rate * 256;
> -
> -                       ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
> -                                       WM8962_FLL_MCLK,
> data->clk_frequency,
> -                                       pll_out);
> -                       if (ret < 0) {
> -                               dev_err(dev, "failed to start FLL: %d\n",
> ret);
> -                               return ret;
> -                       }
> -
> -                       ret = snd_soc_dai_set_sysclk(codec_dai,
> -                                       WM8962_SYSCLK_FLL, pll_out,
> -                                       SND_SOC_CLOCK_IN);
> -                       if (ret < 0) {
> -                               dev_err(dev, "failed to set SYSCLK: %d\n",
> ret);
> -                               return ret;
> -                       }
> -               }
> +               if (dapm->bias_level == SND_SOC_BIAS_STANDBY)
> +                       return imx_wm8962_enable_fll(codec_dai);
>                 break;
>
>         case SND_SOC_BIAS_STANDBY:
> -               if (dapm->bias_level == SND_SOC_BIAS_PREPARE) {
> -                       ret = snd_soc_dai_set_sysclk(codec_dai,
> -                                       WM8962_SYSCLK_MCLK,
> data->clk_frequency,
> -                                       SND_SOC_CLOCK_IN);
> -                       if (ret < 0) {
> -                               dev_err(dev,
> -                                       "failed to switch away from FLL:
> %d\n",
> -                                       ret);
> -                               return ret;
> -                       }
> -
> -                       ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
> -                                       0, 0, 0);
> -                       if (ret < 0) {
> -                               dev_err(dev, "failed to stop FLL: %d\n",
> ret);
> -                               return ret;
> -                       }
> -               }
> +               if (dapm->bias_level == SND_SOC_BIAS_PREPARE)
> +                       return imx_wm8962_disable_fll(codec_dai);
>                 break;
>
>         default:
> @@ -225,6 +297,9 @@ static int imx_wm8962_probe(struct platform_device
> *pdev)
>                 goto fail;
>         }
>
> +       data->fll_frequency = 0;
> +       spin_lock_init(&data->fll_lock);
> +
>         data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>         if (IS_ERR(data->codec_clk)) {
>                 ret = PTR_ERR(data->codec_clk);
> --
> 1.8.4
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
