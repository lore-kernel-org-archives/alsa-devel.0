From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/24] ALSA: isa: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:20 +0100
Message-ID: <1392201340-27113-5-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B2486264F74
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7DBD3ABFB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/ad1816a/ad1816a.c        |  6 +++---
 sound/isa/ad1848/ad1848.c          |  4 +---
 sound/isa/adlib.c                  |  4 +---
 sound/isa/als100.c                 |  6 +++---
 sound/isa/azt2320.c                |  6 +++---
 sound/isa/cmi8328.c                |  5 ++---
 sound/isa/cmi8330.c                | 13 ++++++-------
 sound/isa/cs423x/cs4231.c          |  4 +---
 sound/isa/cs423x/cs4236.c          | 16 +++++++---------
 sound/isa/es1688/es1688.c          | 12 +++++-------
 sound/isa/es18xx.c                 | 16 +++++++---------
 sound/isa/galaxy/galaxy.c          |  6 ++----
 sound/isa/gus/gusclassic.c         |  4 +---
 sound/isa/gus/gusextreme.c         |  6 ++----
 sound/isa/gus/gusmax.c             |  6 ++----
 sound/isa/gus/interwave.c          | 13 ++++++-------
 sound/isa/msnd/msnd_pinnacle.c     | 11 +++++------
 sound/isa/opl3sa2.c                | 16 +++++++---------
 sound/isa/opti9xx/miro.c           | 11 ++++-------
 sound/isa/opti9xx/opti92x-ad1848.c | 12 +++++-------
 sound/isa/sb/jazz16.c              |  6 ++----
 sound/isa/sb/sb16.c                | 13 ++++++-------
 sound/isa/sb/sb8.c                 |  6 ++----
 sound/isa/sc6000.c                 |  6 ++----
 sound/isa/sscape.c                 | 11 +++++------
 sound/isa/wavefront/wavefront.c    | 13 ++++++-------
 26 files changed, 96 insertions(+), 136 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 26ce26a5884d..f481a41e027e 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -144,8 +144,9 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 	struct snd_opl3 *opl3;
 	struct snd_timer *timer;
 
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_ad1816a), &card);
+	error = snd_card_new(&pcard->card->dev,
+			     index[dev], id[dev], THIS_MODULE,
+			     sizeof(struct snd_ad1816a), &card);
 	if (error < 0)
 		return error;
 	chip = card->private_data;
@@ -154,7 +155,6 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	if ((error = snd_ad1816a_create(card, port[dev],
 					irq[dev],
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index e3f455bd85cd..093f22a464d7 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -91,7 +91,7 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 	struct snd_pcm *pcm;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0)
 		return error;
 
@@ -119,8 +119,6 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 	if (thinkpad[n])
 		strcat(card->longname, " [Thinkpad]");
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_card_register(card);
 	if (error < 0)
 		goto out;
diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 35659218710f..120c524bb2a0 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -53,7 +53,7 @@ static int snd_adlib_probe(struct device *dev, unsigned int n)
 	struct snd_opl3 *opl3;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0) {
 		dev_err(dev, "could not create card\n");
 		return error;
@@ -83,8 +83,6 @@ static int snd_adlib_probe(struct device *dev, unsigned int n)
 		goto out;
 	}
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_card_register(card);
 	if (error < 0) {
 		dev_err(dev, "could not register card\n");
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 10f08a18fe3b..32d01525211d 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -193,8 +193,9 @@ static int snd_card_als100_probe(int dev,
 	struct snd_card_als100 *acard;
 	struct snd_opl3 *opl3;
 
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_card_als100), &card);
+	error = snd_card_new(&pcard->card->dev,
+			     index[dev], id[dev], THIS_MODULE,
+			     sizeof(struct snd_card_als100), &card);
 	if (error < 0)
 		return error;
 	acard = card->private_data;
@@ -203,7 +204,6 @@ static int snd_card_als100_probe(int dev,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	if (pid->driver_data == SB_HW_DT019X)
 		dma16[dev] = -1;
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index db301ff94ec2..0ea75fc62072 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -184,8 +184,9 @@ static int snd_card_azt2320_probe(int dev,
 	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_card_azt2320), &card);
+	error = snd_card_new(&pcard->card->dev,
+			     index[dev], id[dev], THIS_MODULE,
+			     sizeof(struct snd_card_azt2320), &card);
 	if (error < 0)
 		return error;
 	acard = card->private_data;
@@ -194,7 +195,6 @@ static int snd_card_azt2320_probe(int dev,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	if ((error = snd_card_azt2320_enable_wss(port[dev]))) {
 		snd_card_free(card);
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index ab6b2dc043f1..4778852a1201 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -293,15 +293,14 @@ static int snd_cmi8328_probe(struct device *pdev, unsigned int ndev)
 	}
 	outb(val, port);
 
-	err = snd_card_create(index[ndev], id[ndev], THIS_MODULE,
-				sizeof(struct snd_cmi8328), &card);
+	err = snd_card_new(pdev, index[ndev], id[ndev], THIS_MODULE,
+			   sizeof(struct snd_cmi8328), &card);
 	if (err < 0)
 		return err;
 	cmi = card->private_data;
 	cmi->card = card;
 	cmi->port = port;
 	cmi->wss_cfg = val;
-	snd_card_set_dev(card, pdev);
 
 	err = snd_wss_create(card, port + 4, -1, irq[ndev], dma1[ndev],
 			dma2[ndev], WSS_HW_DETECT, 0, &cmi->wss);
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 270b9659ef7f..dfedfd85f205 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -514,14 +514,15 @@ static int snd_cmi8330_resume(struct snd_card *card)
 
 #define PFX	"cmi8330: "
 
-static int snd_cmi8330_card_new(int dev, struct snd_card **cardp)
+static int snd_cmi8330_card_new(struct device *pdev, int dev,
+				struct snd_card **cardp)
 {
 	struct snd_card *card;
 	struct snd_cmi8330 *acard;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_cmi8330), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_cmi8330), &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "could not get a new card\n");
 		return err;
