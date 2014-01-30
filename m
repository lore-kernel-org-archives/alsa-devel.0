From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: davinci-mcasp: Configure xxTDM,
	xxFMT and xxFMCT registers synchronously
Date: Thu, 30 Jan 2014 15:15:23 +0200
Message-ID: <1391087725-4088-3-git-send-email-peter.ujfalusi@ti.com>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 400BA265490
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:15:36 +0100 (CET)
In-Reply-To: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

These registers can be configured synchronously for playback and capture.
Furthermore when McASP is in master and sync mode the capture operation
needs the TX path to be configured in order to be able to provide the needed
clocks for the bus.
xxFMT and xxFMCT registers has been already configured for both TX and RX
other places in the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 56 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9ec456aaf80b..ae3e40a63e5e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -524,12 +524,18 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	return 0;
 }
 
-static void mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
+static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 {
 	int i, active_slots;
 	u32 mask = 0;
 	u32 busel = 0;
 
+	if ((mcasp->tdm_slots < 2) || (mcasp->tdm_slots > 32)) {
+		dev_err(mcasp->dev, "tdm slot %d not supported\n",
+			mcasp->tdm_slots);
+		return -EINVAL;
+	}
+
 	active_slots = (mcasp->tdm_slots > 31) ? 32 : mcasp->tdm_slots;
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
@@ -539,35 +545,21 @@ static void mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 	if (!mcasp->dat_port)
 		busel = TXSEL;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* bit stream is MSB first  with no delay */
-		/* DSP_B mode */
-		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXTDM_REG, mask);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, busel | TXORD);
-
-		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
-			mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
-				       FSXMOD(mcasp->tdm_slots), FSXMOD(0x1FF));
-		else
-			printk(KERN_ERR "playback tdm slot %d not supported\n",
-				mcasp->tdm_slots);
-	} else {
-		/* bit stream is MSB first with no delay */
-		/* DSP_B mode */
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
-		mcasp_set_reg(mcasp, DAVINCI_MCASP_RXTDM_REG, mask);
-
-		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
-			mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
-				       FSRMOD(mcasp->tdm_slots), FSRMOD(0x1FF));
-		else
-			printk(KERN_ERR "capture tdm slot %d not supported\n",
-				mcasp->tdm_slots);
-	}
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXTDM_REG, mask);
+	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, busel | TXORD);
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
+		       FSXMOD(mcasp->tdm_slots), FSXMOD(0x1FF));
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXTDM_REG, mask);
+	mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
+		       FSRMOD(mcasp->tdm_slots), FSRMOD(0x1FF));
+
+	return 0;
 }
 
 /* S/PDIF */
-static void mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
+static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
 {
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
@@ -589,6 +581,8 @@ static void mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
 
 	/* Enable the DIT */
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXDITCTL_REG, DITEN);
+
+	return 0;
 }
 
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
@@ -605,6 +599,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	u8 slots = mcasp->tdm_slots;
 	u8 active_serializers;
 	int channels;
+	int ret;
 	struct snd_interval *pcm_channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
 	channels = pcm_channels->min;
@@ -619,9 +614,12 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		fifo_level = mcasp->rxnumevt * active_serializers;
 
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
-		mcasp_dit_hw_param(mcasp);
+		ret = mcasp_dit_hw_param(mcasp);
 	else
-		mcasp_i2s_hw_param(mcasp, substream->stream);
+		ret = mcasp_i2s_hw_param(mcasp, substream->stream);
+
+	if (ret)
+		return ret;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
-- 
1.8.5.3
