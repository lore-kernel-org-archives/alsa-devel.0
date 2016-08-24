From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/9] ASoC: Intel: Skylake: Driver updates
Date: Wed, 24 Aug 2016 18:03:12 +0530
Message-ID: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B643A26759B
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:30 +0200 (CEST)
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

So we had some driver updates collated, time to send them upstream :)

 - manifest data size was not checked so that is fixed
 - previous conversion to use core parsing for HDA capabilities was wrong at
   one place, that is fixed.
 - DMA config size was wrong, that is also fixed
 - Add 32bit format
 - The module instance IDs are manged in driver now.

Dharageswari R (5):
  ASoC: Intel: Skylake: Unload all the loadable modules
  ASoC: Intel: Skylake: Create dynamic instance ids for DSP modules
  ASoC: Intel: Skylake: Use private instance id of modules in IPC
  ASoC: Intel: Skylake: Table for module instance id and private id
  ASoC: Intel: Skylake: Override the actual instance id's to pvt_id's

Jeeja KP (1):
  ASoC: Intel: Skylake: Fix DMA control config size

Samaga Krishna (1):
  ASoC: Intel: Skylake: Add 32bit support

Vinod Koul (2):
  ASoC: Intel: Skylake: check manifest size
  ASoC: Intel: Skylake: Fix the inverted logic check

 sound/soc/intel/skylake/skl-messages.c       |  24 +++--
 sound/soc/intel/skylake/skl-pcm.c            |   5 +-
 sound/soc/intel/skylake/skl-sst-dsp.h        |   6 ++
 sound/soc/intel/skylake/skl-sst-utils.c      | 133 ++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.c       |  44 ++++++++-
 sound/soc/intel/skylake/skl-topology.h       |  13 ++-
 sound/soc/intel/skylake/skl-tplg-interface.h |   3 +-
 7 files changed, 208 insertions(+), 20 deletions(-)

-- 
1.9.1
