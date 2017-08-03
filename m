From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Use correct nuvoton
	codec ID
Date: Thu, 3 Aug 2017 10:25:22 +0530
Message-ID: <20170803045522.GC3053@localhost>
References: <1501654663-24663-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A232664EB
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 06:52:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1501654663-24663-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, Harsha Priya <harshapriya.n@intel.com>, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 02, 2017 at 11:47:43AM +0530, Naveen M wrote:
> Correcting the nau88l25 codec ID to match secondary codec
> and load the machine driver.

We shouldn't have missed it :(

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Naveen M <naveen.m@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 334917e..608c147 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -879,12 +879,12 @@ static void skl_remove(struct pci_dev *pci)
>  
>  static struct sst_codecs skl_codecs = {
>  	.num_codecs = 1,
> -	.codecs = {"NAU88L25"}
> +	.codecs = {"10508825"}
>  };
>  
>  static struct sst_codecs kbl_codecs = {
>  	.num_codecs = 1,
> -	.codecs = {"NAU88L25"}
> +	.codecs = {"10508825"}
>  };
>  
>  static struct sst_codecs bxt_codecs = {
> -- 
> 1.9.1
> 

-- 
~Vinod
