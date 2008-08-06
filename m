From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] ALSA: wss_lib: rework snd_ad1848_probe()
Date: Wed, 06 Aug 2008 08:56:40 +0200
Message-ID: <48994B28.1040107@keyaccess.nl>
References: <489947C0.30104@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080803020607030707060103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C069710385C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 08:56:40 +0200 (CEST)
In-Reply-To: <489947C0.30104@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080803020607030707060103
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 06-08-08 08:42, Rene Herman wrote:

> This reworks snd_ad1848_probe(), making for IMO significantly more 
> straightforward reading.
> 
> The original had a somewhat odd try-loop where it not only waited for 
> the codec to come out of init but also retried a failed basic detect 
> which seems to not make sense. Except for that, the detection logic 
> should be unchanged.
> 
> I am by the way rather unsure what it is that the spin_lock is trying to 
> protect us from here. What's the error scenario if we just not take it? 
> We aren't live yet...
> 
> Next step is folding this into snd_wss_probe() directly.

Oh, but now that I decided to do so not immediately, this first one 
should remeber to switch back to MODE 1, if only for cleanliness.

New version. Never mind the somewhat ugly goto. Disappears when folded 
again.

Rene.


--------------080803020607030707060103
Content-Type: text/plain;
 name="0001-ALSA-wss_lib-rework-snd_ad1848_probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-ALSA-wss_lib-rework-snd_ad1848_probe.patch"

>From 97559e0fd8c8d2e6d300640ebf60d953b87c945c Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Wed, 6 Aug 2008 08:09:34 +0200
Subject: [PATCH] ALSA: wss_lib: rework snd_ad1848_probe()

