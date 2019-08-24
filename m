From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/6] ASoC: atmel_ssc_dai: implement left-justified data
 mode
Date: Sat, 24 Aug 2019 22:26:54 +0200
Message-ID: <44fa6b700421e80778f20ff9ead2b148cf6d2e92.1566677788.git.mirq-linux@rere.qmqm.pl>
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

Enable support for left-justified data mode for SSC-codec link.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: rebased

---
 sound/soc/atmel/atmel_ssc_dai.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7dc6ec9b8c7a..48e9eef34c0f 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -564,6 +564,15 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 
 	switch (ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 
+	case SND_SOC_DAIFMT_LEFT_J:
+		fs_osync = SSC_FSOS_POSITIVE;
+		fs_edge = SSC_START_RISING_RF;
+
+		rcmr =	  SSC_BF(RCMR_STTDLY, 0);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 0);
+
+		break;
+
 	case SND_SOC_DAIFMT_I2S:
 		fs_osync = SSC_FSOS_NEGATIVE;
 		fs_edge = SSC_START_FALLING_RF;
-- 
2.20.1
