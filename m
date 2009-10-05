From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: force AD1848 codec mode on old
	Soundscape
Date: Mon, 5 Oct 2009 18:18:57 +0200
Message-ID: <20091005181857.9496e100.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0453180630614876624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 5897F24531
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 18:03:00 +0200 (CEST)
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

--===============0453180630614876624==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Old Soundscape cards (pre PnP) work only with AD1848 codecs.
If the CS4231 codec is installed it must be used in AD1848
compatible mode.

Also, add gameport support and remove an unused mpu field.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The second version: do not set joystick variable to zeros (false).

BTW. The OSS sscape from the 2.6 kernel cannot handle my Media FX card.
It seems  that only Soundscape PnP may work (after fixing existing bugs).
I prefer removing it completely.

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index cf98525..6de56d1 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1639,6 +1639,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     mpu_irq	- MPU-401 IRQ # (PnP setup)
     dma		- DMA # (PnP setup)
     dma2	- 2nd DMA # (PnP setup, -1 to disable)
+    joystick	- Enable gameport - 0 = disable (default), 1 = enable
 
     This module supports multiple cards.
 
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index c739374..e348f8b 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -54,6 +54,7 @@ static int irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
 static int mpu_irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
 static int dma[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_DMA;
 static int dma2[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_DMA;
+static bool joystick[SNDRV_CARDS] __devinitdata;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index number for SoundScape soundcard");
@@ -79,6 +80,9 @@ MODULE_PARM_DESC(dma, "DMA # for SoundScape driver.");
 module_param_array(dma2, int, NULL, 0444);
 MODULE_PARM_DESC(dma2, "DMA2 # for SoundScape driver.");
 
+module_param_array(joystick, bool, NULL, 0444);
+MODULE_PARM_DESC(joystick, "Enable gameport.");
+
 #ifdef CONFIG_PNP
 static int isa_registered;
 static int pnp_registered;
@@ -145,7 +149,6 @@ struct soundscape {
 	struct resource *io_res;
 	struct resource *wss_res;
 	struct snd_wss *chip;
-	struct snd_mpu401 *mpu;
 
 	unsigned char midi_vol;
 };
@@ -815,7 +818,6 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum, unsigned l
 		mpu->open_input = mpu401_open;
 		mpu->open_output = mpu401_open;
 		mpu->private_data = sscape;
-		sscape->mpu = mpu;
 
 		initialise_mpu401(mpu);
 	}
@@ -836,12 +838,30 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 	register struct soundscape *sscape = get_card_soundscape(card);
 	struct snd_wss *chip;
 	int err;
+	int codec_type = WSS_HW_DETECT;
+
+	switch (sscape->type) {
+	case MEDIA_FX:
+	case SSCAPE:
+		/*
+		 * There are some freak examples of early Soundscape cards
+		 * with CS4231 instead of AD1848/CS4248. Unfortunately, the
+		 * CS4231 works only in CS4248 compatibility mode on
+		 * these cards so force it.
+		 */
+		if (sscape->ic_type != IC_OPUS)
+			codec_type = WSS_HW_AD1848;
+		break;
 
-	if (sscape->type == SSCAPE_VIVO)
+	case SSCAPE_VIVO:
 		port += 4;
+		break;
+	default:
+		break;
+	}
 
 	err = snd_wss_create(card, port, -1, irq, dma1, dma2,
-			     WSS_HW_DETECT, WSS_HWSHARE_DMA1, &chip);
+			     codec_type, WSS_HWSHARE_DMA1, &chip);
 	if (!err) {
 		unsigned long flags;
 		struct snd_pcm *pcm;
@@ -927,6 +947,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	struct resource *wss_res;
 	unsigned long flags;
 	int err;
+	int val;
 	const char *name;
 
 	/*
@@ -1026,6 +1047,10 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	sscape_write_unsafe(sscape->io_base, GA_DMAB_REG, 0x20);
 
 	mpu_irq_cfg |= mpu_irq_cfg << 2;
+	val = sscape_read_unsafe(sscape->io_base, GA_HMCTL_REG) & 0xF7;
+	if (joystick[dev])
+		val |= 8;
+	sscape_write_unsafe(sscape->io_base, GA_HMCTL_REG, val | 0x10);
 	sscape_write_unsafe(sscape->io_base, GA_INTCFG_REG, 0xf0 | mpu_irq_cfg);
 	sscape_write_unsafe(sscape->io_base,
 			    GA_CDCFG_REG, 0x09 | DMA_8BIT
-- 
1.6.0.3


----------------------------------------------------------------------
Nie boisz sie wampirow!
A wiêc Graj >>> http://link.interia.pl/f2390


--===============0453180630614876624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0453180630614876624==--
