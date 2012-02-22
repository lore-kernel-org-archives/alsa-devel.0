From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: imx: move SND_SOC_AC97_BUS selection
	down to machine driver
Date: Wed, 22 Feb 2012 21:25:47 +0800
Message-ID: <1329917147-24962-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8828103F18
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:12:29 +0100 (CET)
Received: by yenm14 with SMTP id m14so1767yen.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 05:12:28 -0800 (PST)
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
Rather than selecting the option under SND_IMX_SOC, it's better to
leave the selection to individual machine driver which knows if AC97
support is needed or not.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index e89139f..7c4aa42 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX SSI interface.
@@ -37,6 +36,7 @@ config SND_SOC_MX27VIS_AIC32X4
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
+	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
 	help
-- 
1.7.5.4
