From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 0/4] ASoC: intel - add skylake PCM driver
Date: Thu, 11 Jun 2015 22:03:54 +0530
Message-ID: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EFF1266549
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:32:50 +0200 (CEST)
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

This version removes the bus and match function as that is merged in HDA
core now and we have extended HDA bus merged as well

Please note this series is dependent on sound next having hda core patches
and extended bus patches

Jeeja KP (4):
  ASoC: Intel: add Skylake HDA platform driver
  ASoC: Intel - add Skylake HDA audio driver
  ASoC: Intel - add makefile support for SKL driver
  ASoC: intel - adds support for decoupled mode in skl driver

 sound/soc/intel/Kconfig           |  17 +
 sound/soc/intel/Makefile          |   1 +
 sound/soc/intel/skylake/Makefile  |   3 +
 sound/soc/intel/skylake/skl-pcm.c | 936 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c     | 646 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h     |  74 +++
 6 files changed, 1677 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile
 create mode 100644 sound/soc/intel/skylake/skl-pcm.c
 create mode 100644 sound/soc/intel/skylake/skl.c
 create mode 100644 sound/soc/intel/skylake/skl.h

-- 
1.9.1
