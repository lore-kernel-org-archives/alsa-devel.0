From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: pcm3168a: Add support for multi
	DIN/DOUT with TDM slots parameter
Date: Thu, 20 Jun 2019 12:26:56 +0300
Message-ID: <20190620092656.14759-3-peter.ujfalusi@ti.com>
References: <20190620092656.14759-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37BD0F89730
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 11:26:27 +0200 (CEST)
In-Reply-To: <20190620092656.14759-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The driver was wired to be only usable in DIN1/DOUT1 mode, switching
between TDM and non TDM modes based on the number of channels.

While keeping this functionality for compatibility add support for using
all DIN1/2/3/4 and DOUT1/2/3 if it is needed by setting the TDM slots to
2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/pcm3168a.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 861d24cc002e..f1104d7d6426 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -408,9 +408,11 @@ static int pcm3168a_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
-	pcm3168a->tdm_slots = slots;
-	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
-	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+	if (pcm3168a->tdm_slots && pcm3168a->tdm_slots != slots) {
+		dev_err(component->dev, "Not matching slots %d vs %d\n",
+			pcm3168a->tdm_slots, slots);
+		return -EINVAL;
+	}
 
 	if (pcm3168a->slot_width && pcm3168a->slot_width != slot_width) {
 		dev_err(component->dev, "Not matching slot_width %d vs %d\n",
@@ -418,7 +420,11 @@ static int pcm3168a_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
+	pcm3168a->tdm_slots = slots;
 	pcm3168a->slot_width = slot_width;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+
 	return 0;
 }
 
@@ -431,11 +437,10 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
 	unsigned int rate, fmt, ratio, max_ratio;
-	unsigned int chan;
+	unsigned int tdm_slots;
 	int i, slot_width;
 
 	rate = params_rate(params);
-	chan = params_channels(params);
 
 	ratio = pcm3168a->sysclk / rate;
 
@@ -492,8 +497,20 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* for TDM */
-	if (chan > 2) {
+	if (pcm3168a->tdm_slots)
+		tdm_slots = pcm3168a->tdm_slots;
+	else
+		tdm_slots = params_channels(params);
+
+	/*
+	 * Switch the codec to TDM mode when more than 2 TDM slots are needed
+	 * for the stream.
+	 * If pcm3168a->tdm_slots is not set or set to more than 2 (8/6 usually)
+	 * then DIN1/DOUT1 is used in TDM mode.
+	 * If pcm3168a->tdm_slots is set to 2 then DIN1/2/3/4 and DOUT1/2/3 is
+	 * used in normal mode, no need to switch to TDM modes.
+	 */
+	if (tdm_slots > 2) {
 		switch (fmt) {
 		case PCM3168A_FMT_I2S:
 		case PCM3168A_FMT_DSP_A:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
