From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: Skylake fixes
Date: Sat, 27 Jan 2018 09:50:20 +0530
Message-ID: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 10170266F35
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 05:20:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

This includes fixes for Skylake+ driver which are improving widget type
check, fixes for simultaneous wake-on-voice (WoV) and capture use-case,
fix to improve firmware download latency and lastly, fix to use uuid
instead of module id for library modules.

Guneshwor Singh (1):
  ASoC: Intel: Skylake: Refine skl widget type check

Pawse, GuruprasadX (2):
  ASoC: Intel: Skylake: Add BE DAI for WoV usecase
  ASoC: Intel: board: Add BE DAI link for WoV and update DAPM machine
    map.

Sanyog Kale (1):
  ASoC: Intel: Skylake: Disable clock and power gating during fw/lib
    download

Sriram Periyasamy (1):
  ASoC: Intel: Skylake: Find module id from UUID for bind params

 sound/soc/intel/boards/bxt_rt298.c     |  15 +++++
 sound/soc/intel/skylake/skl-messages.c |   7 ++-
 sound/soc/intel/skylake/skl-pcm.c      |  20 +++++-
 sound/soc/intel/skylake/skl-sst-ipc.h  |   3 +
 sound/soc/intel/skylake/skl-topology.c | 107 +++++++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl-topology.h |  13 +++-
 sound/soc/intel/skylake/skl.c          |  21 +++++++
 sound/soc/intel/skylake/skl.h          |   4 ++
 8 files changed, 176 insertions(+), 14 deletions(-)

-- 
2.16.1
