From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v11 4/8] ASoC: fsl: Kconfig,
	visible config items for simple card
Date: Mon, 19 Aug 2013 17:05:57 +0200
Message-ID: <1376924761-4054-5-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D579C265007
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 17:07:38 +0200 (CEST)
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The simple sound card does not automatically select the used
chipdrivers. This patch makes them user-selectable so simple sound cards
can be used without a problem.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3a4808d..247e340 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,5 +1,11 @@
 config SND_SOC_FSL_SSI
-	tristate
+	tristate "Freescale SSI unit"
+	help
+	  Say Y here if you want tou use a Freescale SSI unit. This option is
+	  automatically selected if your board has a seperated sound card
+	  driver. If you are using one of the generic drivers, please select
+	  this manually.
+
 
 config SND_SOC_FSL_UTILS
 	tristate
@@ -109,15 +115,24 @@ config SND_SOC_IMX_SSI
 	tristate
 
 config SND_SOC_IMX_PCM_FIQ
-	tristate
+	tristate "i.MX PCM FIQ"
 	select FIQ
+	help
+	  Say Y here if you are using a generic soundcard and you have a chip
+	  that with this audio muxer. Otherwise select N.
 
 config SND_SOC_IMX_PCM_DMA
-	tristate
+	tristate "i.MX PCM DMA"
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y here if you are using a generic soundcard and you have a DMA
+	  capable SSI unit. Otherwise select N.
 
 config SND_SOC_IMX_AUDMUX
-	tristate
+	tristate "i.MX Audio muxer"
+	help
+	  Say Y here if you are using a generic soundcard and you have chip
+	  with this audio muxer. Otherwise select N.
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
-- 
1.8.4.rc3
