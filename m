From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/4] ASoC: Intel: Skylake: Disable async
	suspend
Date: Wed, 22 Jun 2016 19:44:17 +0530
Message-ID: <1466604861-24288-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 283A9265870
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 16:11:13 +0200 (CEST)
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

Skylake does not support async suspend, so mark it and update the machine
driver. Also revert older machine patch which worked around this by using
pm.complete.

Also update a style inconsistency while at it.

Vinod Koul (4):
  ASoC: Intel: Revert "ASoC: Intel: Add support for PM ops in bxt-rt298"
  ASoC: Intel: Skylake: Disable async suspend
  ASoC: Intel: Skylake: Add pm ops for broxton-rt298 machine
  ASoC: Intel: Skylake: Update comment style

 sound/soc/intel/boards/bxt_rt298.c | 24 +-----------------------
 sound/soc/intel/skylake/skl.c      |  4 +++-
 2 files changed, 4 insertions(+), 24 deletions(-)

Thanks
-- 
1.9.1
