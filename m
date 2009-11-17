From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti-miro: use variables directly in the probe
	function
Date: Tue, 17 Nov 2009 18:35:41 +0100
Message-ID: <20091117183541.7f913ae1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 401A010382F
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 18:34:32 +0100 (CET)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the fm_port and mpu_port variables directly in a probe function.
This completely eliminates a need to copy the fm_port value to
the snd_miro structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/miro.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 02e30d7..b8170ad 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -118,8 +118,6 @@ struct snd_miro {
 	int dma1;
 	int dma2;
 
-	long fm_port;
-
 	long mpu_port;
 	int mpu_irq;
 
@@ -757,7 +755,6 @@ static int __devinit snd_miro_init(struct snd_miro *chip,
 	chip->irq = -1;
 	chip->dma1 = -1;
 	chip->dma2 = -1;
-	chip->fm_port = -1;
 	chip->mpu_port = -1;
 	chip->mpu_irq = -1;
 
@@ -1261,7 +1258,6 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 	}
 
 	miro->wss_base = port;
-	miro->fm_port = fm_port;
 	miro->mpu_port = mpu_port;
 	miro->irq = irq;
 	miro->mpu_irq = mpu_irq;
@@ -1276,11 +1272,12 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 		}
 	}
 
-	if (miro->mpu_port == SNDRV_AUTO_PORT) {
-		if ((miro->mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2)) < 0) {
+	if (mpu_port == SNDRV_AUTO_PORT) {
+		mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2);
+		if (mpu_port < 0) {
 			snd_card_free(card);
 			snd_printk(KERN_ERR "unable to find a free MPU401 port\n");
-			return -EBUSY;
+			return -EBUSY
 		}
 	}
 	if (miro->irq == SNDRV_AUTO_IRQ) {
@@ -1380,20 +1377,24 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 		card->shortname, miro->name, pcm->name, miro->wss_base + 4,
 		miro->irq, miro->dma1, miro->dma2);
 
-	if (miro->mpu_port <= 0 || miro->mpu_port == SNDRV_AUTO_PORT)
+	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
 		rmidi = NULL;
-	else
-		if ((error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-				miro->mpu_port, 0, miro->mpu_irq, IRQF_DISABLED,
-				&rmidi)))
-			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n", miro->mpu_port);
+	else {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+				mpu_port, 0, miro->mpu_irq, IRQF_DISABLED,
+				&rmidi);
+		if (error < 0)
+			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n",
+				   mpu_port);
+	}
 
-	if (miro->fm_port > 0 && miro->fm_port != SNDRV_AUTO_PORT) {
+	if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT) {
 		struct snd_opl3 *opl3 = NULL;
 		struct snd_opl4 *opl4;
-		if (snd_opl4_create(card, miro->fm_port, miro->fm_port - 8, 
+		if (snd_opl4_create(card, fm_port, fm_port - 8,
 				    2, &opl3, &opl4) < 0)
-			snd_printk(KERN_WARNING "no OPL4 device at 0x%lx\n", miro->fm_port);
+			snd_printk(KERN_WARNING "no OPL4 device at 0x%lx\n",
+				   fm_port);
 	}
 
 	if ((error = snd_set_aci_init_values(miro)) < 0) {
-- 
1.6.4


----------------------------------------------------------------------
Internetowi nie placa! Otworz Konto Direct.
Kliknij >> http://link.interia.pl/f2448
