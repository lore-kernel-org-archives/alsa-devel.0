From: jeeja.kp@intel.com
Subject: [PATCH v2 00/11] ASoC: Intel: Skylake: More driver
	updates
Date: Fri, 24 Mar 2017 23:10:23 +0530
Message-ID: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C82162669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch series provides updates on the following:
 o Fix LLCH register read.
 o Add 16-bit constraint to FE bxt_rt298 machine.
 o Fix DMA position reporting for capture stream.
 o Use the sig_bits to define dai bps caps.
 o Update sig_bits based on converter capability.
 o Rearrangement of code to cleanup SKL SST library.
 o Add support for deferred DSP module bind.

Changes in v2:
	- Addressed Pierre's comments for "Fix DMA position reporting
	  for capture stream" patch.

B, Jayachandran (1):
  ALSA: hda: Fix LLCH register read

G Kranthi (1):
  ASoC: Intel: Skylake: Add 16-bit constraint to FE bxt_rt298 machine

Hardik T Shah (1):
  ASoC: Intel: Skylake: Fix DMA position reporting for capture stream

Jeeja KP (5):
  ASoC: Intel: Skylake: Use the sig_bits to define dai bps capability
  ASoC: hdac_hdmi: Update sig_bits based on converter capability
  ASoC: Intel: Skylake: Rearrangement of code to cleanup SKL SST library
  ASoC: Intel: Skylake: Fix module state after unbind and delete
  ASoC: Intel: Skylake: Add support for deferred DSP module bind

Vinod Koul (3):
  ASoC: Intel: Skylake: Don't unload module when in use
  ASoC: Intel: Skylake: Remove redundant vmixer handler
  ASoC: Intel: Skylake: remove hard coded ACPI path

 sound/hda/hdac_controller.c             |   2 +-
 sound/soc/codecs/hdac_hdmi.c            |   4 +-
 sound/soc/intel/boards/bxt_rt298.c      |   3 +
 sound/soc/intel/skylake/skl-messages.c  |   2 +-
 sound/soc/intel/skylake/skl-nhlt.c      |   7 +-
 sound/soc/intel/skylake/skl-pcm.c       |  95 ++++++++++++++++---
 sound/soc/intel/skylake/skl-sst-dsp.h   |  24 +++--
 sound/soc/intel/skylake/skl-sst-ipc.h   |   8 ++
 sound/soc/intel/skylake/skl-sst-utils.c |  60 ++----------
 sound/soc/intel/skylake/skl-sst.c       |   5 +
 sound/soc/intel/skylake/skl-topology.c  | 159 +++++++++++++++++++++++++-------
 sound/soc/intel/skylake/skl-topology.h  |  17 ++--
 sound/soc/intel/skylake/skl.h           |   1 +
 13 files changed, 263 insertions(+), 124 deletions(-)

-- 
2.5.0
