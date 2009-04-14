From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Tue, 14 Apr 2009 13:32:20 +0100
Message-ID: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEC9F24156
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:32:21 +0200 (CEST)
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

The following changes since commit 34e51ce60a210094bd66cf0a75dd8512247618ca:
  Takashi Iwai (1):
        Merge branch 'for-2.6.30' of git://git.kernel.org/.../broonie/sound=
-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.31

Alexander Beregalov (1):
      ASoC: n810: replace BUG() with BUG_ON()

Daniel Gl=F6ckner (3):
      ASoC: Add driver for s6000 I2S interface
      ASoC: s6105 IP camera machine specific ASoC code
      ASoC: correct s6000 I2S clock polarity

Daniel Ribeiro (1):
      ASoC: pxa-ssp.c fix clock/frame invert

Mark Brown (11):
      ASoC: Display return code when failing to add a DAPM kcontrol
      ASoC: Provide core support for symmetric sample rates
      ASoC: Add WM8988 CODEC driver
      Merge branch 's6000' into for-2.6.31
      ASoC: WM9713 requires symmetric rates on the voice DAI
      ASoC: Factor out application of power for generic widgets
      ASoC: Support DAPM events for DACs and ADCs
      ASoC: Move the WM9713 voice DAC powerdown to a DAPM event
      ASoC: Add WM8960 CODEC driver
      Merge branch 'for-2.6.30' into for-2.6.31
      Merge branch 'for-2.6.30' into for-2.6.31

Peter Ujfalusi (1):
      ASoC: tlv320aic23: add DSP_A format support

 include/sound/soc-dai.h        |    1 +
 include/sound/soc-dapm.h       |   10 +
 include/sound/soc.h            |    6 +
 sound/soc/Kconfig              |    1 +
 sound/soc/Makefile             |    1 +
 sound/soc/codecs/Kconfig       |    8 +
 sound/soc/codecs/Makefile      |    4 +
 sound/soc/codecs/tlv320aic23.c |    2 +
 sound/soc/codecs/wm8960.c      |  969 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8960.h      |  127 +++++
 sound/soc/codecs/wm8988.c      | 1097 ++++++++++++++++++++++++++++++++++++=
++++
 sound/soc/codecs/wm8988.h      |   60 +++
 sound/soc/codecs/wm9713.c      |   40 +-
 sound/soc/omap/n810.c          |    7 +-
 sound/soc/pxa/pxa-ssp.c        |   11 +-
 sound/soc/s6000/Kconfig        |   19 +
 sound/soc/s6000/Makefile       |   11 +
 sound/soc/s6000/s6000-i2s.c    |  629 +++++++++++++++++++++++
 sound/soc/s6000/s6000-i2s.h    |   25 +
 sound/soc/s6000/s6000-pcm.c    |  497 ++++++++++++++++++
 sound/soc/s6000/s6000-pcm.h    |   35 ++
 sound/soc/s6000/s6105-ipcam.c  |  244 +++++++++
 sound/soc/soc-core.c           |   38 ++
 sound/soc/soc-dapm.c           |  131 +++---
 24 files changed, 3893 insertions(+), 80 deletions(-)
 create mode 100644 sound/soc/codecs/wm8960.c
 create mode 100644 sound/soc/codecs/wm8960.h
 create mode 100644 sound/soc/codecs/wm8988.c
 create mode 100644 sound/soc/codecs/wm8988.h
 create mode 100644 sound/soc/s6000/Kconfig
 create mode 100644 sound/soc/s6000/Makefile
 create mode 100644 sound/soc/s6000/s6000-i2s.c
 create mode 100644 sound/soc/s6000/s6000-i2s.h
 create mode 100644 sound/soc/s6000/s6000-pcm.c
 create mode 100644 sound/soc/s6000/s6000-pcm.h
 create mode 100644 sound/soc/s6000/s6105-ipcam.c
