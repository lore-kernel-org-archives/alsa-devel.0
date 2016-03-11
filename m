From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/8] ASoC: Intel: Skylake: Add Broxton DSP
	support
Date: Fri, 11 Mar 2016 10:12:48 +0530
Message-ID: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1871F260682
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:38:53 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Broxton DSP is similar to Skylake with similar DSP capabilities but
differs in a few subtle ways. It doesn't have Code Loader DMA and use HDA
DMA. The DSP power up/down routines are also bit different in the two
platforms. Also the FW needs to be downloaded only once and not on every
power sequence as it is cached by DSP in protected memory region.

All these changes for new DSP ops are abstracted in a new BXTN-dsp ops file.

This patch series starts with moving code around to prepare for new code and
also fix whitespace issue in existing code.
Since we have different loader ops we move Skylake ones to newly
defined ops. Then we add device IDs and lastly the broxton ops.

Jayachandran B (1):
  ASoC: Intel: Skylake: Unstatify skl_dsp_enable_core

Jeeja KP (4):
  ASoC: Intel: add dmabuffer to common sst_dsp
  ASoC: Intel: Skylake: Move Skylake dsp ops & loader ops
  ASoC: hdac_hdmi: Add broxton device ID
  ASoC: Intel: Bxtn: Add Broxton DSP support

Senthilnathan Veppur (1):
  ASoC: Intel: Bxtn: Add Broxton PCI ID

Vinod Koul (2):
  ASoC: Intel: Skylake: Move module id defines
  ASoC: Intel: Skylake: Fix whitepsace issues

 sound/soc/codecs/hdac_hdmi.c           |   1 +
 sound/soc/intel/Kconfig                |   1 +
 sound/soc/intel/common/sst-dsp-priv.h  |   1 +
 sound/soc/intel/skylake/Makefile       |   2 +-
 sound/soc/intel/skylake/bxt-sst.c      | 328 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 182 +++++++++++++++++-
 sound/soc/intel/skylake/skl-sst-dsp.c  |  14 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  |  20 +-
 sound/soc/intel/skylake/skl-sst.c      |   3 -
 sound/soc/intel/skylake/skl.c          |   7 +
 sound/soc/intel/skylake/skl.h          |  12 +-
 11 files changed, 549 insertions(+), 22 deletions(-)
 create mode 100644 sound/soc/intel/skylake/bxt-sst.c

-- 
1.9.1
