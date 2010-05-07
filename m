From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Fri, 7 May 2010 17:46:11 +0100
Message-ID: <20100507164611.GF25793@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C3421038BA
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 18:47:57 +0200 (CEST)
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 340DF11012A
	for <alsa-devel@alsa-project.org>; Fri,  7 May 2010 17:47:57 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.71)
	(envelope-from <broonie@rakim.wolfsonmicro.main>) id 1OAQiS-0005PZ-NB
	for alsa-devel@alsa-project.org; Fri, 07 May 2010 17:47:56 +0100
Resent-Message-ID: <20100507164756.GG25793@rakim.wolfsonmicro.main>
Resent-To: alsa-devel@alsa-project.org
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
Cc: alsa-devel@alsa-project.rog, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit aeb29a82de7c80d4d0253b042f17eb1f725b08f1:
  Takashi Iwai (1):
        Merge branch 'for-2.6.35' of git://git.kernel.org/.../lrg/asoc-2.6 into topic/asoc

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-2.6.35

Note the change in git server - master.kernel.org appears to be having
issues at the minute.

Jassi Brar (12):
      ASoC: S3C: I2Sv2: Move defines closer to driver
      ASoC: SAMSUNG: I2S: Add bit definitions
      ASoC: S3C2412: I2S: Debug IMS field
      ASoC: S3C2412: I2S: Return correct source clock
      ASoC: S3C: I2Sv2: Discard redundant field iis_clk
      ASoC: S3C: I2Sv2: Unify i2s_get_clock callback
      ASoC: S3C64XX: I2S: Use s3c2412 defines
      ASoC: S3C: I2Sv2: New field for controller feature
      ASoC: S3C: I2S: Move set_sysclk to common code
      ARM: S3C2412: DMA: Remove I2S FIFO address
      ASoC: S3C64XX: IISv4: Add CPU driver
      ASoC: SMDK64XX: Switch to IISv4 CPU driver

Mark Brown (2):
      ASoC: Add debug output tracing all cache register writes
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.35

Peter Ujfalusi (3):
      ASoC: core: Support for limiting the volume
      Revert "ASoC: tpa6130a2: Support for limiting gain"
      ASoC: tpa6130a2: Fix for the custom kcontrol functions

 arch/arm/mach-s3c2412/dma.c                        |    3 -
 .../plat-samsung/include/plat/regs-s3c2412-iis.h   |   82 --------
 include/sound/soc.h                                |    2 +
 include/sound/tpa6130a2-plat.h                     |    1 -
 sound/soc/codecs/tpa6130a2.c                       |   90 ++-------
 sound/soc/s3c24xx/Kconfig                          |   12 +-
 sound/soc/s3c24xx/Makefile                         |    2 +
 sound/soc/s3c24xx/jive_wm8750.c                    |    2 +-
 sound/soc/s3c24xx/regs-i2s-v2.h                    |  115 +++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.c                     |   87 ++++++---
 sound/soc/s3c24xx/s3c-i2s-v2.h                     |   11 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                    |   41 +----
 sound/soc/s3c24xx/s3c2412-i2s.h                    |    2 -
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c                 |  209 ++++++++++++++++++++
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |   57 +-----
 sound/soc/s3c24xx/s3c64xx-i2s.h                    |    3 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c                |    6 +-
 sound/soc/soc-cache.c                              |   12 ++
 sound/soc/soc-core.c                               |   39 ++++
 19 files changed, 484 insertions(+), 292 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
 create mode 100644 sound/soc/s3c24xx/regs-i2s-v2.h
 create mode 100644 sound/soc/s3c24xx/s3c64xx-i2s-v4.c
