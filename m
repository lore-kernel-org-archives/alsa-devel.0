From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCHv2 05/11] ASoc: si476x: Remove the
 set_cache_io() entirely from ASoC probe.
Date: Thu, 27 Mar 2014 07:41:52 -0700
Message-ID: <CAHQ1cqGpnrLu1Uanv8s1PR1Lk_zoMqwvtCxQ_cw0Rvs=pQXhrg@mail.gmail.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
 <1395812433-26410-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 5007A26179B
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 15:41:54 +0100 (CET)
Received: by mail-pd0-f178.google.com with SMTP id x10so3477224pdj.9
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 07:41:52 -0700 (PDT)
In-Reply-To: <1395812433-26410-6-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shc_work@mail.ru, tiwai@suse.de, viresh.kumar@linaro.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, vinod.koul@intel.com, Mark Brown <broonie@kernel.org>, akpm@linux-foundation.org, s.trumtrar@pengutronix.de, rf@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 25, 2014 at 10:40 PM, Xiubo Li <Li.Xiubo@freescale.com> wrote:
> As we can set the CODEC I/O while snd_soc_register_codec(), so the
> calling of set_cache_io() from CODEC ASoC probe could be removed
> entirely.
>
> And then we can set the CODEC I/O in the device probe instead of
> CODEC ASoC probe as earily as possible.
>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/codecs/si476x.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
> index 244c097..961b7e8 100644
> --- a/sound/soc/codecs/si476x.c
> +++ b/sound/soc/codecs/si476x.c
> @@ -208,13 +208,6 @@ out:
>         return err;
>  }
>
> -static int si476x_codec_probe(struct snd_soc_codec *codec)
> -{
> -       struct regmap *regmap = dev_get_regmap(codec->dev->parent, NULL);
> -
> -       return snd_soc_codec_set_cache_io(codec, regmap);
> -}
> -
>  static struct snd_soc_dai_ops si476x_dai_ops = {
>         .hw_params      = si476x_codec_hw_params,
>         .set_fmt        = si476x_codec_set_dai_fmt,
> @@ -238,8 +231,13 @@ static struct snd_soc_dai_driver si476x_dai = {
>         .ops            = &si476x_dai_ops,
>  };
>
> +struct regmap *si476x_get_regmap(struct device *dev)
> +{
> +       return dev_get_regmap(dev->parent, NULL);
> +}
> +
>  static struct snd_soc_codec_driver soc_codec_dev_si476x = {
> -       .probe  = si476x_codec_probe,
> +       .get_regmap = si476x_get_regmap,
>         .dapm_widgets = si476x_dapm_widgets,
>         .num_dapm_widgets = ARRAY_SIZE(si476x_dapm_widgets),
>         .dapm_routes = si476x_dapm_routes,
> --
> 1.8.4
>
>

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
