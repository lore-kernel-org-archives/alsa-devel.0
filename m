From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix merge issue with WM8962 control
 addition
Date: Tue, 21 Sep 2010 14:06:52 +0100
Message-ID: <1285074412.3089.42.camel@odin>
References: <1285007250-28565-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 210341038AE
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:06:57 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 28so5393074wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 06:06:57 -0700 (PDT)
In-Reply-To: <1285007250-28565-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-20 at 19:27 +0100, Mark Brown wrote:
> Let's not add the core controls twice.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 28adc6c..c4deea1 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -1845,8 +1845,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
>  	wm8962->reg_cache[WM8962_HPOUTL_VOLUME] |= WM8962_HPOUT_VU;
>  	wm8962->reg_cache[WM8962_HPOUTR_VOLUME] |= WM8962_HPOUT_VU;
>  
> -	snd_soc_add_controls(codec, wm8962_snd_controls,
> -			     ARRAY_SIZE(wm8962_snd_controls));
>  	wm8962_add_widgets(codec);
>  
>  	wm8962_init_beep(codec);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
