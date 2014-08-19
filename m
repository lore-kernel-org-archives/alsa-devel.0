From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v2 0/5] ASoC: Intel: sst - add the merrifield DSP
	driver
Date: Tue, 19 Aug 2014 16:07:02 +0530
Message-ID: <1408444627-28906-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E13062655F6
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 12:58:59 +0200 (CEST)
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

This path series add the Merrifield DSP driver which is used to load and
managed the DSP along with sending and receiving IPCs for PCM and compressed
audio.

Changes in v2:
	* Now download fw during device resume
	* Removed runtime reference counting from driver context
	* Using dedicated functions instead ioctl
	* Addressed review comments

Subhransu S. Prusty (1):
  ASoC: mfld-compress: Use dedicated function instead of ioctl

Vinod Koul (4):
  ASoC: Intel: mrfld - add the dsp sst driver
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
 sound/soc/intel/sst/sst_drv_interface.c      | 773 +++++++++++++++++++++
 sound/soc/intel/sst/sst_ipc.c                | 373 ++++++++++
 sound/soc/intel/sst/sst_loader.c             | 975 +++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c                | 207 ++++++
 sound/soc/intel/sst/sst_stream.c             | 526 +++++++++++++++
 13 files changed, 4173 insertions(+), 19 deletions(-)
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
