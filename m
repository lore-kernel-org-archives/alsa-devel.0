From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/6] ASoC: atmel_ssc_dai: rework DAI format configuration
Date: Sat, 24 Aug 2019 22:26:53 +0200
Message-ID: <f5949b0326fdcdca072f3ed03f77de9e207631cd.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Chas Williams <3chas3@gmail.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring <robh-dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Rework DAI format calculation in preparation for adding more formats
later. As a side-effect this enables all CBM/CBS x CFM/CFS combinations
for supported formats. (Note: the additional modes are not tested.)

Note: this changes FSEDGE to POSITIVE for I2S CBM_CFS mode as the TXSYN
interrupt is not used anyway.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: added note about extended modes' status
     incorporated common FS (LRCLK) configuration

---
 sound/soc/atmel/atmel_ssc_dai.c | 286 +++++++++-----------------------
 1 file changed, 80 insertions(+), 206 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 6f89483ac88c..7dc6ec9b8c7a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -471,7 +471,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int ret;
-	int fslen, fslen_ext;
+	int fslen, fslen_ext, fs_osync, fs_edge;
 	u32 cmr_div;
 	u32 tcmr_period;
 	u32 rcmr_period;
@@ -558,226 +558,36 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * Compute SSC register settings.
 	 */
-	switch (ssc_p->daifmt
-		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
 
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * I2S format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated
-		 * from the MCK divider, and the BCLK signal
-		 * is output on the SSC TK line.
-		 */
-
-		if (bits > 16 && !ssc->pdata->has_fslen_ext) {
-			dev_err(dai->dev,
-				"sample size %d is too large for SSC device\n",
-				bits);
-			return -EINVAL;
-		}
-
-		fslen_ext = (bits - 1) / 16;
-		fslen = (bits - 1) % 16;
-
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
-
-		rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(RFMR_FSLEN, fslen)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
-			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
-
-		tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(TFMR_FSLEN, fslen)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/* I2S format, CODEC supplies BCLK and LRC clocks. */
-		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
+	fslen_ext = (bits - 1) / 16;
+	fslen = (bits - 1) % 16;
 
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFS:
-		/* I2S format, CODEC supplies BCLK, SSC supplies LRCLK. */
-		if (bits > 16 && !ssc->pdata->has_fslen_ext) {
-			dev_err(dai->dev,
-				"sample size %d is too large for SSC device\n",
-				bits);
-			return -EINVAL;
-		}
-
-		fslen_ext = (bits - 1) / 16;
-		fslen = (bits - 1) % 16;
-
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-
-		rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(RFMR_FSLEN, fslen)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
-
-		tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_NEGATIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(TFMR_FSLEN, fslen)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output
-		 * on the SSC TK line.
-		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, 1)
-			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
+	case SND_SOC_DAIFMT_I2S:
+		fs_osync = SSC_FSOS_NEGATIVE;
+		fs_edge = SSC_START_FALLING_RF;
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, 1)
-			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
-			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+		rcmr =	  SSC_BF(RCMR_STTDLY, 1);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 1);
 
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
 		break;
 
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_A:
 		/*
-		 * DSP/PCM Mode A format, CODEC supplies BCLK and LRC clocks.
+		 * DSP/PCM Mode A format
 		 *
 		 * Data is transferred on first BCLK after LRC pulse rising
 		 * edge.If stereo, the right channel data is contiguous with
 		 * the left channel data.
 		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
+		fs_osync = SSC_FSOS_POSITIVE;
+		fs_edge = SSC_START_RISING_RF;
+		fslen = fslen_ext = 0;
 
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
+		rcmr =	  SSC_BF(RCMR_STTDLY, 1);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 1);
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
-
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
 		break;
 
 	default:
@@ -785,6 +595,70 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			ssc_p->daifmt);
 		return -EINVAL;
 	}
+
+	if (!atmel_ssc_cfs(ssc_p)) {
+		fslen = fslen_ext = 0;
+		rcmr_period = tcmr_period = 0;
+		fs_osync = SSC_FSOS_NONE;
+	}
+
+	rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+	tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+
+	if (atmel_ssc_cbs(ssc_p)) {
+		/*
+		 * SSC provides BCLK
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output
+		 * on the SSC TK line.
+		 */
+		rcmr |=	  SSC_BF(RCMR_CKS, SSC_CKS_DIV)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
+
+		tcmr |=	  SSC_BF(TCMR_CKS, SSC_CKS_DIV)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS);
+	} else {
+		rcmr |=	  SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
+					SSC_CKS_PIN : SSC_CKS_CLOCK)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
+
+		tcmr |=	  SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
+					SSC_CKS_CLOCK : SSC_CKS_PIN)
+			| SSC_BF(TCMR_CKO, SSC_CKO_NONE);
+	}
+
+	rcmr |=	  SSC_BF(RCMR_PERIOD, rcmr_period)
+		| SSC_BF(RCMR_CKI, SSC_CKI_RISING);
+
+	tcmr |=   SSC_BF(TCMR_PERIOD, tcmr_period)
+		| SSC_BF(TCMR_CKI, SSC_CKI_FALLING);
+
+	rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
+		| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		| SSC_BF(RFMR_FSOS, fs_osync)
+		| SSC_BF(RFMR_FSLEN, fslen)
+		| SSC_BF(RFMR_DATNB, (channels - 1))
+		| SSC_BIT(RFMR_MSBF)
+		| SSC_BF(RFMR_LOOP, 0)
+		| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+	tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
+		| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		| SSC_BF(TFMR_FSDEN, 0)
+		| SSC_BF(TFMR_FSOS, fs_osync)
+		| SSC_BF(TFMR_FSLEN, fslen)
+		| SSC_BF(TFMR_DATNB, (channels - 1))
+		| SSC_BIT(TFMR_MSBF)
+		| SSC_BF(TFMR_DATDEF, 0)
+		| SSC_BF(TFMR_DATLEN, (bits - 1));
+
+	if (fslen_ext && !ssc->pdata->has_fslen_ext) {
+		dev_err(dai->dev, "sample size %d is too large for SSC device\n",
+			bits);
+		return -EINVAL;
+	}
+
 	pr_debug("atmel_ssc_hw_params: "
 			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
 			rcmr, rfmr, tcmr, tfmr);
-- 
2.20.1
