From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 10/20] ASoC: imx: add an explicit Kconfig
	option for imx-ssi driver
Date: Sat,  3 Mar 2012 23:19:51 +0800
Message-ID: <1330788001-10158-11-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A0DCB103A87
	for <alsa-devel@alsa-project.org>; Sat,  3 Mar 2012 16:06:58 +0100 (CET)
Received: by mail-iy0-f179.google.com with SMTP id h37so3836616iak.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Mar 2012 07:06:58 -0800 (PST)
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Currently ASoC:imx uses menuconfig option SND_IMX_SOC selects imx-ssi
driver, and it works because all the machine driver covered by the
menuconfig need to build imx-ssi driver in.  However, it will not work
any more if we have a imx based machine driver going into the menuconfig
while working with fsl_ssi driver (sound/soc/fsl/fsl_ssi.c) rather than
imx-ssi one.

The patch adds an explicit Kconfig option SND_SOC_IMX_SSI for imx-ssi
driver, so that it can be selected independently from the menuconfig
option SND_IMX_SOC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig  |    7 +++++++
 sound/soc/imx/Makefile |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 2566032..810acaa 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -8,6 +8,9 @@ menuconfig SND_IMX_SOC
 
 if SND_IMX_SOC
 
+config SND_SOC_IMX_SSI
+	tristate
+
 config SND_SOC_IMX_PCM
 	tristate
 
@@ -30,6 +33,7 @@ config SND_MXC_SOC_WM1133_EV1
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_FIQ
 	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_SSI
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
@@ -40,6 +44,7 @@ config SND_SOC_MX27VIS_AIC32X4
 	select SND_SOC_TLV320AIC32X4
 	select SND_MXC_SOC_MX2
 	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
 	  board with TLV320AIC32X4 codec.
@@ -51,6 +56,7 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
 	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
@@ -65,6 +71,7 @@ config SND_SOC_EUKREA_TLV320
 	select SND_SOC_TLV320AIC23
 	select SND_MXC_SOC_FIQ
 	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_SSI
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index e9ed362..f5db3e9 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,8 +1,8 @@
 # i.MX Platform Support
-snd-soc-imx-objs := imx-ssi.o
+snd-soc-imx-ssi-objs := imx-ssi.o
 snd-soc-imx-audmux-objs := imx-audmux.o
 
-obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
+obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
 obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
 obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
-- 
1.7.5.4
