From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: DSD native format on SoC
Date: Tue, 21 Mar 2017 12:29:13 +0100
Message-ID: <CAOf5uw=SkgOfnJsK3s=aA0CWLsLvRB=zU9eMjVf7q29K4CfDHw@mail.gmail.com>
References: <2e1612da-b0cd-9468-a723-63d57ed6c775@melcoinc.co.jp>
 <4d015652-e002-b4f1-49f3-71829b725ab7@melcoinc.co.jp>
 <20170318111410.GA4442@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A146266D5E
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 12:29:14 +0100 (CET)
Received: by mail-it0-f49.google.com with SMTP id y18so1593614itc.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 04:29:14 -0700 (PDT)
In-Reply-To: <20170318111410.GA4442@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naoki Matsumoto <n-matsumoto@melcoinc.co.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mail google <adamo.a60@gmail.com>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <zonque@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi


On Sat, Mar 18, 2017 at 12:14 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi all
>
> On Mon, Mar 13, 2017 at 05:42:43PM +0900, Naoki Matsumoto wrote:
>> Retry send because alsa-dev ML doesn't delivery yet.
>>
>> -------- Original Message --------
>> From: Naoki Matsumoto
>> Sent: Monday, Mar 13, 2017 10:39 AM GMT+0900
>> To: michael@amarulasolutions.com
>> Cc: alsa-devel@alsa-project.org
>> Subject: DSD native format on SoC
>>
>> Hello
>>
>> I know only xmos-native-dsd(DSD_U32_BE).
>> I'll share what I know.
>> I know information about DSD only fragmentally...
>>
>
> Problem here is SoC subsytem for me
>
> https://github.com/zonque/alsa-dsd-player.git
>
> Cannot set sample format tyring U16_LE DSD. I have changed a bit the core
> and some components but seems that does not go in.
>
> Any idea?


After dig a bit more with strace and fix a typo here, look like that
available formats are not pass up to the alsa lib. So alsa lib fail
without even try to go there when it sets format. Can someone suggest
how to debug in a good way this scenario?

Michael



