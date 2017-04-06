From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: STI: Fix null ptr deference in IRQ
	handler" to the asoc tree
Date: Thu, 06 Apr 2017 19:55:08 +0100
Message-ID: <E1cwCYm-0001gh-Ky@debutante>
References: <1490706295-4116-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8200526684C
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 20:55:24 +0200 (CEST)
In-Reply-To: <1490706295-4116-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: STI: Fix null ptr deference in IRQ handler

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

>From d05d862ead8eca5e7d4ccf82d39d9189579ee5b1 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Tue, 28 Mar 2017 15:04:55 +0200
Subject: [PATCH] ASoC: STI: Fix null ptr deference in IRQ handler

With RTlinux a race condition has been found that leads to NULL ptr crash:
- On CPU 0: uni_player_irq_handler is called to treat XRUN
 "(player->state == UNIPERIF_STATE_STOPPED)" is FALSE so status is checked,
 dev_err(player->dev, "FIFO underflow error detected") is printed
and then snd_pcm_stream_lock should be called to lock stream for stopping.
- On CPU 1: application stop and close the stream.
Issue is that the stop and shutdown functions are executed while
"FIFO underflow error detected" is printed.
So when CPU 0 calls snd_pcm_stream_lock, player->substream is already null.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h        |  1 +
 sound/soc/sti/uniperif_player.c | 35 ++++++++++++++++++++++++-----------
 sound/soc/sti/uniperif_reader.c | 24 ++++++++++++++++++++----
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index d487dd2ef016..cfcb0ea9d99d 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1299,6 +1299,7 @@ struct uniperif {
 	int ver; /* IP version, used by register access macros */
 	struct regmap_field *clk_sel;
 	struct regmap_field *valid_sel;
+	spinlock_t irq_lock; /* use to prevent race condition with IRQ */
 
 	/* capabilities */
 	const struct snd_pcm_hardware *hw;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 60ae31a303ab..d7e8dd46d2cc 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -65,10 +65,13 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 	unsigned int status;
 	unsigned int tmp;
 
-	if (player->state == UNIPERIF_STATE_STOPPED) {
-		/* Unexpected IRQ: do nothing */
-		return IRQ_NONE;
-	}
+	spin_lock(&player->irq_lock);
+	if (!player->substream)
+		goto irq_spin_unlock;
+
+	snd_pcm_stream_lock(player->substream);
+	if (player->state == UNIPERIF_STATE_STOPPED)
+		goto stream_unlock;
 
 	/* Get interrupt status & clear them immediately */
 	status = GET_UNIPERIF_ITS(player);
@@ -88,9 +91,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 			SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(player);
 
 			/* Stop the player */
-			snd_pcm_stream_lock(player->substream);
 			snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
-			snd_pcm_stream_unlock(player->substream);
 		}
 
 		ret = IRQ_HANDLED;
@@ -104,9 +105,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
 
 		/* Stop the player */
-		snd_pcm_stream_lock(player->substream);
 		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(player->substream);
 
 		ret = IRQ_HANDLED;
 	}
@@ -116,7 +115,8 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		if (!player->underflow_enabled) {
 			dev_err(player->dev,
 				"unexpected Underflow recovering\n");
-			return -EPERM;
+			ret = -EPERM;
+			goto stream_unlock;
 		}
 		/* Read the underflow recovery duration */
 		tmp = GET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(player);
@@ -138,13 +138,16 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		dev_err(player->dev, "Underflow recovery failed\n");
 
 		/* Stop the player */
-		snd_pcm_stream_lock(player->substream);
 		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(player->substream);
 
 		ret = IRQ_HANDLED;
 	}
 
+stream_unlock:
+	snd_pcm_stream_unlock(player->substream);
+irq_spin_unlock:
+	spin_unlock(&player->irq_lock);
+
 	return ret;
 }
 
@@ -588,6 +591,7 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
 	struct snd_aes_iec958 *iec958 =  &player->stream_settings.iec958;
