From: Nicola Lunghi <nick83ola@gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix Line6 Helix audio format rates
Date: Tue,  2 Jul 2019 01:43:14 +0100
Message-ID: <20190702004439.30131-1-nick83ola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: info@jensverwiebe.de, Nicola Lunghi <nick83ola@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Jussi Laako <jussi@sonarnerd.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Line6 Helix and HX stomp don't support retrieving
the number of clock sample rate.

Add a quirk to return the default value of 48Khz.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 sound/usb/format.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index c02b51a82775..05442f6ada62 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -313,10 +313,32 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
-		dev_err(&dev->dev,
-			"%s(): unable to retrieve number of sample rates (clock %d)\n",
+		switch (chip->usb_id) {
+		/* LINE 6 HX pedals don't support getting the clock sample rate.
+		 * Set the framerate to 48khz by default
+		 */
+		case USB_ID(0x0E41, 0x4244): /* HELIX */
+		case USB_ID(0x0E41, 0x4246): /* HX STOMP */
+			dev_warn(&dev->dev,
+				"%s(): line6 helix: unable to retrieve number of sample rates. Set it to default value (clock %d).\n",
 				__func__, clock);
-		goto err;
+			fp->nr_rates = 1;
+			fp->rate_min = 48000;
+			fp->rate_max = 48000;
+			fp->rates = SNDRV_PCM_RATE_48000;
+			fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+			if (!fp->rate_table) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
+			fp->rate_table[0] = 48000;
+			return 0;
+		default:
+			dev_err(&dev->dev,
+				"%s(): unable to retrieve number of sample rates (clock %d)\n",
+					__func__, clock);
+			goto err;
+		}
 	}
 
 	nr_triplets = (tmp[1] << 8) | tmp[0];
-- 
2.19.1
