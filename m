From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl: Add map for Maxim IV
	Feedback
Date: Thu, 17 Aug 2017 08:55:29 +0530
Message-ID: <20170817032529.GW3053@localhost>
References: <1502864677-11596-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CF422675E0
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 05:22:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1502864677-11596-1-git-send-email-naveen.m@intel.com>
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

On Wed, Aug 16, 2017 at 11:54:37AM +0530, Naveen M wrote:
> MAX98927 provides IV feedback on the capture widget.
> Here we are connecting the capture widget to SSP0_RX and
> SSP0_RX to the algorithm running on host.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Naveen M <naveen.m@intel.com>
> Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> index 5b68ee9..c99b121 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> @@ -103,6 +103,11 @@ enum {
>  	{ "codec0_in", NULL, "ssp1 Rx" },
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
> index 60a7e72..60bae42 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -113,6 +113,11 @@ enum {
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

-- 
~Vinod
