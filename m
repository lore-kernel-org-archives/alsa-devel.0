From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: add compressed support
Date: Thu, 30 Oct 2014 16:20:55 +0530
Message-ID: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7765E2604B8
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:31:51 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This add compressed support in sst ipc driver. Along with it two minor fixes
on driver as well

Fang, Yang A (1):
  ASoC: Intel: use correct firmware name

Subhransu S. Prusty (1):
  ASoC: mfld-compress: implement .power callback

Vinod Koul (2):
  ASoC: Intel: sst: load firmware using async callback
  ASoC: Intel: sst - add compressed ops handling

 sound/soc/intel/sst-mfld-platform-compress.c |    8 +-
 sound/soc/intel/sst-mfld-platform.h          |    1 +
 sound/soc/intel/sst/sst.c                    |   15 ++
 sound/soc/intel/sst/sst_drv_interface.c      |  285 ++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_loader.c             |    5 +-
 5 files changed, 309 insertions(+), 5 deletions(-)
