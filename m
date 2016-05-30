From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Skylake: Manifest parsing
	support
Date: Mon, 30 May 2016 17:42:54 +0530
Message-ID: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D6126073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:45 +0200 (CEST)
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

The firmware file contains the extended manifest which needs to
be stripped before downloading of firmware.

The firmware manifest also contains manifest which has module
information, Driver needs to parse and create module information
and use it for sending IPCs.

So this series adds common API for stripping manifest and then
strips it for SKL and BXT.  Also it adds core support to parse
and add module information and its use in SKL and BXT.

Changes in this series:
 - modified manifest parse to be generic utility code, added calling patches
   from SKL n BXTN
 - fix issues in last rvw
 - add extended manifest parsing in this series
 - make manifest series common and use list instead of table and bxtn
   modules will have manifest parsing and addition later

Ramesh Babu (1):
  ASoC: Intel: Skylake: Add strip extended manifest utility

Shreyas NC (1):
  ASoC: Intel: Skylake: Add DSP firmware manifest parsing

Vinod Koul (5):
  ASoC: Intel: Skylake: Don't use local pointer for firmware
  ASoC: Intel: Skylake: Strip manifest for Skylake platform
  ASoC: Intel: Skylake: Strip manifest for Broxton platform
  ASoC: Intel: Skylake: Find uuids for Skylake
  ASoC: Intel: Skylake: Find uuids for Broxton

 sound/soc/intel/skylake/Makefile        |   2 +-
 sound/soc/intel/skylake/bxt-sst.c       |  26 +++-
 sound/soc/intel/skylake/skl-sst-dsp.h   |   8 +
 sound/soc/intel/skylake/skl-sst-ipc.h   |   3 +
 sound/soc/intel/skylake/skl-sst-utils.c | 256 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c       |  23 ++-
 sound/soc/intel/skylake/skl-topology.c  |   4 +
 7 files changed, 315 insertions(+), 7 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-sst-utils.c

-- 
1.9.1
