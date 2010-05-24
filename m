From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix uninitialised variable in
 siu_dai.c
Date: Mon, 24 May 2010 11:42:31 +0100
Message-ID: <1274697751.3064.87.camel@odin>
References: <Pine.LNX.4.64.1005241051190.2611@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B4F87245E0
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 12:42:35 +0200 (CEST)
Received: by wyj26 with SMTP id 26so1477452wyj.38
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 03:42:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1005241051190.2611@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-24 at 10:55 +0200, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Strangely, the compiler doesn't warn about this one, but I really don't 
> see how this can be correct. Am I being blind?

No, I think the compiler is at fault here.

> 
>  sound/soc/sh/siu_dai.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
> index d86ee1b..eeed5ed 100644
> --- a/sound/soc/sh/siu_dai.c
> +++ b/sound/soc/sh/siu_dai.c
> @@ -588,6 +588,8 @@ static int siu_dai_prepare(struct snd_pcm_substream *substream,
>  		ret = siu_dai_spbstart(port_info);
>  		if (ret < 0)
>  			goto fail;
> +	} else {
> +		ret = 0;
>  	}
>  
>  	port_info->play_cap |= self;

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
