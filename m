From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] sound/soc/fsl/p1022_ds.c: Add
 of_node_put to avoid memory leak
Date: Tue, 31 Aug 2010 16:59:48 +0100
Message-ID: <20100831155948.GB30599@rakim.wolfsonmicro.main>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
	<1283269738-14612-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB9751037F5
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 17:59:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283269738-14612-3-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 05:48:56PM +0200, Julia Lawall wrote:
> Add a call to of_node_put in the error handling code following a call to
> of_parse_phandle.
> 
> This patch also moves the existing call to of_node_put tothe end of the
> error handling code, to make it possible to jump to of_node_put without
> doing the other cleanup operations.  These appear to be disjoint
> operations, so the ordering doesn't matter.

CCing in Timur who wrote and maintains that driver - looks OK to me.

> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r exists@
> local idexpression x;
> expression E,E1,E2;
> statement S;
> @@
> 
> *x = 
> (of_find_node_by_path
> |of_find_node_by_name
> |of_find_node_by_phandle
> |of_get_parent
> |of_get_next_parent
> |of_get_next_child
> |of_find_compatible_node
> |of_match_node
> |of_find_node_by_type
> |of_find_node_with_property
> |of_find_matching_node
> |of_parse_phandle
> )(...);
> ...
> if (x == NULL) S
> <... when != x = E
> *if (...) {
>   ... when != of_node_put(x)
>       when != if (...) { ... of_node_put(x); ... }
> (
>   return <+...x...+>;
> |
> *  return ...;
> )
> }
> ...>
> (
> E2 = x;
> |
> of_node_put(x);
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  sound/soc/fsl/p1022_ds.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
> index f8176e8..63b9eaa 100644
> --- a/sound/soc/fsl/p1022_ds.c
> +++ b/sound/soc/fsl/p1022_ds.c
> @@ -346,8 +346,10 @@ static int p1022_ds_probe(struct platform_device *pdev)
>  	}
>  
>  	mdata = kzalloc(sizeof(struct machine_data), GFP_KERNEL);
> -	if (!mdata)
> -		return -ENOMEM;
> +	if (!mdata) {
> +		ret = -ENOMEM;
> +		goto error_put;
> +	}
>  
>  	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
>  	mdata->dai[0].ops = &p1022_ds_ops;
> @@ -502,13 +504,12 @@ static int p1022_ds_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error:
> -	of_node_put(codec_np);
> -
>  	if (sound_device)
>  		platform_device_unregister(sound_device);
>  
>  	kfree(mdata);
> -
> +error_put:
> +	of_node_put(codec_np);
>  	return ret;
>  }
>  
> 
