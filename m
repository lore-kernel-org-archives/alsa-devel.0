From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 0/7] ASoC: Intel: sst - add the merrifield
	IPC driver
Date: Thu, 16 Oct 2014 20:00:12 +0530
Message-ID: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id ED5552605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:06:42 +0200 (CEST)
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

This path series adds the Merrifield IPC driver which is used to load and
manage the DSP along with sending and receiving IPCs for PCM and compressed
audio.

v4 updates:
 - fix the comment style issues
 - fix for id allocation handling
 - modularize the code to remove few repated patterns
 - comments from previos rev (hopefully didnt miss anything) 

Vinod Koul (7):
  ASoC: Intel: mrfld - add the dsp sst driver
  ASoC: Intel: mrfld - Add DSP load and management
  ASoC: Intel: sst - add pcm ops handling
  ASoC: Intel: sst: Add IPC handling
  ASoC: Intel: sst: add stream operations
  ASoC: Intel: sst: Add some helper functions
  ASoC: Intel: sst: Add makefile and kconfig changes

 arch/x86/include/asm/platform_sst_audio.h |   34 ++
 sound/soc/intel/Kconfig                   |    4 +
 sound/soc/intel/Makefile                  |    3 +
 sound/soc/intel/sst/Makefile              |    3 +
 sound/soc/intel/sst/sst.c                 |  434 +++++++++++++++++++++++
 sound/soc/intel/sst/sst.h                 |  539 +++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_drv_interface.c   |  403 +++++++++++++++++++++
 sound/soc/intel/sst/sst_ipc.c             |  358 +++++++++++++++++++
 sound/soc/intel/sst/sst_loader.c          |  461 ++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c             |  446 ++++++++++++++++++++++++
 sound/soc/intel/sst/sst_stream.c          |  437 +++++++++++++++++++++++
 11 files changed, 3122 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c
