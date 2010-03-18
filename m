From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: SIU driver shall select FW_LOADER
Date: Thu, 18 Mar 2010 09:39:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The SIU ASoC driver must load firmware to program the DSP, therefore it 
has to select FW_LOADER in its Kconfig entry.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 1066749..f07f6d8 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -32,6 +32,7 @@ config SND_SOC_SH4_SIU
 	select DMA_ENGINE
 	select DMADEVICES
 	select SH_DMAE
+	select FW_LOADER
 
 ##
 ## Boards
