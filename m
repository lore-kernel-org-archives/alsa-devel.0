From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 1 Sep 2009 13:52:57 +0100
Message-ID: <20090901125257.GA20475@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AFF0244DC
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 14:52:59 +0200 (CEST)
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

The following changes since commit d2c0bdaa9362c4b2ab7416420d034a0a2d1ec979:
  Jarkko Nikula (1):
        ASoC: OMAP: Add functionality to set CLKR and FSR sources in McBSP DAI

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: new board driver to connect bfin-5xx with ad1836 codec

jassi brar (1):
      ASoC: Debugged improper setting of PLL fields in WM8580 driver

 sound/soc/blackfin/Kconfig        |    8 ++
 sound/soc/blackfin/Makefile       |    2 +
 sound/soc/blackfin/bf5xx-ad1836.c |  128 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8580.c         |    4 +-
 4 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad1836.c
