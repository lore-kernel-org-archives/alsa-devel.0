From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Thu, 15 Oct 2009 15:40:39 +0100
Message-ID: <20091015144039.GB24756@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42EFC24539
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 16:40:40 +0200 (CEST)
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

The following changes since commit ebab1b1d07266ab8ca9f65065e68b02f05504c4e:
  Mark Brown (1):
        ASoC: Minor fixups to tpa6130a2 driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Ben Dooks (1):
      ASoC: S3C: Remove <plat/audio.h>

Eero Nurkkala (1):
      ASoC: Serialize access to dapm_power_widgets()

Igor Grinberg (1):
      ASoC: finally enable support for eXeda and CM-X300

Mark Brown (2):
      ASoC: Remove snd_soc_suspend_device()
      Merge branch 'for-2.6.32' into for-2.6.33

Peter Ujfalusi (2):
      ASoC: TPA6130A2: Make tpa6130a2_power as static
      ASoC: Codec driver for Texas Instruments tlv320dac33 codec

 arch/arm/plat-s3c/include/plat/audio.h |   45 --
 include/sound/soc.h                    |    5 -
 include/sound/tlv320dac33-plat.h       |   20 +
 sound/soc/codecs/Kconfig               |    4 +
 sound/soc/codecs/Makefile              |    2 +
 sound/soc/codecs/cs4270.c              |   20 -
 sound/soc/codecs/tlv320dac33.c         | 1237 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320dac33.h         |  267 +++++++
 sound/soc/codecs/tpa6130a2.c           |    2 +-
 sound/soc/codecs/tpa6130a2.h           |    1 -
 sound/soc/codecs/wm8350.c              |   17 -
 sound/soc/codecs/wm8400.c              |   17 -
 sound/soc/codecs/wm8523.c              |   17 -
 sound/soc/codecs/wm8580.c              |   17 -
 sound/soc/codecs/wm8711.c              |   17 -
 sound/soc/codecs/wm8731.c              |   34 -
 sound/soc/codecs/wm8753.c              |   35 -
 sound/soc/codecs/wm8776.c              |   34 -
 sound/soc/codecs/wm8900.c              |   17 -
 sound/soc/codecs/wm8903.c              |   17 -
 sound/soc/codecs/wm8940.c              |   17 -
 sound/soc/codecs/wm8960.c              |   17 -
 sound/soc/codecs/wm8961.c              |   17 -
 sound/soc/codecs/wm8988.c              |   34 -
 sound/soc/codecs/wm9081.c              |   17 -
 sound/soc/pxa/Kconfig                  |    3 +-
 sound/soc/s3c24xx/neo1973_wm8753.c     |    1 -
 sound/soc/s3c24xx/s3c-i2s-v2.c         |    1 -
 sound/soc/s3c24xx/s3c2412-i2s.c        |    1 -
 sound/soc/s3c24xx/s3c2443-ac97.c       |    1 -
 sound/soc/s3c24xx/s3c24xx-i2s.c        |    2 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c        |    1 -
 sound/soc/s3c24xx/s3c64xx-i2s.c        |    1 -
 sound/soc/soc-core.c                   |   39 -
 sound/soc/soc-dapm.c                   |    2 +-
 35 files changed, 1535 insertions(+), 444 deletions(-)
 delete mode 100644 arch/arm/plat-s3c/include/plat/audio.h
 create mode 100644 include/sound/tlv320dac33-plat.h
 create mode 100644 sound/soc/codecs/tlv320dac33.c
 create mode 100644 sound/soc/codecs/tlv320dac33.h
