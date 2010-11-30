From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Fix memory overflow in
 LZO initialization
Date: Tue, 30 Nov 2010 12:05:00 +0000
Message-ID: <1291118700.3293.15.camel@odin>
References: <1291031013-16686-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 30BA21037F3
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 13:05:08 +0100 (CET)
Received: by wyi11 with SMTP id 11so5614883wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 04:05:07 -0800 (PST)
In-Reply-To: <1291031013-16686-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Mon, 2010-11-29 at 11:43 +0000, Dimitris Papastamos wrote:
> The bitmap_zero() nbits argument was improperly set to reg_size
> but the underlying buffer was bmp_size long.  This caused the memset
> to zero past the end of the allocated buffer and into the kernel heap
> causing strange kernel crashes sometimes by overwriting critical
> kernel structures.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 9b1ba33..5143984 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -1348,7 +1348,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
>  		ret = -ENOMEM;
>  		goto err;
>  	}
> -	bitmap_zero(sync_bmp, reg_size);
> +	bitmap_zero(sync_bmp, bmp_size);
>  
>  	/* allocate the lzo blocks and initialize them */
>  	for (i = 0; i < blkcount; ++i) {

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
