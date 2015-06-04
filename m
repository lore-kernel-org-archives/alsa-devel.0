From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/22] ASoC: tas2552: Correct PDM configuration
	register bit definitions
Date: Thu, 4 Jun 2015 15:22:28 +0300
Message-ID: <1433420571-5421-5-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F012662AA
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:07 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The PDM clock can be selected via bit0-1.
PDM_DATA_ES bit is at bit2.

The code were trying to select BCLK as PDM reference clock but instead
it was selecting PLL and set the DATA_ES bit to 1.
Selecting the PLL output as reference clock as default does make sense,
but the driver should not change the PDM data edge.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c |  2 +-
 sound/soc/codecs/tas2552.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 9954bd4c14f3..07a0ec03905d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -376,7 +376,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 				TAS2552_DIN_SRC_SEL_AVG_L_R | TAS2552_88_96KHZ);
 	snd_soc_write(codec, TAS2552_DOUT, TAS2552_PDM_DATA_I);
 	snd_soc_write(codec, TAS2552_OUTPUT_DATA, TAS2552_PDM_DATA_V_I | 0x8);
-	snd_soc_write(codec, TAS2552_PDM_CFG, TAS2552_PDM_BCLK_SEL);
+	snd_soc_write(codec, TAS2552_PDM_CFG, TAS2552_PDM_CLK_SEL_PLL);
 	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
 				TAS2552_APT_THRESH_2_1_7);
 
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 6cea8f31bf88..938d90f1cab9 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -99,12 +99,12 @@
 #define TAS2552_PDM_DATA_V_I	(0x11 << 6)
 
 /* PDM CFG Register */
-#define TAS2552_PDM_DATA_ES_RISE 0x4
-
-#define TAS2552_PDM_PLL_CLK_SEL 0x00
-#define TAS2552_PDM_IV_CLK_SEL	(1 << 1)
-#define TAS2552_PDM_BCLK_SEL	(1 << 2)
-#define TAS2552_PDM_MCLK_SEL	(1 << 3)
+#define TAS2552_PDM_CLK_SEL_PLL		(0x0 << 0)
+#define TAS2552_PDM_CLK_SEL_IVCLKIN	(0x1 << 0)
+#define TAS2552_PDM_CLK_SEL_BCLK	(0x2 << 0)
+#define TAS2552_PDM_CLK_SEL_MCLK	(0x3 << 0)
+#define TAS2552_PDM_CLK_SEL_MASK	TAS2552_PDM_CLK_SEL_MCLK
+#define TAS2552_PDM_DATA_ES	 	(1 << 2)
 
 /* Boost pass-through register */
 #define TAS2552_APT_DELAY_50	0x00
-- 
2.4.2
