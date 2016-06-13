From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Update Bxt machine and pm
	support
Date: Mon, 13 Jun 2016 17:58:57 +0530
Message-ID: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C5EF2650D1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:28 +0200 (CEST)
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

This series first adds constraints and other updates on Bxt-rt298
machine for various scenarios.

Then it updates platform driver for PM support to enable firmware reload
on suspend and fixes dma id for purge request, updates stall bits on
stall/unstall commands and finally adds PM support in machine.

Jayachandran B (2):
  ASoC: Intel: Skylake: Enable firmware reload in suspend
  ASoC: Intel: Skylake: Update DSP stall bits

Jeeja KP (1):
  ASoC: Intel: Add support for PM ops in bxt-rt298

Senthilnathan Veppur (4):
  ASoC: Intel: Add DMIC 4 channel support for bxt machine
  ASoC: Intel: Add FE rate & channel constraints for bxt-rt298
  ASoC: Intel: Update ignore suspend for bxt-rt298
  ASoC: Intel: Skylake: Update FW purge for Broxton

 sound/soc/intel/boards/bxt_rt298.c    | 140 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/bxt-sst.c     |  25 +++++-
 sound/soc/intel/skylake/skl-sst-dsp.c |  15 ++--
 sound/soc/intel/skylake/skl-sst-dsp.h |   2 +
 sound/soc/intel/skylake/skl-sst-ipc.h |   3 +
 sound/soc/intel/skylake/skl-sst.c     |   1 +
 sound/soc/intel/skylake/skl.c         |   1 +
 7 files changed, 176 insertions(+), 11 deletions(-)

-- 
1.9.1
