From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] i.MX ssi: MX31ads sound support should
	depend on MACH_MX31ADS
Date: Mon, 31 May 2010 10:49:53 +0200
Message-ID: <1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CD6F6243E3
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 10:49:56 +0200 (CEST)
In-Reply-To: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index eba9b9d..11b4bcc 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -13,7 +13,7 @@ config SND_MXC_SOC_SSI
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
-	depends on SND_IMX_SOC && EXPERIMENTAL
+	depends on SND_IMX_SOC && MACH_MX31ADS && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_SSI
 	help
-- 
1.7.1
