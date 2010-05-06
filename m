From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL} ASoC updates for 2.6.35
Date: Thu, 06 May 2010 15:47:02 +0100
Message-ID: <1273157222.2992.46.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6387A2475A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 16:47:06 +0200 (CEST)
Received: by fxm2 with SMTP id 2so23070fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 07:47:04 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit cb7b76961f73e4ae934d44f7b2e7ba974442f2fe:
  Takashi Iwai (1):
        Merge branch 'for-2.6.35' of git://git.kernel.org/.../lrg/asoc-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.35

Jarkko Nikula (2):
      ASoC: omap: Add basic audio support for Nokia RX-51/N900
      ASoC: tlv320aic3x: Add platform data and reset gpio handling

Liam Girdwood (3):
      ASoC: pandora - update DAPM pins
      ASoC: zoom2 - update DAPM pins
      ASoC: tlv320dac33 - disable regulators at i2c remove()

Peter Ujfalusi (9):
      ASoC: TWL4030: AIF/APLL fix in DAPM domain
      ASoC: TWL4030: Remove OUTL/R outputs
      ASoC: tlv320dac33: Optimize power up, and restore
      ASoC: tlv320dac33: Revised module loading, and DAC33 ID read
      ASoC: tlv320dac33: Manage a pointer for snd_pcm_substream in private structure
      ASoC: tlv320dac33: Support for turning off the codec
      ASoC: tpa6130a2: TLV mapping for tpa6140a2
      ASoC: tpa6130a2: Support for limiting gain
      ASoC: tlv320dac33: Use codec defaults for LOM/LOP and DAC power

 include/sound/tlv320aic3x.h    |   17 +++
 include/sound/tpa6130a2-plat.h |    1 +
 sound/soc/codecs/tlv320aic3x.c |   25 ++++
 sound/soc/codecs/tlv320dac33.c |  223 ++++++++++++++++--------------
 sound/soc/codecs/tpa6130a2.c   |   99 +++++++++++++-
 sound/soc/codecs/twl4030.c     |   86 ++++++++----
 sound/soc/omap/Kconfig         |   10 ++
 sound/soc/omap/Makefile        |    2 +
 sound/soc/omap/omap3pandora.c  |    2 -
 sound/soc/omap/rx51.c          |  294 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/zoom2.c         |    3 -
 11 files changed, 619 insertions(+), 143 deletions(-)
 create mode 100644 include/sound/tlv320aic3x.h
 create mode 100644 sound/soc/omap/rx51.c
