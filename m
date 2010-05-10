From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Mon, 10 May 2010 18:15:12 +0100
Message-ID: <20100510171512.GA14458@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDD2D247E1
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 19:15:13 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit d0bbc24d2ab78d9efc61bc80cfc85f59626ba5af:
  Jassi Brar (1):
        ASoC: SMDK64XX: Switch to IISv4 CPU driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Mark Brown (8):
      ASoC: Remove unneeded suspend bias managment from CODEC drivers
      ASoC: Remove unused DAPM suspend flag
      ASoC: Refactor DAPM suspend handling
      ASoC: Support leaving paths enabled over system suspend
      ASoC: Allow active paths from the GSM modem while the GTA02 is suspended
      ASoC: Allow DAI links to be kept active over suspend
      ASoC: Refactor WM8731 regulator management into bias management
      ASoC: Use more idiomatic driver name for WM8731

 drivers/mfd/wm831x-irq.c                 |   30 ++++++++++
 include/sound/soc-dapm.h                 |    3 +-
 include/sound/soc.h                      |    3 +
 sound/soc/codecs/ak4535.c                |    1 -
 sound/soc/codecs/cq93vc.c                |    2 +-
 sound/soc/codecs/ssm2602.c               |    1 -
 sound/soc/codecs/stac9766.c              |    3 -
 sound/soc/codecs/tlv320aic23.c           |    1 -
 sound/soc/codecs/tlv320aic3x.c           |    2 +-
 sound/soc/codecs/tlv320dac33.c           |    3 -
 sound/soc/codecs/twl4030.c               |    1 -
 sound/soc/codecs/twl6040.c               |    1 -
 sound/soc/codecs/uda1380.c               |    1 -
 sound/soc/codecs/wm8350.c                |    3 -
 sound/soc/codecs/wm8510.c                |    2 +-
 sound/soc/codecs/wm8711.c                |    2 +-
 sound/soc/codecs/wm8728.c                |    2 +-
 sound/soc/codecs/wm8731.c                |   54 +++++++++--------
 sound/soc/codecs/wm8903.c                |    1 -
 sound/soc/codecs/wm8940.c                |    1 -
 sound/soc/codecs/wm8960.c                |    2 +-
 sound/soc/codecs/wm8974.c                |    2 +-
 sound/soc/codecs/wm9712.c                |    3 -
 sound/soc/codecs/wm9713.c                |    3 -
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c |    8 +++
 sound/soc/soc-core.c                     |   73 ++++++++++++++++++++++--
 sound/soc/soc-dapm.c                     |   92 +++++++++++++++++++-----------
 27 files changed, 206 insertions(+), 94 deletions(-)
