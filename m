From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: fix irq releasing if the irq cannot
	be allocated
Date: Wed, 9 Dec 2009 20:12:43 +0100
Message-ID: <20091209201243.9b67fc71.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id A0194103811
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 20:10:55 +0100 (CET)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id EA217106953
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 20:10:53 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id C69C825A5B1B
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 20:10:52 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the chip->irq to check if the irq should be released so the irq is not released
if it has not been allocated.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/opti92x-ad1848.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 8c88401..d8eac3f 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -548,10 +548,13 @@ __skip_mpu:
 
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
@@ -691,10 +694,9 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 
 	if (chip) {
 #ifdef OPTi93X
-		struct snd_wss *codec = chip->codec;
-		if (codec && codec->irq > 0) {
-			disable_irq(codec->irq);
-			free_irq(codec->irq, codec);
+		if (chip->irq > 0) {
+			disable_irq(chip->irq);
+			free_irq(chip->irq, chip);
 		}
 		release_and_free_resource(chip->res_mc_indir);
 #endif
@@ -759,9 +761,9 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 #endif
 #ifdef OPTi93X
 	error = request_irq(irq, snd_opti93x_interrupt,
-			    IRQF_DISABLED, DEV_NAME" - WSS", codec);
+			    IRQF_DISABLED, DEV_NAME" - WSS", chip);
 	if (error < 0) {
-		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
+		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", irq);
 		return error;
 	}
 #endif
-- 
1.6.4


----------------------------------------------------------------------
Internetowi nie placa! Otworz Konto Direct.
http://link.interia.pl/f24f7
