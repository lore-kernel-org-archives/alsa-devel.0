From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Fri, 22 May 2009 21:21:24 +0100
Message-ID: <20090522202122.GA4722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FE822452B
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 22:21:34 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit e24805dd85283ac0912b9c400768a4d171b400ff:
  Atsushi Nemoto (1):
        ASoC: Add TXx9 AC link controller driver (v3)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Mark Brown (2):
      ASoC: Make snd_soc_read() and snd_soc_write() functions
      ASoC: WM9081 mono DAC with integrated 2.6W class AB/D amplifier driver

Peter Ujfalusi (5):
      ASoC: TWL4030: Change DAPM routings and controls for DACs and PGAs
      ASoC: TWL4030: Move the Headset pop-attenuation code to PGA event
      ASoC: TWL4030: Add support for platform dependent configuration
      ASoC: SDP4030: Use the twl4030_setup_data for headset pop-removal
      ASoC: TWL4030: Differentiate the playback streams

 include/sound/soc.h        |   17 +-
 include/sound/wm9081.h     |   25 +
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl4030.c |  285 ++++++---
 sound/soc/codecs/twl4030.h |    5 +
 sound/soc/codecs/wm9081.c  | 1532 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm9081.h  |  787 +++++++++++++++++++++++
 sound/soc/omap/sdp3430.c   |    7 +
 9 files changed, 2559 insertions(+), 105 deletions(-)
 create mode 100644 include/sound/wm9081.h
 create mode 100644 sound/soc/codecs/wm9081.c
 create mode 100644 sound/soc/codecs/wm9081.h