@@ -635,10 +636,9 @@ static int snd_cmi8330_isa_probe(struct device *pdev,
 	struct snd_card *card;
 	int err;
 
-	err = snd_cmi8330_card_new(dev, &card);
+	err = snd_cmi8330_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, pdev);
 	if ((err = snd_cmi8330_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -698,7 +698,7 @@ static int snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 			       
-	res = snd_cmi8330_card_new(dev, &card);
+	res = snd_cmi8330_card_new(&pcard->card->dev, dev, &card);
 	if (res < 0)
 		return res;
 	if ((res = snd_cmi8330_pnp(dev, card->private_data, pcard, pid)) < 0) {
@@ -706,7 +706,6 @@ static int snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return res;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((res = snd_cmi8330_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return res;
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index ba9a74eff3e0..7dba07a4343a 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -95,7 +95,7 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 	struct snd_pcm *pcm;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0)
 		return error;
 
@@ -135,8 +135,6 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 			dev_warn(dev, "MPU401 not detected\n");
 	}
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_card_register(card);
 	if (error < 0)
 		goto out;
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 69614acb2052..750f51c904fc 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -364,13 +364,14 @@ static void snd_card_cs4236_free(struct snd_card *card)
 	release_and_free_resource(acard->res_sb_port);
 }
 
-static int snd_cs423x_card_new(int dev, struct snd_card **cardp)
+static int snd_cs423x_card_new(struct device *pdev, int dev,
+			       struct snd_card **cardp)
 {
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_card_cs4236), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_card_cs4236), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_card_cs4236_free;
@@ -487,10 +488,9 @@ static int snd_cs423x_isa_probe(struct device *pdev,
 	struct snd_card *card;
 	int err;
 
-	err = snd_cs423x_card_new(dev, &card);
+	err = snd_cs423x_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, pdev);
 	if ((err = snd_cs423x_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -577,7 +577,7 @@ static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 		if (!strcmp(cdev->id[0].id, cid))
 			break;
 	}
-	err = snd_cs423x_card_new(dev, &card);
+	err = snd_cs423x_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
 	err = snd_card_cs423x_pnp(dev, card->private_data, pdev, cdev);
@@ -586,7 +586,6 @@ static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 	if ((err = snd_cs423x_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -638,7 +637,7 @@ static int snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	res = snd_cs423x_card_new(dev, &card);
+	res = snd_cs423x_card_new(&pcard->card->dev, dev, &card);
 	if (res < 0)
 		return res;
 	if ((res = snd_card_cs423x_pnpc(dev, card->private_data, pcard, pid)) < 0) {
@@ -647,7 +646,6 @@ static int snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return res;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((res = snd_cs423x_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return res;
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index cdcfb57f1f0a..76001fe0579d 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -187,8 +187,8 @@ static int snd_es1688_isa_probe(struct device *dev, unsigned int n)
 	struct snd_card *card;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE,
-				sizeof(struct snd_es1688), &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE,
+			     sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
 
@@ -196,8 +196,6 @@ static int snd_es1688_isa_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_es1688_probe(card, n);
 	if (error < 0)
 		goto out;
@@ -274,8 +272,9 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 	if (dev == SNDRV_CARDS)
 		return -ENODEV;
 
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_es1688), &card);
+	error = snd_card_new(&pcard->card->dev,
+			     index[dev], id[dev], THIS_MODULE,
+			     sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
 	chip = card->private_data;
@@ -285,7 +284,6 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	error = snd_es1688_probe(card, dev);
 	if (error < 0)
 		return error;
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 12978b864c3a..1c16830af3d8 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2105,10 +2105,11 @@ static int snd_audiodrive_pnpc(int dev, struct snd_es18xx *chip,
 #define is_isapnp_selected(dev)		0
 #endif
 
-static int snd_es18xx_card_new(int dev, struct snd_card **cardp)
+static int snd_es18xx_card_new(struct device *pdev, int dev,
+			       struct snd_card **cardp)
 {
-	return snd_card_create(index[dev], id[dev], THIS_MODULE,
-			       sizeof(struct snd_es18xx), cardp);
+	return snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct snd_es18xx), cardp);
 }
 
 static int snd_audiodrive_probe(struct snd_card *card, int dev)
@@ -2179,10 +2180,9 @@ static int snd_es18xx_isa_probe1(int dev, struct device *devptr)
 	struct snd_card *card;
 	int err;
 
-	err = snd_es18xx_card_new(dev, &card);
+	err = snd_es18xx_card_new(devptr, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, devptr);
 	if ((err = snd_audiodrive_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2284,14 +2284,13 @@ static int snd_audiodrive_pnp_detect(struct pnp_dev *pdev,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	err = snd_es18xx_card_new(dev, &card);
+	err = snd_es18xx_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
 	if ((err = snd_audiodrive_pnp(dev, card->private_data, pdev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 	if ((err = snd_audiodrive_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2342,7 +2341,7 @@ static int snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	res = snd_es18xx_card_new(dev, &card);
+	res = snd_es18xx_card_new(&pcard->card->dev, dev, &card);
 	if (res < 0)
 		return res;
 
@@ -2350,7 +2349,6 @@ static int snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return res;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((res = snd_audiodrive_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return res;
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 81244e7cea5b..1eb2b1ec0fd9 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -506,13 +506,11 @@ static int snd_galaxy_probe(struct device *dev, unsigned int n)
 	u8 type;
 	int err;
 
-	err = snd_card_create(index[n], id[n], THIS_MODULE, sizeof *galaxy,
-			      &card);
+	err = snd_card_new(dev, index[n], id[n], THIS_MODULE,
+			   sizeof(*galaxy), &card);
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, dev);
-
 	card->private_free = snd_galaxy_free;
 	galaxy = card->private_data;
 
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 1adc1b924f39..7ce29ffa1af9 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -149,7 +149,7 @@ static int snd_gusclassic_probe(struct device *dev, unsigned int n)
 	struct snd_gus_card *gus;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0)
 		return error;
 
@@ -199,8 +199,6 @@ static int snd_gusclassic_probe(struct device *dev, unsigned int n)
 		sprintf(card->longname + strlen(card->longname),
 			"&%d", gus->gf1.dma2);
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_card_register(card);
 	if (error < 0)
 		goto out;
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 38e1e3260c24..28a16936a397 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -242,8 +242,8 @@ static int snd_gusextreme_probe(struct device *dev, unsigned int n)
 	struct snd_opl3 *opl3;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE,
-				sizeof(struct snd_es1688), &card);
+	error = snd_card_new(dev, index[n], id[n], THIS_MODULE,
+			     sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
 
@@ -328,8 +328,6 @@ static int snd_gusextreme_probe(struct device *dev, unsigned int n)
 		"irq %i&%i, dma %i&%i", es1688->port,
 		gus->gf1.irq, es1688->irq, gus->gf1.dma1, es1688->dma8);
 
-	snd_card_set_dev(card, dev);
-
 	error = snd_card_register(card);
 	if (error < 0)
 		goto out;
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 652d5d834620..39df36ca3acb 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -214,8 +214,8 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 	struct snd_wss *wss;
 	struct snd_gusmax *maxcard;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_gusmax), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_gusmax), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_gusmax_free;
@@ -337,8 +337,6 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 	if (xdma2 >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%i", xdma2);
 
-	snd_card_set_dev(card, pdev);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto _err;
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index afef0d738078..5abbbe477d16 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -625,14 +625,15 @@ static void snd_interwave_free(struct snd_card *card)
 		free_irq(iwcard->irq, (void *)iwcard);
 }
 
-static int snd_interwave_card_new(int dev, struct snd_card **cardp)
+static int snd_interwave_card_new(struct device *pdev, int dev,
+				  struct snd_card **cardp)
 {
 	struct snd_card *card;
 	struct snd_interwave *iwcard;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_interwave), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_interwave), &card);
 	if (err < 0)
 		return err;
 	iwcard = card->private_data;
@@ -779,11 +780,10 @@ static int snd_interwave_isa_probe1(int dev, struct device *devptr)
 	struct snd_card *card;
 	int err;
 
-	err = snd_interwave_card_new(dev, &card);
+	err = snd_interwave_card_new(devptr, dev, &card);
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, devptr);
 	if ((err = snd_interwave_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -876,7 +876,7 @@ static int snd_interwave_pnp_detect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 				
-	res = snd_interwave_card_new(dev, &card);
+	res = snd_interwave_card_new(&pcard->card->dev, dev, &card);
 	if (res < 0)
 		return res;
 
@@ -884,7 +884,6 @@ static int snd_interwave_pnp_detect(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return res;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((res = snd_interwave_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return res;
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 0a90bd6ae232..5016bf957f51 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -905,12 +905,11 @@ static int snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
 		return -ENODEV;
 	}
 
-	err = snd_card_create(index[idx], id[idx], THIS_MODULE,
-			      sizeof(struct snd_msnd), &card);
+	err = snd_card_new(pdev, index[idx], id[idx], THIS_MODULE,
+			   sizeof(struct snd_msnd), &card);
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, pdev);
 	chip = card->private_data;
 	chip->card = card;
 
@@ -1122,14 +1121,14 @@ static int snd_msnd_pnp_detect(struct pnp_card_link *pcard,
 	 * Create a new ALSA sound card entry, in anticipation
 	 * of detecting our hardware ...
 	 */
-	ret = snd_card_create(index[idx], id[idx], THIS_MODULE,
-			      sizeof(struct snd_msnd), &card);
+	ret = snd_card_new(&pcard->card->dev,
+			   index[idx], id[idx], THIS_MODULE,
+			   sizeof(struct snd_msnd), &card);
 	if (ret < 0)
 		return ret;
 
 	chip = card->private_data;
 	chip->card = card;
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	/*
 	 * Read the correct parameters off the ISA PnP bus ...
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index cc01c419b7e9..a219bc37816b 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -627,14 +627,15 @@ static void snd_opl3sa2_free(struct snd_card *card)
 	release_and_free_resource(chip->res_port);
 }
 
-static int snd_opl3sa2_card_new(int dev, struct snd_card **cardp)
+static int snd_opl3sa2_card_new(struct device *pdev, int dev,
+				struct snd_card **cardp)
 {
 	struct snd_card *card;
 	struct snd_opl3sa2 *chip;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_opl3sa2), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_opl3sa2), &card);
 	if (err < 0)
 		return err;
 	strcpy(card->driver, "OPL3SA2");
@@ -737,14 +738,13 @@ static int snd_opl3sa2_pnp_detect(struct pnp_dev *pdev,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	err = snd_opl3sa2_card_new(dev, &card);
+	err = snd_opl3sa2_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
 	if ((err = snd_opl3sa2_pnp(dev, card->private_data, pdev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -802,14 +802,13 @@ static int snd_opl3sa2_pnp_cdetect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	err = snd_opl3sa2_card_new(dev, &card);
+	err = snd_opl3sa2_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
 	if ((err = snd_opl3sa2_pnp(dev, card->private_data, pdev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -883,10 +882,9 @@ static int snd_opl3sa2_isa_probe(struct device *pdev,
 	struct snd_card *card;
 	int err;
 
-	err = snd_opl3sa2_card_new(dev, &card);
+	err = snd_opl3sa2_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, pdev);
 	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 619753d96ca5..c2ca681ac51b 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1411,8 +1411,8 @@ static int snd_miro_isa_probe(struct device *devptr, unsigned int n)
 	struct snd_miro *miro;
 	struct snd_card *card;
 
-	error = snd_card_create(index, id, THIS_MODULE,
-				sizeof(struct snd_miro), &card);
+	error = snd_card_new(devptr, index, id, THIS_MODULE,
+			     sizeof(struct snd_miro), &card);
 	if (error < 0)
 		return error;
 
@@ -1479,8 +1479,6 @@ static int snd_miro_isa_probe(struct device *devptr, unsigned int n)
 		}
 	}
 
-	snd_card_set_dev(card, devptr);
-
 	error = snd_miro_probe(card);
 	if (error < 0) {
 		snd_card_free(card);
@@ -1584,8 +1582,8 @@ static int snd_miro_pnp_probe(struct pnp_card_link *pcard,
 		return -EBUSY;
 	if (!isapnp)
 		return -ENODEV;
-	err = snd_card_create(index, id, THIS_MODULE,
-				sizeof(struct snd_miro), &card);
+	err = snd_card_new(&pcard->card->dev, index, id, THIS_MODULE,
+			   sizeof(struct snd_miro), &card);
 	if (err < 0)
 		return err;
 
@@ -1612,7 +1610,6 @@ static int snd_miro_pnp_probe(struct pnp_card_link *pcard,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pcard->card->dev);
 	err = snd_miro_probe(card);
 	if (err < 0) {
 		snd_card_free(card);
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 6effe99bbb9c..c9b582848603 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -934,13 +934,13 @@ static int snd_opti9xx_probe(struct snd_card *card)
 	return snd_card_register(card);
 }
 
-static int snd_opti9xx_card_new(struct snd_card **cardp)
+static int snd_opti9xx_card_new(struct device *pdev, struct snd_card **cardp)
 {
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE,
-			      sizeof(struct snd_opti9xx), &card);
+	err = snd_card_new(pdev, index, id, THIS_MODULE,
+			   sizeof(struct snd_opti9xx), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_card_opti9xx_free;
@@ -1010,7 +1010,7 @@ static int snd_opti9xx_isa_probe(struct device *devptr,
 	}
 #endif
 
-	error = snd_opti9xx_card_new(&card);
+	error = snd_opti9xx_card_new(devptr, &card);
 	if (error < 0)
 		return error;
 
@@ -1018,7 +1018,6 @@ static int snd_opti9xx_isa_probe(struct device *devptr,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, devptr);
 	if ((error = snd_opti9xx_probe(card)) < 0) {
 		snd_card_free(card);
 		return error;
@@ -1100,7 +1099,7 @@ static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 		return -EBUSY;
 	if (! isapnp)
 		return -ENODEV;
-	error = snd_opti9xx_card_new(&card);
+	error = snd_opti9xx_card_new(&pcard->card->dev, &card);
 	if (error < 0)
 		return error;
 	chip = card->private_data;
@@ -1131,7 +1130,6 @@ static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return error;
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((error = snd_opti9xx_probe(card)) < 0) {
 		snd_card_free(card);
 		return error;
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 356a6308392f..90d2eba549e9 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -229,8 +229,8 @@ static int snd_jazz16_probe(struct device *devptr, unsigned int dev)
 	static int possible_dmas16[] = {5, 7, -1};
 	int err, xirq, xdma8, xdma16, xmpu_port, xmpu_irq;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_card_jazz16), &card);
+	err = snd_card_new(devptr, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_card_jazz16), &card);
 	if (err < 0)
 		return err;
 
@@ -327,8 +327,6 @@ static int snd_jazz16_probe(struct device *devptr, unsigned int dev)
 					mpu_port[dev]);
 	}
 
-	snd_card_set_dev(card, devptr);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto err_free;
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index a4130993955f..3f694543a7ea 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -323,13 +323,14 @@ static void snd_sb16_free(struct snd_card *card)
 #define is_isapnp_selected(dev)		0
 #endif
 
-static int snd_sb16_card_new(int dev, struct snd_card **cardp)
+static int snd_sb16_card_new(struct device *devptr, int dev,
+			     struct snd_card **cardp)
 {
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_card_sb16), &card);
+	err = snd_card_new(devptr, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_card_sb16), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_sb16_free;
@@ -493,7 +494,7 @@ static int snd_sb16_isa_probe1(int dev, struct device *pdev)
 	struct snd_card *card;
 	int err;
 
-	err = snd_sb16_card_new(dev, &card);
+	err = snd_sb16_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
 
@@ -507,7 +508,6 @@ static int snd_sb16_isa_probe1(int dev, struct device *pdev)
 	awe_port[dev] = port[dev] + 0x400;
 #endif
 
-	snd_card_set_dev(card, pdev);
 	if ((err = snd_sb16_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -613,10 +613,9 @@ static int snd_sb16_pnp_detect(struct pnp_card_link *pcard,
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || !isapnp[dev])
 			continue;
-		res = snd_sb16_card_new(dev, &card);
+		res = snd_sb16_card_new(&pcard->card->dev, dev, &card);
 		if (res < 0)
 			return res;
-		snd_card_set_dev(card, &pcard->card->dev);
 		if ((res = snd_card_sb16_pnp(dev, card->private_data, pcard, pid)) < 0 ||
 		    (res = snd_sb16_probe(card, dev)) < 0) {
 			snd_card_free(card);
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index a806ae90a944..6c32b3aa34af 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -102,8 +102,8 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 	struct snd_opl3 *opl3;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_sb8), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_sb8), &card);
 	if (err < 0)
 		return err;
 	acard = card->private_data;
@@ -192,8 +192,6 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 		chip->port,
 		irq[dev], dma8[dev]);
 
-	snd_card_set_dev(card, pdev);
-
 	if ((err = snd_card_register(card)) < 0)
 		goto _err;
 
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 09d481b3ba7f..15a152eaa2e8 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -559,8 +559,8 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	char __iomem *vmss_port;
 
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, sizeof(vport),
-				&card);
+	err = snd_card_new(devptr, index[dev], id[dev], THIS_MODULE,
+			   sizeof(vport), &card);
 	if (err < 0)
 		return err;
 
@@ -668,8 +668,6 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	sprintf(card->longname, "Gallant SC-6000 at 0x%lx, irq %d, dma %d",
 		mss_port[dev], xirq, xdma);
 
-	snd_card_set_dev(card, devptr);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto err_unmap2;
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 57b338973ede..44405df7d4be 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -1169,8 +1169,8 @@ static int snd_sscape_probe(struct device *pdev, unsigned int dev)
 	struct soundscape *sscape;
 	int ret;
 
-	ret = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct soundscape), &card);
+	ret = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct soundscape), &card);
 	if (ret < 0)
 		return ret;
 
@@ -1178,7 +1178,6 @@ static int snd_sscape_probe(struct device *pdev, unsigned int dev)
 	sscape->type = SSCAPE;
 
 	dma[dev] &= 0x03;
-	snd_card_set_dev(card, pdev);
 
 	ret = create_sscape(dev, card);
 	if (ret < 0)
@@ -1259,8 +1258,9 @@ static int sscape_pnp_detect(struct pnp_card_link *pcard,
 	 * Create a new ALSA sound card entry, in anticipation
 	 * of detecting our hardware ...
 	 */
-	ret = snd_card_create(index[idx], id[idx], THIS_MODULE,
-			      sizeof(struct soundscape), &card);
+	ret = snd_card_new(&pcard->card->dev,
+			   index[idx], id[idx], THIS_MODULE,
+			   sizeof(struct soundscape), &card);
 	if (ret < 0)
 		return ret;
 
@@ -1288,7 +1288,6 @@ static int sscape_pnp_detect(struct pnp_card_link *pcard,
 		wss_port[idx] = pnp_port_start(dev, 1);
 		dma2[idx] = pnp_dma(dev, 1);
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	ret = create_sscape(idx, card);
 	if (ret < 0)
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 82dd76939fa0..bfbf38cf9841 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -334,14 +334,15 @@ snd_wavefront_free(struct snd_card *card)
 	}
 }
 
-static int snd_wavefront_card_new(int dev, struct snd_card **cardp)
+static int snd_wavefront_card_new(struct device *pdev, int dev,
+				  struct snd_card **cardp)
 {
 	struct snd_card *card;
 	snd_wavefront_card_t *acard;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(snd_wavefront_card_t), &card);
+	err = snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(snd_wavefront_card_t), &card);
 	if (err < 0)
 		return err;
 
@@ -564,10 +565,9 @@ static int snd_wavefront_isa_probe(struct device *pdev,
 	struct snd_card *card;
 	int err;
 
-	err = snd_wavefront_card_new(dev, &card);
+	err = snd_wavefront_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, pdev);
 	if ((err = snd_wavefront_probe(card, dev)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -612,7 +612,7 @@ static int snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	res = snd_wavefront_card_new(dev, &card);
+	res = snd_wavefront_card_new(&pcard->card->dev, dev, &card);
 	if (res < 0)
 		return res;
 
@@ -623,7 +623,6 @@ static int snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
 			return -ENODEV;
 		}
 	}
-	snd_card_set_dev(card, &pcard->card->dev);
 
 	if ((res = snd_wavefront_probe(card, dev)) < 0)
 		return res;
-- 
1.8.5.2
