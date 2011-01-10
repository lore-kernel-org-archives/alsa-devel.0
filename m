From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-core: Add support for NULL
 default register caches
Date: Mon, 10 Jan 2011 21:48:58 +0000
Message-ID: <1294696138.3416.237.camel@odin>
References: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3F88F24634
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 22:50:12 +0100 (CET)
Received: by wyi11 with SMTP id 11so19941000wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 13:50:07 -0800 (PST)
In-Reply-To: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Timur@alsa-project.org, Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 10:10 +0000, Dimitris Papastamos wrote:
> The infrastructure for handling NULL default register maps is already
> included in the soc-cache code, just ensure that we don't try to dereference
> a NULL pointer while accessing a NULL register cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index bac7291..a9f19c1 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3503,11 +3503,13 @@ int snd_soc_register_codec(struct device *dev,
>  		 * kernel might have freed the array by the time we initialize
>  		 * the cache.
>  		 */
> -		codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
> -					      reg_size, GFP_KERNEL);
> -		if (!codec->reg_def_copy) {
> -			ret = -ENOMEM;
> -			goto fail;
> +		if (codec_drv->reg_cache_default) {
> +			codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
> +						      reg_size, GFP_KERNEL);
> +			if (!codec->reg_def_copy) {
> +				ret = -ENOMEM;
> +				goto fail;
> +			}
>  		}
>  	}
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
