From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/3] ASoC: Intel: add runtime power
	management support
Date: Fri, 31 Oct 2014 12:38:18 +0530
Message-ID: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D824F2654E5
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 08:49:17 +0100 (CET)
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

This series fixes the device open pm handling and adds the runtime pm
support. Also we fix lock usage while changing the driver state

Changes in v2:
 - fix style in comments
 - fix error prints and remove noisy debug

Mythri P K (1):
  Audio: SST: use lock when changing SST state.

Subhransu S. Prusty (1):
  ASoC: Intel: mrfld: Fix runtime pm calls in sst_open_pcm_stream

Vinod Koul (1):
  ASoC: Intel: sst: add runtime power management handling

 sound/soc/intel/sst/sst.c               |   65 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_drv_interface.c |   12 ++----
 sound/soc/intel/sst/sst_ipc.c           |    2 +-
 3 files changed, 70 insertions(+), 9 deletions(-)
