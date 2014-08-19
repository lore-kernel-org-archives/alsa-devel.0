From: Sean Cross <xobs@kosagi.com>
Subject: [PATCH] ASoC: fsl: Fix building of imx-es8328 on PPC
Date: Tue, 19 Aug 2014 12:49:34 +0800
Message-ID: <1408423775-3236-1-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.g1.pair.com (mail1.g1.pair.com [66.39.3.162])
 by alsa0.perex.cz (Postfix) with ESMTP id C81EE2655F9
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 06:49:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lars@metafoo.de, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Nicolin Chen <b42378@freescale.com>, alsa-devel@alsa-project.org
Cc: Sean Cross <xobs@kosagi.com>, bunnie@kosagi.com
List-Id: alsa-devel@alsa-project.org

The imx-es8328 driver fails to build on PPC because it explicitly depends on
SND_SOC_IMX_PCM_FIQ, which itself doesn't build on PPC.  Instead, rely on
the SND_SOC_FSL_SSI config option to pull in the necessary libraries.

While we're at it, remove SND_SOC_FSL_UTILS, which also is not needed.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 sound/soc/fsl/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index c0ace69..13199b5 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -237,8 +237,6 @@ config SND_SOC_IMX_ES8328
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_FSL_SSI
-	select SND_SOC_FSL_UTILS
-	select SND_SOC_IMX_PCM_FIQ
 	help
 	  Say Y if you want to add support for the ES8328 audio codec connected
 	  via SSI/I2S over either SPI or I2C.
-- 
2.0.0
