From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 00/19] ASoC for moorestown
Date: Wed, 04 May 2011 21:44:53 +0800
Message-ID: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A429B10381B
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

This series of patches provides the ASoC implementation of moorestown audio.

This series adds a new codec called upd9976 and a new machine driver called
mrst_machine.  The platform driver is mostly re-used.

With this patchset, it can do:
 - playback via headphone
 - playback via internal speaker
 - capture via DMIC
 - capture via headset microphone
 - jack detection

However, other functionalities such as voice support in uPD9976 codec is not
implemented yet.  This patchset mainly focuses on the audio support in uPD9976
codec.

Any comments are welcome.

---

Lu Guanqun (17):
      ASoC: upd9976: Add Renesas uPD9976 codec driver
      ASoC: sst_platform: add cpu dai driver for moorestown platform
      ASoC: mrst_machine: add moorestown machine driver
      ASoC: mrst_machine: add speaker widget to moorestown machine driver
      ASoC: mrst_machine: enable user to select different output
      ASoC: upd9976: add DMIC support
      ASoC: upd9976: add Analog MIC support
      ASoC: upd9976: add microphone bias support
      ASoC: upd9976: add jack detection function
      ASoC: mrst_machine: add capture functionality
      ASoC: mrst_machine: add jack detection support
      ASoC: upd9976: add mute switch for DMIC
      ASoC: upd9976: add mute switch for analog
      ASoC: mrst_machine: make DMIC's output to PCM2 mono
      ASoC: mrst_machine: make MIC2 pseudo-differential
      ASoC: upd9976: add capture volume for analog inputs
      ASoC: upd9976: add capture volume for DMIC

Wang Xingchao (2):
      ASoC: upd9976: add capture ability for dai driver
      ASoC: sst_platform: add capture capability for cpu dai driver


 sound/soc/codecs/Kconfig         |    4 
 sound/soc/codecs/Makefile        |    2 
 sound/soc/codecs/upd9976.c       |  569 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/upd9976.h       |   85 ++++++
 sound/soc/mid-x86/Kconfig        |   12 +
 sound/soc/mid-x86/Makefile       |    2 
 sound/soc/mid-x86/mrst_machine.c |  365 ++++++++++++++++++++++++
 sound/soc/mid-x86/sst_platform.c |   20 +
 8 files changed, 1059 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/upd9976.c
 create mode 100644 sound/soc/codecs/upd9976.h
 create mode 100644 sound/soc/mid-x86/mrst_machine.c

-- 
guanqun
