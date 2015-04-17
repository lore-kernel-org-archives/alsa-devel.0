From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/9] Add SKL ipc handling code
Date: Fri, 17 Apr 2015 18:45:58 +0530
Message-ID: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BA2626582D
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:12 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This series adds support for managing DSP and posting IPC and processing IPC
replies.

Subhransu S. Prusty (9):
  ASoC: hda: Add helper to read/write to dsp mmio space
  ASoC: hda: Add IPC library for SKL platform
  ASoC: hda: Add config option for SKL ipc library
  ASoC: hda: Add DSP init and boot up functionality
  ASoC: hda: Add dsp loader ops
  ASoC: hda: Add Code Loader DMA support
  ASoC: hda: Add DSP library functions for SKL platform
  ASoC: hda: Add for CL DMA interrupt handling
  ASoC: hda: Export API to change DSP power state

 include/sound/soc-hda-sst-cldma.h        |  234 ++++++++
 include/sound/soc-hda-sst-dsp.h          |  266 +++++++++
 include/sound/soc-hda-sst-ipc.h          |  134 +++++
 sound/soc/hda/Kconfig                    |    7 +
 sound/soc/hda/Makefile                   |    3 +
 sound/soc/hda/intel/Makefile             |    6 +
 sound/soc/hda/intel/soc-hda-sst-cldma.c  |  297 +++++++++
 sound/soc/hda/intel/soc-hda-sst-dsp.c    |  510 ++++++++++++++++
 sound/soc/hda/intel/soc-hda-sst-ipc.c    |  963 ++++++++++++++++++++++++++++++
 sound/soc/hda/intel/soc-hda-sst-skl-fw.h |  163 +++++
 sound/soc/hda/intel/soc-hda-sst-skl.c    |  292 +++++++++
 11 files changed, 2875 insertions(+)
 create mode 100644 include/sound/soc-hda-sst-cldma.h
 create mode 100644 include/sound/soc-hda-sst-dsp.h
 create mode 100644 include/sound/soc-hda-sst-ipc.h
 create mode 100644 sound/soc/hda/intel/Makefile
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-cldma.c
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-dsp.c
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-ipc.c
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-skl-fw.h
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-skl.c

-- 
1.7.9.5
