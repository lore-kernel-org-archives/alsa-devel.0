From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [v2 0/4] Add debugfs support for skylake driver
Date: Thu, 29 Jun 2017 12:26:00 +0530
Message-ID: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A8B266C25
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 08:56:52 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

This series introduces debugfs support for skylake driver. It helps in
debugging by providing module configurations which is loaded from topology.

It also allows to read the firmware registers which are a part of SRAM
memory area accessible by host CPU through a memory window.

Guneshwor Singh (1):
  ASoC: Intel: common: Add sram address to sst_addr structure

Sodhi, VunnyX (1):
  ASoC: Intel: Skylake: Add support to read firmware registers

Vinod Koul (2):
  ASoC: Intel: Skylake: Add debugfs support
  ASoC: Intel: Skylake: Debugfs facility to dump module config

Changes in v2:
- Re-ordered patch and squashed platform changes

Guneshwor Singh (1):
  ASoC: Intel: common: Add sram address to sst_addr structure

Sodhi, VunnyX (1):
  ASoC: Intel: Skylake: Add support to read firmware registers

Vinod Koul (2):
  ASoC: Intel: Skylake: Add debugfs support
  ASoC: Intel: Skylake: Debugfs facility to dump module config

 sound/soc/intel/common/sst-dsp-priv.h  |   4 +
 sound/soc/intel/skylake/Makefile       |   4 +
 sound/soc/intel/skylake/bxt-sst.c      |   4 +
 sound/soc/intel/skylake/skl-debug.c    | 269 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c      |   5 +
 sound/soc/intel/skylake/skl-topology.c |   3 +
 sound/soc/intel/skylake/skl.c          |   5 +
 sound/soc/intel/skylake/skl.h          |  26 ++++
 8 files changed, 320 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl-debug.c

-- 
2.13.0
