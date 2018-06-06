From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Wed,  6 Jun 2018 21:38:08 +0200
Message-ID: <20180606193811.16007-1-malat@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Make it possible to select SND_JZ4740_SOC_I2S on MACH_JZ4780

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 sound/soc/jz4740/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6b6e87..35d82d96e781 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,20 +1,20 @@
 config SND_JZ4740_SOC
-	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
+	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-	  the JZ4740 I2S interface. You will also need to select the audio
+	  the JZ4740/JZ4780 I2S interface. You will also need to select the audio
 	  interfaces to support below.
 
 if SND_JZ4740_SOC
 
 config SND_JZ4740_SOC_I2S
-	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
+	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740/JZ4780 SoC"
 	depends on HAS_IOMEM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
-	  based boards.
+	  or JZ4780 based boards.
 
 config SND_JZ4740_SOC_QI_LB60
 	tristate "SoC Audio support for Qi LB60"
-- 
2.11.0
