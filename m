From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Implement set_tdm_slot
	callback" to the asoc tree
Date: Tue,  4 Jun 2019 15:58:59 +0100 (BST)
Message-ID: <20190604145859.C6FEA440046@finisterre.sirena.org.uk>
References: <20190604111249.17893-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAFF2F896EF
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 16:59:01 +0200 (CEST)
In-Reply-To: <20190604111249.17893-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Implement set_tdm_slot callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 9b8e8b893ff52264df2b54a6820ae3c4bb820624 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 4 Jun 2019 14:12:49 +0300
Subject: [PATCH] ASoC: pcm3168a: Implement set_tdm_slot callback

Initially we only going to care about the slot_width as for example
DSP_A/B needs 32 bclk per slots and to be able to use TDM mode the codec
(and CPU) needs to use DSP_A/B modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 60 ++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index e0d5839fe1a7..9eb24ca09793 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -56,6 +56,9 @@ struct pcm3168a_priv {
 	unsigned long sysclk;
 	unsigned int adc_fmt;
 	unsigned int dac_fmt;
+	int tdm_slots;
+	u32 tdm_mask[2];
+	int slot_width;
 };
 
 static const char *const pcm3168a_roll_off[] = { "Sharp", "Slow" };
@@ -387,6 +390,41 @@ static int pcm3168a_set_dai_fmt_adc(struct snd_soc_dai *dai,
 	return pcm3168a_set_dai_fmt(dai, format, false);
 }
 
+static int pcm3168a_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				 unsigned int rx_mask, int slots,
+				 int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
+
+	if (tx_mask >= (1<<slots) || rx_mask >= (1<<slots)) {
+		dev_err(component->dev,
+			"Bad tdm mask tx: 0x%08x rx: 0x%08x slots %d\n",
+			tx_mask, rx_mask, slots);
+		return -EINVAL;
+	}
+
+	if (slot_width &&
+	    (slot_width != 16 && slot_width != 24 && slot_width != 32 )) {
+		dev_err(component->dev, "Unsupported slot_width %d\n",
+			slot_width);
+		return -EINVAL;
+	}
+
+	pcm3168a->tdm_slots = slots;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+
+	if (pcm3168a->slot_width && pcm3168a->slot_width != slot_width) {
+		dev_err(component->dev, "Not matching slot_width %d vs %d\n",
+			pcm3168a->slot_width, slot_width);
+		return -EINVAL;
+	}
+
+	pcm3168a->slot_width = slot_width;
+	return 0;
+}
+
 static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -431,22 +469,26 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	min_frame_size = params_width(params) * 2;
+	if (pcm3168a->slot_width)
+		min_frame_size = pcm3168a->slot_width;
+	else
+		min_frame_size = params_width(params);
+
 	switch (min_frame_size) {
-	case 32:
+	case 16:
 		if (master_mode || (fmt != PCM3168A_FMT_RIGHT_J)) {
-			dev_err(component->dev, "32-bit frames are supported only for slave mode using right justified\n");
+			dev_err(component->dev, "16-bit slots are supported only for slave mode using right justified\n");
 			return -EINVAL;
 		}
 		fmt = PCM3168A_FMT_RIGHT_J_16;
 		break;
-	case 48:
+	case 24:
 		if (master_mode || (fmt & PCM3168A_FMT_DSP_MASK)) {
-			dev_err(component->dev, "48-bit frames not supported in master mode, or slave mode using DSP\n");
+			dev_err(component->dev, "24-bit slots not supported in master mode, or slave mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
-	case 64:
+	case 32:
 		break;
 	default:
 		dev_err(component->dev, "unsupported frame size: %d\n", min_frame_size);
@@ -554,14 +596,16 @@ static const struct snd_soc_dai_ops pcm3168a_dac_dai_ops = {
 	.set_fmt	= pcm3168a_set_dai_fmt_dac,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
 	.hw_params	= pcm3168a_hw_params,
-	.digital_mute	= pcm3168a_digital_mute
+	.digital_mute	= pcm3168a_digital_mute,
+	.set_tdm_slot	= pcm3168a_set_tdm_slot,
 };
 
 static const struct snd_soc_dai_ops pcm3168a_adc_dai_ops = {
 	.startup	= pcm3168a_startup,
 	.set_fmt	= pcm3168a_set_dai_fmt_adc,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
-	.hw_params	= pcm3168a_hw_params
+	.hw_params	= pcm3168a_hw_params,
+	.set_tdm_slot	= pcm3168a_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver pcm3168a_dais[] = {
-- 
2.20.1
