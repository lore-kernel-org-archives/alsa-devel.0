From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/6] ASoC: Intel: ACPI support and machines
Date: Tue,  4 Nov 2014 16:25:14 +0530
Message-ID: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D67522605F2
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:54:42 +0100 (CET)
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

This is third rev of patch series which fixes the modules split as
discussed in ML. The core part is now module along with PCI and ACPI one.
Added fix reported by Dan as well. Also added the BYTCR machine driver and
MERR machine driver

Updates in v3:
- Fix export fo few more symbols
- fix cleanup of probe and setup code
- add MERR machine code

Subhransu S. Prusty (1):
  ASoC: Intel: add BYTCR machine driver with RT5640

Vinod Koul (5):
  ASoC: Intel: mrfld - remove unnecessary check for pointer
  ASoC: Intel: mrfld - create separate module for pci part
  ASoC: Intel: mrfld - add shim save restore
  ASoC: Intel: mrfld- add ACPI module
  ASoC: Intel: Add Merrifield machine driver

 sound/soc/intel/Kconfig             |   37 +++-
 sound/soc/intel/Makefile            |    4 +
 sound/soc/intel/bytcr_dpcm_rt5640.c |  258 ++++++++++++++++++++++
 sound/soc/intel/merr_dpcm_wm8958.c  |  416 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.c |    2 +-
 sound/soc/intel/sst/Makefile        |    8 +-
 sound/soc/intel/sst/sst.c           |  254 +++++----------------
 sound/soc/intel/sst/sst.h           |    9 +-
 sound/soc/intel/sst/sst_acpi.c      |  377 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pci.c       |  209 ++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c       |    3 +
 11 files changed, 1378 insertions(+), 199 deletions(-)
 create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c
 create mode 100644 sound/soc/intel/merr_dpcm_wm8958.c
 create mode 100644 sound/soc/intel/sst/sst_acpi.c
 create mode 100644 sound/soc/intel/sst/sst_pci.c
