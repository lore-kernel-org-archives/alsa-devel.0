From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/4] ASoC: Intel: Skylake - Add IPC routines
Date: Thu,  9 Jul 2015 21:38:51 +0530
Message-ID: <1436458135-25537-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 863FD2661DC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 18:07:11 +0200 (CEST)
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

First 2 patches are against common IPC code and can be applied independently
Last two add IPC handling and aDSP management routines

v3 changes:
 - sst_dsp_register_poll uses opportunistic polling and polls for first few
   instances using mdelay and later sleeps
 - s/skl_ipc_reply_find_msg/skl_ipc_reply_get_msg
 - return IRQ_NONE when interrupt in not handled
 - removed trace_printk and superfluous cast to/from void *

Subhransu S. Prusty (4):
  ASoC: Intel: Add helper to poll register for DSP status
  ASoC: Intel: Add helper to update register bits with attr RWC
  ASoC: Intel: Add Skylake IPC library
  ASoC: Intel: Add DSP init and boot up functionality for SKL

 sound/soc/intel/Kconfig               |   1 +
 sound/soc/intel/common/sst-dsp-priv.h |   8 +
 sound/soc/intel/common/sst-dsp.c      |  71 ++++
 sound/soc/intel/common/sst-dsp.h      |   6 +
 sound/soc/intel/skylake/Makefile      |   5 +
 sound/soc/intel/skylake/skl-sst-dsp.c | 337 +++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h |  57 +++
 sound/soc/intel/skylake/skl-sst-ipc.c | 760 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h | 125 ++++++
 9 files changed, 1370 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.h

-- 
1.9.1
