From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] ASoC: axentia: tse850: add ASoC driver for the
 Axentia TSE-850
Date: Wed, 9 Nov 2016 19:54:39 +0100
Message-ID: <a9231718-c716-35a1-b704-0687518ded59@axentia.se>
References: <1478622057-12426-1-git-send-email-peda@axentia.se>
 <1478622057-12426-3-git-send-email-peda@axentia.se>
 <20161109133852.nvlyiqow2xpbc6ga@sirena.org.uk>
 <3d6b99e8-f19f-51fd-1676-c3a4549ec312@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d6b99e8-f19f-51fd-1676-c3a4549ec312@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

On 2016-11-09 17:27, Peter Rosin wrote:
> On 2016-11-09 14:38, Mark Brown wrote:
>> On Tue, Nov 08, 2016 at 05:20:57PM +0100, Peter Rosin wrote:
>>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +	struct device *dev = rtd->dev;
>>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>> +	int dir = substream->stream != SNDRV_PCM_STREAM_PLAYBACK;
>>> +	int div_id = dir ? ATMEL_SSC_RCMR_PERIOD : ATMEL_SSC_TCMR_PERIOD;
>>> +	int period = snd_soc_params_to_frame_size(params) / 2 - 1;
>>
>> Please write the logic out as normal if statements for legibility.  It's
>> a bit concerning that we even need this function, it looks like pretty
>> basic stuff that I'd expect the CPU DAI to just be doing - why can't
>> this be the default behaviour of the CPU DAI?
> 
> I don't know and obviously don't have all the relevant HW to test
> changes. Do you want me to attempt such a change anyway?
> Adding Cc: Nicolas Ferre

Something like this, perhaps?

Cheers,
Peter


diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 16e459aedffe..059b0b63bd51 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -380,6 +380,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 		/* Clear the SSC dividers */
 		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+		ssc_p->forced_divider = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
 
@@ -429,10 +430,12 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		break;
 
 	case ATMEL_SSC_TCMR_PERIOD:
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_TCMR_PERIOD);
 		ssc_p->tcmr_period = div;
 		break;
 
 	case ATMEL_SSC_RCMR_PERIOD:
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_RCMR_PERIOD);
 		ssc_p->rcmr_period = div;
 		break;
 
@@ -459,6 +462,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int ret;
 	int fslen, fslen_ext;
+	u32 tcmr_period;
+	u32 rcmr_period;
 
 	/*
 	 * Currently, there is only one set of dma params for
@@ -470,6 +475,13 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
+	tcmr_period = ssc_p->tcmr_period;
+	if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_TCMR_PERIOD)))
+		tcmr_period = snd_soc_params_to_frame_size(params) / 2 - 1;
+	rcmr_period = ssc_p->rcmr_period;
+	if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_RCMR_PERIOD)))
+		rcmr_period = snd_soc_params_to_frame_size(params) / 2 - 1;
+
 	dma_params = ssc_p->dma_params[dir];
 
 	channels = params_channels(params);
@@ -524,7 +536,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -540,7 +552,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -606,7 +618,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -623,7 +635,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -650,7 +662,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		 * MCK divider, and the BCLK signal is output
 		 * on the SSC TK line.
 		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, 1)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -665,7 +677,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, 1)
 			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index 80b153857a88..75194f582131 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -113,6 +113,7 @@ struct atmel_ssc_info {
 	unsigned short cmr_div;
 	unsigned short tcmr_period;
 	unsigned short rcmr_period;
+	unsigned int forced_divider;
 	struct atmel_pcm_dma_params *dma_params[2];
 	struct atmel_ssc_state ssc_state;
 	unsigned long mck_rate;
-- 
2.1.4