+	unsigned long flags;
 
 	mutex_lock(&player->ctrl_lock);
 	iec958->status[0] = ucontrol->value.iec958.status[0];
@@ -596,12 +600,14 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	iec958->status[3] = ucontrol->value.iec958.status[3];
 	mutex_unlock(&player->ctrl_lock);
 
+	spin_lock_irqsave(&player->irq_lock, flags);
 	if (player->substream && player->substream->runtime)
 		uni_player_set_channel_status(player,
 					      player->substream->runtime);
 	else
 		uni_player_set_channel_status(player, NULL);
 
+	spin_unlock_irqrestore(&player->irq_lock, flags);
 	return 0;
 }
 
@@ -686,9 +692,12 @@ static int uni_player_startup(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&player->irq_lock, flags);
 	player->substream = substream;
+	spin_unlock_irqrestore(&player->irq_lock, flags);
 
 	player->clk_adj = 0;
 
@@ -986,12 +995,15 @@ static void uni_player_shutdown(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	unsigned long flags;
 
+	spin_lock_irqsave(&player->irq_lock, flags);
 	if (player->state != UNIPERIF_STATE_STOPPED)
 		/* Stop the player */
 		uni_player_stop(player);
 
 	player->substream = NULL;
+	spin_unlock_irqrestore(&player->irq_lock, flags);
 }
 
 static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
@@ -1096,6 +1108,7 @@ int uni_player_init(struct platform_device *pdev,
 	}
 
 	mutex_init(&player->ctrl_lock);
+	spin_lock_init(&player->irq_lock);
 
 	/* Ensure that disabled by default */
 	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 93a8df6ed880..ee0055e60852 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -46,10 +46,15 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 	struct uniperif *reader = dev_id;
 	unsigned int status;
 
+	spin_lock(&reader->irq_lock);
+	if (!reader->substream)
+		goto irq_spin_unlock;
+
+	snd_pcm_stream_lock(reader->substream);
 	if (reader->state == UNIPERIF_STATE_STOPPED) {
 		/* Unexpected IRQ: do nothing */
 		dev_warn(reader->dev, "unexpected IRQ\n");
-		return IRQ_HANDLED;
+		goto stream_unlock;
 	}
 
 	/* Get interrupt status & clear them immediately */
@@ -60,13 +65,16 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
 		dev_err(reader->dev, "FIFO error detected\n");
 
-		snd_pcm_stream_lock(reader->substream);
 		snd_pcm_stop(reader->substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(reader->substream);
 
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
 
+stream_unlock:
+	snd_pcm_stream_unlock(reader->substream);
+irq_spin_unlock:
+	spin_unlock(&reader->irq_lock);
+
 	return ret;
 }
 
@@ -347,9 +355,12 @@ static int uni_reader_startup(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *reader = priv->dai_data.uni;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&reader->irq_lock, flags);
 	reader->substream = substream;
+	spin_unlock_irqrestore(&reader->irq_lock, flags);
 
 	if (!UNIPERIF_TYPE_IS_TDM(reader))
 		return 0;
@@ -375,12 +386,15 @@ static void uni_reader_shutdown(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *reader = priv->dai_data.uni;
+	unsigned long flags;
 
+	spin_lock_irqsave(&reader->irq_lock, flags);
 	if (reader->state != UNIPERIF_STATE_STOPPED) {
 		/* Stop the reader */
 		uni_reader_stop(reader);
 	}
 	reader->substream = NULL;
+	spin_unlock_irqrestore(&reader->irq_lock, flags);
 }
 
 static const struct snd_soc_dai_ops uni_reader_dai_ops = {
@@ -415,6 +429,8 @@ int uni_reader_init(struct platform_device *pdev,
 		return -EBUSY;
 	}
 
+	spin_lock_init(&reader->irq_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_reader_init);
-- 
2.11.0
