From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] ASoC Blackfin and API updates
Date: Mon, 29 Sep 2008 14:39:51 +0100
Message-ID: <20080929133951.GA20161@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7568D2438A
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 15:39:52 +0200 (CEST)
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

The following changes since commit ad7f41b60efde140df0f929e8d408ebe2e59cb0e:
  Jean Delvare (1):
        ALSA: Drop Vladimir Barinov's e-mail address

adding the Blackfin updates Brian posted over the weekend plus some more
usage of snd_soc_dapm_nc_pin() are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Cliff Cai (4):
      ASoC codec: AD73311 audio codec driver
      ASoC Blackfin: add I2S DAI support for AD73311
      ASoC Blackfin: add asoc ad73311 driver supporting in Blackfin boards
      ASoC Blackfin: fix bug - Audio Latency on AD1981 with MMAP enabled

Mark Brown (2):
      ASoC: Use snd_soc_dapm_nc_pin() in Zaurus machine drivers
      ASoC: Use snd_soc_dapm_nc_pin() in N810 machine driver

 sound/soc/blackfin/Kconfig          |   16 +++
 sound/soc/blackfin/Makefile         |    3 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   42 +++++-
 sound/soc/blackfin/bf5xx-ac97.c     |    1 -
 sound/soc/blackfin/bf5xx-ad73311.c  |  240 +++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-i2s.c      |   47 +++++--
 sound/soc/blackfin/bf5xx-sport.h    |    2 +
 sound/soc/codecs/Kconfig            |    4 +
 sound/soc/codecs/Makefile           |    2 +
 sound/soc/codecs/ad73311.c          |  107 ++++++++++++++++
 sound/soc/codecs/ad73311.h          |   90 +++++++++++++
 sound/soc/omap/n810.c               |    6 +-
 sound/soc/pxa/corgi.c               |    4 +-
 sound/soc/pxa/poodle.c              |    4 +-
 sound/soc/pxa/spitz.c               |   14 +-
 sound/soc/pxa/tosa.c                |    4 +-
 16 files changed, 547 insertions(+), 39 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad73311.c
 create mode 100644 sound/soc/codecs/ad73311.c
 create mode 100644 sound/soc/codecs/ad73311.h
