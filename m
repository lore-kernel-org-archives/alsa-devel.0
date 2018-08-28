From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm: restrict formats
	depending on slot width" to the asoc tree
Date: Tue, 28 Aug 2018 21:47:03 +0100 (BST)
Message-ID: <20180828204703.F3EC244007A@finisterre.ee.mobilebroadband>
References: <20180827142107.8153-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 82E0E26781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:47:28 +0200 (CEST)
In-Reply-To: <20180827142107.8153-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-tdm: restrict formats depending on slot width

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

>From 302df2694b97e6a56f7956c1105630809b141ea0 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 Aug 2018 16:21:07 +0200
Subject: [PATCH] ASoC: meson: axg-tdm: restrict formats depending on slot
 width

Restrict the formats possible on the TDM interface depending on the width
of the TDM slot and let dpcm merging do the rest.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 50 +++++++++++++++++------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 7b8baf46d968..585ce030b79b 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -42,6 +42,7 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 	struct axg_tdm_stream *rx = (struct axg_tdm_stream *)
 		dai->capture_dma_data;
 	unsigned int tx_slots, rx_slots;
+	unsigned int fmt = 0;
 
 	tx_slots = axg_tdm_slots_total(tx_mask);
 	rx_slots = axg_tdm_slots_total(rx_mask);
@@ -52,38 +53,45 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 		return -EINVAL;
 	}
 
-	/*
-	 * Amend the dai driver channel number and let dpcm channel merge do
-	 * its job
-	 */
-	if (tx) {
-		tx->mask = tx_mask;
-		dai->driver->playback.channels_max = tx_slots;
-	}
-
-	if (rx) {
-		rx->mask = rx_mask;
-		dai->driver->capture.channels_max = rx_slots;
-	}
-
 	iface->slots = slots;
 
 	switch (slot_width) {
 	case 0:
-		/* defaults width to 32 if not provided */
-		iface->slot_width = 32;
-		break;
-	case 8:
-	case 16:
-	case 24:
+		slot_width = 32;
+		/* Fall-through */
 	case 32:
-		iface->slot_width = slot_width;
+		fmt |= SNDRV_PCM_FMTBIT_S32_LE;
+		/* Fall-through */
+	case 24:
+		fmt |= SNDRV_PCM_FMTBIT_S24_LE;
+		fmt |= SNDRV_PCM_FMTBIT_S20_LE;
+		/* Fall-through */
+	case 16:
+		fmt |= SNDRV_PCM_FMTBIT_S16_LE;
+		/* Fall-through */
+	case 8:
+		fmt |= SNDRV_PCM_FMTBIT_S8;
 		break;
 	default:
 		dev_err(dai->dev, "unsupported slot width: %d\n", slot_width);
 		return -EINVAL;
 	}
 
+	iface->slot_width = slot_width;
+
+	/* Amend the dai driver and let dpcm merge do its job */
+	if (tx) {
+		tx->mask = tx_mask;
+		dai->driver->playback.channels_max = tx_slots;
+		dai->driver->playback.formats = fmt;
+	}
+
+	if (rx) {
+		rx->mask = rx_mask;
+		dai->driver->capture.channels_max = rx_slots;
+		dai->driver->capture.formats = fmt;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_set_tdm_slots);
-- 
2.18.0
