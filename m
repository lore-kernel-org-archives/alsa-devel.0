From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/7] ASoC: intel - add skylake PCM driver
Date: Wed, 29 Apr 2015 01:24:23 +0530
Message-ID: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DDD4260427
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:26 +0200 (CEST)
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

This patch series adds the hda codec wrapper first followed by asoc hda
controller library, then SKL PCM driver and last decouples the controller
for splitting the links

Jeeja KP (7):
  ASoC: hda - add soc hda codec driver wrapper
  ALSA: hda - add new HDA registers
  ASoC: hda - adds SoC controller and stream operations
  ASoC: intel - add Skylake HDA platform driver
  ASoC: intel - add Skylake HDA audio driver
  ASoC: intel - add makefile support for SKL driver
  ASoC: intel - adds support for decoupled mode in skl driver

 include/sound/hda_register.h          |   87 +++
 include/sound/soc-hdaudio.h           |  343 ++++++++++++
 sound/soc/Kconfig                     |    1 +
 sound/soc/Makefile                    |    1 +
 sound/soc/hda/Kconfig                 |    3 +
 sound/soc/hda/Makefile                |    3 +
 sound/soc/hda/soc-hda-codec.c         |   85 +++
 sound/soc/hda/soc-hda-codec.h         |   44 ++
 sound/soc/hda/soc-hdac-controller.c   |  289 ++++++++++
 sound/soc/hda/soc-hdac-stream.c       |  390 ++++++++++++++
 sound/soc/intel/Kconfig               |   20 +
 sound/soc/intel/Makefile              |    1 +
 sound/soc/intel/skylake/Makefile      |    3 +
 sound/soc/intel/skylake/hda-skl-pcm.c |  933 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/hda-skl.c     |  743 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/hda-skl.h     |   74 +++
 16 files changed, 3020 insertions(+)
 create mode 100644 include/sound/soc-hdaudio.h
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/soc-hda-codec.c
 create mode 100644 sound/soc/hda/soc-hda-codec.h
 create mode 100644 sound/soc/hda/soc-hdac-controller.c
 create mode 100644 sound/soc/hda/soc-hdac-stream.c
 create mode 100644 sound/soc/intel/skylake/Makefile
 create mode 100644 sound/soc/intel/skylake/hda-skl-pcm.c
 create mode 100644 sound/soc/intel/skylake/hda-skl.c
 create mode 100644 sound/soc/intel/skylake/hda-skl.h

-- 
1.7.9.5
