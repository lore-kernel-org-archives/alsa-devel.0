From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Skylake: Fix suspend issues
Date: Mon, 23 Nov 2015 22:26:22 +0530
Message-ID: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E327E265473
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:52:51 +0100 (CET)
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

While testing legacy Suspend on Skylake, we found few issues that require
driver changes. This was tested with usermode apps and aplay.

We need to add RESUME capability in driver to let ALSA resume us, then HDA
was not getting reconfigured upon resume so that is updated.  CLDMA needs to
be polled as that takes a little while like HDA DMA, also clear of
registers is required per spec upon setup

Last one fixes resource leak upon failures by movng free call up (not
related to suspend though but observed when we saw failures)

Jeeja KP (6):
  ASoC: Intel: Skylake: Add Resume capability in PCM info.
  ASoC: Intel: Skylake: Reconfigure HDA stream register in
    prepare/resume
  ASoC: Intel: Skylake: Fix to update bit depth for module params
  ASoC: Intel: Skylake: Add pcm capability to support 16/8k rates.
  ASoC: Intel: Skylake: Poll CLDMA RUN bit when set
  ASoC: Intel: Skylake: Clear stream registers before setting up stream

Vinod Koul (1):
  ASoC: Intel: Skylake: Move up pipe mem free

 sound/soc/intel/skylake/skl-pcm.c       | 22 +++++----
 sound/soc/intel/skylake/skl-sst-cldma.c | 82 +++++++++++++++++++++------------
 sound/soc/intel/skylake/skl-topology.c  | 22 +++++++--
 3 files changed, 86 insertions(+), 40 deletions(-)

-- 
1.9.1
