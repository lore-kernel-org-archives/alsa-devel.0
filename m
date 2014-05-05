From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/4] Add support for merrfield audio
Date: Mon,  5 May 2014 23:31:44 +0530
Message-ID: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 522B3260890
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 20:18:34 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This RFC patch series is dependent upon the "ASoC: Intel: rework the mfld
platform driver" series

This add support for Merrfield machine based on WM8958 codec and Intels
Merrfield SoC. The SoC implementation is based on DPCM.

At last the SST DSP driver has been added which provides the low level IPC
functionality and power management.

Vinod Koul (4):
  ASoC: Intel: add SSP BE DAIs
  ASoC: Intel: Add merrifield machine driver
  ASoC: Intel: add the low level dsp driver for mrfld
  ASoC: Intel: add support for mrfld DPCM platform

 sound/soc/intel/Kconfig                          |   20 +
 sound/soc/intel/board/Makefile                   |    4 +
 sound/soc/intel/board/merr_dpcm_wm8958.c         |  619 ++++++++++
 sound/soc/intel/platform-libs/controls_v2.h      |  754 +++++++++++++
 sound/soc/intel/platform-libs/controls_v2_dpcm.c | 1315 ++++++++++++++++++++++
 sound/soc/intel/platform-libs/sst_widgets.h      |  378 +++++++
 sound/soc/intel/platform_ipc_v2.h                |  694 ++++++++++++
 sound/soc/intel/sst-mfld-platform-compress.c     |    8 +-
 sound/soc/intel/sst-mfld-platform-pcm.c          |  490 +++++++--
 sound/soc/intel/sst-mfld-platform.h              |    2 +
 sound/soc/intel/sst/Makefile                     |    5 +
 sound/soc/intel/sst/sst.c                        |  631 +++++++++++
 sound/soc/intel/sst/sst.h                        |  686 +++++++++++
 sound/soc/intel/sst/sst_drv_interface.c          |  812 +++++++++++++
 sound/soc/intel/sst/sst_ipc.c                    |  388 +++++++
 sound/soc/intel/sst/sst_loader.c                 |  947 ++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c                    |  203 ++++
 sound/soc/intel/sst/sst_stream.c                 |  529 +++++++++
 18 files changed, 8401 insertions(+), 84 deletions(-)
 create mode 100644 sound/soc/intel/board/Makefile
 create mode 100644 sound/soc/intel/board/merr_dpcm_wm8958.c
 create mode 100644 sound/soc/intel/platform-libs/controls_v2.h
 create mode 100644 sound/soc/intel/platform-libs/controls_v2_dpcm.c
 create mode 100644 sound/soc/intel/platform-libs/sst_widgets.h
 create mode 100644 sound/soc/intel/platform_ipc_v2.h
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c
