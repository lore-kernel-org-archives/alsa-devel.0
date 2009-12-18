From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/5] ALSA: AACI: simplify codec rate information
Date: Fri, 18 Dec 2009 17:48:35 +0000
Message-ID: <E1NLgwN-0005ND-5O@rmk-PC.arm.linux.org.uk>
References: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 2F4DB103912
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:48:54 +0100 (CET)
In-Reply-To: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's no need for a specific rule; ALSA's generic AC'97 support
calculates the necessary rate constraint information itself, and
we can use this directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |   75 ++---------------------------------------------------
 1 files changed, 3 insertions(+), 72 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 1497dce..106e0b7 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -330,63 +330,6 @@ static irqreturn_t aaci_irq(int irq, void *devid)
 /*
  * ALSA support.
  */
-
-struct aaci_stream {
-	unsigned char codec_idx;
-	unsigned char rate_idx;
-};
-
-static struct aaci_stream aaci_streams[] = {
-	[ACSTREAM_FRONT] = {
-		.codec_idx	= 0,
-		.rate_idx	= AC97_RATES_FRONT_DAC,
-	},
-	[ACSTREAM_SURROUND] = {
-		.codec_idx	= 0,
-		.rate_idx	= AC97_RATES_SURR_DAC,
-	},
-	[ACSTREAM_LFE] = {
-		.codec_idx	= 0,
-		.rate_idx	= AC97_RATES_LFE_DAC,
-	},
-};
-
-static inline unsigned int aaci_rate_mask(struct aaci *aaci, int streamid)
-{
-	struct aaci_stream *s = aaci_streams + streamid;
-	return aaci->ac97_bus->codec[s->codec_idx]->rates[s->rate_idx];
-}
-
-static unsigned int rate_list[] = {
-	5512, 8000, 11025, 16000, 22050, 32000, 44100,
-	48000, 64000, 88200, 96000, 176400, 192000
-};
-
-/*
- * Double-rate rule: we can support double rate iff channels == 2
- *  (unimplemented)
- */
-static int
-aaci_rule_rate_by_channels(struct snd_pcm_hw_params *p, struct snd_pcm_hw_rule *rule)
-{
-	struct aaci *aaci = rule->private;
-	unsigned int rate_mask = SNDRV_PCM_RATE_8000_48000|SNDRV_PCM_RATE_5512;
-	struct snd_interval *c = hw_param_interval(p, SNDRV_PCM_HW_PARAM_CHANNELS);
-
-	switch (c->max) {
-	case 6:
-		rate_mask &= aaci_rate_mask(aaci, ACSTREAM_LFE);
-	case 4:
-		rate_mask &= aaci_rate_mask(aaci, ACSTREAM_SURROUND);
-	case 2:
-		rate_mask &= aaci_rate_mask(aaci, ACSTREAM_FRONT);
-	}
-
-	return snd_interval_list(hw_param_interval(p, rule->var),
-				 ARRAY_SIZE(rate_list), rate_list,
-				 rate_mask);
-}
-
 static struct snd_pcm_hardware aaci_hw_info = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -400,10 +343,7 @@ static struct snd_pcm_hardware aaci_hw_info = {
 	 */
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 
-	/* should this be continuous or knot? */
-	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
-	.rate_max		= 48000,
-	.rate_min		= 4000,
+	/* rates are setup from the AC'97 codec */
 	.channels_min		= 2,
 	.channels_max		= 6,
 	.buffer_bytes_max	= 64 * 1024,
@@ -423,6 +363,8 @@ static int __aaci_pcm_open(struct aaci *aaci,
 	aacirun->substream = substream;
 	runtime->private_data = aacirun;
 	runtime->hw = aaci_hw_info;
+	runtime->hw.rates = aacirun->pcm->rates;
+	snd_pcm_limit_hw_rates(runtime);
 
 	/*
 	 * FIXME: ALSA specifies fifo_size in bytes.  If we're in normal
@@ -433,17 +375,6 @@ static int __aaci_pcm_open(struct aaci *aaci,
 	 */
 	runtime->hw.fifo_size = aaci->fifosize * 2;
 
-	/*
-	 * Add rule describing hardware rate dependency
-	 * on the number of channels.
-	 */
-	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  aaci_rule_rate_by_channels, aaci,
-				  SNDRV_PCM_HW_PARAM_CHANNELS,
-				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (ret)
-		goto out;
-
 	ret = request_irq(aaci->dev->irq[0], aaci_irq, IRQF_SHARED|IRQF_DISABLED,
 			  DRIVER_NAME, aaci);
 	if (ret)
-- 
1.6.2.5
