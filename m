From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Report error code when failing to
 add controls
Date: Tue, 21 Sep 2010 14:06:43 +0100
Message-ID: <1285074403.3089.41.camel@odin>
References: <1285006551-24084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1848610388C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:06:48 +0200 (CEST)
Received: by wwb28 with SMTP id 28so5393074wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 06:06:47 -0700 (PDT)
In-Reply-To: <1285006551-24084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-20 at 19:15 +0100, Mark Brown wrote:
> Helps with diagnostics.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 8d8c5cd..7c64e03 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1983,8 +1983,8 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
>  		const struct snd_kcontrol_new *control = &controls[i];
>  		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
>  		if (err < 0) {
> -			dev_err(codec->dev, "%s: Failed to add %s\n",
> -				codec->name, control->name);
> +			dev_err(codec->dev, "%s: Failed to add %s: %d\n",
> +				codec->name, control->name, err);
>  			return err;
>  		}
>  	}

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
