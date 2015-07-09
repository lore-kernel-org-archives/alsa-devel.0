From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v8 0/4] ASoC: Intel: Add skylake PCM driver
Date: Thu,  9 Jul 2015 15:20:07 +0530
Message-ID: <1436435411-28028-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 177A926510F
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 11:48:27 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This patch series adds the SKL PCM driver in first two patches and then adds
decoupling of the controller for splitting the links in last patch

this version fixes
 - superflous cast from/to void *, both gcc and sparse are happy!
 - remove buffer memset
 - check return of pm_runtime_get_sync
 - set dma_data to NULL on free
 - remove ifdef PM for pm_runtime_active
 - fix pci_set_drvdata calls

Jeeja KP (4):
  ASoC: Intel: Add Skylake HDA platform driver
  ASoC: Intel: Add Skylake HDA audio driver
  ASoC: Intel: Add makefile support for SKL driver
  ASoC: Intel: Add support for decoupled mode in skl driver

 sound/soc/intel/Kconfig           |   4 +
 sound/soc/intel/Makefile          |   1 +
 sound/soc/intel/skylake/Makefile  |   3 +
 sound/soc/intel/skylake/skl-pcm.c | 916 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c     | 536 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h     |  71 +++
 6 files changed, 1531 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile
 create mode 100644 sound/soc/intel/skylake/skl-pcm.c
 create mode 100644 sound/soc/intel/skylake/skl.c
 create mode 100644 sound/soc/intel/skylake/skl.h

-- 
1.9.1
