From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Ensure consistent cache
	naming
Date: Mon, 29 Nov 2010 11:20:16 +0000
Message-ID: <1291029616.3299.152.camel@odin>
References: <1291028068-25461-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8A210382C
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 12:20:21 +0100 (CET)
Received: by wwe15 with SMTP id 15so4437481wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 03:20:21 -0800 (PST)
In-Reply-To: <1291028068-25461-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Mon, 2010-11-29 at 10:54 +0000, Dimitris Papastamos wrote:
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h   |    2 +-
>  sound/soc/soc-cache.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 3eb92ef..9e593cf 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -256,7 +256,7 @@ enum snd_soc_control_type {
>  };
>  
>  enum snd_soc_compress_type {
> -	SND_SOC_NO_COMPRESSION,
> +	SND_SOC_FLAT_COMPRESSION,
>  	SND_SOC_LZO_COMPRESSION,
>  	SND_SOC_RBTREE_COMPRESSION
>  };
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index e5b1888..9b1ba33 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -1520,7 +1520,7 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
>  /* an array of all supported compression types */
>  static const struct snd_soc_cache_ops cache_types[] = {
>  	{
> -		.id = SND_SOC_NO_COMPRESSION,
> +		.id = SND_SOC_FLAT_COMPRESSION,
>  		.init = snd_soc_flat_cache_init,
>  		.exit = snd_soc_flat_cache_exit,
>  		.read = snd_soc_flat_cache_read,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
