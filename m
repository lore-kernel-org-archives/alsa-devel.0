From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cmi8330: add OPL3 support
Date: Wed, 21 Jan 2009 08:18:16 +0100
Message-ID: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 625811037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 08:15:18 +0100 (CET)
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

Add OPL3 handling to the driver
and volume control for FM synthesis.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/Kconfig   |    1 +
 sound/isa/cmi8330.c |   30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 2d6ce32..ae917e1 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -94,6 +94,7 @@ config SND_CMI8330
 	tristate "C-Media CMI8330"
 	select SND_WSS_LIB
 	select SND_SB16_DSP
+	select SND_OPL3_LIB
 	help
 	  Say Y here to include support for soundcards based on the
 	  C-Media CMI8330 chip.
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index e49aec7..dec6ea5 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -51,6 +51,7 @@
 #include <linux/moduleparam.h>
 #include <sound/core.h>
 #include <sound/wss.h>
+#include <sound/opl3.h>
 #include <sound/sb.h>
 #include <sound/initval.h>
 
@@ -79,6 +80,7 @@ static int sbdma16[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 static int wssirq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 static int wssdma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+static long fmport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for CMI8330 soundcard.");
@@ -107,6 +109,8 @@ MODULE_PARM_DESC(wssirq, "IRQ # for CMI8330 WSS driver.");
 module_param_array(wssdma, int, NULL, 0444);
 MODULE_PARM_DESC(wssdma, "DMA for CMI8330 WSS driver.");
 
+module_param_array(fmport, long, NULL, 0444);
+MODULE_PARM_DESC(fmport, "FM port # for CMI8330 driver.");
 #ifdef CONFIG_PNP
 static int isa_registered;
 static int pnp_registered;
@@ -219,8 +223,10 @@ WSS_SINGLE("3D Control - Switch", 0,
 		CMI8330_RMUX3D, 5, 1, 1),
 WSS_SINGLE("PC Speaker Playback Volume", 0,
 		CMI8330_OUTPUTVOL, 3, 3, 0),
-WSS_SINGLE("FM Playback Switch", 0,
-		CMI8330_RECMUX, 3, 1, 1),
+WSS_DOUBLE("FM Playback Switch", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("FM Playback Volume", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
 WSS_SINGLE(SNDRV_CTL_NAME_IEC958("Input ", CAPTURE, SWITCH), 0,
 		CMI8330_RMUX3D, 7, 1, 1),
 WSS_SINGLE(SNDRV_CTL_NAME_IEC958("Input ", PLAYBACK, SWITCH), 0,
@@ -333,6 +339,7 @@ static int __devinit snd_cmi8330_pnp(int dev, struct snd_cmi8330 *acard,
 	wssport[dev] = pnp_port_start(pdev, 0);
 	wssdma[dev] = pnp_dma(pdev, 0);
 	wssirq[dev] = pnp_irq(pdev, 0);
+	fmport[dev] = pnp_port_start(pdev, 1);
 
 	/* allocate SB16 resources */
 	pdev = acard->play;
@@ -487,6 +494,7 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 {
 	struct snd_cmi8330 *acard;
 	int i, err;
+	struct snd_opl3 *opl3;
 
 	acard = card->private_data;
 	err = snd_wss_create(card, wssport[dev] + 4, -1,
@@ -530,6 +538,24 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 		snd_printk(KERN_ERR PFX "failed to create pcms\n");
 		return err;
 	}
+	if (fmport[dev] != SNDRV_AUTO_PORT) {
+		if (snd_opl3_create(card,
+				    fmport[dev], fmport[dev] + 2,
+				    OPL3_HW_AUTO, 0, &opl3) < 0) {
+			snd_printk(KERN_ERR PFX
+				   "no OPL device at 0x%lx-0x%lx ?\n",
+				   fmport[dev], fmport[dev] + 2);
+		} else {
+			err = snd_opl3_timer_new(opl3, 0, 1);
+			if (err < 0)
+				return err;
+
+			err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
+
 
 	strcpy(card->driver, "CMI8330/C3D");
 	strcpy(card->shortname, "C-Media CMI8330/C3D");
-- 
1.5.2.2



----------------------------------------------------------------------
Zobacz gry internetowe dla dzieci!
sprawdz >>>http://link.interia.pl/f202c
