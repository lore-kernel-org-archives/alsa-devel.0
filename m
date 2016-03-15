From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Skylake: Fix module removal
Date: Tue, 15 Mar 2016 15:27:10 +0530
Message-ID: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E62B5261298
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:05 +0100 (CET)
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

Skyalke driver were crashing on module removal when we run "alsa reload".

The first issues was caused by component framwork regression which Russell
fixed and in in 4.5. In driver there were still some missing order which
needs to be fixed. This series first update the list parsing in core, then
ensure proper freeup of code objects, and then esnureing driver does proper
cleanup and i915 dependency

Vinod Koul (6):
  ALSA: hda: use list macro for parsing on cleanup
  ASoC: Intel: Skylake: free codec objects on removal
  ASoC: Intel: Skylake: Freeup properly on skl_dsp_free
  ASoC: Intel: Skylake: Unmap the address last
  ASoC: Intel: Skylake: Call i915 exit last
  ASoC: Intel: Skylake: remove call to pci_dev_put

 sound/hda/ext/hdac_ext_stream.c       |  5 ++---
 sound/soc/intel/skylake/skl-sst-dsp.c |  5 +++++
 sound/soc/intel/skylake/skl.c         | 22 +++++++++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

Thanks
-- 
1.9.1
