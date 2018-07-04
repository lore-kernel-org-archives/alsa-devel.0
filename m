From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: Use snd_pcm_stop_xrun() helper" to
	the asoc tree
Date: Wed, 04 Jul 2018 15:42:06 +0100
Message-ID: <E1faiys-00041m-WE@debutante>
References: <20180704140146.6768-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F35E4267790
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:42:12 +0200 (CEST)
In-Reply-To: <20180704140146.6768-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Alexandre Torgue <alexandre.torgue@st.com>, Patrick Lai <plai@codeaurora.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: Use snd_pcm_stop_xrun() helper

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From dc865fb9e7c2251c9585ff6a7bf185d499db13e4 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 4 Jul 2018 16:01:45 +0200
Subject: [PATCH] ASoC: sti: Use snd_pcm_stop_xrun() helper

The XRUN trigger from the driver should be done via
snd_pcm_stop_xrun().  It fixes the missing stream locking as a gratis,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0.rc2
