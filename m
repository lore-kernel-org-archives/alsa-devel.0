From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 12:33:33 -0700
Message-ID: <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B8612261A90
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 21:33:34 +0200 (CEST)
Received: by mail-pb0-f52.google.com with SMTP id wz12so1557011pbc.11
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:33:33 -0700 (PDT)
In-Reply-To: <1380220461-16359-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 26, 2013 at 11:34 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The current si476x I/O implementation wraps the regmap for the core with
> functions that make the register map cache only when the device is powered
> down. This implementation appears to be incomplete since there is no code
> to synchronise the cache so writes done while the core is powered down
> will be ignored, the device will only be configured if it is powered.

I wouldn't be surprised if I messed up that part of the code since the
HW that I used to have to test it didn't actually use the codec
driver(I initially developed the driver on a different HW that did use
the driver but after some time I lost my access to that particular HW)

>
> A better and more idiomatic approach would be to have the MFD manage the
> cache, making the device cache only when it powers things down. This also
> allows ASoC to use the standard regmap helpers for the device which helps

Correct me if my understanding is wrong but using standard helper
function would mean using hw_write and hw_read from soc-io.c. Looking
at the source code of those functions I don't believe the are
performing any sort of locking(once again I may be wrong) and rely on
regmap_* implementation to do it internally. With si476x driver it is
not the case and it is important that codec write/read functions
perform si476x_core_lock(core) before they call regmap functions. If
that is not done it is possible to wreak havoc on I2C bus by trying to
access the registers of the codec and doing some V4L2 operations on
the corresponding radio device.

Although I completely agree that cache managing should be moved to MFD.


> remove the ASoC custom ones so do convert to do that.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/si476x.c | 46 +---------------------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)
>
> diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
> index 38f3b10..ec29d26 100644
> --- a/sound/soc/codecs/si476x.c
> +++ b/sound/soc/codecs/si476x.c
> @@ -60,48 +60,6 @@ enum si476x_pcm_format {
>         SI476X_PCM_FORMAT_S24_LE        = 6,
>  };
>
> -static unsigned int si476x_codec_read(struct snd_soc_codec *codec,
> -                                     unsigned int reg)
> -{
> -       int err;
> -       unsigned int val;
> -       struct si476x_core *core = codec->control_data;
> -
> -       si476x_core_lock(core);
> -       if (!si476x_core_is_powered_up(core))
> -               regcache_cache_only(core->regmap, true);
> -
> -       err = regmap_read(core->regmap, reg, &val);
> -
> -       if (!si476x_core_is_powered_up(core))
> -               regcache_cache_only(core->regmap, false);
> -       si476x_core_unlock(core);
> -
> -       if (err < 0)
> -               return err;
> -
> -       return val;
> -}
> -
> -static int si476x_codec_write(struct snd_soc_codec *codec,
> -                             unsigned int reg, unsigned int val)
> -{
> -       int err;
> -       struct si476x_core *core = codec->control_data;
> -
> -       si476x_core_lock(core);
> -       if (!si476x_core_is_powered_up(core))
> -               regcache_cache_only(core->regmap, true);
> -
> -       err = regmap_write(core->regmap, reg, val);
> -
> -       if (!si476x_core_is_powered_up(core))
> -               regcache_cache_only(core->regmap, false);
> -       si476x_core_unlock(core);
> -
> -       return err;
> -}
> -
>  static const struct snd_soc_dapm_widget si476x_dapm_widgets[] = {
>  SND_SOC_DAPM_OUTPUT("LOUT"),
>  SND_SOC_DAPM_OUTPUT("ROUT"),
> @@ -239,7 +197,7 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
>
>  static int si476x_codec_probe(struct snd_soc_codec *codec)
>  {
> -       codec->control_data = i2c_mfd_cell_to_core(codec->dev);
> +       codec->control_data = dev_get_regmap(codec->dev.parent);
>         return 0;
>  }
>
> @@ -268,8 +226,6 @@ static struct snd_soc_dai_driver si476x_dai = {
>
>  static struct snd_soc_codec_driver soc_codec_dev_si476x = {
>         .probe  = si476x_codec_probe,
> -       .read   = si476x_codec_read,
> -       .write  = si476x_codec_write,
>         .dapm_widgets = si476x_dapm_widgets,
>         .num_dapm_widgets = ARRAY_SIZE(si476x_dapm_widgets),
>         .dapm_routes = si476x_dapm_routes,
> --
> 1.8.4.rc3
>
