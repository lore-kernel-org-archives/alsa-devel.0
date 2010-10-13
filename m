From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add WM8962 microphone bias control
Date: Wed, 13 Oct 2010 10:30:04 +0100
Message-ID: <1286962204.3282.26.camel@odin>
References: <1286908637-10424-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A66B4243AA
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:30:08 +0200 (CEST)
Received: by wwb28 with SMTP id 28so4937892wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 02:30:08 -0700 (PDT)
In-Reply-To: <1286908637-10424-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2010-10-12 at 19:37 +0100, Mark Brown wrote:
> We unconditionally require SYSCLK since while only microphone detection
> specifically requires SYSCLK any actual use case would enable it via
> some other means but microphone detection may have nothing active other
> than the bias itself.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index e5009d0..894d0cd 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2566,6 +2566,8 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
>  	{ "MIXINR", "IN3R Switch", "IN3R" },
>  	{ "MIXINR", "PGA Switch", "INPGAR" },
>  
> +	{ "MICBIAS", NULL, "SYSCLK" },
> +
>  	{ "ADCL", NULL, "SYSCLK" },
>  	{ "ADCL", NULL, "TOCLK" },
>  	{ "ADCL", NULL, "MIXINL" },

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
