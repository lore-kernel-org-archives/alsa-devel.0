From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/20] ALSA: pci: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:10 +0100
Message-ID: <1392202347-11774-4-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CAE6C26507F
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0365ABA6
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ad1889.c                  | 2 +-
 sound/pci/ali5451/ali5451.c         | 2 +-
 sound/pci/als300.c                  | 2 +-
 sound/pci/atiixp.c                  | 2 +-
 sound/pci/atiixp_modem.c            | 2 +-
 sound/pci/au88x0/au88x0.c           | 2 +-
 sound/pci/aw2/aw2-alsa.c            | 2 +-
 sound/pci/azt3328.c                 | 2 +-
 sound/pci/bt87x.c                   | 2 +-
 sound/pci/ca0106/ca0106_main.c      | 2 +-
 sound/pci/cmipci.c                  | 2 +-
 sound/pci/cs4281.c                  | 2 +-
 sound/pci/cs46xx/cs46xx_lib.c       | 2 +-
 sound/pci/cs5530.c                  | 2 +-
 sound/pci/cs5535audio/cs5535audio.c | 2 +-
 sound/pci/ctxfi/ctatc.c             | 2 +-
 sound/pci/echoaudio/echoaudio.c     | 2 +-
 sound/pci/emu10k1/emu10k1_main.c    | 2 +-
 sound/pci/emu10k1/emu10k1x.c        | 2 +-
 sound/pci/ens1370.c                 | 2 +-
 sound/pci/es1938.c                  | 2 +-
 sound/pci/es1968.c                  | 2 +-
 sound/pci/fm801.c                   | 2 +-
 sound/pci/hda/hda_intel.c           | 2 +-
 sound/pci/ice1712/ice1712.c         | 2 +-
 sound/pci/ice1712/ice1724.c         | 2 +-
 sound/pci/intel8x0.c                | 2 +-
 sound/pci/intel8x0m.c               | 2 +-
 sound/pci/korg1212/korg1212.c       | 2 +-
 sound/pci/lola/lola.c               | 2 +-
 sound/pci/lx6464es/lx6464es.c       | 2 +-
 sound/pci/maestro3.c                | 2 +-
 sound/pci/mixart/mixart.c           | 2 +-
 sound/pci/nm256/nm256.c             | 2 +-
 sound/pci/pcxhr/pcxhr.c             | 2 +-
 sound/pci/riptide/riptide.c         | 2 +-
 sound/pci/sis7019.c                 | 2 +-
 sound/pci/sonicvibes.c              | 2 +-
 sound/pci/trident/trident_main.c    | 2 +-
 sound/pci/via82xx.c                 | 2 +-
 sound/pci/via82xx_modem.c           | 2 +-
 sound/pci/vx222/vx222.c             | 2 +-
 sound/pci/ymfpci/ymfpci_main.c      | 2 +-
 43 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index ba4da1ed0444..6b134caf12ca 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -960,7 +960,7 @@ snd_ad1889_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_ad1889_free(chip);
 		return err;
 	}
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 115b1120319a..5802f9778ff7 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2212,7 +2212,7 @@ static int snd_ali_create(struct snd_card *card,
 	}
 
 	snd_ali_printk("snd_device_new is called.\n");
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, codec, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, codec, &ops);
 	if (err < 0) {
 		snd_ali_free(codec);
 		return err;
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 9acd88ab93a4..ad45cd7d3f56 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -755,7 +755,7 @@ static int snd_als300_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 						chip, &ops)) < 0) {
 		snd_als300_free(chip);
 		return err;
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 85f893b5cc99..04f0c19d57fa 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1652,7 +1652,7 @@ static int snd_atiixp_create(struct snd_card *card,
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_atiixp_free(chip);
 		return err;
 	}
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 2b3244a85cf8..3c87b8f5df51 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1277,7 +1277,7 @@ static int snd_atiixp_create(struct snd_card *card,
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_atiixp_free(chip);
 		return err;
 	}
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index afb1b44b741e..5ad6f95bb06e 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -207,7 +207,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	// End of PCI setup.
 
 	// Register alsa root device.
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		goto alloc_out;
 	}
 
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index e9dabee42805..3c5ca5485b3f 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -312,7 +312,7 @@ static int snd_aw2_create(struct snd_card *card,
 	}
 	chip->irq = pci->irq;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		free_irq(chip->irq, (void *)chip);
 		iounmap(chip->iobase_virt);
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 641c235ab4d8..dd9799f1413d 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2570,7 +2570,7 @@ snd_azf3328_create(struct snd_card *card,
 
 	snd_azf3328_debug_show_ports(chip);
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0)
 		goto out_err;
 
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 06dc7d97cc0c..d4875505adae 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -769,7 +769,7 @@ static int snd_bt87x_create(struct snd_card *card,
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0)
 		goto fail;
 
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index f659c7a89c0c..87a6765eb0b1 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1736,7 +1736,7 @@ static int snd_ca0106_create(int dev, struct snd_card *card,
 
 	ca0106_init_chip(chip, 0);
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_ca0106_free(chip);
 		return err;
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 66c0558ce449..43db4a98b9db 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3164,7 +3164,7 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 	sprintf(card->longname, "%s%s at %#lx, irq %i",
 		card->shortname, modelstr, cm->iobase, cm->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, cm, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, cm, &ops)) < 0) {
 		snd_cmipci_free(cm);
 		return err;
 	}
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 2bd55177b1ae..54e927b9fbee 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1395,7 +1395,7 @@ static int snd_cs4281_create(struct snd_card *card,
 		return tmp;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_cs4281_free(chip);
 		return err;
 	}
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 28766478f81c..829bbc3ac8ec 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -4040,7 +4040,7 @@ int snd_cs46xx_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_cs46xx_free(chip);
 		return err;
 	}
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 8037e8600a72..f008b097bb53 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -238,7 +238,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		return err;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_cs5530_free(chip);
 		return err;
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 051b3e28e341..5e790fa02e1a 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -320,7 +320,7 @@ static int snd_cs5535audio_create(struct snd_card *card,
 	cs5535au->irq = pci->irq;
 	pci_set_master(pci);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 				  cs5535au, &ops)) < 0)
 		goto sndfail;
 
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index af632bd08323..2c83ce856d11 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1735,7 +1735,7 @@ int ct_atc_create(struct snd_card *card, struct pci_dev *pci,
 		goto error1;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, atc, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, atc, &ops);
 	if (err < 0)
 		goto error1;
 
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 1ef77c0d39ec..1f665ff104f2 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2028,7 +2028,7 @@ static int snd_echo_create(struct snd_card *card,
 	}
 	DE_INIT(("Card init OK\n"));
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_echo_free(chip);
 		return err;
 	}
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 75504da63613..df02ec2ab72e 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -2013,7 +2013,7 @@ int snd_emu10k1_create(struct snd_card *card,
 		goto error;
 	snd_emu10k1_audio_enable(emu);
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, emu, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, emu, &ops);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 3988eaa778cf..f35862a45b2a 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1013,7 +1013,7 @@ static int snd_emu10k1x_create(struct snd_card *card,
 
 	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 				  chip, &ops)) < 0) {
 		snd_emu10k1x_free(chip);
 		return err;
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 0f89d2a2090e..607478451ed4 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2173,7 +2173,7 @@ static int snd_ensoniq_create(struct snd_card *card,
 
 	snd_ensoniq_chip_init(ensoniq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, ensoniq, &ops)) < 0) {
 		snd_ensoniq_free(ensoniq);
 		return err;
 	}
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 33489bcc0aff..b6133a974f23 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1653,7 +1653,7 @@ static int snd_es1938_create(struct snd_card *card,
 
 	snd_es1938_chip_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_es1938_free(chip);
 		return err;
 	}
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 87e9cd5d3ceb..d19a5a3eb2e0 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2778,7 +2778,7 @@ static int snd_es1968_create(struct snd_card *card,
 
 	snd_es1968_chip_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_es1968_free(chip);
 		return err;
 	}
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 8b6af212cbfe..9c69579895c2 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1246,7 +1246,7 @@ static int snd_fm801_create(struct snd_card *card,
 		chip->irq = -1;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_fm801_free(chip);
 		return err;
 	}
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0870f5f3ed1c..1d4069e08947 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3584,7 +3584,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		}
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_printk(KERN_ERR SFX "%s: Error creating device [card]!\n",
 		   pci_name(chip->pci));
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 99c022a0d612..659079754861 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2633,7 +2633,7 @@ static int snd_ice1712_create(struct snd_card *card,
 	     ICEREG(ice, IRQMASK));
 	outb(0x00, ICEMT(ice, IRQ));
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, ice, &ops);
 	if (err < 0) {
 		snd_ice1712_free(ice);
 		return err;
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index cf1ba116a772..1afedc6646d8 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2603,7 +2603,7 @@ static int snd_vt1724_create(struct snd_card *card,
 		return -EIO;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, ice, &ops);
 	if (err < 0) {
 		snd_vt1724_free(ice);
 		return err;
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index ff24acf06bdd..04f7c7771da7 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3212,7 +3212,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 	}
 	chip->irq = pci->irq;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_intel8x0_free(chip);
 		return err;
 	}
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index f8c72bd8a3cd..b030211da513 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1238,7 +1238,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
 	}
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 8f36d77f01e5..164b6109178e 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2372,7 +2372,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (rc)
 		K1212_DEBUG_PRINTK("K1212_DEBUG: Reboot Card - RC = %d [%s]\n", rc, stateName[korg1212->cardState]);
 
