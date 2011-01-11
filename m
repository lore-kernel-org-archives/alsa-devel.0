From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Fix invalid memory access
 during snd_soc_lzo_cache_sync()
Date: Tue, 11 Jan 2011 11:45:56 +0000
Message-ID: <1294746356.3338.9.camel@odin>
References: <1294745042-23352-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 135FA24600
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:46:00 +0100 (CET)
Received: by wyi11 with SMTP id 11so20466182wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 03:45:59 -0800 (PST)
In-Reply-To: <1294745042-23352-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Tue, 2011-01-11 at 11:24 +0000, Dimitris Papastamos wrote:
> The size of the lzo syncing bitmap was incorrectly set to the size
> of the cache times the word size, however, the correct size is the
> size of the cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index a9ebc07..8c2a21a 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -1361,7 +1361,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
>  			goto err;
>  		}
>  		lzo_blocks[i]->sync_bmp = sync_bmp;
> -		lzo_blocks[i]->sync_bmp_nbits = reg_size;
> +		lzo_blocks[i]->sync_bmp_nbits = bmp_size;
>  		/* alloc the working space for the compressed block */
>  		ret = snd_soc_lzo_prepare(lzo_blocks[i]);
>  		if (ret < 0)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
