From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Skylake: Add code loader DMA
	support
Date: Fri, 10 Jul 2015 22:18:38 +0530
Message-ID: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A06B266606
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 18:47:00 +0200 (CEST)
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

This series add code loader DMA support to Skylake driver and then adds the
IPC init routines along with few smaller changes

Omair M Abdullah (1):
  ASoC: Intel: Skylake: Print error code in IPC for SKL

Subhransu S. Prusty (3):
  ASoC: Intel: Skylake: Add dsp loader ops
  ASoC: Intel: Skylake: Process code loader DMA interrupt
  ASoC: Intel: Skylake: Add SKL DSP initialization

Vinod Koul (3):
  ASoC: Intel: Skylake: Add code loader DMA registers
  ASoC: Intel: Skylake: add code loader DMA operations
  ASoC: Intel: Skylake: Add code loader DMA APIs

 sound/soc/intel/common/sst-dsp-priv.h   |   3 +
 sound/soc/intel/skylake/Makefile        |   3 +-
 sound/soc/intel/skylake/skl-sst-cldma.c | 327 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-cldma.h | 251 ++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.c   |   5 +
 sound/soc/intel/skylake/skl-sst-dsp.h   |  26 +++
 sound/soc/intel/skylake/skl-sst-ipc.c   |  11 ++
 sound/soc/intel/skylake/skl-sst.c       | 280 +++++++++++++++++++++++++++
 8 files changed, 905 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-sst-cldma.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-cldma.h
 create mode 100644 sound/soc/intel/skylake/skl-sst.c

-- 
1.9.1
