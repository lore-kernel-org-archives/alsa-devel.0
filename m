From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Fix some error handling path
 in 'sst_platform_get_resources()'
Date: Sun, 28 Jan 2018 21:12:24 +0100
Message-ID: <9cec4b1a-15b4-b9fa-8731-7e7205646fa1@linux.intel.com>
References: <20180127124028.3795-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F3DC266E42
 for <alsa-devel@alsa-project.org>; Sun, 28 Jan 2018 21:12:21 +0100 (CET)
In-Reply-To: <20180127124028.3795-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, arvind.yadav.cs@gmail.com
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 1/27/18 1:40 PM, Christophe JAILLET wrote:
> Several error handling paths set 'ret' to an error code, but the function
> always returns 0 (i.e. success)
> 
> Return 'ret' instead in order to return the error code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I guess that the code needs more correction. For this first try, I've left
> the logic as-is, but I don't really see why we call 'pci_release_regions()'
> in the normal path.
> A 'return 0;' before the 'do_release_regions' label would sound more
> logical to me.

The code looks indeed weird, but I am a bit concerned about changing it 
without actually running tests. The state of this driver is questionable 
(firmware not available in the regular firmware tree, no know test 
running on Edison/Merrifield), so changes should really be parked and 
merged as a batch with likely other needed changes. This has been on my 
TODO list for some time but it's likely going to be a post-March topic.


> ---
>   sound/soc/intel/atom/sst/sst_pci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
> index 6906ee624cf6..8cae20802b7c 100644
> --- a/sound/soc/intel/atom/sst/sst_pci.c
> +++ b/sound/soc/intel/atom/sst/sst_pci.c
> @@ -105,9 +105,12 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>   		goto do_release_regions;
>   	}
>   	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
> +
> +	ret = 0;
> +
>   do_release_regions:
>   	pci_release_regions(pci);
> -	return 0;
> +	return ret;
>   }
>   
>   /*
> 
