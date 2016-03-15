From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/6] ASoC: Intel: Skylake: Fix module removal
Date: Tue, 15 Mar 2016 16:39:22 +0530
Message-ID: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A8D265727
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 12:05:45 +0100 (CET)
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

Skylake driver were crashing on module removal when we run "alsa reload".

The first issues was caused by component framework regression which Russell
fixed and in in 4.5. In driver there were still some missing order which
needs to be fixed. This series first update the list parsing in core, then
ensure proper freeup of code objects, and then ensuring driver does proper
cleanup and i915 dependency


Changes in v2:
- Add acked by Takashi
- Remove codec destructor wrapper

Vinod Koul (6):
  ALSA: hda: use list macro for parsing on cleanup
  ASoC: Intel: Skylake: free codec objects on removal
  ASoC: Intel: Skylake: Freeup properly on skl_dsp_free
  ASoC: Intel: Skylake: Unmap the address last
  ASoC: Intel: Skylake: Call i915 exit last
  ASoC: Intel: Skylake: remove call to pci_dev_put

 sound/hda/ext/hdac_ext_stream.c       |  5 ++---
 sound/soc/intel/skylake/skl-sst-dsp.c |  5 +++++
 sound/soc/intel/skylake/skl.c         | 17 ++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.9.1
