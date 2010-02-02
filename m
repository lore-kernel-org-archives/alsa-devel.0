From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Tue, 2 Feb 2010 13:51:52 +0000
Message-ID: <20100202135152.GA31841@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95F04243EE
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 14:51:54 +0100 (CET)
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

The following changes since commit 9e6e96a197a03752d39a63e4f83e0b707ccedad7:
  Mark Brown (1):
        ASoC: Add WM8994 CODEC driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Daniel Mack (1):
      ASoC: fix PXA SSP port resume

Joe Perches (1):
      ASoC: Fix continuation line formats

Joonyoung Shim (1):
      ASoC: Fix BCLK calculation of WM8994

Mark Brown (1):
      ASoC: Fix WM8994 dependency

 sound/soc/codecs/Kconfig    |    2 +-
 sound/soc/codecs/wm8994.c   |    7 ++-----
 sound/soc/pxa/pxa-ssp.c     |   12 +++++++-----
 sound/soc/s3c24xx/s3c-pcm.c |    3 +--
 4 files changed, 11 insertions(+), 13 deletions(-)
