From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm8994: Demux the microphone detection IRQ
Date: Wed, 13 Aug 2014 10:05:45 +0100
Message-ID: <1407920746-7534-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Current code only allows direct routing of the WM8994 microphone
detection signal to a GPIO this change adds support to demux the
interrupt from the main interrupt line of the codec.

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 247b390..557156e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4089,17 +4089,23 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	switch (control->type) {
 	case WM8994:
-		if (wm8994->micdet_irq) {
+		if (wm8994->micdet_irq)
 			ret = request_threaded_irq(wm8994->micdet_irq, NULL,
 						   wm8994_mic_irq,
 						   IRQF_TRIGGER_RISING,
 						   "Mic1 detect",
 						   wm8994);
-			if (ret != 0)
-				dev_warn(codec->dev,
-					 "Failed to request Mic1 detect IRQ: %d\n",
-					 ret);
-		}
+		 else
+			ret = wm8994_request_irq(wm8994->wm8994,
+					WM8994_IRQ_MIC1_DET,
+					wm8994_mic_irq, "Mic 1 detect",
+					wm8994);
+
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic1 detect IRQ: %d\n",
+				 ret);
+
 
 		ret = wm8994_request_irq(wm8994->wm8994,
 					 WM8994_IRQ_MIC1_SHRT,
-- 
1.7.9.5
