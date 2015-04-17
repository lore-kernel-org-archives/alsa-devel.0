From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/7] ASoC: hda - add ASoC Skylake HD audio
	driver
Date: Fri, 17 Apr 2015 14:43:13 +0530
Message-ID: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AC96C260538
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:18:49 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This version incorporates the comments from Takashi & Mark on last RFC
series. This also clubs the ASoC HDA wrapper and controller driver to single
series. This is based on for ASoC Skylake HD Audio driver and based on
Takashi's topic/hda Dropped the based on comments
  ALSA: hda - add id table support for hdac device/driver
  ALSA: hda - Add generic helper function to register/unregister driver
  ALSA: hda - add generic function to unregister all devices on bus Dropped
the below patch and add new patch
  ALSA: hda - add id table support for hdac device/driver

Jeeja KP (6):
  ALSA: hda - add generic functions to set hdac stream params
  ASoC: hda - add soc hda codec driver wrapper
  ASoC: hda - add Skylake platform driver
  ASoC: hda - add Skylake HD audio driver
  ASoC: hda - enable ASoC Skylake HD audio driver
  ASoC: hda - added Skylake I2S machine driver

Ramesh Babu (1):
  ALSA: hda - add ASoC device type for hda core

 include/sound/hdaudio.h          |    4 +
 sound/hda/hdac_stream.c          |   31 ++
 sound/soc/Kconfig                |    1 +
 sound/soc/Makefile               |    1 +
 sound/soc/codecs/Kconfig         |    3 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/soc-hda-codec.c |   79 ++++
 sound/soc/codecs/soc-hda-codec.h |   43 +++
 sound/soc/hda/Kconfig            |   43 +++
 sound/soc/hda/Makefile           |    6 +
 sound/soc/hda/boards/Makefile    |    3 +
 sound/soc/hda/boards/skl_rt286.c |  313 ++++++++++++++++
 sound/soc/hda/hda_skl.c          |  748 ++++++++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_skl.h          |   44 +++
 sound/soc/hda/hda_skl_pcm.c      |  498 +++++++++++++++++++++++++
 15 files changed, 1819 insertions(+)
 create mode 100644 sound/soc/codecs/soc-hda-codec.c
 create mode 100644 sound/soc/codecs/soc-hda-codec.h
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/boards/Makefile
 create mode 100644 sound/soc/hda/boards/skl_rt286.c
 create mode 100644 sound/soc/hda/hda_skl.c
 create mode 100644 sound/soc/hda/hda_skl.h
 create mode 100644 sound/soc/hda/hda_skl_pcm.c

-- 
1.7.9.5
