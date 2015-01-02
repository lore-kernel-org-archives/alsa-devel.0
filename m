From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/21] ALSA: wss: Remove (almost) always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:43 +0100
Message-ID: <1420197895-17696-10-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C2F9926049F
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:10 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

Most callers of snd_wss_pcm(), snd_wss_timer() and snd_cs4236_pcm() pass
NULL as the last parameter, some callers pass a pointer but never use it
after the function has been called and only a few callers pass a pointer and
actually use it. The later is only the case for snd_wss_pcm() for
snd_cs4236_pcm() and it is possible to get the same PCM object by accessing
the pcm field of the snd_wss struct that was passed as the first parameter.

This function removes the last parameters from the functions mentioned above
and updates the callers which used it to use chip->pcm instead. This allows
us to slightly simplify the functions since they don't have to check and set
the last parameter anymore which makes the code slightly shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/wss.h                |  6 +++---
 sound/isa/ad1848/ad1848.c          |  7 +++----
 sound/isa/azt2320.c                |  4 ++--
 sound/isa/cmi8328.c                |  4 ++--
 sound/isa/cs423x/cs4231.c          |  9 ++++-----
 sound/isa/cs423x/cs4236.c          | 13 ++++++-------
 sound/isa/cs423x/cs4236_lib.c      |  9 +++------
 sound/isa/galaxy/galaxy.c          |  4 ++--
 sound/isa/gus/gusmax.c             |  4 ++--
 sound/isa/gus/interwave.c          | 10 +++++-----
 sound/isa/opl3sa2.c                |  4 ++--
 sound/isa/opti9xx/miro.c           | 12 +++++-------
 sound/isa/opti9xx/opti92x-ad1848.c | 13 +++++--------
 sound/isa/sc6000.c                 |  2 +-
 sound/isa/sscape.c                 |  5 ++---
 sound/isa/wavefront/wavefront.c    |  4 ++--
 sound/isa/wss/wss_lib.c            |  8 ++------
 17 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/include/sound/wss.h b/include/sound/wss.h
index 0c7f034..1823e3a 100644
--- a/include/sound/wss.h
+++ b/include/sound/wss.h
@@ -154,8 +154,8 @@ int snd_wss_create(struct snd_card *card,
 		      unsigned short hardware,
 		      unsigned short hwshare,
 		      struct snd_wss **rchip);
-int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
-int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer);
+int snd_wss_pcm(struct snd_wss *chip, int device);
+int snd_wss_timer(struct snd_wss *chip, int device);
 int snd_wss_mixer(struct snd_wss *chip);
 
 const struct snd_pcm_ops *snd_wss_get_pcm_ops(int direction);
@@ -167,7 +167,7 @@ int snd_cs4236_create(struct snd_card *card,
 		      unsigned short hardware,
 		      unsigned short hwshare,
 		      struct snd_wss **rchip);
