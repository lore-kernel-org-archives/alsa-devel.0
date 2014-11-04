From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/5] ASoC: Intel: ACPI support and machines
Date: Tue,  4 Nov 2014 11:01:03 +0530
Message-ID: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7153E2605D7
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 06:30:34 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is second rev of patch series which fixes the modules split as
discussed in ML. The core part is now module along with PCI and ACPI one.
Added fix reported by Dan as well. Also added the BYTCR machine driver

Subhransu S. Prusty (1):
  ASoC: Intel: add BYTCR machine driver with RT5640

Vinod Koul (4):
  ASoC: Intel: mrfld - remove unnecessary check for pointer
  ASoC: Intel: mrfld - create separate module for pci part
  ASoC: Intel: mrfld - add shim save restore
  ASoC: Intel: mrfld- add ACPI module

 sound/soc/intel/Kconfig             |   22 ++-
 sound/soc/intel/Makefile            |    2 +
 sound/soc/intel/bytcr_dpcm_rt5640.c |  258 +++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.c |    2 +-
 sound/soc/intel/sst/Makefile        |    8 +-
 sound/soc/intel/sst/sst.c           |  243 +++++-----------------
 sound/soc/intel/sst/sst.h           |    9 +-
 sound/soc/intel/sst/sst_acpi.c      |  386 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pci.c       |  225 ++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c       |    2 +
 10 files changed, 958 insertions(+), 199 deletions(-)
 create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c
 create mode 100644 sound/soc/intel/sst/sst_acpi.c
 create mode 100644 sound/soc/intel/sst/sst_pci.c
