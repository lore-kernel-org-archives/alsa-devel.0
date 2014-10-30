From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/9] ASoC: Intel: more modulartion of init and
	add ACPI
Date: Thu, 30 Oct 2014 16:21:43 +0530
Message-ID: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 684B8265087
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:30 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The first patch is a fix of mfld-pcm driver
Rest of the series is devoted to ACPI support with 7 patch moving the probe
routine and sperating into common and PCI and later moving PCI code to
sst-pci file so that it can be shared with ACPI
Lats patch adds support for ACPI with BYT driver support.

This series is dependent upon the PM and compressed series sent earlier
today

Subhransu S. Prusty (9):
  ASoC: Intel: mfld-pcm: Fix to Store device context in sst_data
  ASoC: Intel: move the driver wq init to a routine
  ASoC: Intel: move the lock and wq initialization to routine
  ASoC: Intel: move the driver context allocation to routine
  ASoC: Intel: modularize driver probe and remove
  ASoC: Intel: more probe modularization for sst
  ASoC: Intel: move PCI probe to a seprate file
  ASoC: Intel: add shim save context and restore routines
  ASoC: Intel: Add ACPI driver for SST

 sound/soc/intel/Kconfig                 |    7 +
 sound/soc/intel/sst-mfld-platform-pcm.c |    1 +
 sound/soc/intel/sst/Makefile            |    8 +
 sound/soc/intel/sst/sst.c               |  391 ++++++++++++-------------------
 sound/soc/intel/sst/sst.h               |    7 +
 sound/soc/intel/sst/sst_acpi.c          |  387 ++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pci.c           |  225 ++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c           |    2 +
 8 files changed, 793 insertions(+), 235 deletions(-)
 create mode 100644 sound/soc/intel/sst/sst_acpi.c
 create mode 100644 sound/soc/intel/sst/sst_pci.c
