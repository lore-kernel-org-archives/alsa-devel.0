From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
Date: Thu, 23 Feb 2012 14:47:21 +0800
Message-ID: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E161E10400E
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:34:01 +0100 (CET)
Received: by dady9 with SMTP id y9so1003556dad.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 22:33:59 -0800 (PST)
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
index 91b66ef..17810d9 100644
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
@@ -12,6 +11,7 @@ if SND_IMX_SOC
 
 config SND_MXC_SOC_FIQ
 	tristate
+	select FIQ
 
 config SND_MXC_SOC_MX2
 	tristate
-- 
1.7.5.4
