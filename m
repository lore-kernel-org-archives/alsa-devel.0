From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 3/7] ASoC: sti: reset refactoring
Date: Mon, 24 Oct 2016 16:42:53 +0200
Message-ID: <1477320177-30130-4-git-send-email-arnaud.pouliquen@st.com>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D4667266CB9
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:15 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Reset is common to player and reader, migrate function in sti_uniperif.c

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c    | 23 +++++++++++++++++++++++
 sound/soc/sti/uniperif.h        |  2 ++
 sound/soc/sti/uniperif_player.c | 34 +++-------------------------------
 sound/soc/sti/uniperif_reader.c | 15 +--------------
 4 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index ee91ae5..98eb205 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/delay.h>
 
 #include "uniperif.h"
 
@@ -97,6 +98,28 @@ struct sti_uniperiph_dev_data {
 	{},
 };
 
+int  sti_uniperiph_reset(struct uniperif *uni)
+{
+	int count = 10;
+
+	/* Reset uniperipheral uni */
+	SET_UNIPERIF_SOFT_RST_SOFT_RST(uni);
+
+	if (uni->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
+		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(uni) && count) {
+			udelay(5);
+			count--;
+		}
+	}
+
+	if (!count) {
+		dev_err(uni->dev, "Failed to reset uniperif\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots,
 			       int slot_width)
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 1993c65..d487dd2 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1397,6 +1397,8 @@ static inline int sti_uniperiph_get_unip_tdm_frame_size(struct uniperif *uni)
 	return (uni->tdm_slot.slots * uni->tdm_slot.slot_width / 8);
 }
 
+int  sti_uniperiph_reset(struct uniperif *uni);
+
 int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots,
 			       int slot_width);
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 00a0fb3..d59ec90 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 
@@ -55,25 +54,6 @@
 	.buffer_bytes_max = 256 * PAGE_SIZE
 };
 
-static inline int reset_player(struct uniperif *player)
-{
-	int count = 10;
-
-	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
-		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(player) && count) {
-			udelay(5);
-			count--;
-		}
-	}
-
-	if (!count) {
-		dev_err(player->dev, "Failed to reset uniperif\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 /*
  * uni_player_irq_handler
  * In case of error audio stream is stopped; stop action is protected via PCM
@@ -862,10 +842,8 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 
 	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(player, 0);
 
-	/* Reset uniperipheral player */
-	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
 
-	return reset_player(player);
+	return sti_uniperiph_reset(player);
 }
 
 static int uni_player_start(struct uniperif *player)
@@ -897,10 +875,7 @@ static int uni_player_start(struct uniperif *player)
 		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(player);
 	}
 
-	/* Reset uniperipheral player */
-	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
-
-	ret = reset_player(player);
+	ret = sti_uniperiph_reset(player);
 	if (ret < 0) {
 		clk_disable_unprepare(player->clk);
 		return ret;
@@ -949,10 +924,7 @@ static int uni_player_stop(struct uniperif *player)
 	/* Turn the player off */
 	SET_UNIPERIF_CTRL_OPERATION_OFF(player);
 
-	/* Soft reset the player */
-	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
-
-	ret = reset_player(player);
+	ret = sti_uniperiph_reset(player);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 09314f8..59043f7 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 
 #include <sound/soc.h>
@@ -186,7 +185,6 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 	struct uniperif *reader = priv->dai_data.uni;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int transfer_size, trigger_limit, ret;
-	int count = 10;
 
 	/* The reader should be stopped */
 	if (reader->state != UNIPERIF_STATE_STOPPED) {
@@ -288,18 +286,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 	}
 
 	/* Reset uniperipheral reader */
-	SET_UNIPERIF_SOFT_RST_SOFT_RST(reader);
-
-	while (GET_UNIPERIF_SOFT_RST_SOFT_RST(reader)) {
-		udelay(5);
-		count--;
-	}
-	if (!count) {
-		dev_err(reader->dev, "Failed to reset uniperif\n");
-		return -EIO;
-	}
-
-	return 0;
+	return sti_uniperiph_reset(reader);
 }
 
 static int uni_reader_start(struct uniperif *reader)
-- 
1.9.1
