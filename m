From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Add support for
	loading FE dais from topology
Date: Mon,  9 Oct 2017 11:20:29 +0530
Message-ID: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EA12266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 07:50:44 +0200 (CEST)
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

This series adds support for loading FE dais using topology. A flag is
introduced to decide whether to register FE dais defined in the platform
driver or use from topology. By default, it is set to register the FE
dais defined in the platform driver. While at it, fix a missing sentinel
too.

Guneshwor Singh (3):
  ASoC: Intel: Skylake: Add flag to check to register FE dais from
    topology
  ASoC: Intel: Skylake: Add dai load ops for dais from topology
  ASoC: Intel: Skylake: Fix missing sentinel in sst_acpi_mach

 sound/soc/intel/skylake/skl-pcm.c      | 46 +++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.c |  1 +
 sound/soc/intel/skylake/skl-topology.h |  3 +++
 sound/soc/intel/skylake/skl.c          | 10 +++++++-
 sound/soc/intel/skylake/skl.h          |  4 ++-
 5 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.14.2
