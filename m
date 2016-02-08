From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Really fix the BYT/HSW
	regressions
Date: Mon,  8 Feb 2016 10:45:35 +0530
Message-ID: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C6C3260474
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 06:12:08 +0100 (CET)
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
Cc: patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

So we had some issues due to common acpi matching code which caused
regression on BYT first and fixes on that caused regression on HSW.

So this series revert the old fix and properly fixes by making matching
module as a separate ones and then adding BYT PCI ids conditionally.

This was tested on BYT/CHT platforms, HSW/BDW and SKL so test coverge
should ensure that this is really fixed this time.

Thanks to Jie Yang and Pierre for testing and suggesting fixes

Pierre-Louis Bossart (1):
  ASoC: Intel: Load the atom DPCM driver only

Vinod Koul (3):
  ASoC: Intel: Revert "ASoC: Intel: fix ACPI probe regression with Atom
    DPCM driver"
  ASoC: Intel: Create independent acpi match module
  ASoC: Intel: Add module tags for common match module

 sound/soc/intel/Kconfig                 | 13 +++++++++++--
 sound/soc/intel/common/Makefile         |  9 +++------
 sound/soc/intel/common/sst-acpi.c       |  4 ++++
 sound/soc/intel/common/sst-match-acpi.c |  3 +++
 4 files changed, 21 insertions(+), 8 deletions(-)

-- 
1.9.1
