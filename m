From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/2] ASoC: Memeory leak fixes
Date: Thu,  5 May 2016 11:19:17 +0530
Message-ID: <1462427359-30402-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F0126526E
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 07:43:20 +0200 (CEST)
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

This series fixes two memeory leaks, first in topology core to
freeup the objects in widget creation and second one on Skylake
driver for NHLT table cleanup

Jeeja KP (2):
  ASoC: topology: Fix memory leak in widget creation
  ASoC: Intel: Skylake: Fix memory leak in nhlt init

 sound/soc/intel/skylake/skl-nhlt.c | 15 +++++++++------
 sound/soc/intel/skylake/skl.c      |  5 ++++-
 sound/soc/intel/skylake/skl.h      |  6 +++---
 sound/soc/soc-topology.c           |  2 ++
 4 files changed, 18 insertions(+), 10 deletions(-)

-- 
1.9.1
