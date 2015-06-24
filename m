From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC: Intel: fix kconfig,
	symbols and sparse
Date: Wed, 24 Jun 2015 12:47:15 +0100
Message-ID: <1435146435.2655.63.camel@loki>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 72ED526596E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:47:18 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-06-19 at 23:55 +0530, Vinod Koul wrote:
> So this series has two parts
> part 1, first three patches which fix the issue of BYT driver not getting
> compiled in -next and then cleans up symbol usage in various driver
> Second part fixes (next three) spare warnings on drivers
> 
> Vinod Koul (6):
>   ASoC: Intel: use CONFIG_SND_SOC for intel boards
>   ASoC: Intel: kconfig - Move DW_DMAC_CORE dependency to machines
>   ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
>   ASOC: intel - hsw: fix sparse unused varible warn
>   ASoC: intel - atom: statify sst_slot_enum_info
>   ASoC: Intel -atom: fix sst_platform_compr_ops declaration
> 
>  sound/soc/intel/Kconfig                      | 24 +++++++++++++-----------
>  sound/soc/intel/Makefile                     |  2 +-
>  sound/soc/intel/atom/sst-atom-controls.c     |  2 +-
>  sound/soc/intel/atom/sst-mfld-platform-pcm.c |  1 -
>  sound/soc/intel/atom/sst-mfld-platform.h     |  1 +
>  sound/soc/intel/haswell/sst-haswell-pcm.c    |  1 -
>  6 files changed, 16 insertions(+), 15 deletions(-)
> 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
