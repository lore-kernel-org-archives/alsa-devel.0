From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Fix locking of core
Date: Sun, 20 Oct 2013 11:22:58 -0700
Message-ID: <CAHQ1cqGBW1==EDC6pxT8ZtZ5WYird-iW4r_H2UE_WJ8s382_Aw@mail.gmail.com>
References: <1382289308-12733-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 96771261717
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 20:22:59 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id lf10so3807319pab.34
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 11:22:58 -0700 (PDT)
In-Reply-To: <1382289308-12733-1-git-send-email-broonie@kernel.org>
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

On Sun, Oct 20, 2013 at 10:15 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The conversion of the si476x to regmap removed locking of the core during
> register updates, allowing things like power state changes for the MFD to
> happen during a register update. Avoid this by taking the core lock in the
> DAI operations (which are the only things that do register updates) as we
> used to do in the open coded register I/O functions.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Looks good to me, thanks for doing the work!

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>




> ---
>  sound/soc/codecs/si476x.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
> index 03645ce..52e7cb0 100644
> --- a/sound/soc/codecs/si476x.c
> +++ b/sound/soc/codecs/si476x.c
> @@ -73,6 +73,7 @@ static const struct snd_soc_dapm_route si476x_dapm_routes[] = {
>  static int si476x_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
>                                     unsigned int fmt)
>  {
> +       struct si476x_core *core = i2c_mfd_cell_to_core(codec_dai->dev);
>         int err;
>         u16 format = 0;
>
> @@ -136,9 +137,14 @@ static int si476x_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
>                 return -EINVAL;
>         }
>
> +       si476x_core_lock(core);
> +
>         err = snd_soc_update_bits(codec_dai->codec, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
>                                   SI476X_DIGITAL_IO_OUTPUT_FORMAT_MASK,
>                                   format);
> +
> +       si476x_core_unlock(core);
> +
>         if (err < 0) {
>                 dev_err(codec_dai->codec->dev, "Failed to set output format\n");
>                 return err;
> @@ -151,6 +157,7 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
>                                   struct snd_pcm_hw_params *params,
>                                   struct snd_soc_dai *dai)
>  {
> +       struct si476x_core *core = i2c_mfd_cell_to_core(dai->dev);
>         int rate, width, err;
>
>         rate = params_rate(params);
> @@ -176,11 +183,13 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
>                 return -EINVAL;
>         }
>
> +       si476x_core_lock(core);
> +
>         err = snd_soc_write(dai->codec, SI476X_DIGITAL_IO_OUTPUT_SAMPLE_RATE,
>                             rate);
>         if (err < 0) {
>                 dev_err(dai->codec->dev, "Failed to set sample rate\n");
> -               return err;
> +               goto out;
>         }
>
>         err = snd_soc_update_bits(dai->codec, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
> @@ -189,10 +198,13 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
>                                   (width << SI476X_DIGITAL_IO_SAMPLE_SIZE_SHIFT));
>         if (err < 0) {
>                 dev_err(dai->codec->dev, "Failed to set output width\n");
> -               return err;
> +               goto out;
>         }
>
> -       return 0;
> +out:
> +       si476x_core_unlock(core);
> +
> +       return err;
>  }
>
>  static int si476x_codec_probe(struct snd_soc_codec *codec)
> --
> 1.8.4.rc3
>
