From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Thu, 4 Feb 2010 12:40:01 +0000
Message-ID: <20100204124001.GA15074@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E83224404
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 13:40:04 +0100 (CET)
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

The following changes since commit 026384d614b827f368834860c9b623ce08439b7e:
  Daniel Mack (1):
        ASoC: fix PXA SSP port resume

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Guennadi Liakhovetski (1):
      ASoC: fix compilation breakage in sound/soc/sh/fsi.c

Mark Brown (8):
      ASoC: Allow CODECs to ask soc-cache to suppress physical writes
      ASoC: Add a cache_sync bit to the CODEC structure
      ASoC: Convert WM8993 to use shared cache I/O code
      ASoC: Initial WM8993 regulator API hookup
      ASoC: Disable WM8993 regulators when turning bias off
      ASoC: Add support for BIAS_OFF when idle to WM8904
      ASoC: Optimise WM8904 output stage power control
      ASoC: Add WM8912 DAC support

Peter Ujfalusi (1):
      ASoC: TWL4030: Module unloading fix

 include/sound/soc.h        |    2 +
 sound/soc/codecs/twl4030.c |    5 +-
 sound/soc/codecs/wm8904.c  |  176 ++++++++++++++++++++++++-------
 sound/soc/codecs/wm8993.c  |  247 ++++++++++++++++++++++---------------------
 sound/soc/sh/fsi.c         |   40 +++----
 sound/soc/soc-cache.c      |   36 ++++++-
 6 files changed, 320 insertions(+), 186 deletions(-)
