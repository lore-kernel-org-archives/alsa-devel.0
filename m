From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss-lib: move AD1845 frequency setting into
	wss-lib
Date: Fri, 9 Jan 2009 23:10:52 +0100
Message-ID: <20090109231052.606a5497.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id B528E1037EB
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 23:08:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>, "Theodore J. Allen" <tjallen@hws.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is required to allow the sscape driver
to autodetect installed codec.

Also, do not create a timer if detected codec
has no hardware timer (e.g. AD1848).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Rene Herman
---

Ted, please test if the patch helps to make your Soundscape Elite
card working. If not the patch is required anyway as your last feedback
showed that frequency setting is incorrect in the sscape driver if
the codec is not the AD1845.

 sound/isa/sscape.c      |  113 +++-------------------------------------------
 sound/isa/wss/wss_lib.c |   40 +++++++++++++++++
 2 files changed, 48 insertions(+), 105 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 48a16d8..bc44916 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -129,9 +129,6 @@ enum GA_REG {
 #define DMA_8BIT  0x80
 
 
-#define AD1845_FREQ_SEL_MSB    0x16
-#define AD1845_FREQ_SEL_LSB    0x17
-
 enum card_type {
 	SSCAPE,
 	SSCAPE_PNP,
@@ -955,82 +952,6 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum, unsigned l
 
 
 /*
- * Override for the CS4231 playback format function.
- * The AD1845 has much simpler format and rate selection.
- */
-static void ad1845_playback_format(struct snd_wss *chip,
-				   struct snd_pcm_hw_params *params,
-				   unsigned char format)
-{
-	unsigned long flags;
-	unsigned rate = params_rate(params);
-
-	/*
-	 * The AD1845 can't handle sample frequencies
-	 * outside of 4 kHZ to 50 kHZ
-	 */
-	if (rate > 50000)
-		rate = 50000;
-	else if (rate < 4000)
-		rate = 4000;
-
-	spin_lock_irqsave(&chip->reg_lock, flags);
-
-	/*
-	 * Program the AD1845 correctly for the playback stream.
-	 * Note that we do NOT need to toggle the MCE bit because
-	 * the PLAYBACK_ENABLE bit of the Interface Configuration
-	 * register is set.
-	 * 
-	 * NOTE: We seem to need to write to the MSB before the LSB
-	 *       to get the correct sample frequency.
-	 */
-	snd_wss_out(chip, CS4231_PLAYBK_FORMAT, (format & 0xf0));
-	snd_wss_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
-	snd_wss_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
-
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-}
-
-/*
- * Override for the CS4231 capture format function. 
- * The AD1845 has much simpler format and rate selection.
- */
-static void ad1845_capture_format(struct snd_wss *chip,
-				  struct snd_pcm_hw_params *params,
-				  unsigned char format)
-{
-	unsigned long flags;
-	unsigned rate = params_rate(params);
-
-	/*
-	 * The AD1845 can't handle sample frequencies 
-	 * outside of 4 kHZ to 50 kHZ
-	 */
-	if (rate > 50000)
-		rate = 50000;
-	else if (rate < 4000)
-		rate = 4000;
-
-	spin_lock_irqsave(&chip->reg_lock, flags);
-
-	/*
-	 * Program the AD1845 correctly for the playback stream.
-	 * Note that we do NOT need to toggle the MCE bit because
-	 * the CAPTURE_ENABLE bit of the Interface Configuration
-	 * register is set.
-	 *
-	 * NOTE: We seem to need to write to the MSB before the LSB
-	 *       to get the correct sample frequency.
-	 */
-	snd_wss_out(chip, CS4231_REC_FORMAT, (format & 0xf0));
-	snd_wss_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
-	snd_wss_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
-
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-}
-
-/*
  * Create an AD1845 PCM subdevice on the SoundScape. The AD1845
  * is very much like a CS4231, with a few extra bits. We will
  * try to support at least some of the extra bits by overriding
@@ -1055,11 +976,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 		unsigned long flags;
 		struct snd_pcm *pcm;
 
-#define AD1845_FREQ_SEL_ENABLE  0x08
-
-#define AD1845_PWR_DOWN_CTRL   0x1b
-#define AD1845_CRYS_CLOCK_SEL  0x1d
-
 /*
  * It turns out that the PLAYBACK_ENABLE bit is set
  * by the lowlevel driver ...
@@ -1074,7 +990,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
  */
 
 		if (sscape->type != SSCAPE_VIVO) {
-			int val;
 			/*
 			 * The input clock frequency on the SoundScape must
 			 * be 14.31818 MHz, because we must set this register
@@ -1082,22 +997,10 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 			 */
 			snd_wss_mce_up(chip);
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_wss_out(chip, AD1845_CRYS_CLOCK_SEL, 0x20);
+			snd_wss_out(chip, AD1845_CLOCK, 0x20);
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
 			snd_wss_mce_down(chip);
 
-			/*
-			 * More custom configuration:
-			 * a) select "mode 2" and provide a current drive of 8mA
-			 * b) enable frequency selection (for capture/playback)
-			 */
-			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_wss_out(chip, CS4231_MISC_INFO,
-				    CS4231_MODE2 | 0x10);
-			val = snd_wss_in(chip, AD1845_PWR_DOWN_CTRL);
-			snd_wss_out(chip, AD1845_PWR_DOWN_CTRL,
-				    val | AD1845_FREQ_SEL_ENABLE);
-			spin_unlock_irqrestore(&chip->reg_lock, flags);
 		}
 
 		err = snd_wss_pcm(chip, 0, &pcm);
@@ -1113,11 +1016,13 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 					    "for AD1845 chip\n");
 			goto _error;
 		}
