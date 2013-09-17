From: <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio
Date: Tue, 17 Sep 2013 12:26:05 +0300
Message-ID: <c59efc1524b19f50dc37606bfa246dde9c20d312.1379409268.git.jsarha@ti.com>
References: <cover.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>

AM33xx uses same McASP IP as the Davinci Platform. This patch updates
Kconfig and makefile to enable build for McASP, PCM & Codec drivers.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/Kconfig  |   18 +++++++++++++++---
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index c82f89c..6c8e687 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,9 +1,10 @@
 config SND_DAVINCI_SOC
-	tristate "SoC Audio for the TI DAVINCI chip"
-	depends on ARCH_DAVINCI
+	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
+	depends on ARCH_DAVINCI || SOC_AM33XX
 	help
+	  Machine driver for DAVINCI audio.
 	  Say Y or M if you want to add support for codecs attached to
-	  the DAVINCI AC97 or I2S interface. You will also need
+	  the DAVINCI AC97, I2S, or McASP interface. You will also need
 	  to select the audio interfaces to support below.
 
 config SND_DAVINCI_SOC_I2S
@@ -15,6 +16,17 @@ config SND_DAVINCI_SOC_MCASP
 config SND_DAVINCI_SOC_VCIF
 	tristate
 
+config SND_AM33XX_SOC_EVM
+	tristate "SoC Audio for the AM33XX chip based boards"
+	select SND_DAVINCI_SOC
+	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for SoC audio on AM33XX
+	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
+	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
+	  setup.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a396ab6..bc81e79 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM33XX_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
