From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v3 0/4] [PATCH v3 0/4] Add debugfs support for
	skylake driver
Date: Fri, 30 Jun 2017 09:06:04 +0530
Message-ID: <20170630033608.31466-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 275882673F8
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 05:36:19 +0200 (CEST)
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

Changes in v3:
- Change debugfs parent from debugfs root to ASoC platform component

Changes in v2:
- Re-ordered patch and squashed platform changes

Guneshwor Singh (1):
  ASoC: Intel: Skylake: Add sram address to sst_addr structure

Vinod Koul (2):
  ASoC: Intel: Skylake: Add debugfs support
  ASoC: Intel: Skylake: Debugfs facility to dump module config

Vunny Sodhi (1):
  ASoC: Intel: Skylake: Add support to read firmware registers

 sound/soc/intel/common/sst-dsp-priv.h  |   4 +
 sound/soc/intel/skylake/Makefile       |   4 +
 sound/soc/intel/skylake/bxt-sst.c      |   4 +
 sound/soc/intel/skylake/skl-debug.c    | 268 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      |   6 +-
 sound/soc/intel/skylake/skl-sst.c      |   5 +
 sound/soc/intel/skylake/skl-topology.c |   3 +
 sound/soc/intel/skylake/skl.c          |   2 +
 sound/soc/intel/skylake/skl.h          |  26 ++++
 9 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-debug.c

-- 
2.13.0
