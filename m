From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 0/5] Version 5
Date: Thu, 24 May 2012 15:24:45 +0200
Message-ID: <1337865885-25957-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id E8DE924495
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 15:24:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

*) ALSA-core helper function made static inline
*) Removed debug-functions from the core-patch
*) Bug-fixes in codec-file
*) Controversial controls (clock-stuff) moved to machine-file
*) Removed custom functions for second codec-interface
*) Streams moved to separete DAPM-widgets

Ola Lilja (5):
  ALSA: pcm: Add debug-print helper function
  ASoC: core: Add widget SND_SOC_DAPM_CLOCK_SUPPLY
  ASoC: Ux500: Add platform-driver
  ASoC: codecs: Add AB8500 codec-driver
  ASoC: Ux500: Add machine-driver

 include/sound/pcm.h             |   11 +
 include/sound/soc-dapm.h        |   10 +
 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/ab8500-codec.c | 2569 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ab8500-codec.h |  606 +++++++++
 sound/soc/soc-dapm.c            |   38 +
 sound/soc/ux500/Kconfig         |   18 +
 sound/soc/ux500/Makefile        |    6 +
 sound/soc/ux500/mop500.c        |  117 ++
 sound/soc/ux500/mop500_ab8500.c |  441 +++++++
 sound/soc/ux500/mop500_ab8500.h |   22 +
 sound/soc/ux500/ux500_pcm.c     |  318 +++++
 sound/soc/ux500/ux500_pcm.h     |   35 +
 14 files changed, 4197 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ab8500-codec.c
 create mode 100644 sound/soc/codecs/ab8500-codec.h
 create mode 100644 sound/soc/ux500/mop500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

-- 
1.7.8.3
