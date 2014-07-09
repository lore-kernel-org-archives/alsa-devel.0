From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/8] ASoC: Intel: sst - add the merrifield DSP
	driver
Date: Wed,  9 Jul 2014 14:57:56 +0530
Message-ID: <1404898076-1882-9-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E6ECD26501B
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:29 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This path series add the Merrifield DSP driver which is used to load and managed
the DSP along with sending and receiving IPCs for PCM and compressed audio

Vinod Koul (8):
  ASoC: Intel: add sst shim register start-end variables
  ASoC: Intel: mfld: add dsp error codes
  ASoC: Intel: mrlfd - add generic parameter interface
  ASoC: Intel: mrfld - add the dsp sst driver
  ASoC: Intel: sst: add power management handling
  ASoC: Intel: sst: load firmware using async callback
  ASoC: Intel: sst - add compressed ops handling
  compile

 arch/x86/include/asm/platform_sst_audio.h |   33 +
 sound/soc/intel/Kconfig                   |    6 +-
 sound/soc/intel/Makefile                  |    3 +
 sound/soc/intel/sst-dsp.h                 |    4 +
 sound/soc/intel/sst-mfld-dsp.h            |   15 +
 sound/soc/intel/sst-mfld-platform.h       |    5 +-
 sound/soc/intel/sst/Makefile              |    3 +
 sound/soc/intel/sst/sst.c                 |  586 ++++++++++++++++++
 sound/soc/intel/sst/sst.h                 |  666 ++++++++++++++++++++
 sound/soc/intel/sst/sst_drv_interface.c   |  819 +++++++++++++++++++++++++
 sound/soc/intel/sst/sst_ipc.c             |  368 +++++++++++
 sound/soc/intel/sst/sst_loader.c          |  951 +++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c             |  208 +++++++
 sound/soc/intel/sst/sst_stream.c          |  534 ++++++++++++++++
 14 files changed, 4199 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c
