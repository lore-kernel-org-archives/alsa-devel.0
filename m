From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: reset refactoring" to the asoc tree
Date: Wed, 26 Oct 2016 11:46:09 +0100
Message-ID: <E1bzLij-0005OQ-Se@debutante>
References: <1477320177-30130-4-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 809C926697D
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:16 +0200 (CEST)
In-Reply-To: <1477320177-30130-4-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: reset refactoring

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4c88f89f9c255d0a754e38ff1a55a6f8cef362e8 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:53 +0200
Subject: [PATCH] ASoC: sti: reset refactoring

Reset is common to player and reader, migrate function in sti_uniperif.c

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c    | 23 +++++++++++++++++++++++
 sound/soc/sti/uniperif.h        |  2 ++
 sound/soc/sti/uniperif_player.c | 34 +++-------------------------------
 sound/soc/sti/uniperif_reader.c | 15 +--------------
 4 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index ee91ae5f812a..98eb205a0b62 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/delay.h>
 
 #include "uniperif.h"
 
@@ -97,6 +98,28 @@ static const struct of_device_id snd_soc_sti_match[] = {
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
index 1993c655fb79..d487dd2ef016 100644
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
index c9b4670b772b..00022aa48280 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 
@@ -55,25 +54,6 @@ static const struct snd_pcm_hardware uni_player_pcm_hw = {
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
@@ -858,10 +838,8 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 
 	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(player, 0);
 
-	/* Reset uniperipheral player */
-	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
 
-	return reset_player(player);
+	return sti_uniperiph_reset(player);
 }
 
 static int uni_player_start(struct uniperif *player)
@@ -893,10 +871,7 @@ static int uni_player_start(struct uniperif *player)
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
@@ -945,10 +920,7 @@ static int uni_player_stop(struct uniperif *player)
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
index 09314f8be841..59043f7a0e5c 100644
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
2.8.1
