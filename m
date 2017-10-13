From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] ASoC: Intel: Skylake: Add support for
 loading FE dais from topology
Date: Fri, 13 Oct 2017 14:52:40 +0530
Message-ID: <20171013092240.GA30097@localhost>
References: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 05889266EE0
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 11:18:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 09, 2017 at 11:20:29AM +0530, Guneshwor Singh wrote:
> This series adds support for loading FE dais using topology. A flag is
> introduced to decide whether to register FE dais defined in the platform
> driver or use from topology. By default, it is set to register the FE
> dais defined in the platform driver. While at it, fix a missing sentinel
> too.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Guneshwor Singh (3):
>   ASoC: Intel: Skylake: Add flag to check to register FE dais from
>     topology
>   ASoC: Intel: Skylake: Add dai load ops for dais from topology
>   ASoC: Intel: Skylake: Fix missing sentinel in sst_acpi_mach
> 
>  sound/soc/intel/skylake/skl-pcm.c      | 46 +++++++++++++++++++++++++++++++---
>  sound/soc/intel/skylake/skl-topology.c |  1 +
>  sound/soc/intel/skylake/skl-topology.h |  3 +++
>  sound/soc/intel/skylake/skl.c          | 10 +++++++-
>  sound/soc/intel/skylake/skl.h          |  4 ++-
>  5 files changed, 58 insertions(+), 6 deletions(-)
> 
> -- 
> 2.14.2
> 

-- 
~Vinod
