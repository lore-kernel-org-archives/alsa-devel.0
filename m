From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ASoC: sti: Use snd_pcm_stop_xrun() helper
Date: Wed,  4 Jul 2018 16:01:45 +0200
Message-ID: <20180704140146.6768-4-tiwai@suse.de>
References: <20180704140146.6768-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 317FA267731
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:01:50 +0200 (CEST)
In-Reply-To: <20180704140146.6768-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Alexandre Torgue <alexandre.torgue@st.com>, Patrick Lai <plai@codeaurora.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

The XRUN trigger from the driver should be done via
snd_pcm_stop_xrun().  It fixes the missing stream locking as a gratis,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sti/uniperif_player.c | 6 +++---
 sound/soc/sti/uniperif_reader.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d8b6936e544e..313dab2857ef 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -91,7 +91,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 			SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(player);
 
 			/* Stop the player */
-			snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+			snd_pcm_stop_xrun(player->substream);
 		}
 
 		ret = IRQ_HANDLED;
@@ -105,7 +105,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
 
 		/* Stop the player */
-		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stop_xrun(player->substream);
 
 		ret = IRQ_HANDLED;
 	}
@@ -138,7 +138,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		dev_err(player->dev, "Underflow recovery failed\n");
 
 		/* Stop the player */
-		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stop_xrun(player->substream);
 
 		ret = IRQ_HANDLED;
 	}
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index ee0055e60852..7b63d35ef428 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -65,7 +65,7 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
 		dev_err(reader->dev, "FIFO error detected\n");
 
-		snd_pcm_stop(reader->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stop_xrun(reader->substream);
 
 		ret = IRQ_HANDLED;
 	}
-- 
2.18.0
