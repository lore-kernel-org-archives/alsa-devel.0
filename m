From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 19 Jan 2011 10:22:48 +0000
Message-ID: <20110119102248.GA16485@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6ABCE2439C
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 11:22:30 +0100 (CET)
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
To: Takasi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 18b022eb117e7f70c191267551ff865f278a9258:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-01-12 12:26:24 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Alexander Sverdlin (1):
      ASoC: EP93xx: fixed LRCLK rate and DMA oper. in I2S code

Barry Song (2):
      ASoC: Blackfin TDM: use external frame syncs
      ASoC: Blackfin: fix DAI/SPORT config dependency issues

Dimitris Papastamos (1):
      ASoC: WM8990: msleep() takes milliseconds not jiffies

Matti J. Aaltonen (1):
      ASoC: WL1273 FM radio: Fix breakage with MFD API changes

Mike Frysinger (2):
      ASoC: Blackfin TDM: fix missed snd_soc_dai_get_drvdata update
      ASoC: Blackfin AC97: fix build error after multi-component update

Seungwhan Youn (1):
      ASoC: documentation updates

Vasily Khoruzhick (2):
      ASoC: PXA: Fix jack detection on Zipit Z2
      ASoC: PXA: Fix codec address on Zipit Z2

 Documentation/sound/alsa/soc/codec.txt    |   45 +++++++++----------
 Documentation/sound/alsa/soc/machine.txt  |   38 ++++------------
 Documentation/sound/alsa/soc/platform.txt |   12 ++++-
 sound/soc/blackfin/Kconfig                |   11 +++--
 sound/soc/blackfin/bf5xx-ac97.c           |    4 +-
 sound/soc/blackfin/bf5xx-tdm.c            |   10 ++--
 sound/soc/codecs/Kconfig                  |    2 +-
 sound/soc/codecs/wl1273.c                 |   29 +++++-------
 sound/soc/codecs/wl1273.h                 |   71 -----------------------------
 sound/soc/codecs/wm8990.c                 |   10 ++--
 sound/soc/ep93xx/ep93xx-i2s.c             |   18 ++++----
 sound/soc/pxa/z2.c                        |    3 +-
 12 files changed, 82 insertions(+), 171 deletions(-)
