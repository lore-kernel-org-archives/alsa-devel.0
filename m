From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: omap: Make RX51 depend on GPIOLIB due to
	jack usage
Date: Mon, 20 Jan 2014 23:00:01 +0000
Message-ID: <1390258801-26986-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98ACD2619D0
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 00:00:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since the GPIO jacks are only supported if gpiolib is built and fail to
compile otherwise add a build depedency.  This is unlikely to have any
practical impact outside of coverage testing.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/omap/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4a07f7179690..22ad9c5654b5 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -30,6 +30,7 @@ config SND_OMAP_SOC_RX51
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
+	depends on GPIOLIB
 	help
 	  Say Y if you want to add support for SoC audio on Nokia RX-51
 	  hardware. This is also known as Nokia N900 product.
-- 
1.8.5.2
