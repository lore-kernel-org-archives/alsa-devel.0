From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 00/10] ASoC Support For Moorestown
Date: Fri, 06 May 2011 13:45:57 +0800
Message-ID: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C5207103839
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:44:31 +0200 (CEST)
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

v2:
 - change pr_err to dev_err
 - change DAPM widgets' name (adding correct suffix)
 - change to data based init of controls, widgets and route in machine driver
 - add Master Volume
 - change original "HP & Spker Mixer Volume" to "PCM Volume"
 - squash some patches into one, resulting in less number of patches
 - move jack handling from machine driver to codec driver
 - in codec probe, set the bias level to standby instead of off

Thanks for all the reviewers:
 - Mark Brown
 - Dimitris Papastamos
 - Takashi Iwai
 - Koul Vinod

Any more comments are welcome. :)

---

Lu Guanqun (8):
      ASoC: upd9976: Add Renesas uPD9976 codec driver
      ASoC: mrst_machine: add moorestown machine driver
      ASoC: upd9976: add DMIC support
      ASoC: upd9976: add Analog MIC support
      ASoC: upd9976: add jack detection function
      ASoC: mrst_machine: add capture functionality
      ASoC: mrst_machine: add jack detection support
      ASoC: mrst_machine: add initial config to machine driver

Wang Xingchao (2):
      ASoC: sst_platform: modify current cpu dai driver to suit the needs for moorestown platform
      ASoC: upd9976: add capture ability for dai driver


 sound/soc/codecs/Kconfig         |    4 
 sound/soc/codecs/Makefile        |    2 
 sound/soc/codecs/upd9976.c       |  697 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/upd9976.h       |   87 +++++
 sound/soc/mid-x86/Kconfig        |   12 +
 sound/soc/mid-x86/Makefile       |    2 
 sound/soc/mid-x86/mrst_machine.c |  228 ++++++++++++
 sound/soc/mid-x86/sst_platform.c |   13 -
 8 files changed, 1041 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/codecs/upd9976.c
 create mode 100644 sound/soc/codecs/upd9976.h
 create mode 100644 sound/soc/mid-x86/mrst_machine.c

-- 
guanqun
