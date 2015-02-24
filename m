From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/4] ASoC: Intel: BSW driver updates
Date: Tue, 24 Feb 2015 11:39:43 +0530
Message-ID: <1424758188-15569-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 09F532604D4
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 07:12:47 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series adds rest of the remaining 4 patches posted in v1.
This is generated on top of Mark's topic/intel

Subhransu S. Prusty (2):
  ASoC: Intel: Remove ignore suspend support
  ASoC: Intel: Remove soc pm handling to allow platform driver handle
    it

Vinod Koul (2):
  ASoC: Intel: add pm support in sst ipc driver
  ASoC: Intel: Move the fw download to power_control

 sound/soc/intel/cht_bsw_rt5672.c        |    3 -
 sound/soc/intel/sst/sst.c               |  128 +++++++++++++++++++++++++++++--
 sound/soc/intel/sst/sst.h               |    9 +++
 sound/soc/intel/sst/sst_drv_interface.c |   27 ++++++-
 4 files changed, 152 insertions(+), 15 deletions(-)

-- 
1.7.9.5
