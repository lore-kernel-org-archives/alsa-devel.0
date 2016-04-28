From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: Skylake: Wov optimizations
Date: Thu, 28 Apr 2016 18:45:24 +0530
Message-ID: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9D42666C9
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:41 +0200 (CEST)
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

This series starts with two minor fixes on driver to fix a memory leak and
one NULL pointer exception and then adds power optimization to driver for WOV
case by suspending the stream DMA and keeping only DSP pipe and endpoint On
during that case

Dharageswari.R (2):
  ASoC: Intel: Skylake: Fix the NULL pointer exception in dsp_clean up
  ASoC: Intel: Skylake: Prevent sending Set DMA Control IPC if the
    widget is "On"

Jeeja KP (2):
  ASoC: Intel: Skylake: Suspend PCMs when marked as active suspend
  ASoC: Intel: Boards: remove ignore_suspend for WoV streams

Mousumi Jana (1):
  ASoC: Intel: Skylake: Fix memory leak during init instance

 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  1 -
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |  1 -
 sound/soc/intel/boards/skl_rt286.c              |  1 -
 sound/soc/intel/skylake/skl-messages.c          |  2 +-
 sound/soc/intel/skylake/skl-pcm.c               | 32 ++++++++++++++++---------
 sound/soc/intel/skylake/skl-sst-dsp.c           |  2 --
 sound/soc/intel/skylake/skl-sst.c               |  4 ++++
 7 files changed, 26 insertions(+), 17 deletions(-)

-- 
1.9.1
