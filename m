From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/5] ASoC: intel: fix to sst driver series
Date: Mon, 20 Oct 2014 15:29:03 +0530
Message-ID: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B1B260597
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:36:13 +0200 (CEST)
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

Hi,

This series fixes comments observed while applying the sst series last week.


Vinod Koul (5):
  ASoC: intel: use __iowrite32_copy for 32 bit copy
  ASoC: intel: log an error on double free
  ASoC: intel: fix the kernldoc comment
  ASoC: intel: explain why block not found isn't error always
  ASoC: intel: use __iowrite32_copy for 32 bit copy

 sound/soc/intel/sst-firmware.c          |    7 ++-----
 sound/soc/intel/sst/sst_drv_interface.c |    4 +++-
 sound/soc/intel/sst/sst_ipc.c           |   15 +++++++++++++++
 sound/soc/intel/sst/sst_loader.c        |    9 +++------
 4 files changed, 23 insertions(+), 12 deletions(-)
