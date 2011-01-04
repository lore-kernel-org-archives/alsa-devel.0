From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: regarding references taken on platform and codec
 driver modules
Date: Tue, 4 Jan 2011 15:48:26 +0000
Message-ID: <20110104154825.GF24774@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
	<20110103163532.GB7370@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51BC3@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD8C243AA
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 16:49:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE053BF51BC3@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, ".lrg"@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 11:26:34PM +0530, Harsha, Priya wrote:

> Please provide your comments on the patch below that makes this change

Please follow Documentation/SubmittingPatches - remember to CC
maintainers (I've added Liam) and don't bury your patches in the middle
of another e-mail.

> From: Harsha Priya <priya.harsha@intel.com>
> Date: Mon, 3 Jan 2011 22:36:05 +0530
> Subject: [PATCH] Fix the reference to codec and platform driver to where they are probed
> 
> The soc-core take the platform and codec driver reference and does not free
> them all. This cause the module unload to fail.

Please explain in which circumstances this happens in the changelog; 

> This patch fixes by the taking one reference to platform and codec module and 
> free the same.This allows load/unload properly

This looks reasonable, though we're now not counting CODEC DAIs
individually as we do with platform DAIs which is a bit asymmetric, it
might be nicer to change to free all the references we're currently
taking to the CODEC.  I'm not too fussed, though.

> free the same.This allows load/unload properly
> 
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> Signed-off-by: Vinod Koul<vinod.koul@intel.com>
> 
> 	modified:   sound/soc/soc-core.c

No need for this in the patch either.  Leaving the patch content for Liam:

> 
> ---
>  sound/soc/soc-core.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c index 606281a..97f9d3e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1259,9 +1259,6 @@ find_codec:
>  		if (!strcmp(codec->name, dai_link->codec_name)) {
>  			rtd->codec = codec;
>  
> -			if (!try_module_get(codec->dev->driver->owner))
> -				return -ENODEV;
> -
>  			/* CODEC found, so find CODEC DAI from registered DAIs from this CODEC*/
>  			list_for_each_entry(codec_dai, &dai_list, list) {
>  				if (codec->dev == codec_dai->dev && @@ -1287,10 +1284,6 @@ find_platform:
>  	/* no, then find CPU DAI from registered DAIs*/
>  	list_for_each_entry(platform, &platform_list, list) {
>  		if (!strcmp(platform->name, dai_link->platform_name)) {
> -
> -			if (!try_module_get(platform->dev->driver->owner))
> -				return -ENODEV;
> -
>  			rtd->platform = platform;
>  			goto out;
>  		}
> @@ -1425,6 +1418,9 @@ static int soc_probe_codec(struct snd_soc_card *card,
>  	soc_init_codec_debugfs(codec);
>  
>  	/* mark codec as probed and add to card codec list */
> +	if (!try_module_get(codec->dev->driver->owner))
> +		return -ENODEV;
> +
>  	codec->probed = 1;
>  	list_add(&codec->card_list, &card->codec_dev_list);
>  	list_add(&codec->dapm.list, &card->dapm_list); @@ -1556,6 +1552,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  			}
>  		}
>  		/* mark platform as probed and add to card platform list */
> +
> +		if (!try_module_get(platform->dev->driver->owner))
> +			return -ENODEV;
> +
>  		platform->probed = 1;
>  		list_add(&platform->card_list, &card->platform_dev_list);
>  	}
> --
> 1.7.2.3
> 
