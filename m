From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/2]  ASoC: Intel: Add Broxton Machine
Date: Tue, 10 May 2016 22:02:04 +0530
Message-ID: <1462897926-20271-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D55D226524F
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:26:28 +0200 (CEST)
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

Broxton uses SSP5 for audio on Intel board, so add the 6 SSPs and then
machine driver which uses RT298 codec

Pardha Saradhi K (1):
  ASoC: Intel: Skylake: Add more SSP DAIs

Ramesh Babu (1):
  ASoC: Intel: Add Broxton-P machine driver

 sound/soc/intel/Kconfig            |  15 ++
 sound/soc/intel/boards/Makefile    |   2 +
 sound/soc/intel/boards/bxt_rt298.c | 353 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c  |  72 ++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 sound/soc/intel/boards/bxt_rt298.c

-- 
1.9.1
