From: jeeja.kp@intel.com
Subject: [PATCH 0/6] ASoC: Intel: Skylake: Driver updates on
	DSP firmware
Date: Mon,  2 Jan 2017 09:50:01 +0530
Message-ID: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 594E2266653
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 05:09:21 +0100 (CET)
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

This patch series provides update on DSP firmware download by optimizing
o updating the dsp register poll method to use accurate timeout.
o optimizing ROM init retries.
o saving the firmware/library context at boot and use this ctx for
downloading the firmware to DSP memory.
o cleanup to store the library manifest data
o release the firmware in cleanup routine.

Jeeja KP (6):
  ASoC: Intel: Common: Update dsp register poll implementation
  ASoC: Intel: bxtn: Use DSP poll API to poll FW status
  ASoC: Intel: Skylake: Clean up manifest info
  ASoC: Intel: Skylake: Release FW ctx in cleanup
  ASoC: Intel: bxtn: Fix to store the FW/Library context at boot
  ASoC: Intel: bxtn: optimize ROM init retries

 sound/soc/intel/common/sst-dsp.c             |  52 +++++-----
 sound/soc/intel/skylake/bxt-sst.c            | 142 ++++++++++++++-------------
 sound/soc/intel/skylake/skl-sst-dsp.h        |   4 +-
 sound/soc/intel/skylake/skl-sst-ipc.h        |   5 +-
 sound/soc/intel/skylake/skl-sst.c            |   3 +
 sound/soc/intel/skylake/skl-topology.c       |  41 ++++----
 sound/soc/intel/skylake/skl-topology.h       |  13 +++
 sound/soc/intel/skylake/skl-tplg-interface.h |  12 ---
 8 files changed, 137 insertions(+), 135 deletions(-)

-- 
2.5.0
