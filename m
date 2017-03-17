From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs35l35: Stash dev pointer directly
	rather than CODEC pointer
Date: Fri, 17 Mar 2017 15:44:55 +0000
Message-ID: <1489765495-8502-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D872669D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 16:43:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The driver stashes a CODEC pointer in the cs35l35_private structure,
which is used to obtain a struct device pointer for error messages in the
interrupt handler.

However, doing so is not very safe as the interrupt is registered, as it
should be in bus probe, but the CODEC pointer can't be safely stored until
the ASoC level probe. This leaves a window between the two probes where if
any interrupts are received a NULL pointer will be deferenced in the IRQ
handler.

Fix this issue by saving a pointer to the device directly and passing that
to the error messages in the interrupt handler rather than using the CODEC
pointer to access the device pointer.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 29 ++++++++++++++---------------
 sound/soc/codecs/cs35l35.h |  2 +-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 05117fc..1d9f332 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -741,8 +741,6 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 	struct monitor_cfg *monitor_config = &cs35l35->pdata.mon_cfg;
 	int ret;
 
-	cs35l35->codec = codec;
-
 	/* Set Platform Data */
 	if (cs35l35->pdata.bst_vctl)
 		regmap_update_bits(cs35l35->regmap, CS35L35_BST_CVTR_V_CTL,
@@ -1004,7 +1002,6 @@ static struct regmap_config cs35l35_regmap = {
 static irqreturn_t cs35l35_irq(int irq, void *data)
 {
 	struct cs35l35_private *cs35l35 = data;
-	struct snd_soc_codec *codec = cs35l35->codec;
 	unsigned int sticky1, sticky2, sticky3, sticky4;
 	unsigned int mask1, mask2, mask3, mask4, current1;
 
@@ -1032,7 +1029,7 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 
 	/* handle the interrupts */
 	if (sticky1 & CS35L35_CAL_ERR) {
-		dev_crit(codec->dev, "Calibration Error\n");
+		dev_crit(cs35l35->dev, "Calibration Error\n");
 
 		/* error is no longer asserted; safe to reset */
 		if (!(current1 & CS35L35_CAL_ERR)) {
@@ -1051,10 +1048,10 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky1 & CS35L35_AMP_SHORT) {
-		dev_crit(codec->dev, "AMP Short Error\n");
+		dev_crit(cs35l35->dev, "AMP Short Error\n");
 		/* error is no longer asserted; safe to reset */
 		if (!(current1 & CS35L35_AMP_SHORT)) {
-			dev_dbg(codec->dev, "Amp short error release\n");
+			dev_dbg(cs35l35->dev, "Amp short error release\n");
 			regmap_update_bits(cs35l35->regmap,
 					CS35L35_PROT_RELEASE_CTL,
 					CS35L35_SHORT_RLS, 0);
@@ -1069,11 +1066,11 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky1 & CS35L35_OTW) {
-		dev_warn(codec->dev, "Over temperature warning\n");
+		dev_warn(cs35l35->dev, "Over temperature warning\n");
 
 		/* error is no longer asserted; safe to reset */
 		if (!(current1 & CS35L35_OTW)) {
-			dev_dbg(codec->dev, "Over temperature warn release\n");
+			dev_dbg(cs35l35->dev, "Over temperature warn release\n");
 			regmap_update_bits(cs35l35->regmap,
 					CS35L35_PROT_RELEASE_CTL,
 					CS35L35_OTW_RLS, 0);
@@ -1088,10 +1085,10 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky1 & CS35L35_OTE) {
-		dev_crit(codec->dev, "Over temperature error\n");
+		dev_crit(cs35l35->dev, "Over temperature error\n");
 		/* error is no longer asserted; safe to reset */
 		if (!(current1 & CS35L35_OTE)) {
-			dev_dbg(codec->dev, "Over temperature error release\n");
+			dev_dbg(cs35l35->dev, "Over temperature error release\n");
 			regmap_update_bits(cs35l35->regmap,
 					CS35L35_PROT_RELEASE_CTL,
 					CS35L35_OTE_RLS, 0);
@@ -1106,7 +1103,7 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky3 & CS35L35_BST_HIGH) {
-		dev_crit(codec->dev, "VBST error: powering off!\n");
+		dev_crit(cs35l35->dev, "VBST error: powering off!\n");
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
 			CS35L35_PDN_AMP, CS35L35_PDN_AMP);
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
@@ -1114,7 +1111,7 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky3 & CS35L35_LBST_SHORT) {
-		dev_crit(codec->dev, "LBST error: powering off!\n");
+		dev_crit(cs35l35->dev, "LBST error: powering off!\n");
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
 			CS35L35_PDN_AMP, CS35L35_PDN_AMP);
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
@@ -1122,13 +1119,13 @@ static irqreturn_t cs35l35_irq(int irq, void *data)
 	}
 
 	if (sticky2 & CS35L35_VPBR_ERR)
-		dev_dbg(codec->dev, "Error: Reactive Brownout\n");
+		dev_dbg(cs35l35->dev, "Error: Reactive Brownout\n");
 
 	if (sticky4 & CS35L35_VMON_OVFL)
-		dev_dbg(codec->dev, "Error: VMON overflow\n");
+		dev_dbg(cs35l35->dev, "Error: VMON overflow\n");
 
 	if (sticky4 & CS35L35_IMON_OVFL)
-		dev_dbg(codec->dev, "Error: IMON overflow\n");
+		dev_dbg(cs35l35->dev, "Error: IMON overflow\n");
 
 	return IRQ_HANDLED;
 }
@@ -1365,6 +1362,8 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	if (!cs35l35)
 		return -ENOMEM;
 
+	cs35l35->dev = dev;
+
 	i2c_set_clientdata(i2c_client, cs35l35);
 	cs35l35->regmap = devm_regmap_init_i2c(i2c_client, &cs35l35_regmap);
 	if (IS_ERR(cs35l35->regmap)) {
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index c203081..156d2f0 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -265,7 +265,7 @@
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 struct  cs35l35_private {
-	struct snd_soc_codec *codec;
+	struct device *dev;
 	struct cs35l35_platform_data pdata;
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[2];
-- 
2.1.4
