From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates
Date: Thu, 2 Oct 2008 11:02:00 +0100
Message-ID: <20081002100200.GA3025@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98FC8244F0
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 12:02:01 +0200 (CEST)
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

The following changes since commit 2e2ed79f64e935540b0d148f7e2c3ebefafe133e:
  Vladimir Barinov (1):
        ALSA: Correct Vladimir Barinov's e-mail address

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Of these only the patch from Rob is 2.6.27 material.

Arun KS (1):
      ASoC: Add destination and source port for DMA on OMAP1

Frank Mandarino (1):
      ASoC: Remove references to Endrelia ETI-B1 board

Jonas Bonn (2):
      ASoC: Add widgets before setting endpoints on GTA01
      ASoC: Drop device registration from GTA01 lm4857 driver

Rob Sims (1):
      ASoC: Set correct name for WM8753 rec mixer output

 sound/soc/at91/Kconfig             |   17 --
 sound/soc/at91/Makefile            |    5 -
 sound/soc/at91/eti_b1_wm8731.c     |  349 ------------------------------------
 sound/soc/codecs/wm8753.c          |    4 +-
 sound/soc/omap/omap-pcm.c          |    4 +-
 sound/soc/s3c24xx/neo1973_wm8753.c |   57 +-----
 6 files changed, 14 insertions(+), 422 deletions(-)
 delete mode 100644 sound/soc/at91/eti_b1_wm8731.c
