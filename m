From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss_lib: snd_wss_calibrate_mute improvement
Date: Sun, 17 Aug 2008 22:38:27 +0200
Message-ID: <20080817223827.d3250ef5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 16712243A2
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 22:32:32 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Mute sound by setting mute bit without
setting volume to 0. It makes both source code
and binary shorter.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---


diff -urp alsa-ref/sound/isa/wss/wss_lib.c alsa-driver/sound/isa/wss/wss_lib.c
--- alsa-ref/sound/isa/wss/wss_lib.c	2008-08-14 00:05:30.000000000 +0200
+++ alsa-driver/sound/isa/wss/wss_lib.c	2008-08-17 22:33:24.620085406 +0200
@@ -574,7 +574,7 @@ static void snd_wss_calibrate_mute(struc
 {
 	unsigned long flags;
 
-	mute = mute ? 1 : 0;
+	mute = mute ? 0x80 : 0;
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	if (chip->calibrate_mute == mute) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -589,34 +589,34 @@ static void snd_wss_calibrate_mute(struc
 			     chip->image[CS4231_LOOPBACK]);
 	}
 	snd_wss_dout(chip, CS4231_AUX1_LEFT_INPUT,
-		     mute ? 0x80 : chip->image[CS4231_AUX1_LEFT_INPUT]);
+		     mute | chip->image[CS4231_AUX1_LEFT_INPUT]);
 	snd_wss_dout(chip, CS4231_AUX1_RIGHT_INPUT,
-		     mute ? 0x80 : chip->image[CS4231_AUX1_RIGHT_INPUT]);
+		     mute | chip->image[CS4231_AUX1_RIGHT_INPUT]);
 	snd_wss_dout(chip, CS4231_AUX2_LEFT_INPUT,
-		     mute ? 0x80 : chip->image[CS4231_AUX2_LEFT_INPUT]);
+		     mute | chip->image[CS4231_AUX2_LEFT_INPUT]);
 	snd_wss_dout(chip, CS4231_AUX2_RIGHT_INPUT,
-		     mute ? 0x80 : chip->image[CS4231_AUX2_RIGHT_INPUT]);
+		     mute | chip->image[CS4231_AUX2_RIGHT_INPUT]);
 	snd_wss_dout(chip, CS4231_LEFT_OUTPUT,
-		     mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
+		     mute | chip->image[CS4231_LEFT_OUTPUT]);
 	snd_wss_dout(chip, CS4231_RIGHT_OUTPUT,
-		     mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
+		     mute | chip->image[CS4231_RIGHT_OUTPUT]);
 	if (!(chip->hardware & WSS_HW_AD1848_MASK)) {
 		snd_wss_dout(chip, CS4231_LEFT_LINE_IN,
-			     mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
+			     mute | chip->image[CS4231_LEFT_LINE_IN]);
 		snd_wss_dout(chip, CS4231_RIGHT_LINE_IN,
-			     mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
+			     mute | chip->image[CS4231_RIGHT_LINE_IN]);
 		snd_wss_dout(chip, CS4231_MONO_CTRL,
 			     mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
 	}
 	if (chip->hardware == WSS_HW_INTERWAVE) {
 		snd_wss_dout(chip, CS4231_LEFT_MIC_INPUT,
-			     mute ? 0x80 : chip->image[CS4231_LEFT_MIC_INPUT]);
+			     mute | chip->image[CS4231_LEFT_MIC_INPUT]);
 		snd_wss_dout(chip, CS4231_RIGHT_MIC_INPUT,
-			     mute ? 0x80 : chip->image[CS4231_RIGHT_MIC_INPUT]);
+			     mute | chip->image[CS4231_RIGHT_MIC_INPUT]);
 		snd_wss_dout(chip, CS4231_LINE_LEFT_OUTPUT,
-			mute ? 0x80 : chip->image[CS4231_LINE_LEFT_OUTPUT]);
+			     mute | chip->image[CS4231_LINE_LEFT_OUTPUT]);
 		snd_wss_dout(chip, CS4231_LINE_RIGHT_OUTPUT,
-			mute ? 0x80 : chip->image[CS4231_LINE_RIGHT_OUTPUT]);
+			     mute | chip->image[CS4231_LINE_RIGHT_OUTPUT]);
 	}
 	chip->calibrate_mute = mute;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);

---------------------------------------------------------------------- 
Igrzyska na Dzikim Zachodzie!
Sprawdz >> http://link.interia.pl/f1edc 
	
