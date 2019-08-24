From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/6] ASoC: atmel_ssc_dai: Enable shared FSYNC source in
 frame-slave mode
Date: Sat, 24 Aug 2019 22:26:57 +0200
Message-ID: <b56ebac96ad232e2d9871067b13654eb9223f28f.1566677788.git.mirq-linux@rere.qmqm.pl>
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

SSC driver allows only synchronous TX and RX. In slave mode for BCLK
it uses only one of TK or RK pin, but for LRCLK it configured separate
inputs from TF and RF pins. Allow configuration with common FS signal.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: use alternate DT binding
     split DT and drivers/misc changes

---
 sound/soc/atmel/atmel_ssc_dai.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 48e9eef34c0f..035d4da58f2b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -605,14 +605,32 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (!atmel_ssc_cfs(ssc_p)) {
+	if (atmel_ssc_cfs(ssc_p)) {
+		/*
+		 * SSC provides LRCLK
+		 *
+		 * Both TF and RF are generated, so use them directly.
+		 */
+		rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+		tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+	} else {
 		fslen = fslen_ext = 0;
 		rcmr_period = tcmr_period = 0;
 		fs_osync = SSC_FSOS_NONE;
-	}
 
-	rcmr |=	  SSC_BF(RCMR_START, fs_edge);
-	tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		if (ssc->lrclk_from_tf_pin) {
+			rcmr |=	  SSC_BF(RCMR_START, SSC_START_TX_RX);
+			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		} else if (ssc->lrclk_from_rf_pin) {
+			/* assume RF is to be used when RK is used as BCLK input */
+			/* Note: won't work correctly on SAMA5D2 due to errata */
+			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+			tcmr |=	  SSC_BF(TCMR_START, SSC_START_TX_RX);
+		} else {
+			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		}
+	}
 
 	if (atmel_ssc_cbs(ssc_p)) {
 		/*
-- 
2.20.1
