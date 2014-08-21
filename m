From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 00/11] ASoC: Intel: sst - add the merrifield IPC
	driver
Date: Thu, 21 Aug 2014 18:20:39 +0530
Message-ID: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D54862651E3
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:12:46 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This path series adds the Merrifield IPC driver which is used to load and
manage the DSP along with sending and receiving IPCs for PCM and compressed
audio.

Changes in v3:
	* First patch is splitted into multiple patches
	* Now download fw during device resume
	* Removed runtime reference counting from driver context
	* Using dedicated functions instead ioctl
	* Addressed review comments

Subhransu S. Prusty (8):
  ASoC: Intel: mrfld - add the dsp sst driver
  ASoC: Intel: mrfld - Add DSP load and management
  ASoC: Intel: sst - add pcm ops handling
  ASoC: Intel: sst: Add IPC handling
  ASoC: Intel: sst: add stream operations
  ASoC: Intel: sst: Add some helper functions
  ASoC: Intel: sst: Add makefile and kconfig changes
  ASoC: mfld-compress: Use dedicated function instead of ioctl

Vinod Koul (3):
  ASoC: Intel: sst: add power management handling
  ASoC: Intel: sst: load firmware using async callback
  ASoC: Intel: sst - add compressed ops handling

 arch/x86/include/asm/platform_sst_audio.h    |  33 +
 sound/soc/intel/Kconfig                      |   4 +
 sound/soc/intel/Makefile                     |   3 +
 sound/soc/intel/sst-mfld-platform-compress.c |  38 +-
 sound/soc/intel/sst-mfld-platform.h          |  27 +-
 sound/soc/intel/sst/Makefile                 |   3 +
 sound/soc/intel/sst/sst.c                    | 576 ++++++++++++++++
 sound/soc/intel/sst/sst.h                    | 654 ++++++++++++++++++
 sound/soc/intel/sst/sst_drv_interface.c      | 784 +++++++++++++++++++++
 sound/soc/intel/sst/sst_ipc.c                | 368 ++++++++++
 sound/soc/intel/sst/sst_loader.c             | 975 +++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c                | 207 ++++++
 sound/soc/intel/sst/sst_stream.c             | 526 +++++++++++++++
 13 files changed, 4179 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c

-- 
1.9.0
