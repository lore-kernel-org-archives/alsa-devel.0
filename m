From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix multi-component mismerge in
 WM8523
Date: Mon, 22 Nov 2010 19:21:37 +0000
Message-ID: <1290453697.3309.83.camel@odin>
References: <1290453176-21019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id A71D3243E9
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 20:21:44 +0100 (CET)
Received: by ewy2 with SMTP id 2so4082397ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 11:21:44 -0800 (PST)
In-Reply-To: <1290453176-21019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-11-22 at 19:12 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8523.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
> index d331888..bf44ec7 100644
> --- a/sound/soc/codecs/wm8523.c
> +++ b/sound/soc/codecs/wm8523.c
> @@ -147,7 +147,6 @@ static int wm8523_startup(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> -	return 0;
>  	snd_pcm_hw_constraint_list(substream->runtime, 0,
>  				   SNDRV_PCM_HW_PARAM_RATE,
>  				   &wm8523->rate_constraint);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
