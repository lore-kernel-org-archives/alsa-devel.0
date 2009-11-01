From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4236: detect chip in one pass
Date: Sun, 1 Nov 2009 16:50:38 +0100
Message-ID: <20091101165038.e3f5b0e9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4263888506980898853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 1BC8224385
	for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2009 16:32:54 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, wim@djo.tudelft.nl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============4263888506980898853==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The cs4236 was two step detection with call to the snd_wss_free()
between two steps. The snd_wss_free() did not free a sound device
created in the snd_wss_create(). This caused an OOPS during module
removal as the same sound device was released twice. The same OOPS
happened if the cs4236 module loading failed.

Fix this by adapting the snd_cs4236_create() to correctly work with
chips less capable then cs4236. The snd_cs4236_create() behaves the
same as the snd_wss_create() if the chip is less capable than the cs4236.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This is the second version of the patch with added snd_device_free() call
in error path.

 include/sound/wss.h           |    1 -
 sound/isa/cs423x/cs4236.c     |   13 +---
 sound/isa/cs423x/cs4236_lib.c |  144 ++++++++++++++++++++++-------------------
 sound/isa/wss/wss_lib.c       |    3 +-
 4 files changed, 81 insertions(+), 80 deletions(-)

diff --git a/include/sound/wss.h b/include/sound/wss.h
index 6d65f32..fd01f22 100644
--- a/include/sound/wss.h
+++ b/include/sound/wss.h
@@ -154,7 +154,6 @@ int snd_wss_create(struct snd_card *card,
 		      unsigned short hardware,
 		      unsigned short hwshare,
 		      struct snd_wss **rchip);
-int snd_wss_free(struct snd_wss *chip);
 int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
 int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer);
 int snd_wss_mixer(struct snd_wss *chip);
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index a076a6c..93fa672 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -394,21 +394,15 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 			return -EBUSY;
 		}
 
