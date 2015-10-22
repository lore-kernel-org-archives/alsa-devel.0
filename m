From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/9] ASoC: Intel: Skylake: Fixes and updates
Date: Thu, 22 Oct 2015 23:22:33 +0530
Message-ID: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E5526260542
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:49:28 +0200 (CEST)
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

This series adds various fixes thru the driver. It also updates ssp node
structure to latest FW interface. Last patch add support for static pin
connections between modules, which is useful for intra pipe connections

Jeeja KP (7):
  ASoC: Intel: Skylake: Fix return for pm_runtime_get_sync()
  ASoC: Intel: Skylake: Remove BE copier blob memcpy
  ASoC: Intel: Skylake: Update for ssp node index in copier cfg
  ASoC: Intel: Skylake: Add support to disable module notifications
  ASoC: Intel: Skylake: Fix to check return value of dsp init
  ASoC: Intel: Skylake: Fix to set Non gateway copier cfg
  ASoC: Intel: Skylake: Add support to topology for module static pin

Subhransu S. Prusty (2):
  ASoC: Intel: Skylake: Fix to use correct macros for the path iteration
  ASoC: Intel: Skylake: Fix to fill all sink/source pipe params

 sound/soc/intel/skylake/skl-messages.c       | 44 +++++++++++++++--
 sound/soc/intel/skylake/skl-pcm.c            |  2 +-
 sound/soc/intel/skylake/skl-topology.c       | 74 +++++++++++++++++-----------
 sound/soc/intel/skylake/skl-topology.h       |  8 ++-
 sound/soc/intel/skylake/skl-tplg-interface.h |  7 ++-
 5 files changed, 95 insertions(+), 40 deletions(-)

-- 
1.9.1
