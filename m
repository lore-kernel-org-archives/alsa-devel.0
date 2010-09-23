From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix incorrect parameter to
 snd_soc_codec_volatile_register
Date: Thu, 23 Sep 2010 18:36:52 +0100
Message-ID: <1285263412.3090.169.camel@odin>
References: <1285168566-20226-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id DF72C244B1
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 19:37:08 +0200 (CEST)
Received: by wyb32 with SMTP id 32so21263wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 10:37:07 -0700 (PDT)
In-Reply-To: <1285168566-20226-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Wed, 2010-09-22 at 16:16 +0100, Dimitris Papastamos wrote:
> We need to pass the register index and not the register value.
> This patch depends on my previous patch "ASoC: Delegate to hw
> specific read for volatile registers".
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 5d9d2f8..3e4680b 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -177,7 +177,7 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
>  	data[0] = reg;
>  	data[1] = value & 0xff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, value) &&
> +	if (!snd_soc_codec_volatile_register(codec, reg) &&
>  		reg < codec->driver->reg_cache_size)
>  			cache[reg] = value;
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
