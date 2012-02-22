From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
Date: Wed, 22 Feb 2012 16:40:26 +0800
Message-ID: <1329900026-24270-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 90A472456B
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 09:27:12 +0100 (CET)
Received: by iabz21 with SMTP id z21so10991259iab.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 00:27:09 -0800 (PST)
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

CONFIG_FIQ is only needed when CONFIG_SND_MXC_SOC_FIQ is selected to
build imx-pcm-fiq.c, so let SND_MXC_SOC_FIQ select FIQ.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 91b66ef..e89139f 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select FIQ
 	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -11,6 +10,7 @@ menuconfig SND_IMX_SOC
 if SND_IMX_SOC
 
 config SND_MXC_SOC_FIQ
+	select FIQ
 	tristate
 
 config SND_MXC_SOC_MX2
-- 
1.7.5.4