Make snd_ad1848_probe() easier to follow. With an exception for only
trying once as soon as the codec is out of init (which should be all
that's needed) the detection logic should be unchanged.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/isa/wss/wss_lib.c |  133 ++++++++++++++++++++++++----------------------
 1 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 955db45..cbe9565 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1147,79 +1147,84 @@ static snd_pcm_uframes_t snd_wss_capture_pointer(struct snd_pcm_substream *subst
 
 static int snd_ad1848_probe(struct snd_wss *chip)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned long flags;
-	int i, id, rev, ad1847;
+	unsigned char r;
+	unsigned short hardware = 0;
+	int err = 0;
+	int i;
 
-	id = 0;
-	ad1847 = 0;
-	for (i = 0; i < 1000; i++) {
-		mb();
-		if (inb(chip->port + CS4231P(REGSEL)) & CS4231_INIT)
-			msleep(1);
-		else {
-			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_wss_out(chip, CS4231_MISC_INFO, 0x00);
-			snd_wss_out(chip, CS4231_LEFT_INPUT, 0xaa);
-			snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x45);
-			rev = snd_wss_in(chip, CS4231_RIGHT_INPUT);
-			if (rev == 0x65) {
-				spin_unlock_irqrestore(&chip->reg_lock, flags);
-				id = 1;
-				ad1847 = 1;
-				break;
-			}
-			if (rev == 0x45) {
-				rev = snd_wss_in(chip, CS4231_LEFT_INPUT);
-				if (rev == 0xaa || rev == 0x8a) {
-					spin_unlock_irqrestore(&chip->reg_lock, flags);
-					id = 1;
-					break;
-				}
-			}
-			spin_unlock_irqrestore(&chip->reg_lock, flags);
-		}
+	while (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
+		if (time_after(jiffies, timeout))
+			return -ENODEV;
+		cond_resched();
 	}
-	if (id != 1)
-		return -ENODEV;	/* no valid device found */
-	id = 0;
-	if (chip->hardware == WSS_HW_DETECT)
-		id = ad1847 ? WSS_HW_AD1847 : WSS_HW_AD1848;
-
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	inb(chip->port + CS4231P(STATUS));	/* clear any pendings IRQ */
-	outb(0, chip->port + CS4231P(STATUS));
-	mb();
-	if (id == WSS_HW_AD1848) {
-		/* check if there are more than 16 registers */
-		rev = snd_wss_in(chip, CS4231_MISC_INFO);
-		snd_wss_out(chip, CS4231_MISC_INFO, 0x40);
-		for (i = 0; i < 16; ++i) {
-			if (snd_wss_in(chip, i) != snd_wss_in(chip, i + 16)) {
-				id = WSS_HW_CMI8330;
-				break;
-			}
+
+	/* set CS423x MODE 1 */
+	snd_wss_out(chip, CS4231_MISC_INFO, 0);
+
+	snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x45); /* 0x55 & ~0x10 */
+	r = snd_wss_in(chip, CS4231_RIGHT_INPUT);
+	if (r != 0x45) {
+		/* RMGE always high on AD1847 */
+		if ((r & ~CS4231_ENABLE_MIC_GAIN) != 0x45) {
+			err = -ENODEV;
+			goto out;
+		}
+		hardware = WSS_HW_AD1847;
+	} else {
+		snd_wss_out(chip, CS4231_LEFT_INPUT,  0xaa);
+		r = snd_wss_in(chip, CS4231_LEFT_INPUT);
+		/* L/RMGE always low on AT2320 */
+		if ((r | CS4231_ENABLE_MIC_GAIN) != 0xaa) {
+			err = -ENODEV;
+			goto out;
 		}
-		snd_wss_out(chip, CS4231_MISC_INFO, 0x00);
-		if (id != WSS_HW_CMI8330 && (rev & 0x80))
-			id = WSS_HW_CS4248;
-		if (id == WSS_HW_CMI8330 && (rev & 0x0f) != 0x0a)
-			id = 0;
 	}
-	if (id == WSS_HW_CMI8330) {
-		/* verify it is not CS4231 by changing the version register */
-		/* on CMI8330 it is volume control register and can be set 0 */
-		snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
-		snd_wss_dout(chip, CS4231_VERSION, 0x00);
-		rev = snd_wss_in(chip, CS4231_VERSION) & 0xe7;
-		if (rev)
-			id = 0;
-		snd_wss_out(chip, CS4231_MISC_INFO, 0);
+
+	/* clear pending IRQ */
+	wss_inb(chip, CS4231P(STATUS));
+	wss_outb(chip, CS4231P(STATUS), 0);
+	mb();
+
+	if ((chip->hardware & WSS_HW_TYPE_MASK) != WSS_HW_DETECT)
+		goto out;
+
+	if (hardware) {
+		chip->hardware = hardware;
+		goto out;
 	}
-	if (id)
-		chip->hardware = id;
 
+	r = snd_wss_in(chip, CS4231_MISC_INFO);
+
+	/* set CS423x MODE 2 */
+	snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
+	for (i = 0; i < 16; i++) {
+		if (snd_wss_in(chip, i) != snd_wss_in(chip, 16 + i)) {
+			/* we have more than 16 registers: check ID */
+			if ((r & 0xf) != 0xa)
+				goto out_mode;
+			/*
+			 * on CMI8330, CS4231_VERSION is volume control and
+			 * can be set to 0
+			 */
+			snd_wss_dout(chip, CS4231_VERSION, 0);
+			r = snd_wss_in(chip, CS4231_VERSION) & 0xe7;
+			if (!r)
+				chip->hardware = WSS_HW_CMI8330;
+			goto out_mode;
+		}
+	}
+	if (r & 0x80)
+		chip->hardware = WSS_HW_CS4248;
+	else
+		chip->hardware = WSS_HW_AD1848;
+out_mode:
+	snd_wss_out(chip, CS4231_MISC_INFO, 0);
+out:
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return 0;		/* all things are ok.. */
+	return err;
 }
 
 static int snd_wss_probe(struct snd_wss *chip)
-- 
1.5.5


--------------080803020607030707060103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080803020607030707060103--
