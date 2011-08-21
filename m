From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Sun, 21 Aug 2011 13:08:43 +0100
Message-ID: <20110821120843.GA12673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D81624361
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 14:08:45 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit f6b864a9071e21186476910613ec9913b56067a2:

  ASoC: Fix compile warning in wm8750.c (2011-08-12 18:22:10 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

The biggest change here is cleaning up the ad193x mess - there appear to
have been quite a few issues on top of the entertainment with the
register I/O.

Axel Lin (2):
      ASoC: soc-jack: Fix checking return value of request_any_context_irq
      ASoC: sta32x: Fix a memory leak if snd_soc_register_codec fails

Jarkko Nikula (1):
      ASoC: omap: Fix build errors in ams-delta

Mark Brown (1):
      ASoC: Move WM8962 CLKREG_OVD earlier

Sascha Hauer (1):
      ASoC: Fix check for symmetric rate enforcement

Scott Jiang (5):
      ASoC: ad193x: fix registers definition
      ASoC: ad193x: fix dac word len setting
      ASoC: ad193x: fix system clock
      ASoC: Add spi hw read function for 16 addr 8 data mode for ad193x fix
      ASoC: ad193x: remove cache support

Vasily Khoruzhick (2):
      ASoC: h1940: Fix compilation error due to missing header
      ASoC: rx1950: Fix compilation error due to missing header

 sound/soc/blackfin/bf5xx-ad193x.c  |    2 +-
 sound/soc/codecs/ad193x.c          |   11 ++---------
 sound/soc/codecs/ad193x.h          |    5 +++--
 sound/soc/codecs/sta32x.c          |    1 +
 sound/soc/codecs/wm8962.c          |    8 ++++----
 sound/soc/omap/ams-delta.c         |    6 ++++--
 sound/soc/samsung/h1940_uda1380.c  |    1 +
 sound/soc/samsung/rx1950_uda1380.c |    1 +
 sound/soc/soc-io.c                 |   23 +++++++++++++++++++++++
 sound/soc/soc-jack.c               |    2 +-
 sound/soc/soc-pcm.c                |    3 +++
 11 files changed, 44 insertions(+), 19 deletions(-)
