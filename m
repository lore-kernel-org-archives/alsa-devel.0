From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Return -1 instead of -EINVAL to
 ensure consistency
Date: Wed, 22 Sep 2010 09:54:41 +0100
Message-ID: <1285145681.3107.5.camel@odin>
References: <1285085047-31508-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0627910380D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 10:54:43 +0200 (CEST)
Received: by wyb32 with SMTP id 32so258611wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 01:54:43 -0700 (PDT)
In-Reply-To: <1285085047-31508-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-21 at 17:04 +0100, Dimitris Papastamos wrote:
> The code can't really cope with I/O errors, so it would be better
> to be consistent throughout all cache functions and return -1 instead
> of -EINVAL.
> 
> The return value of snd_soc_read(...) is mostly checked in the probe
> function and nowhere else.
> ---
>  sound/soc/soc-cache.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 28bf1ff..6702a3d 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -228,7 +228,7 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
>  	if (reg >= codec->driver->reg_cache_size ||
>  	    snd_soc_codec_volatile_register(codec, reg)) {
>  		if (codec->cache_only)
> -			return -EINVAL;
> +			return -1;
>  
>  		return codec->hw_read(codec, reg);
>  	} else {
> @@ -455,7 +455,7 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
>  	if (reg >= codec->driver->reg_cache_size ||
>  	    snd_soc_codec_volatile_register(codec, reg)) {
>  		if (codec->cache_only)
> -			return -EINVAL;
> +			return -1;
>  
>  		return codec->hw_read(codec, reg);
>  	}

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