-		err = snd_wss_timer(chip, 0, NULL);
-		if (err < 0) {
-			snd_printk(KERN_ERR "sscape: No timer device "
-					    "for AD1845 chip\n");
-			goto _error;
+		if (chip->hardware != WSS_HW_AD1848) {
+			err = snd_wss_timer(chip, 0, NULL);
+			if (err < 0) {
+				snd_printk(KERN_ERR "sscape: No timer device "
+						    "for AD1845 chip\n");
+				goto _error;
+			}
 		}
 
 		if (sscape->type != SSCAPE_VIVO) {
@@ -1128,8 +1033,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 						    "MIDI mixer control\n");
 				goto _error;
 			}
-			chip->set_playback_format = ad1845_playback_format;
-			chip->set_capture_format = ad1845_capture_format;
 		}
 
 		strcpy(card->driver, "SoundScape");
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 3d6c5f2..13299ae 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -646,6 +646,24 @@ static void snd_wss_playback_format(struct snd_wss *chip,
 			full_calib = 0;
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
+	} else if (chip->hardware == WSS_HW_AD1845) {
+		unsigned rate = params_rate(params);
+
+		/*
+		 * Program the AD1845 correctly for the playback stream.
+		 * Note that we do NOT need to toggle the MCE bit because
+		 * the PLAYBACK_ENABLE bit of the Interface Configuration
+		 * register is set.
+		 *
+		 * NOTE: We seem to need to write to the MSB before the LSB
+		 *       to get the correct sample frequency.
+		 */
+		spin_lock_irqsave(&chip->reg_lock, flags);
+		snd_wss_out(chip, CS4231_PLAYBK_FORMAT, (pdfr & 0xf0));
+		snd_wss_out(chip, AD1845_UPR_FREQ_SEL, (rate >> 8) & 0xff);
+		snd_wss_out(chip, AD1845_LWR_FREQ_SEL, rate & 0xff);
+		full_calib = 0;
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	if (full_calib) {
 		snd_wss_mce_up(chip);
@@ -690,6 +708,24 @@ static void snd_wss_capture_format(struct snd_wss *chip,
 			full_calib = 0;
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
+	} else if (chip->hardware == WSS_HW_AD1845) {
+		unsigned rate = params_rate(params);
+
+		/*
+		 * Program the AD1845 correctly for the capture stream.
+		 * Note that we do NOT need to toggle the MCE bit because
+		 * the PLAYBACK_ENABLE bit of the Interface Configuration
+		 * register is set.
+		 *
+		 * NOTE: We seem to need to write to the MSB before the LSB
+		 *       to get the correct sample frequency.
+		 */
+		spin_lock_irqsave(&chip->reg_lock, flags);
+		snd_wss_out(chip, CS4231_REC_FORMAT, (cdfr & 0xf0));
+		snd_wss_out(chip, AD1845_UPR_FREQ_SEL, (rate >> 8) & 0xff);
+		snd_wss_out(chip, AD1845_LWR_FREQ_SEL, rate & 0xff);
+		full_calib = 0;
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	if (full_calib) {
 		snd_wss_mce_up(chip);
@@ -1314,6 +1350,10 @@ static int snd_wss_probe(struct snd_wss *chip)
 		chip->image[CS4231_ALT_FEATURE_2] =
 			chip->hardware == WSS_HW_INTERWAVE ? 0xc2 : 0x01;
 	}
+	/* enable fine grained frequency selection */
+	if (chip->hardware == WSS_HW_AD1845)
+		chip->image[AD1845_PWR_DOWN] = 8;
+
 	ptr = (unsigned char *) &chip->image;
 	regnum = (chip->hardware & WSS_HW_AD1848_MASK) ? 16 : 32;
 	snd_wss_mce_down(chip);
-- 
1.5.2.2


----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