-        if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, korg1212, &ops)) < 0) {
+        if ((err = snd_device_new(card, SNDRV_DEV_CARD, korg1212, &ops)) < 0) {
                 snd_korg1212_free(korg1212);
                 return err;
         }
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 56d4f94daea2..5bc7ec244e32 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -678,7 +678,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 	if (err < 0)
 		goto errout;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_printk(KERN_ERR SFX "Error creating device [card]!\n");
 		goto errout;
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index b9743d4fa1cc..ad750bcfb061 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1039,7 +1039,7 @@ static int snd_lx6464es_create(struct snd_card *card,
 	}
 	chip->irq = pci->irq;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0)
 		goto device_new_failed;
 
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 076c3ec000c0..6af776c91b50 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2664,7 +2664,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 		snd_printk(KERN_WARNING "can't allocate apm buffer\n");
 #endif
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_m3_free(chip);
 		return err;
 	}
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 9ab057bb9859..79f3b736664c 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1022,7 +1022,7 @@ static int snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int
 	chip->chip_idx = idx;
 	chip->mgr = mgr;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_mixart_chip_free(chip);
 		return err;
 	}
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index b7afd9c8dcd7..4bcf2e27250d 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1623,7 +1623,7 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 
 	// pci_set_master(pci); /* needed? */
 	
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0)
 		goto __error;
 
 	*chip_ret = chip;
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 3880f6da9a87..042c35002459 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1233,7 +1233,7 @@ static int pcxhr_create(struct pcxhr_mgr *mgr,
 			chip->nb_streams_capt = 1;	/* or 1 stereo stream */
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		pcxhr_chip_free(chip);
 		return err;
 	}
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b4a8278241b1..93c37643556e 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1911,7 +1911,7 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_riptide_free(chip);
 		return err;
 	}
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 6b26b93e001d..0ea1fa86e204 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1400,7 +1400,7 @@ static int sis_chip_create(struct snd_card *card,
 	voice->num = SIS_CAPTURE_CHAN_AC97_PCM_IN;
 	voice->ctrl_base = SIS_CAPTURE_DMA_ADDR(sis->ioaddr, voice->num);
 
-	rc = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sis, &ops);
+	rc = snd_device_new(card, SNDRV_DEV_CARD, sis, &ops);
 	if (rc)
 		goto error_out_cleanup;
 
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 9ff408fff7b0..5930bca1dca2 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1385,7 +1385,7 @@ static int snd_sonicvibes_create(struct snd_card *card,
 #endif
 	sonic->revision = snd_sonicvibes_in(sonic, SV_IREG_REVISION);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sonic, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, sonic, &ops)) < 0) {
 		snd_sonicvibes_free(sonic);
 		return err;
 	}
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 4f3c4be30a48..3ffe84593ddc 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3638,7 +3638,7 @@ int snd_trident_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, trident, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, trident, &ops)) < 0) {
 		snd_trident_free(trident);
 		return err;
 	}
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 20d2eeeecf47..c01f8b91254e 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2431,7 +2431,7 @@ static int snd_via82xx_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_via82xx_free(chip);
 		return err;
 	}
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 519740154824..9b43453e358f 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1151,7 +1151,7 @@ static int snd_via82xx_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_via82xx_free(chip);
 		return err;
 	}
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 4323556c13f8..f070f0e4d282 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -176,7 +176,7 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	}
 	chip->irq = pci->irq;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_vx222_free(chip);
 		return err;
 	}
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index c7e98ff4f80f..eef437d85df7 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2480,7 +2480,7 @@ int snd_ymfpci_create(struct snd_card *card,
 	}
 #endif
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_ymfpci_free(chip);
 		return err;
 	}
-- 
1.8.5.2