>
> diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
> index cc34b16..0dea529 100644
> --- a/sound/soc/codecs/pcm179x.c
> +++ b/sound/soc/codecs/pcm179x.c
> @@ -89,18 +89,19 @@ static int pcm179x_startup(struct snd_pcm_substream *substream,
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> -       u64 formats = PCM1792A_FORMATS;
> +       u64 formats = PCM1795_FORMATS;
>
>         switch (priv->codec_model) {
> -       case PCM1795:
> -               formats = PCM1795_FORMATS;
> +       case PCM1792A:
> +               formats = PCM1792A_FORMATS;
>                 break;
>         default:
>                 break;
>         }
>
> -       snd_pcm_hw_constraint_mask64(substream->runtime,
> -                                    SNDRV_PCM_HW_PARAM_FORMAT, formats);
> +       if (formats != PCM1795_FORMATS)
> +               snd_pcm_hw_constraint_mask64(substream->runtime,
> +                                            SNDRV_PCM_HW_PARAM_FORMAT, formats);
>
>         msleep(50);
>         return 0;
> @@ -227,7 +228,7 @@ static struct snd_soc_dai_driver pcm179x_dai = {
>                 .rates = SNDRV_PCM_RATE_CONTINUOUS,
>                 .rate_min = 10000,
>                 .rate_max = 200000,
> -               .formats = PCM179X_FORMATS, },
> +               .formats = PCM1795_FORMATS, },
>         .ops = &pcm179x_dai_ops,
>  };
>
> @@ -252,9 +253,9 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
>  };
>
>  const struct of_device_id pcm179x_of_match[] = {
> -       { .compatible = "ti,pcm1792a", },
> -       { .compatible = "ti,pcm1795", .data = (void *)PCM1795, },
> -       { .compatible = "ti,pcm1796", },
> +       { .compatible = "ti,pcm1792a", .data = (void *)PCM1792A },
> +       { .compatible = "ti,pcm1795", },
> +       { .compatible = "ti,pcm1796", .data = (void *)PCM1792A },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
> index 4c00047..0665ec8 100644
> --- a/sound/soc/codecs/pcm179x.h
> +++ b/sound/soc/codecs/pcm179x.h
> @@ -22,7 +22,8 @@
>
>  #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
>
> -#define PCM1795_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE)
> +#define PCM1795_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
> +                        SNDRV_PCM_FMTBIT_DSD_U16_LE)
>
>  extern const struct regmap_config pcm179x_regmap_config;
>  extern const struct of_device_id pcm179x_of_match[];
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index c55cbfa..d3afa89 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -55,7 +55,7 @@ config SND_SOC_ROCHCHIP_DACMAX
>         tristate "SoC Audio support for DACMAX boards using a pcm1792 codec"
>         depends on SND_SOC_ROCKCHIP && SPI && GPIOLIB
>         select SND_SOC_ROCKCHIP_I2S
> -       select SND_SOC_PCM179X
> +       select SND_SOC_PCM179X_SPI
>         help
>           Say Y or M here if you want to add support for SoC audio on Dacmax
>           boards using the pcm1792a codec.
> diff --git a/sound/soc/rockchip/dacmax.c b/sound/soc/rockchip/dacmax.c
> index fb302a8..fa79549 100644
> --- a/sound/soc/rockchip/dacmax.c
> +++ b/sound/soc/rockchip/dacmax.c
> @@ -22,6 +22,7 @@
>   *
>   */
>
> +#define DEBUG
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> @@ -39,6 +40,7 @@
>  #define CLK1   (1 << 1)
>  #define CLK0   (1 << 2)
>  #define W32    (1 << 3)
> +#define DSD_EN (1 << 4)
>
>  #define DAI_NAME_SIZE  32
>
> @@ -52,6 +54,7 @@ struct dacmax_data {
>         int clk_1;
>         int clk_2;
>         int w32;
> +       int dsd_enable;
>  };
>
>  static const struct snd_soc_dapm_widget dacmax_dapm_widgets[] = {
> @@ -78,6 +81,10 @@ static void dacmax_change_freq(struct dacmax_data *data, u8 mask)
>         gpio_set_value(data->w32, value);
>         pr_debug("%s: BITSXWORD(%d)\n", __func__, value);
>
> +       value = (mask & DSD_EN) ? 1 : 0;
> +       gpio_set_value(data->dsd_enable, value);
> +       pr_debug("%s: DSD ENABLE (%d)\n", __func__, value);
> +
>         mdelay(20);
>  }
>
> @@ -91,6 +98,7 @@ static int dacmax_ext_clock_update(struct dacmax_data *data,
>                 params_format(params));
>
>         switch (params_format(params)) {
> +       case SNDRV_PCM_FORMAT_DSD_U16_LE:
>         case SNDRV_PCM_FORMAT_S16_LE:
>                 break;
>         case SNDRV_PCM_FORMAT_S24_LE:
> @@ -103,6 +111,8 @@ static int dacmax_ext_clock_update(struct dacmax_data *data,
>         }
>
>         switch (params_rate(params)) {
> +       case 2822400:
> +               mask |= DSD_EN;
>         case 44100:
>                 break;
>         case 48000:
> @@ -251,6 +261,7 @@ static int dacmax_probe(struct platform_device *pdev)
>         data->clk_1 = clk_1;
>         data->clk_2 = clk_2;
>         data->w32 = w32;
> +       data->dsd_enable = dsd_enable;
>
>         ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
>         if (ret) {
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index 68fea0a..67fd6ec 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -302,6 +302,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
>         case SNDRV_PCM_FORMAT_S8:
>                 val |= I2S_TXCR_VDW(8);
>                 break;
> +       case SNDRV_PCM_FORMAT_DSD_U16_LE:
>         case SNDRV_PCM_FORMAT_S16_LE:
>                 val |= I2S_TXCR_VDW(16);
>                 break;
> @@ -457,7 +458,8 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
>                             SNDRV_PCM_FMTBIT_S16_LE |
>                             SNDRV_PCM_FMTBIT_S20_3LE |
>                             SNDRV_PCM_FMTBIT_S24_LE |
> -                           SNDRV_PCM_FMTBIT_S32_LE),
> +                           SNDRV_PCM_FMTBIT_S32_LE |
> +                           SNDRV_PCM_FMTBIT_DSD_U16_LE),
>         },
>         .capture = {
>                 .stream_name = "Capture",
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a1305f8..1ae0aea 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2980,6 +2980,7 @@ static u64 codec_format_map[] = {
>         SNDRV_PCM_FMTBIT_U18_3LE | SNDRV_PCM_FMTBIT_U18_3BE,
>         SNDRV_PCM_FMTBIT_FLOAT_LE | SNDRV_PCM_FMTBIT_FLOAT_BE,
>         SNDRV_PCM_FMTBIT_FLOAT64_LE | SNDRV_PCM_FMTBIT_FLOAT64_BE,
> +       SNDRV_PCM_FORMAT_DSD_U16_LE | SNDRV_PCM_FORMAT_DSD_U16_BE,
>         SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
>         | SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE,
>  };
>> on Wed, 8 Mar 2017 08:21:23 +0100, Michael Nazzareno Trimarchi wrote:
>> DSD is a continuous stream of bits that flows over two separate
>> channels, left and right, synchronized by a clock, while I2S is a
>> single data wire and an additional wire that states if the incoming
>> sample refers to the left channel or the right channel. There is no
>> way to get DSD data other than a circuit which decode DSD streams
>> coming directly from a conventional source, like, for examples, a
>> SACD.
>>
>> The Volta dac has an internal decoding circuitry that still employs
>> the I2S standard as a usual 44100Hz/16 bits, but sourcing the shift
>> clock at twice the DSD standard frequency of 2.8224MHz, since it has
>> to split two the16 bits words received on a single wire into the two
>> DSD channels, as the standard wants.
>>
>> When DSD is enabled, the control signal PCD/DSD must be high, CK3..CK0
>> must be all low. The I2S interface works as a standard 44100Hz/16 bit
>> and the DSD streaming must be packed into 16 bits lenght words
>> left/right as per LRCK logic. The BCLK frequency supplied from the
>> interface is 5644800Hz in case of DSD and 11289600 for DSD2.
>> I don't know your device.
>> but I've understood that it's device layer implantation topic.
>> I think that your sound device need to support SND_PCM_FORMAT_DSD_*.
>>
>> Refer:enum snd_pcm_format_t
>> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html
>>
>> If you use xmos-natvie-dsd, the implement is linux.git/sound/usb/quirks.c
>>
>> Can you explain how now DSD can be pass to audio card? The idea is to
>> declare it on the audio card and then configure it as a PCM card but I
>> don't know how data are suppose to arrive from alsa userspace.
>> I know DSD playback on sound device that xmos.
>> Have you checked this page?
>> https://github.com/lintweaker/xmos-native-dsd
>>
>> As alsa-lib
>> 1. snd_pcm_open
>> e.g, USB sound device. In your case, soc internal sound device
>> 2. snd_ocm_hw_params_set_format
>> e.g, SND_PCM_FORMAT_DSD_U32_BE
>> 3. snd_pcm_writei
>>
>> Other elements
>> * DSD decoder(e.g,dsf/dsdiff)
>> * Player
>> if you use xmos-native-dsd(DSD_U32_BE) device, we can use MPD Ver0.20.2+
>> I don't know other DSD pcm_formats.
>>
>> Just information. It may be wrong.
>> Thank you
>>
>>
>> --
>> **********************************************
>> Naoki MATSUMOTO
>> Email:n-matsumoto@melcoinc.co.jp
>> Tel  :050-5830-8916
>> **********************************************
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
