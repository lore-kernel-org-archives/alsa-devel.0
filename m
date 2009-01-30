From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] ess1688: fix OPL3 port setting (3rd rev)
Date: Fri, 30 Jan 2009 19:20:29 +0100
Message-ID: <20090130192029.7eef5f36.krzysztof.h1@poczta.fm>
References: <20090125211031.32d37d66.krzysztof.h1@poczta.fm>
	<497CE243.5010400@gmail.com> <s5hbptu5rp6.wl%tiwai@suse.de>
	<20090129155527.1abc61e4.krzysztof.h1@poczta.fm>
	<s5h63jytaol.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 44E5124131
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 19:16:58 +0100 (CET)
In-Reply-To: <s5h63jytaol.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The ess1688 driver uses the same port
for PCM audio (SB compatible) and OPL3
synthesis. It is not always right so allow to
choose a different port for OPL3 synthesis.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
I am sorry for stupid copy-paste error. It is fixed now.

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index b463771..e7fbb06 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -49,6 +49,7 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260 */
+static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* Usually 0x388 */
 static long mpu_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,9,10 */
 static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,9,10 */
@@ -65,6 +66,8 @@ MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(mpu_port, long, NULL, 0444);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
+module_param_array(fm_port, long, NULL, 0444);
+MODULE_PARM_DESC(fm_port, "FM port # for ES1688 driver.");
 MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(mpu_irq, int, NULL, 0444);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
@@ -143,13 +146,19 @@ static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
 	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name,
 		chip->port, chip->irq, chip->dma8);
 
-	if (snd_opl3_create(card, chip->port, chip->port + 2,
-			OPL3_HW_OPL3, 0, &opl3) < 0)
-		dev_warn(dev, "opl3 not detected at 0x%lx\n", chip->port);
-	else {
-		error =	snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-		if (error < 0)
-			goto out;
+	if (fm_port[n] == SNDRV_AUTO_PORT)
+		fm_port[n] = port[n];	/* share the same port */
+
+	if (fm_port[n] > 0) {
+		if (snd_opl3_create(card, fm_port[n], fm_port[n] + 2,
+				OPL3_HW_OPL3, 0, &opl3) < 0)
+			dev_warn(dev,
+				 "opl3 not detected at 0x%lx\n", fm_port[n]);
+		else {
+			error =	snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+			if (error < 0)
+				goto out;
+		}
 	}
 
 	if (mpu_irq[n] >= 0 && mpu_irq[n] != SNDRV_AUTO_IRQ &&

-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019
