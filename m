From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Introduce tokens for CNL
Date: Mon, 21 Aug 2017 14:16:39 +0530
Message-ID: <20170821084646.6525-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E328267453
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:46:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

This series introduces topology changes for CNL platform. Cannonlake
DSP supports various formats, rates and channels for each module. To
represent the buffer size, cycles per second and required memory page
per format/channel/rate per module, common module data are abstracted
out and are now part of the topology manifest. This is necessary for
pipelines which involve algo modules as they required floating point
calculations.

With the addition of manifest tokens, buffer size, formats and page
required by dsp modules can be pre-calculated and populate in the conf
manifest instead of computing them in the driver.

This change is backward compatible with the existing model.

Jeeja KP (1):
  ASoC: Intel: Skylake: Update module id in pin connections

Ramesh Babu (1):
  ASoC: Intel: Skylake: Parse and update module config structure

Shreyas NC (5):
  ASoC: Intel: Skylake: Parse multiple manifest data blocks
  ASoC: Intel: uapi: Add new tokens for module common data
  ASoC: Intel: Skylake: Commonize parsing of format tokens
  ASoC: Intel: Skylake: Add driver structures to be filled from topology
    manifest
  ASoC: Intel: Skylake: Populate module data from topology manifest

 include/uapi/sound/snd_sst_tokens.h    |  96 ++++-
 sound/soc/intel/skylake/skl-messages.c |  59 ++-
 sound/soc/intel/skylake/skl-pcm.c      |  44 +-
 sound/soc/intel/skylake/skl-topology.c | 718 ++++++++++++++++++++++++++++-----
 sound/soc/intel/skylake/skl-topology.h |  79 ++++
 sound/soc/intel/skylake/skl.h          |   2 +
 6 files changed, 871 insertions(+), 127 deletions(-)

-- 
2.14.1
