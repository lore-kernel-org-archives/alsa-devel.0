From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss_lib: do not mess mixer settings during
	probe
Date: Sun, 24 Aug 2008 18:08:03 +0200
Message-ID: <20080824180804.b88effc0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 378D12415A
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 18:01:49 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the wss_dout function which does not mess
shadowed register values during chip probing.
Otherwise, user ends up with stupid mixer settings
after driver loading.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Especially, the recording settings are messed up like
left channel recording from different source than
right channel.

diff -urp linux-ref/sound/isa/wss/wss_lib.c linux-2.6/sound/isa/wss/wss_lib.c
--- linux-ref/sound/isa/wss/wss_lib.c	2008-08-14 00:05:30.000000000 +0200
+++ linux-2.6/sound/isa/wss/wss_lib.c	2008-08-25 21:13:14.000000000 +0200
@@ -1162,9 +1162,9 @@ static int snd_ad1848_probe(struct snd_w
 	spin_lock_irqsave(&chip->reg_lock, flags);
 
 	/* set CS423x MODE 1 */
-	snd_wss_out(chip, CS4231_MISC_INFO, 0);
+	snd_wss_dout(chip, CS4231_MISC_INFO, 0);
 
-	snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x45); /* 0x55 & ~0x10 */
+	snd_wss_dout(chip, CS4231_RIGHT_INPUT, 0x45); /* 0x55 & ~0x10 */
 	r = snd_wss_in(chip, CS4231_RIGHT_INPUT);
 	if (r != 0x45) {
 		/* RMGE always high on AD1847 */
@@ -1174,7 +1174,7 @@ static int snd_ad1848_probe(struct snd_w
 		}
 		hardware = WSS_HW_AD1847;
 	} else {
-		snd_wss_out(chip, CS4231_LEFT_INPUT,  0xaa);
+		snd_wss_dout(chip, CS4231_LEFT_INPUT,  0xaa);
 		r = snd_wss_in(chip, CS4231_LEFT_INPUT);
 		/* L/RMGE always low on AT2320 */
 		if ((r | CS4231_ENABLE_MIC_GAIN) != 0xaa) {
@@ -1199,7 +1199,7 @@ static int snd_ad1848_probe(struct snd_w
 	r = snd_wss_in(chip, CS4231_MISC_INFO);
 
 	/* set CS423x MODE 2 */
-	snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
+	snd_wss_dout(chip, CS4231_MISC_INFO, CS4231_MODE2);
 	for (i = 0; i < 16; i++) {
 		if (snd_wss_in(chip, i) != snd_wss_in(chip, 16 + i)) {
 			/* we have more than 16 registers: check ID */
@@ -1221,7 +1221,7 @@ static int snd_ad1848_probe(struct snd_w
 	else
 		chip->hardware = WSS_HW_AD1848;
 out_mode:
-	snd_wss_out(chip, CS4231_MISC_INFO, 0);
+	snd_wss_dout(chip, CS4231_MISC_INFO, 0);
 out:
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return err;




----------------------------------------------------------------------
Zobacz galerie - tak wygladaja wampiry!
>> link http://link.interia.pl/f1eee
