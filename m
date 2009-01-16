From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss-lib: remove "pops" before each played sound
Date: Fri, 16 Jan 2009 22:47:30 +0100
Message-ID: <20090116224730.fe9d786a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 839E5103823
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 22:44:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Theodore Allen <allen@hws.edu>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

A WSS codec is autocalibrated each time before
playing sound. Do only one calibration during
codec initialization.

Complete snd_wss_calibrate_mute to mute loopback
volume as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/wss/wss_lib.c |   41 +++++++++++++----------------------------
 1 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 13299ae..f0c0be5 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -181,25 +181,6 @@ static void snd_wss_wait(struct snd_wss *chip)
 		udelay(100);
 }
 
-static void snd_wss_outm(struct snd_wss *chip, unsigned char reg,
-			    unsigned char mask, unsigned char value)
-{
-	unsigned char tmp = (chip->image[reg] & mask) | value;
-
-	snd_wss_wait(chip);
-#ifdef CONFIG_SND_DEBUG
-	if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
-		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
-#endif
-	chip->image[reg] = tmp;
-	if (!chip->calibrate_mute) {
-		wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
-		wmb();
-		wss_outb(chip, CS4231P(REG), tmp);
-		mb();
-	}
-}
-
 static void snd_wss_dout(struct snd_wss *chip, unsigned char reg,
 			 unsigned char value)
 {
@@ -587,7 +568,15 @@ static void snd_wss_calibrate_mute(struct snd_wss *chip, int mute)
 			     chip->image[CS4231_RIGHT_INPUT]);
 		snd_wss_dout(chip, CS4231_LOOPBACK,
 			     chip->image[CS4231_LOOPBACK]);
+	} else {
+		snd_wss_dout(chip, CS4231_LEFT_INPUT,
+			     0);
+		snd_wss_dout(chip, CS4231_RIGHT_INPUT,
+			     0);
+		snd_wss_dout(chip, CS4231_LOOPBACK,
+			     0xfd);
 	}
+
 	snd_wss_dout(chip, CS4231_AUX1_LEFT_INPUT,
 		     mute | chip->image[CS4231_AUX1_LEFT_INPUT]);
 	snd_wss_dout(chip, CS4231_AUX1_RIGHT_INPUT,
@@ -630,7 +619,6 @@ static void snd_wss_playback_format(struct snd_wss *chip,
 	int full_calib = 1;
 
 	mutex_lock(&chip->mce_mutex);
-	snd_wss_calibrate_mute(chip, 1);
 	if (chip->hardware == WSS_HW_CS4231A ||
 	    (chip->hardware & WSS_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
@@ -681,7 +669,6 @@ static void snd_wss_playback_format(struct snd_wss *chip,
 			udelay(100);	/* this seems to help */
 		snd_wss_mce_down(chip);
 	}
-	snd_wss_calibrate_mute(chip, 0);
 	mutex_unlock(&chip->mce_mutex);
 }
 
@@ -693,7 +680,6 @@ static void snd_wss_capture_format(struct snd_wss *chip,
 	int full_calib = 1;
 
 	mutex_lock(&chip->mce_mutex);
-	snd_wss_calibrate_mute(chip, 1);
 	if (chip->hardware == WSS_HW_CS4231A ||
 	    (chip->hardware & WSS_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
@@ -750,7 +736,6 @@ static void snd_wss_capture_format(struct snd_wss *chip,
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		snd_wss_mce_down(chip);
 	}
-	snd_wss_calibrate_mute(chip, 0);
 	mutex_unlock(&chip->mce_mutex);
 }
 
@@ -807,6 +792,7 @@ static void snd_wss_init(struct snd_wss *chip)
 {
 	unsigned long flags;
 
+	snd_wss_calibrate_mute(chip, 1);
 	snd_wss_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
@@ -830,6 +816,8 @@ static void snd_wss_init(struct snd_wss *chip)
 
 	snd_wss_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
+	chip->image[CS4231_IFACE_CTRL] &= ~CS4231_AUTOCALIB;
+	snd_wss_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
 	snd_wss_out(chip,
 		    CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -863,6 +851,7 @@ static void snd_wss_init(struct snd_wss *chip)
 			    chip->image[CS4231_REC_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_wss_mce_down(chip);
+	snd_wss_calibrate_mute(chip, 0);
 
 #ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (5)\n");
@@ -921,8 +910,6 @@ static void snd_wss_close(struct snd_wss *chip, unsigned int mode)
 		mutex_unlock(&chip->open_mutex);
 		return;
 	}
-	snd_wss_calibrate_mute(chip, 1);
-
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	if (!(chip->hardware & WSS_HW_AD1848_MASK))
@@ -955,8 +942,6 @@ static void snd_wss_close(struct snd_wss *chip, unsigned int mode)
 	wss_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
-	snd_wss_calibrate_mute(chip, 0);
-
 	chip->mode = 0;
 	mutex_unlock(&chip->open_mutex);
 }
@@ -1149,7 +1134,7 @@ irqreturn_t snd_wss_interrupt(int irq, void *dev_id)
 	if (chip->hardware & WSS_HW_AD1848_MASK)
 		wss_outb(chip, CS4231P(STATUS), 0);
 	else
-		snd_wss_outm(chip, CS4231_IRQ_STATUS, status, 0);
+		snd_wss_out(chip, CS4231_IRQ_STATUS, status);
 	spin_unlock(&chip->reg_lock);
 	return IRQ_HANDLED;
 }
-- 
1.5.2.2


----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
