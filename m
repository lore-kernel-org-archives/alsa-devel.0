From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/13] ASoC: Intel: BSW driver updates
Date: Thu, 12 Feb 2015 09:59:52 +0530
Message-ID: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D2726509E
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:33 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch series first adds nonatomic pcm ops support in ASoC (it is
already availble in ALSA). Then adds driver support.
Later it adds puase/resume and suspend/resume support to the intel driver

Subhransu S. Prusty (3):
  ASoC: Intel: Add memcpy32_fromio as well
  ASoC: Intel: Remove ignore suspend support
  ASoC: Intel: Remove soc pm handling to allow platform driver handle
    it

Vinod Koul (10):
  ASoC: core: allow pcms to be registered as nonatomic
  ASoC: Intel: mark cht machine driver with nonatomic trigger
  ASoC: Intel: update MMX ID to 3
  ASoC: Intel: add support for pause and resume in sst
  ASoC: Intel: add support for pcm stream suspend/resume
  ASoC: Intel: add support for platform suspend
  ASoC: Intel: save and restore the CSR register
  ASoC: Intel: reset the DSP while suspending
  ASoC: Intel: add pm support in sst ipc driver
  ASoC: Intel: Move the fw download to power_control

 include/sound/soc.h                     |    3 +
 sound/soc/intel/cht_bsw_rt5672.c        |    5 +-
 sound/soc/intel/sst-atom-controls.h     |    2 +-
 sound/soc/intel/sst-mfld-platform-pcm.c |   60 ++++++++++++++
 sound/soc/intel/sst-mfld-platform.h     |    1 +
 sound/soc/intel/sst/sst.c               |  134 ++++++++++++++++++++++++++++---
 sound/soc/intel/sst/sst.h               |   12 +++
 sound/soc/intel/sst/sst_drv_interface.c |   58 ++++++++++++-
 sound/soc/intel/sst/sst_loader.c        |   10 ++-
 sound/soc/soc-pcm.c                     |    1 +
 10 files changed, 268 insertions(+), 18 deletions(-)

-- 
1.7.9.5
