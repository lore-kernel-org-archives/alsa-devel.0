From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/7] ASoC: Intel: Introduce tokens for
	CNL
Date: Fri, 25 Aug 2017 11:11:13 +0530
Message-ID: <20170825054109.GG3053@localhost>
References: <20170823140354.792-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D285D266998
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 07:37:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170823140354.792-1-guneshwor.o.singh@intel.com>
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

On Wed, Aug 23, 2017 at 07:33:47PM +0530, Guneshwor Singh wrote:
> This series introduces topology changes for CNL platform. Cannonlake
> DSP supports various formats, rates and channels for each module. To
> represent the buffer size, cycles per second and required memory page
> per format/channel/rate per module, common module data are abstracted
> out and are now part of the topology manifest. This is necessary for
> pipelines which involve algo modules as they required floating point
> calculations.
> 
> With the addition of manifest tokens, buffer size, formats and page
> required by dsp modules can be pre-calculated and populate in the conf
> manifest instead of computing them in the driver.
> 
> This change is backward compatible with the existing model.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Changes in v2:
> - Removed token SKL_TKN_MM_U8_MAX_INST_COUNT and its structure member
>   which is never used.
> 
> Jeeja KP (1):
>   ASoC: Intel: Skylake: Update module id in pin connections
> 
> Ramesh Babu (1):
>   ASoC: Intel: Skylake: Parse and update module config structure
> 
> Shreyas NC (5):
>   ASoC: Intel: Skylake: Parse multiple manifest data blocks
>   ASoC: Intel: uapi: Add new tokens for module common data
>   ASoC: Intel: Skylake: Commonize parsing of format tokens
>   ASoC: Intel: Skylake: Add driver structures to be filled from topology
>     manifest
>   ASoC: Intel: Skylake: Populate module data from topology manifest
> 
>  include/uapi/sound/snd_sst_tokens.h    |  92 ++++-
>  sound/soc/intel/skylake/skl-messages.c |  59 ++-
>  sound/soc/intel/skylake/skl-pcm.c      |  44 +-
>  sound/soc/intel/skylake/skl-topology.c | 713 ++++++++++++++++++++++++++++-----
>  sound/soc/intel/skylake/skl-topology.h |  78 ++++
>  sound/soc/intel/skylake/skl.h          |   2 +
>  6 files changed, 861 insertions(+), 127 deletions(-)
> 
> -- 
> 2.14.1
> 

-- 
~Vinod
