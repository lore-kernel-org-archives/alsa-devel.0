From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH v2 4/7] ASoC: sti: helper functions for unip
	tdm slots configuration
Date: Thu, 7 Apr 2016 11:25:33 +0200
Message-ID: <1460021136-27822-5-git-send-email-moise.gergaud@st.com>
References: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id EA1302661CD
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:25:59 +0200 (CEST)
In-Reply-To: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

- sti_uniperiph_set_tdm_slot: store tdm slot config in unip context
- sti_uniperiph_get_tdm_word_pos: configure unip tdm slots pos regs

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sti/uniperif.h     | 23 +++++++++++
 2 files changed, 113 insertions(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 39bcefe..0c2474c 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -11,6 +11,96 @@
 #include "uniperif.h"
 
 /*
+ * User frame size shall be 2, 4, 6 or 8 32-bits words length
+ * (i.e. 8, 16, 24 or 32 bytes)
+ * This constraint comes from allowed values for
+ * UNIPERIF_I2S_FMT_NUM_CH register
+ */
+#define UNIPERIF_MAX_FRAME_SZ 0x20
+#define UNIPERIF_ALLOWED_FRAME_SZ (0x08 | 0x10 | 0x18 | UNIPERIF_MAX_FRAME_SZ)
+
+int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *uni = priv->dai_data.uni;
+	int i, frame_size, avail_slots;
+
+	if (!UNIPERIF_TYPE_IS_TDM(uni)) {
+		dev_err(uni->dev, "cpu dai not in tdm mode\n");
+		return -EINVAL;
+	}
+
+	/* store info in unip context */
+	uni->tdm_slot.slots = slots;
+	uni->tdm_slot.slot_width = slot_width;
+	/* unip is unidirectionnal */
+	uni->tdm_slot.mask = (tx_mask != 0) ? tx_mask : rx_mask;
+
+	/* number of available timeslots */
+	for (i = 0, avail_slots = 0; i < uni->tdm_slot.slots; i++) {
+		if ((uni->tdm_slot.mask >> i) & 0x01)
+			avail_slots++;
+	}
+	uni->tdm_slot.avail_slots = avail_slots;
+
+	/* frame size in bytes */
+	frame_size = uni->tdm_slot.avail_slots * uni->tdm_slot.slot_width / 8;
+
+	/* check frame size is allowed */
+	if ((frame_size > UNIPERIF_MAX_FRAME_SZ) ||
+	    (frame_size & ~(int)UNIPERIF_ALLOWED_FRAME_SZ)) {
+		dev_err(uni->dev, "frame size not allowed: %d bytes\n",
+			frame_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
+				   unsigned int *word_pos)
+{
+	int slot_width = uni->tdm_slot.slot_width / 8;
+	int slots_num = uni->tdm_slot.slots;
+	unsigned int slots_mask = uni->tdm_slot.mask;
+	int i, j, k;
+	unsigned int word16_pos[4];
+
+	/* word16_pos:
+	 * word16_pos[0] = WORDX_LSB
+	 * word16_pos[1] = WORDX_MSB,
+	 * word16_pos[2] = WORDX+1_LSB
+	 * word16_pos[3] = WORDX+1_MSB
+	 */
+
+	/* set unip word position */
+	for (i = 0, j = 0, k = 0; (i < slots_num) && (k < WORD_MAX); i++) {
+		if ((slots_mask >> i) & 0x01) {
+			word16_pos[j] = i * slot_width;
+
+			if (slot_width == 4) {
+				word16_pos[j + 1] = word16_pos[j] + 2;
+				j++;
+			}
+			j++;
+
+			if (j > 3) {
+				word_pos[k] = word16_pos[1] |
+					      (word16_pos[0] << 8) |
+					      (word16_pos[3] << 16) |
+					      (word16_pos[2] << 24);
+				j = 0;
+				k++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
  * sti_uniperiph_dai_create_ctrl
  * This function is used to create Ctrl associated to DAI but also pcm device.
  * Request is done by front end to associate ctrl with pcm device id
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 750eb5a..fb8e427 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1270,6 +1270,14 @@ enum uniperif_iec958_encoding_mode {
 	UNIPERIF_IEC958_ENCODING_MODE_ENCODED
 };
 
+enum uniperif_word_pos {
+	WORD_1_2,
+	WORD_3_4,
+	WORD_5_6,
+	WORD_7_8,
+	WORD_MAX
+};
+
 struct uniperif_info {
 	int id; /* instance value of the uniperipheral IP */
 	enum uniperif_type type;
@@ -1281,6 +1289,13 @@ struct uniperif_iec958_settings {
 	struct snd_aes_iec958 iec958;
 };
 
+struct dai_tdm_slot {
+	unsigned int mask;
+	int slots;
+	int slot_width;
+	unsigned int avail_slots;
+};
+
 struct uniperif {
 	/* System information */
 	struct uniperif_info *info;
@@ -1317,6 +1332,7 @@ struct uniperif {
 
 	/* dai properties */
 	unsigned int daifmt;
+	struct dai_tdm_slot tdm_slot;
 
 	/* DAI callbacks */
 	const struct snd_soc_dai_ops *dai_ops;
@@ -1373,4 +1389,11 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai);
 
+int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width);
+
+int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
+				   unsigned int *word_pos);
+
 #endif
-- 
1.9.1
