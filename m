From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: kbl: Add map for Maxim IV
 Feedback
Date: Wed, 23 Aug 2017 06:41:07 +0530
Message-ID: <20170823011107.GC3053@localhost>
References: <1503393562-31613-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 23F93266834
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 03:07:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1503393562-31613-1-git-send-email-naveen.m@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

hi Naveen,

On Tue, Aug 22, 2017 at 02:49:22PM +0530, Naveen M wrote:
> MAX98927 provides IV feedback on the capture widget.
> Here we are connecting the capture widget to SSP0_RX and
> SSP0_RX to the algorithm running on host.

This is good

> 
> v2: rebased on newer kernel (d46b182)

But this is not, version info is useful for review but useless for changelog
This should be after s-ob lines
> 
> Signed-off-by: Naveen M <naveen.m@intel.com>
> Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

-- 

here put version line, its skipped while applying

> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> index c144214..8d2a1c0 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> @@ -107,6 +107,11 @@ enum {
>  	{ "hs_in", NULL, "ssp1 Rx" },
>  	{ "ssp1 Rx", NULL, "AIF Capture" },
>  
> +	/* IV feedback path */
> +	{ "codec0_fb_in", NULL, "ssp0 Rx"},
> +	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
> +	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
> +
>  	/* DMIC */
>  	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
>  	{ "DMIC01 Rx", NULL, "DMIC AIF" },
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index c2ef538..8d19da9 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -119,6 +119,11 @@ enum {
>  	{ "codec1_in", NULL, "ssp0 Rx" },
>  	{ "ssp0 Rx", NULL, "AIF1 Capture" },
>  
> +	/* IV feedback path */
> +	{ "codec0_fb_in", NULL, "ssp0 Rx"},
> +	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
> +	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
> +
>  	/* DMIC */
>  	{ "DMIC1L", NULL, "DMIC" },
>  	{ "DMIC1R", NULL, "DMIC" },
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
