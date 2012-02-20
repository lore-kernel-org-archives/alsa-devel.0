From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: imx/mxs: remove redundant SND_PCM
	selection
Date: Mon, 20 Feb 2012 15:05:24 +0800
Message-ID: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id AD3BC246C4
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 07:52:30 +0100 (CET)
Received: by pbbrp2 with SMTP id rp2so6227750pbb.38
	for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2012 22:52:29 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

SND_PCM is already selected by SND_SOC, there is no need for
SND_IMX_SOC and SND_MXS_SOC to select it again.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    1 -
 sound/soc/mxs/Kconfig |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 7383917..91b66ef 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select SND_PCM
 	select FIQ
 	select SND_SOC_AC97_BUS
 	help
diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index e4ba8d5..21d20f3 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
 	depends on ARCH_MXS
-	select SND_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the MXS SAIF interface.
-- 
1.7.5.4
