From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Fixes to free
 resources on init failure
Date: Wed, 23 Aug 2017 06:41:55 +0530
Message-ID: <20170823011154.GD3053@localhost>
References: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B0922266834
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 03:08:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 22, 2017 at 04:45:49PM +0530, Subhransu S. Prusty wrote:
> Some resources are not freed for ipc and dsp init failures. This results in
> random failures in a stress test environment. So fixed to free the required
> resources and also fixed the DSP core reference counting for firmware load
> failure.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Subhransu S. Prusty (4):
>   ASoC: Intel: Skylake: Fix to free dsp resource on ipc_init failure
>   ASoC: Intel: Skylake: Fix to free resources for dsp_init failure
>   ASoC: Intel: Skylake: Fix to free correct dev id in free_irq
>   ASoC: Intel: Skylake: Fix DSP core ref count for init failure
> 
>  sound/soc/intel/skylake/bxt-sst.c      |  4 +++-
>  sound/soc/intel/skylake/cnl-sst.c      |  4 +++-
>  sound/soc/intel/skylake/skl-messages.c | 26 +++++++++++++++++++-------
>  sound/soc/intel/skylake/skl-sst-dsp.c  |  4 ++--
>  sound/soc/intel/skylake/skl-sst.c      |  4 +++-
>  sound/soc/intel/skylake/skl.c          |  2 +-
>  6 files changed, 31 insertions(+), 13 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
