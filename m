From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
	slot_width override.
Date: Thu,  6 Aug 2009 15:55:17 +0100
Message-ID: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE9AC24545
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 16:55:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <boshen9@gmail.com>, Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Ribeiro <drwyrm@gmail.com>

Extend set_tdm_slot to allow the user to arbitrarily set the frame width
and active TX/RX slots.

Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
still doesn't handle the slot_width override.

While being there, correct an incorrect use of SlotsPerFrm(7) use in
bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).

(this series is meant for Mark's for-2.6.32 branch)

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h   |    5 +++--
 sound/soc/codecs/wm9081.c |    5 +++--
 sound/soc/pxa/magician.c  |    2 +-
 sound/soc/pxa/pxa-ssp.c   |   27 ++++++++++++++++++++-------
 sound/soc/soc-core.c      |    9 ++++++---
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 25d62ac..2d3fa29 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
 
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots);
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
 
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 
@@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
 	 */
 	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
-		unsigned int mask, int slots);
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	/*
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 156f2a4..c965323 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1214,8 +1214,9 @@ static int wm9081_set_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+/* FIXME: Needs to handle slot_width */
 static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
-			       unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	unsigned int aif1 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
@@ -1227,7 +1228,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 
 	aif1 |= (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
 
-	switch (mask) {
+	switch (rx_mask) {
 	case 1:
 		break;
 	case 2:
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 8889cd3..9f7c61e 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -190,7 +190,7 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index e22c5ce..5b9ed64 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
  * Set the active slots in TDM/Network mode
  */
 static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->dev.ssp;
 	u32 sscr0;
 
-	sscr0 = ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+	sscr0 &= ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS | SSCR0_DSS);
+
+	/* set slot width */
+	if (slot_width > 16)
+		sscr0 |= SSCR0_EDSS | SSCR0_DataSize(slot_width - 16);
+	else
+		sscr0 |= SSCR0_DataSize(slot_width);
 
-	/* set number of active slots */
-	sscr0 |= SSCR0_SlotsPerFrm(slots);
+	if (slots > 1) {
+		/* enable network mode */
+		sscr0 |= SSCR0_MOD;
+
+		/* set number of active slots */
+		sscr0 |= SSCR0_SlotsPerFrm(slots);
+
+		/* set active slot mask */
+		ssp_write_reg(ssp, SSTSA, tx_mask);
+		ssp_write_reg(ssp, SSRSA, rx_mask);
+	}
 	ssp_write_reg(ssp, SSCR0, sscr0);
 
-	/* set active slot mask */
-	ssp_write_reg(ssp, SSTSA, mask);
-	ssp_write_reg(ssp, SSRSA, mask);
 	return 0;
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fb8d7a7..e984a17 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2223,17 +2223,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 /**
  * snd_soc_dai_set_tdm_slot - configure DAI TDM.
  * @dai: DAI
- * @mask: DAI specific mask representing used slots.
+ * @tx_mask: bitmask representing active TX slots.
+ * @rx_mask: bitmask representing active RX slots.
  * @slots: Number of slots in use.
+ * @slot_width: Width in bits for each slot.
  *
  * Configures a DAI for TDM operation. Both mask and slots are codec and DAI
  * specific.
  */
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	if (dai->ops && dai->ops->set_tdm_slot)
-		return dai->ops->set_tdm_slot(dai, mask, slots);
+		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+				slots, slot_width);
 	else
 		return -EINVAL;
 }
-- 
1.6.3.3
