From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] opti93x: fix irq releasing if the irq
 cannot be allocated
Date: Wed, 2 Dec 2009 18:12:36 +0100
Message-ID: <20091202181236.d3de630d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1480261492573858197=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id F145B103802
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 18:10:38 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============1480261492573858197==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Move irq allocating earlier so the codec pointer and codec->irq
are not set if the request_irq() fails.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The third version. The irq is correctly freed if the snd_wss_create() fails
(this is the only change since the previous version).

 sound/isa/opti9xx/opti92x-ad1848.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 5cd5553..7c97ca8 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -558,10 +558,13 @@ __skip_mpu:
 
 static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
 {
-	struct snd_wss *codec = dev_id;
-	struct snd_opti9xx *chip = codec->card->private_data;
+	struct snd_opti9xx *chip = dev_id;
+	struct snd_wss *codec = chip->codec;
 	unsigned char status;
 
+	if (!codec)
+		return IRQ_HANDLED;
+
 	status = snd_opti9xx_read(chip, OPTi9XX_MC_REG(11));
 	if ((status & OPTi93X_IRQ_PLAYBACK) && codec->playback_substream)
 		snd_pcm_period_elapsed(codec->playback_substream);
@@ -690,7 +693,7 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 		struct snd_wss *codec = chip->codec;
 		if (codec && codec->irq > 0) {
 			disable_irq(codec->irq);
-			free_irq(codec->irq, codec);
+			free_irq(codec->irq, chip);
 		}
 #endif
 		release_and_free_resource(chip->res_mc_base);
@@ -738,6 +741,14 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	if (error)
 		return error;
 
+#ifdef OPTi93X
+	error = request_irq(chip->irq, snd_opti93x_interrupt,
+			    IRQF_DISABLED, DEV_NAME" - WSS", chip);
+	if (error < 0) {
+		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
+		return error;
+	}
+#endif
 	error = snd_wss_create(card, chip->wss_base + 4, -1,
 			       chip->irq, chip->dma1, chip->dma2,
 #ifdef OPTi93X
@@ -746,8 +757,12 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			       WSS_HW_DETECT, 0,
 #endif
 			       &codec);
-	if (error < 0)
+	if (error < 0) {
+#ifdef OPTi93X
+		free_irq(chip->irq, chip);
+#endif
 		return error;
+	}
 #ifdef OPTi93X
 	chip->codec = codec;
 #endif
@@ -762,14 +777,6 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	if (error < 0)
 		return error;
 #endif
-#ifdef OPTi93X
-	error = request_irq(chip->irq, snd_opti93x_interrupt,
-			    IRQF_DISABLED, DEV_NAME" - WSS", codec);
-	if (error < 0) {
-		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
-		return error;
-	}
-#endif
 	strcpy(card->driver, chip->name);
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
-- 
1.6.4


----------------------------------------------------------------------
Jak zrobiæ swoj± w³asn± tapetê na telefon?
Sprawdz >>> http://link.interia.pl/f24c3


--===============1480261492573858197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1480261492573858197==--