-int snd_cs4236_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm);
+int snd_cs4236_pcm(struct snd_wss *chip, int device);
 int snd_cs4236_mixer(struct snd_wss *chip);
 
 /*
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 093f22a..f159da4e 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -88,7 +88,6 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_wss *chip;
-	struct snd_pcm *pcm;
 	int error;
 
 	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
@@ -103,7 +102,7 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 
 	card->private_data = chip;
 
-	error = snd_wss_pcm(chip, 0, &pcm);
+	error = snd_wss_pcm(chip, 0);
 	if (error < 0)
 		goto out;
 
@@ -112,10 +111,10 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 		goto out;
 
 	strcpy(card->driver, "AD1848");
-	strcpy(card->shortname, pcm->name);
+	strcpy(card->shortname, chip->pcm->name);
 
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		pcm->name, chip->port, irq[n], dma1[n]);
+		chip->pcm->name, chip->port, irq[n], dma1[n]);
 	if (thinkpad[n])
 		strcat(card->longname, " [Thinkpad]");
 
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 0ea75fc..b8e768e 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -215,7 +215,7 @@ static int snd_card_azt2320_probe(int dev,
 	sprintf(card->longname, "%s, WSS at 0x%lx, irq %i, dma %i&%i",
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
-	error = snd_wss_pcm(chip, 0, NULL);
+	error = snd_wss_pcm(chip, 0);
 	if (error < 0) {
 		snd_card_free(card);
 		return error;
@@ -225,7 +225,7 @@ static int snd_card_azt2320_probe(int dev,
 		snd_card_free(card);
 		return error;
 	}
-	error = snd_wss_timer(chip, 0, NULL);
+	error = snd_wss_timer(chip, 0);
 	if (error < 0) {
 		snd_card_free(card);
 		return error;
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index 4778852..2c89d95 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -307,7 +307,7 @@ static int snd_cmi8328_probe(struct device *pdev, unsigned int ndev)
 	if (err < 0)
 		goto error;
 
-	err = snd_wss_pcm(cmi->wss, 0, NULL);
+	err = snd_wss_pcm(cmi->wss, 0);
 	if (err < 0)
 		goto error;
 
@@ -318,7 +318,7 @@ static int snd_cmi8328_probe(struct device *pdev, unsigned int ndev)
 	if (err < 0)
 		goto error;
 
-	if (snd_wss_timer(cmi->wss, 0, NULL) < 0)
+	if (snd_wss_timer(cmi->wss, 0) < 0)
 		snd_printk(KERN_WARNING "error initializing WSS timer\n");
 
 	if (mpuport[ndev] == SNDRV_AUTO_PORT) {
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 7dba07a..282cd75 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -92,7 +92,6 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_wss *chip;
-	struct snd_pcm *pcm;
 	int error;
 
 	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
@@ -106,15 +105,15 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 
 	card->private_data = chip;
 
-	error = snd_wss_pcm(chip, 0, &pcm);
+	error = snd_wss_pcm(chip, 0);
 	if (error < 0)
 		goto out;
 
 	strcpy(card->driver, "CS4231");
-	strcpy(card->shortname, pcm->name);
+	strcpy(card->shortname, chip->pcm->name);
 
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		pcm->name, chip->port, irq[n], dma1[n]);
+		chip->pcm->name, chip->port, irq[n], dma1[n]);
 	if (dma2[n] >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", dma2[n]);
 
@@ -122,7 +121,7 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	error = snd_wss_timer(chip, 0, NULL);
+	error = snd_wss_timer(chip, 0);
 	if (error < 0)
 		goto out;
 
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 750f51c..9d7582c 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -382,7 +382,6 @@ static int snd_cs423x_card_new(struct device *pdev, int dev,
 static int snd_cs423x_probe(struct snd_card *card, int dev)
 {
 	struct snd_card_cs4236 *acard;
-	struct snd_pcm *pcm;
 	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 	int err;
@@ -404,7 +403,7 @@ static int snd_cs423x_probe(struct snd_card *card, int dev)
 	acard->chip = chip;
 	if (chip->hardware & WSS_HW_CS4236B_MASK) {
 
-		err = snd_cs4236_pcm(chip, 0, &pcm);
+		err = snd_cs4236_pcm(chip, 0);
 		if (err < 0)
 			return err;
 
@@ -412,7 +411,7 @@ static int snd_cs423x_probe(struct snd_card *card, int dev)
 		if (err < 0)
 			return err;
 	} else {
-		err = snd_wss_pcm(chip, 0, &pcm);
+		err = snd_wss_pcm(chip, 0);
 		if (err < 0)
 			return err;
 
@@ -420,17 +419,17 @@ static int snd_cs423x_probe(struct snd_card *card, int dev)
 		if (err < 0)
 			return err;
 	}
-	strcpy(card->driver, pcm->name);
-	strcpy(card->shortname, pcm->name);
+	strcpy(card->driver, chip->pcm->name);
+	strcpy(card->shortname, chip->pcm->name);
 	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i",
-		pcm->name,
+		chip->pcm->name,
 		chip->port,
 		irq[dev],
 		dma1[dev]);
 	if (dma2[dev] >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
 
-	err = snd_wss_timer(chip, 0, NULL);
+	err = snd_wss_timer(chip, 0);
 	if (err < 0)
 		return err;
 
diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index c5adca3..add7ffc 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -376,17 +376,14 @@ int snd_cs4236_create(struct snd_card *card,
 	return 0;
 }
 
-int snd_cs4236_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
+int snd_cs4236_pcm(struct snd_wss *chip, int device)
 {
-	struct snd_pcm *pcm;
 	int err;
 	
-	err = snd_wss_pcm(chip, device, &pcm);
+	err = snd_wss_pcm(chip, device);
 	if (err < 0)
 		return err;
-	pcm->info_flags &= ~SNDRV_PCM_INFO_JOINT_DUPLEX;
-	if (rpcm)
-		*rpcm = pcm;
+	chip->pcm->info_flags &= ~SNDRV_PCM_INFO_JOINT_DUPLEX;
 	return 0;
 }
 
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 1eb2b1e..3227884 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -569,7 +569,7 @@ static int snd_galaxy_probe(struct device *dev, unsigned int n)
 	if (err < 0)
 		goto error;
 
-	err = snd_wss_pcm(chip, 0, NULL);
+	err = snd_wss_pcm(chip, 0);
 	if (err < 0)
 		goto error;
 
@@ -577,7 +577,7 @@ static int snd_galaxy_probe(struct device *dev, unsigned int n)
 	if (err < 0)
 		goto error;
 
-	err = snd_wss_timer(chip, 0, NULL);
+	err = snd_wss_timer(chip, 0);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index b2b3734..8216e8d 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -309,7 +309,7 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 	if (err < 0)
 		goto _err;
 
-	err = snd_wss_pcm(wss, 0, NULL);
+	err = snd_wss_pcm(wss, 0);
 	if (err < 0)
 		goto _err;
 
@@ -317,7 +317,7 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 	if (err < 0)
 		goto _err;
 
-	err = snd_wss_timer(wss, 2, NULL);
+	err = snd_wss_timer(wss, 2);
 	if (err < 0)
 		goto _err;
 
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 8ea54a7..70d0040 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -647,7 +647,6 @@ static int snd_interwave_probe(struct snd_card *card, int dev)
 #ifdef SNDRV_STB
 	struct snd_i2c_bus *i2c_bus;
 #endif
-	struct snd_pcm *pcm;
 	char *str;
 	int err;
 
@@ -695,14 +694,15 @@ static int snd_interwave_probe(struct snd_card *card, int dev)
 	if (err < 0)
 		return err;
 
-	err = snd_wss_pcm(wss, 0, &pcm);
+	err = snd_wss_pcm(wss, 0);
 	if (err < 0)
 		return err;
 
-	sprintf(pcm->name + strlen(pcm->name), " rev %c", gus->revision + 'A');
-	strcat(pcm->name, " (codec)");
+	sprintf(wss->pcm->name + strlen(wss->pcm->name), " rev %c",
+		gus->revision + 'A');
+	strcat(wss->pcm->name, " (codec)");
 
-	err = snd_wss_timer(wss, 2, NULL);
+	err = snd_wss_timer(wss, 2);
 	if (err < 0)
 		return err;
 
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index a219bc3..d7aff52 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -684,7 +684,7 @@ static int snd_opl3sa2_probe(struct snd_card *card, int dev)
 		return err;
 	}
 	chip->wss = wss;
-	err = snd_wss_pcm(wss, 0, NULL);
+	err = snd_wss_pcm(wss, 0);
 	if (err < 0)
 		return err;
 	err = snd_wss_mixer(wss);
@@ -693,7 +693,7 @@ static int snd_opl3sa2_probe(struct snd_card *card, int dev)
 	err = snd_opl3sa2_mixer(card);
 	if (err < 0)
 		return err;
-	err = snd_wss_timer(wss, 0, NULL);
+	err = snd_wss_timer(wss, 0);
 	if (err < 0)
 		return err;
 	if (fm_port[dev] >= 0x340 && fm_port[dev] < 0x400) {
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index c2ca681..5464528 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1270,8 +1270,6 @@ static int snd_miro_probe(struct snd_card *card)
 	int error;
 	struct snd_miro *miro = card->private_data;
 	struct snd_wss *codec;
-	struct snd_timer *timer;
-	struct snd_pcm *pcm;
 	struct snd_rawmidi *rmidi;
 
 	if (!miro->res_mc_base) {
@@ -1310,7 +1308,7 @@ static int snd_miro_probe(struct snd_card *card)
 	if (error < 0)
 		return error;
 
-	error = snd_wss_pcm(codec, 0, &pcm);
+	error = snd_wss_pcm(codec, 0);
 	if (error < 0)
 		return error;
 
@@ -1318,11 +1316,11 @@ static int snd_miro_probe(struct snd_card *card)
 	if (error < 0)
 		return error;
 
-	error = snd_wss_timer(codec, 0, &timer);
+	error = snd_wss_timer(codec, 0);
 	if (error < 0)
 		return error;
 
-	miro->pcm = pcm;
+	miro->pcm = codec->pcm;
 
 	error = snd_miro_mixer(card, miro);
 	if (error < 0)
@@ -1356,8 +1354,8 @@ static int snd_miro_probe(struct snd_card *card)
 
 	strcpy(card->driver, "miro");
 	sprintf(card->longname, "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, miro->name, pcm->name, miro->wss_base + 4,
-		miro->irq, miro->dma1, miro->dma2);
+		card->shortname, miro->name, codec->pcm->name,
+		miro->wss_base + 4, miro->irq, miro->dma1, miro->dma2);
 
 	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
 		rmidi = NULL;
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index c9b5828..840831f 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -820,10 +820,6 @@ static int snd_opti9xx_probe(struct snd_card *card)
 	int xdma2;
 	struct snd_opti9xx *chip = card->private_data;
 	struct snd_wss *codec;
-#ifdef CS4231
-	struct snd_timer *timer;
-#endif
-	struct snd_pcm *pcm;
 	struct snd_rawmidi *rmidi;
 	struct snd_hwdep *synth;
 
@@ -855,7 +851,7 @@ static int snd_opti9xx_probe(struct snd_card *card)
 	if (error < 0)
 		return error;
 	chip->codec = codec;
-	error = snd_wss_pcm(codec, 0, &pcm);
+	error = snd_wss_pcm(codec, 0);
 	if (error < 0)
 		return error;
 	error = snd_wss_mixer(codec);
@@ -867,7 +863,7 @@ static int snd_opti9xx_probe(struct snd_card *card)
 		return error;
 #endif
 #ifdef CS4231
-	error = snd_wss_timer(codec, 0, &timer);
+	error = snd_wss_timer(codec, 0);
 	if (error < 0)
 		return error;
 #endif
@@ -884,11 +880,12 @@ static int snd_opti9xx_probe(struct snd_card *card)
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, pcm->name,
+		card->shortname, codec->pcm->name,
 		chip->wss_base + 4, irq, dma1, xdma2);
 #else
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, pcm->name, chip->wss_base + 4, irq, dma1);
+		card->shortname, codec->pcm->name, chip->wss_base + 4, irq,
+		dma1);
 #endif	/* CS4231 || OPTi93X */
 
 	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 15a152e..51cfa76 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -625,7 +625,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	if (err < 0)
 		goto err_unmap2;
 
