From: Nicola Lunghi <nick83ola@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: fix Line6 Helix audio format rates
Date: Sun,  7 Jul 2019 09:27:34 +0100
Message-ID: <20190707082734.25829-1-nick83ola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Nicola Lunghi <nick83ola@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Jussi Laako <jussi@sonarnerd.net>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Line6 Helix and HX stomp devices don't support retrieving
the number of clock sample rate.

Add a quirk to set it to 48Khz by default.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 sound/usb/format.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index c02b51a82775..31780dfb8eb9 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -285,6 +285,33 @@ static int parse_uac2_sample_rate_range(struct snd_usb_audio *chip,
 	return nr_rates;
 }
 
+/* Line6 Helix series don't support the UAC2_CS_RANGE usb function
+ * call. Return a static table of known clock rates.
+ */
+static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
+						struct audioformat *fp)
+{
+	switch (chip->usb_id) {
+	case USB_ID(0x0E41, 0x4241): /* Line6 Helix */
+	case USB_ID(0x0E41, 0x4242): /* Line6 Helix Rack */
+	case USB_ID(0x0E41, 0x4244): /* Line6 Helix LT */
+	case USB_ID(0x0E41, 0x4246): /* Line6 HX-Stomp */
+		/* supported rates: 48Khz */
+		kfree(fp->rate_table);
+		fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+		if (!fp->rate_table)
+			return -ENOMEM;
+		fp->nr_rates = 1;
+		fp->rate_min = 48000;
+		fp->rate_max = 48000;
+		fp->rates = SNDRV_PCM_RATE_48000;
+		fp->rate_table[0] = 48000;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 /*
  * parse the format descriptor and stores the possible sample rates
  * on the audioformat table (audio class v2 and v3).
@@ -294,7 +321,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
-	int nr_triplets, data_size, ret = 0;
+	int nr_triplets, data_size, ret, ret_l6 = 0;
 	int clock = snd_usb_clock_find_source(chip, fp->protocol,
 					      fp->clock, false);
 
@@ -313,9 +340,22 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
-		dev_err(&dev->dev,
-			"%s(): unable to retrieve number of sample rates (clock %d)\n",
+		/* line6 helix devices don't support UAC2_CS_CONTROL_SAM_FREQ call */
+		ret_l6 = line6_parse_audio_format_rates_quirk(chip, fp);
+		if (ret_l6 == -ENODEV) {
+			/* no line6 device found continue showing the error */
+			dev_err(&dev->dev,
+				"%s(): unable to retrieve number of sample rates (clock %d)\n",
+				__func__, clock);
+			goto err;
+		}
+		if (ret_l6 == 0) {
+			dev_info(&dev->dev,
+				"%s(): unable to retrieve number of sample rates: set it to a predefined value (clock %d).\n",
 				__func__, clock);
+			return 0;
+		}
+		ret = ret_l6;
 		goto err;
 	}
 
-- 
2.19.1
