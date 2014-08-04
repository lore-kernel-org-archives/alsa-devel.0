From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci: Enable menuconfig entry for
	McASP
Date: Mon, 4 Aug 2014 08:56:27 +0300
Message-ID: <1407131787-17171-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 179A726164D
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 07:56:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

In order to be able to use simple-card with McASP on TI SoC based boards we
need to be able to select the McASP via menuconfig.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index b310dd3489ac..d69510c53239 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -16,8 +16,14 @@ config SND_DAVINCI_SOC_I2S
 	tristate
 
 config SND_DAVINCI_SOC_MCASP
+	tristate "Multichannel Audio Serial Port (McASP) support"
 	depends on SND_DAVINCI_SOC || SND_OMAP_SOC || SND_EDMA_SOC
-	tristate
+	help
+	  Say Y or M here if you want to have support for McASP IP found in
+	  various Texas Instruments SoCs like:
+	  - daVinci devices
+	  - Sitara line of SoCs (AM335x, AM438x, etc)
+	  - DRA7x devices
 
 config SND_DAVINCI_SOC_VCIF
 	tristate
-- 
2.0.2
