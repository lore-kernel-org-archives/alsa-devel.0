From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/9] ASoC: tas2552: Correct Boost Auto-Pass
	Through Control register usage
Date: Mon, 8 Jun 2015 15:19:51 +0300
Message-ID: <1433765996-28930-5-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 74D24260415
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:09 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Correct the bit definition so the code will change the bits what it
supposed to change. Also rename the register define to
TAS2552_BOOST_APT_CTRL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c |  6 +++---
 sound/soc/codecs/tas2552.h | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index e4c02ee42966..202c3f4a6390 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -45,7 +45,7 @@ static struct reg_default tas2552_reg_defs[] = {
 	{TAS2552_OUTPUT_DATA, 0xc0},
 	{TAS2552_PDM_CFG, 0x01},
 	{TAS2552_PGA_GAIN, 0x00},
-	{TAS2552_BOOST_PT_CTRL, 0x0f},
+	{TAS2552_BOOST_APT_CTRL, 0x0f},
 	{TAS2552_RESERVED_0D, 0xbe},
 	{TAS2552_LIMIT_RATE_HYS, 0x08},
 	{TAS2552_CFG_2, 0xef},
@@ -601,8 +601,8 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, TAS2552_OUTPUT_DATA,
 		      TAS2552_PDM_DATA_SEL_V_I |
 		      TAS2552_R_DATA_OUT(TAS2552_DATA_OUT_V_DATA));
-	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
-				TAS2552_APT_THRESH_2_1_7);
+	snd_soc_write(codec, TAS2552_BOOST_APT_CTRL, TAS2552_APT_DELAY_200 |
+						     TAS2552_APT_THRESH_20_17);
 
 	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_BOOST_EN |
 				  TAS2552_APT_EN | TAS2552_LIM_EN);
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 4a22f598ecb6..f62a1bcb2e49 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -39,7 +39,7 @@
 #define TAS2552_PDM_CFG			0x11
 #define TAS2552_PGA_GAIN		0x12
 #define TAS2552_EDGE_RATE_CTRL	0x13
-#define TAS2552_BOOST_PT_CTRL	0x14
+#define TAS2552_BOOST_APT_CTRL		0x14
 #define TAS2552_VER_NUM			0x16
 #define TAS2552_VBAT_DATA		0x19
 #define TAS2552_MAX_REG			0x20
@@ -127,16 +127,15 @@
 #define TAS2552_PDM_CLK_SEL_MASK	TAS2552_PDM_CLK_SEL_MCLK
 #define TAS2552_PDM_DATA_ES	 	(1 << 2)
 
-/* Boost pass-through register */
-#define TAS2552_APT_DELAY_50	0x00
-#define TAS2552_APT_DELAY_75	(1 << 1)
-#define TAS2552_APT_DELAY_125	(1 << 2)
-#define TAS2552_APT_DELAY_200	(1 << 3)
-
-#define TAS2552_APT_THRESH_2_5		0x00
-#define TAS2552_APT_THRESH_1_7		(1 << 3)
-#define TAS2552_APT_THRESH_1_4_1_1	(1 << 4)
-#define TAS2552_APT_THRESH_2_1_7	(0x11 << 2)
+/* Boost Auto-pass through register */
+#define TAS2552_APT_DELAY_50		(0x0 << 0)
+#define TAS2552_APT_DELAY_75		(0x1 << 0)
+#define TAS2552_APT_DELAY_125		(0x2 << 0)
+#define TAS2552_APT_DELAY_200		(0x3 << 0)
+#define TAS2552_APT_THRESH_05_02	(0x0 << 2)
+#define TAS2552_APT_THRESH_10_07	(0x1 << 2)
+#define TAS2552_APT_THRESH_14_11	(0x2 << 2)
+#define TAS2552_APT_THRESH_20_17	(0x3 << 2)
 
 /* PLL Control Register */
 #define TAS2552_PLL_J_MASK		0x7f
-- 
2.4.2
