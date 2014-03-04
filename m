From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/4] ASoC: davinci: Add SND_AM43XX_SOC_EPOS_EVM build option
Date: Tue, 4 Mar 2014 15:54:51 +0200
Message-ID: <1c376b7219e364b419fa57610f381dddfdde4a53.1393941102.git.jsarha@ti.com>
References: <cover.1393941102.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1393941102.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add support for am335x and am43x based boards with tlv320aic31xx
compatible codec connected to McASP.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/Kconfig  |   12 ++++++++++++
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index a8ec1fc..e1e3663 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -26,6 +26,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM43XX_SOC_EPOS_EVM
+	tristate "SoC Audio for the AM33XX/AM43XX and TLV320AIC31XX based board"
+	depends on SND_DAVINCI_SOC
+	depends on SOC_AM33XX || SOC_AM43XX
+	select SND_SOC_TLV320AIC31XX
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for SoC audio on
+	  AM335X/AM43XX boards using McASP to connect to a codec of
+	  TLV320AIC31XX series. For example AM43XX-EPOS-EVM has such a
+	  setup.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 744d4d9..d61998f 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM43XX_SOC_EPOS_EVM) += snd-soc-evm.o
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
