From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 0/4] ASoC AC97 audio support for ep93xx
Date: Sun, 10 Oct 2010 13:54:08 +0300
Message-ID: <cover.1286707213.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F718103819
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 12:54:08 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1497128bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 03:54:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, Mika Westerberg <mika.westerberg@iki.fi>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

This series adds AC97 audio support for Cirrus Logic EP93xx family SoCs. Example
machine driver is for Simplemachines Sim.One (which is the only hardware that I
have which has AC97 codec).

The first patch is a bugfix for the DMA code. Without the patch audio DMA
transfers may corrupt if playing application is killed while playing. This
results weird noise playback when application is started again. I would like
Ryan Mallon to confirm that this is indeed correct fix and if possible to check
that I2S transfers still work after this patch is applied.

Please review.

Thanks,
MW

Mika Westerberg (4):
  ARM: ep93xx: DMA: fix channel_disable
  ASoC: add ep93xx AC97 audio driver
  ARM: ep93xx: add AC97 platform support
  ASoC: ep93xx: add Simplemachines Sim.One AC97 audio support

 arch/arm/mach-ep93xx/core.c                     |   32 ++
 arch/arm/mach-ep93xx/dma-m2p.c                  |    2 +-
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    1 +
 sound/soc/ep93xx/Kconfig                        |   17 +-
 sound/soc/ep93xx/Makefile                       |    4 +
 sound/soc/ep93xx/ep93xx-ac97.c                  |  476 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-ac97.h                  |   17 +
 sound/soc/ep93xx/simone.c                       |   80 ++++
 10 files changed, 629 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.c
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.h
 create mode 100644 sound/soc/ep93xx/simone.c
