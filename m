From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v7 0/4] ASoC: intel - add skylake PCM driver
Date: Mon,  6 Jul 2015 08:54:22 +0530
Message-ID: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EBE0D2604ED
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 05:22:41 +0200 (CEST)
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

This version is rebased on 4.2-rc1 and has fixed the style issues identfied
in last review

Jeeja KP (3):
  ASoC: Intel: add Skylake HDA platform driver
  ASoC: Intel - add Skylake HDA audio driver
  ASoC: Intel - add makefile support for SKL driver

Vinod Koul (1):
  ASoC: intel - adds support for decoupled mode in skl driver

 sound/soc/intel/Kconfig           |   7 +
 sound/soc/intel/Makefile          |   1 +
 sound/soc/intel/skylake/Makefile  |   3 +
 sound/soc/intel/skylake/skl-pcm.c | 936 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c     | 543 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h     |  71 +++
 6 files changed, 1561 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile
 create mode 100644 sound/soc/intel/skylake/skl-pcm.c
 create mode 100644 sound/soc/intel/skylake/skl.c
 create mode 100644 sound/soc/intel/skylake/skl.h

-- 
1.9.1
