From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/6] ASoC: Intel: Skylake: fixes and
	commonize machine creation
Date: Thu,  5 Nov 2015 21:34:09 +0530
Message-ID: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 93C842660C7
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:00:54 +0100 (CET)
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

Hi,

This is second attempt to fix the SKL machine creation. So I ended up moving
the match code from common and atom driver into a common routine used by
these and added SKl on top of it.
Also fixed passing fw name from machine table

This also contains resource cleanup fix for skl driver (1st patch)

Vinod Koul (6):
  ASoC: Intel: Skylake: Fix resource cleanup on teardown
  ASoC: Intel: Move apci find machine routines
  ASoC: Intel: Atom: move atom driver to common acpi match
  ASoC: Intel: Skylake: Fix skl machine driver creation
  ASoC: Intel: add fw name to common dsp context
  ASoC: Intel: Skylake: Use the fw name from ACPI mach table

 sound/soc/intel/Kconfig                 |  1 +
 sound/soc/intel/atom/sst/sst_acpi.c     | 67 ++++++++++-----------------------
 sound/soc/intel/common/Makefile         |  3 +-
 sound/soc/intel/common/sst-acpi.c       | 41 +++-----------------
 sound/soc/intel/common/sst-acpi.h       | 33 ++++++++++++++++
 sound/soc/intel/common/sst-dsp-priv.h   |  2 +
 sound/soc/intel/common/sst-match-acpi.c | 43 +++++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c  |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  3 +-
 sound/soc/intel/skylake/skl-sst.c       |  5 ++-
 sound/soc/intel/skylake/skl-topology.c  |  2 +-
 sound/soc/intel/skylake/skl.c           | 56 ++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h           |  3 ++
 13 files changed, 168 insertions(+), 93 deletions(-)
 create mode 100644 sound/soc/intel/common/sst-acpi.h
 create mode 100644 sound/soc/intel/common/sst-match-acpi.c

-- 
1.9.1
