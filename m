From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Sklyake - add IPC routines
Date: Tue, 23 Jun 2015 16:16:50 +0530
Message-ID: <1435056416-24653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 913222654D7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 12:45:18 +0200 (CEST)
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

The SKL aDSP needs to send and receive IPCs to and from aDSP. To aid this we
add IPC and aDSP management routines as a library for driver to use. For
most of IPC handling we use the common IPC Intel code in place and add the
messaging and message parsing bits on top.

First 4 patches are against common IPC code and can be applied independently
Last two add IPC handling and aDSP management routines, they are
not dependent upon anything and can be applied independently but they are
generated against SKL PCM driver series so Makefile updates expect those to be
there

Subhransu S. Prusty (6):
  ASoC: Intel: Add helper to poll register for DSP status
  ASoC: Intel: Define SKL ADSP IPC and general purpose registers
  ASoC: Intel: Reorganize the common dsp structure
  ASoC: Intel: Add helper to update register bits with attr RWC
  ASoC: Intel: Add Skylake IPC library
  ASoC: Intel: Add DSP init and boot up functionality for SKL

 sound/soc/intel/common/sst-dsp-priv.h |  20 +-
 sound/soc/intel/common/sst-dsp.c      |  51 +++
 sound/soc/intel/common/sst-dsp.h      |   6 +
 sound/soc/intel/skylake/Makefile      |   5 +
 sound/soc/intel/skylake/skl-sst-dsp.c | 338 +++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h | 124 ++++++
 sound/soc/intel/skylake/skl-sst-ipc.c | 751 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h | 126 ++++++
 8 files changed, 1417 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.h
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.h

-- 
1.9.1
