From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] ASoC: Intel: kbl: update dmic fixup
	params
Date: Wed, 15 Nov 2017 10:25:24 +0530
Message-ID: <20171115045523.GW3187@localhost>
References: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F3A0B267544
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 05:52:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 09, 2017 at 07:34:34PM +0530, Naveen Manohar wrote:
> Update dmic fixup params to always expose QUAD channel capture device,
> enabling User-space to control channel count.
> Assign min and max channel only based on input hw_params.
> And removes choosing the channel count based on pdata. 

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Naveen Manohar (2):
>   ASoC: Intel: kbl: Remove option of choosing CH count based on pdata
>   ASoC: Intel: kbl: update dmic fixup params
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 44 +++++++++-------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
