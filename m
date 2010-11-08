From: Marek Belisko <marek.belisko@gmail.com>
Subject: [PATCH] ASoC: s3c24xx: Fix compilation problem.
Date: Mon,  8 Nov 2010 13:14:51 +0100
Message-ID: <1289218491-17700-1-git-send-email-marek.belisko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: alsa-devel@alsa-project.org

When make mini2440_defconfig compilation end with undefined
references to DMA functions. There was missing selection
for S3C2410_DMA when compile ASoC audio for S3C24xx CPU.
Tested on mini2440 board.

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 sound/soc/s3c24xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 8a6b53c..d85bf8a 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -2,6 +2,7 @@ config SND_S3C24XX_SOC
 	tristate "SoC Audio for the Samsung S3CXXXX chips"
 	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210
 	select S3C64XX_DMA if ARCH_S3C64XX
+	select S3C2410_DMA if ARCH_S3C2410
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the S3C24XX AC97 or I2S interfaces. You will also need to
-- 
1.7.1