-	err = snd_wss_create(card, port[dev], cport[dev],
+	err = snd_cs4236_create(card, port[dev], cport[dev],
 			     irq[dev],
 			     dma1[dev], dma2[dev],
 			     WSS_HW_DETECT3, 0, &chip);
 	if (err < 0)
 		return err;
+
+	acard->chip = chip;
 	if (chip->hardware & WSS_HW_CS4236B_MASK) {
-		snd_wss_free(chip);
-		err = snd_cs4236_create(card,
-					port[dev], cport[dev],
-					irq[dev], dma1[dev], dma2[dev],
-					WSS_HW_DETECT, 0, &chip);
-		if (err < 0)
-			return err;
-		acard->chip = chip;
 
 		err = snd_cs4236_pcm(chip, 0, &pcm);
 		if (err < 0)
@@ -418,7 +412,6 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 		if (err < 0)
 			return err;
 	} else {
-		acard->chip = chip;
 		err = snd_wss_pcm(chip, 0, &pcm);
 		if (err < 0)
 			return err;
diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index 38835f3..0e29056 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -87,6 +87,7 @@
 #include <sound/core.h>
 #include <sound/wss.h>
 #include <sound/asoundef.h>
+#include <sound/initval.h>
 
 /*
  *
@@ -264,7 +265,10 @@ static void snd_cs4236_resume(struct snd_wss *chip)
 }
 
 #endif /* CONFIG_PM */
-
+/*
+ * This function does no fail if the chip is not CS4236B or compatible.
+ * It just an equivalent to the snd_wss_create() then.
+ */
 int snd_cs4236_create(struct snd_card *card,
 		      unsigned long port,
 		      unsigned long cport,
@@ -281,83 +285,89 @@ int snd_cs4236_create(struct snd_card *card,
 	*rchip = NULL;
 	if (hardware == WSS_HW_DETECT)
 		hardware = WSS_HW_DETECT3;
-	if (cport < 0x100) {
-		snd_printk(KERN_ERR "please, specify control port "
-			   "for CS4236+ chips\n");
-		return -ENODEV;
-	}
+
 	err = snd_wss_create(card, port, cport,
 			     irq, dma1, dma2, hardware, hwshare, &chip);
 	if (err < 0)
 		return err;
 
-	if (!(chip->hardware & WSS_HW_CS4236B_MASK)) {
-		snd_printk(KERN_ERR "CS4236+: MODE3 and extended registers "
-			   "not available, hardware=0x%x\n", chip->hardware);
-		snd_device_free(card, chip);
-		return -ENODEV;
-	}
+	if (chip->hardware & WSS_HW_CS4236B_MASK) {
 #if 0
-	{
-		int idx;
-		for (idx = 0; idx < 8; idx++)
-			snd_printk(KERN_DEBUG "CD%i = 0x%x\n",
-				   idx, inb(chip->cport + idx));
-		for (idx = 0; idx < 9; idx++)
-			snd_printk(KERN_DEBUG "C%i = 0x%x\n",
-				   idx, snd_cs4236_ctrl_in(chip, idx));
-	}
+		{
+			int idx;
+			for (idx = 0; idx < 8; idx++)
+				snd_printk(KERN_DEBUG "CD%i = 0x%x\n",
+					   idx, inb(chip->cport + idx));
+			for (idx = 0; idx < 9; idx++)
+				snd_printk(KERN_DEBUG "C%i = 0x%x\n",
+					   idx, snd_cs4236_ctrl_in(chip, idx));
+		}
 #endif
-	ver1 = snd_cs4236_ctrl_in(chip, 1);
-	ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
-	snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n", cport, ver1, ver2);
-	if (ver1 != ver2) {
-		snd_printk(KERN_ERR "CS4236+ chip detected, but "
-			   "control port 0x%lx is not valid\n", cport);
-		snd_device_free(card, chip);
-		return -ENODEV;
-	}
-	snd_cs4236_ctrl_out(chip, 0, 0x00);
-	snd_cs4236_ctrl_out(chip, 2, 0xff);
-	snd_cs4236_ctrl_out(chip, 3, 0x00);
-	snd_cs4236_ctrl_out(chip, 4, 0x80);
-	snd_cs4236_ctrl_out(chip, 5, ((IEC958_AES1_CON_PCM_CODER & 3) << 6) | IEC958_AES0_CON_EMPHASIS_NONE);
-	snd_cs4236_ctrl_out(chip, 6, IEC958_AES1_CON_PCM_CODER >> 2);
-	snd_cs4236_ctrl_out(chip, 7, 0x00);
-	/* 0x8c for C8 is valid for Turtle Beach Malibu - the IEC-958 output */
-	/* is working with this setup, other hardware should have */
-	/* different signal paths and this value should be selectable */
-	/* in the future */
-	snd_cs4236_ctrl_out(chip, 8, 0x8c);
-	chip->rate_constraint = snd_cs4236_xrate;
-	chip->set_playback_format = snd_cs4236_playback_format;
-	chip->set_capture_format = snd_cs4236_capture_format;
+		if (cport < 0x100 || cport == SNDRV_AUTO_PORT) {
+			snd_printk(KERN_ERR "please, specify control port "
+				   "for CS4236+ chips\n");
+			snd_device_free(card, chip);
+			return -ENODEV;
+		}
+		ver1 = snd_cs4236_ctrl_in(chip, 1);
+		ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
+		snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n",
+				cport, ver1, ver2);
+		if (ver1 != ver2) {
+			snd_printk(KERN_ERR "CS4236+ chip detected, but "
+				   "control port 0x%lx is not valid\n", cport);
+			snd_device_free(card, chip);
+			return -ENODEV;
+		}
+		snd_cs4236_ctrl_out(chip, 0, 0x00);
+		snd_cs4236_ctrl_out(chip, 2, 0xff);
+		snd_cs4236_ctrl_out(chip, 3, 0x00);
+		snd_cs4236_ctrl_out(chip, 4, 0x80);
+		reg = ((IEC958_AES1_CON_PCM_CODER & 3) << 6) |
+		      IEC958_AES0_CON_EMPHASIS_NONE;
+		snd_cs4236_ctrl_out(chip, 5, reg);
+		snd_cs4236_ctrl_out(chip, 6, IEC958_AES1_CON_PCM_CODER >> 2);
+		snd_cs4236_ctrl_out(chip, 7, 0x00);
+		/*
+		 * 0x8c for C8 is valid for Turtle Beach Malibu - the IEC-958
+		 * output is working with this setup, other hardware should
+		 * have different signal paths and this value should be
+		 * selectable in the future
+		 * */
+		snd_cs4236_ctrl_out(chip, 8, 0x8c);
+		chip->rate_constraint = snd_cs4236_xrate;
+		chip->set_playback_format = snd_cs4236_playback_format;
+		chip->set_capture_format = snd_cs4236_capture_format;
 #ifdef CONFIG_PM
-	chip->suspend = snd_cs4236_suspend;
-	chip->resume = snd_cs4236_resume;
+		chip->suspend = snd_cs4236_suspend;
+		chip->resume = snd_cs4236_resume;
 #endif
 
-	/* initialize extended registers */
-	for (reg = 0; reg < sizeof(snd_cs4236_ext_map); reg++)
-		snd_cs4236_ext_out(chip, CS4236_I23VAL(reg), snd_cs4236_ext_map[reg]);
-
-        /* initialize compatible but more featured registers */
-	snd_wss_out(chip, CS4231_LEFT_INPUT, 0x40);
-	snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x40);
-	snd_wss_out(chip, CS4231_AUX1_LEFT_INPUT, 0xff);
-	snd_wss_out(chip, CS4231_AUX1_RIGHT_INPUT, 0xff);
-	snd_wss_out(chip, CS4231_AUX2_LEFT_INPUT, 0xdf);
-	snd_wss_out(chip, CS4231_AUX2_RIGHT_INPUT, 0xdf);
-	snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
-	snd_wss_out(chip, CS4231_LEFT_LINE_IN, 0xff);
-	snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
-	switch (chip->hardware) {
-	case WSS_HW_CS4235:
-	case WSS_HW_CS4239:
-		snd_wss_out(chip, CS4235_LEFT_MASTER, 0xff);
-		snd_wss_out(chip, CS4235_RIGHT_MASTER, 0xff);
-		break;
-	}
+		/* initialize extended registers */
+		for (reg = 0; reg < sizeof(snd_cs4236_ext_map); reg++)
+			snd_cs4236_ext_out(chip, CS4236_I23VAL(reg),
+					   snd_cs4236_ext_map[reg]);
+
+		/* initialize compatible but more featured registers */
+		snd_wss_out(chip, CS4231_LEFT_INPUT, 0x40);
+		snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x40);
+		snd_wss_out(chip, CS4231_AUX1_LEFT_INPUT, 0xff);
+		snd_wss_out(chip, CS4231_AUX1_RIGHT_INPUT, 0xff);
+		snd_wss_out(chip, CS4231_AUX2_LEFT_INPUT, 0xdf);
+		snd_wss_out(chip, CS4231_AUX2_RIGHT_INPUT, 0xdf);
+		snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
+		snd_wss_out(chip, CS4231_LEFT_LINE_IN, 0xff);
+		snd_wss_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
+		switch (chip->hardware) {
+		case WSS_HW_CS4235:
+		case WSS_HW_CS4239:
+			snd_wss_out(chip, CS4235_LEFT_MASTER, 0xff);
+			snd_wss_out(chip, CS4235_RIGHT_MASTER, 0xff);
+			break;
+		}
+	} else
+		snd_printd("chip is not CS4236+, hardware=0x%x\n",
+			   chip->hardware);
 
 	*rchip = chip;
 	return 0;
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 5d2ba1b..aab44e7 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1682,7 +1682,7 @@ static void snd_wss_resume(struct snd_wss *chip)
 }
 #endif /* CONFIG_PM */
 
-int snd_wss_free(struct snd_wss *chip)
+static int snd_wss_free(struct snd_wss *chip)
 {
 	release_and_free_resource(chip->res_port);
 	release_and_free_resource(chip->res_cport);
@@ -1705,7 +1705,6 @@ int snd_wss_free(struct snd_wss *chip)
 	kfree(chip);
 	return 0;
 }
-EXPORT_SYMBOL(snd_wss_free);
 
 static int snd_wss_dev_free(struct snd_device *device)
 {
-- 
1.6.4


----------------------------------------------------------------------
Konkurs: Wygrywaj nagrody z Pudzianem!
Sprawd¼ >> http://link.interia.pl/f240e  


--===============4263888506980898853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4263888506980898853==--