-	err = snd_wss_pcm(chip, 0, NULL);
+	err = snd_wss_pcm(chip, 0);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX
 			   "error creating new WSS PCM device\n");
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 44405df..018ab14 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -877,7 +877,6 @@ static int create_ad1845(struct snd_card *card, unsigned port,
 			     codec_type, WSS_HWSHARE_DMA1, &chip);
 	if (!err) {
 		unsigned long flags;
-		struct snd_pcm *pcm;
 
 		if (sscape->type != SSCAPE_VIVO) {
 			/*
@@ -893,7 +892,7 @@ static int create_ad1845(struct snd_card *card, unsigned port,
 
 		}
 
-		err = snd_wss_pcm(chip, 0, &pcm);
+		err = snd_wss_pcm(chip, 0);
 		if (err < 0) {
 			snd_printk(KERN_ERR "sscape: No PCM device "
 					    "for AD1845 chip\n");
@@ -907,7 +906,7 @@ static int create_ad1845(struct snd_card *card, unsigned port,
 			goto _error;
 		}
 		if (chip->hardware != WSS_HW_AD1848) {
-			err = snd_wss_timer(chip, 0, NULL);
+			err = snd_wss_timer(chip, 0);
 			if (err < 0) {
 				snd_printk(KERN_ERR "sscape: No timer device "
 						    "for AD1845 chip\n");
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index bfbf38c..a0987a5 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -380,11 +380,11 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 		return err;
 	}
 
-	err = snd_wss_pcm(chip, 0, NULL);
+	err = snd_wss_pcm(chip, 0);
 	if (err < 0)
 		return err;
 
-	err = snd_wss_timer(chip, 0, NULL);
+	err = snd_wss_timer(chip, 0);
 	if (err < 0)
 		return err;
 
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 347bb1b..6530d32 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1923,7 +1923,7 @@ static struct snd_pcm_ops snd_wss_capture_ops = {
 	.pointer =	snd_wss_capture_pointer,
 };
 
-int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
+int snd_wss_pcm(struct snd_wss *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1949,8 +1949,6 @@ int snd_wss_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
 					      64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 
 	chip->pcm = pcm;
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 EXPORT_SYMBOL(snd_wss_pcm);
@@ -1961,7 +1959,7 @@ static void snd_wss_timer_free(struct snd_timer *timer)
 	chip->timer = NULL;
 }
 
-int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer)
+int snd_wss_timer(struct snd_wss *chip, int device)
 {
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
@@ -1980,8 +1978,6 @@ int snd_wss_timer(struct snd_wss *chip, int device, struct snd_timer **rtimer)
 	timer->private_free = snd_wss_timer_free;
 	timer->hw = snd_wss_timer_table;
 	chip->timer = timer;
-	if (rtimer)
-		*rtimer = timer;
 	return 0;
 }
 EXPORT_SYMBOL(snd_wss_timer);
-- 
1.8.0
