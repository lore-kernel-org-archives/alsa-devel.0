From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/24] ALSA: pci: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:21 +0100
Message-ID: <1392201340-27113-6-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DF21F265005
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 815D5AC7B
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
 sound/pci/ad1889.c                  |  5 ++---
 sound/pci/ali5451/ali5451.c         |  4 +---
 sound/pci/als300.c                  |  5 ++---
 sound/pci/als4000.c                 |  7 +++----
 sound/pci/asihpi/asihpi.c           | 16 +++++-----------
 sound/pci/atiixp.c                  |  4 +---
 sound/pci/atiixp_modem.c            |  4 +---
 sound/pci/au88x0/au88x0.c           |  5 ++---
 sound/pci/aw2/aw2-alsa.c            |  4 ++--
 sound/pci/azt3328.c                 |  5 ++---
 sound/pci/bt87x.c                   |  4 ++--
 sound/pci/ca0106/ca0106_main.c      |  5 ++---
 sound/pci/cmipci.c                  |  5 ++---
 sound/pci/cs4281.c                  |  5 ++---
 sound/pci/cs46xx/cs46xx.c           |  3 ++-
 sound/pci/cs46xx/cs46xx_lib.c       |  2 --
 sound/pci/cs5530.c                  |  4 ++--
 sound/pci/cs5535audio/cs5535audio.c |  5 ++---
 sound/pci/ctxfi/ctatc.c             |  2 --
 sound/pci/ctxfi/xfi.c               |  3 ++-
 sound/pci/echoaudio/echoaudio.c     |  5 ++---
 sound/pci/emu10k1/emu10k1.c         |  3 ++-
 sound/pci/emu10k1/emu10k1_main.c    |  1 -
 sound/pci/emu10k1/emu10k1x.c        |  5 ++---
 sound/pci/ens1370.c                 |  5 ++---
 sound/pci/es1938.c                  |  5 ++---
 sound/pci/es1968.c                  |  5 ++---
 sound/pci/fm801.c                   |  5 ++---
 sound/pci/hda/hda_intel.c           |  5 ++---
 sound/pci/ice1712/ice1712.c         |  5 ++---
 sound/pci/ice1712/ice1724.c         |  5 ++---
 sound/pci/intel8x0.c                |  4 +---
 sound/pci/intel8x0m.c               |  4 +---
 sound/pci/korg1212/korg1212.c       |  5 ++---
 sound/pci/lola/lola.c               |  5 ++---
 sound/pci/lx6464es/lx6464es.c       |  5 ++---
 sound/pci/maestro3.c                |  5 ++---
 sound/pci/mixart/mixart.c           |  5 ++---
 sound/pci/nm256/nm256.c             |  4 +---
 sound/pci/oxygen/oxygen_lib.c       |  4 ++--
 sound/pci/pcxhr/pcxhr.c             |  4 ++--
 sound/pci/riptide/riptide.c         |  5 ++---
 sound/pci/rme32.c                   |  5 ++---
 sound/pci/rme96.c                   |  5 ++---
 sound/pci/rme9652/hdsp.c            |  5 ++---
 sound/pci/rme9652/hdspm.c           |  6 ++----
 sound/pci/rme9652/rme9652.c         |  5 ++---
 sound/pci/sis7019.c                 |  5 ++---
 sound/pci/sonicvibes.c              |  5 ++---
 sound/pci/trident/trident.c         |  3 ++-
 sound/pci/trident/trident_main.c    |  1 -
 sound/pci/via82xx.c                 |  4 +---
 sound/pci/via82xx_modem.c           |  4 +---
 sound/pci/vx222/vx222.c             |  5 ++---
 sound/pci/ymfpci/ymfpci.c           |  3 ++-
 sound/pci/ymfpci/ymfpci_main.c      |  2 --
 56 files changed, 98 insertions(+), 156 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index b680d03e2419..ba4da1ed0444 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -965,8 +965,6 @@ snd_ad1889_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 
 	return 0;
@@ -996,7 +994,8 @@ snd_ad1889_probe(struct pci_dev *pci,
 	}
 
 	/* (2) */
-	err = snd_card_create(index[devno], id[devno], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[devno], id[devno], THIS_MODULE,
+			   0, &card);
 	/* XXX REVISIT: we can probably allocate chip in this call */
 	if (err < 0)
 		return err;
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index c6835a3d64fb..115b1120319a 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2218,8 +2218,6 @@ static int snd_ali_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	/* initialise synth voices*/
 	for (i = 0; i < ALI_CHANNELS; i++)
 		codec->synth.voices[i].number = i;
@@ -2253,7 +2251,7 @@ static int snd_ali_probe(struct pci_dev *pci,
 
 	snd_ali_printk("probe ...\n");
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 591efb6eef05..9acd88ab93a4 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -761,8 +761,6 @@ static int snd_als300_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	snd_als300_dbgcallleave();
 	return 0;
@@ -829,7 +827,8 @@ static int snd_als300_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 
 	if (err < 0)
 		return err;
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index ffc821b0139e..2b2bb0fa3bc7 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -888,9 +888,9 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	pci_write_config_word(pci, PCI_COMMAND, word | PCI_COMMAND_IO);
 	pci_set_master(pci);
 	
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 
-			      sizeof(*acard) /* private_data: acard */,
-			      &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(*acard) /* private_data: acard */,
+			   &card);
 	if (err < 0) {
 		pci_release_regions(pci);
 		pci_disable_device(pci);
@@ -920,7 +920,6 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 
 	chip->pci = pci;
 	chip->alt_port = iobase;
-	snd_card_set_dev(card, &pci->dev);
 
 	snd_als4000_configure(chip);
 
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 5f2acd35dcb9..e4e42f28177d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2827,17 +2827,13 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	hpi = pci_get_drvdata(pci_dev);
 	adapter_index = hpi->adapter->index;
 	/* first try to give the card the same index as its hardware index */
-	err = snd_card_create(adapter_index,
-			      id[adapter_index], THIS_MODULE,
-			      sizeof(struct snd_card_asihpi),
-			      &card);
+	err = snd_card_new(&pci_dev->dev, adapter_index, id[adapter_index],
+			   THIS_MODULE, sizeof(struct snd_card_asihpi), &card);
 	if (err < 0) {
 		/* if that fails, try the default index==next available */
-		err =
-		    snd_card_create(index[dev], id[dev],
-				    THIS_MODULE,
-				    sizeof(struct snd_card_asihpi),
-				    &card);
+		err = snd_card_new(&pci_dev->dev, index[dev], id[dev],
+				   THIS_MODULE, sizeof(struct snd_card_asihpi),
+				   &card);
 		if (err < 0)
 			return err;
 		snd_printk(KERN_WARNING
@@ -2845,8 +2841,6 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 			adapter_index, card->number);
 	}
 
-	snd_card_set_dev(card, &pci_dev->dev);
-
 	asihpi = card->private_data;
 	asihpi->card = card;
 	asihpi->pci = pci_dev;
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index f6dec3ea371f..85f893b5cc99 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1657,8 +1657,6 @@ static int snd_atiixp_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_chip = chip;
 	return 0;
 }
@@ -1671,7 +1669,7 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	struct atiixp *chip;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 289563ecb6dd..2b3244a85cf8 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1282,8 +1282,6 @@ static int snd_atiixp_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_chip = chip;
 	return 0;
 }
@@ -1296,7 +1294,7 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	struct atiixp_modem *chip;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 7059dd69e5e6..afb1b44b741e 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -211,8 +211,6 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 		goto alloc_out;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 
 	return 0;
@@ -250,7 +248,8 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return -ENOENT;
 	}
 	// (2)
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 2925220d3fcf..e9dabee42805 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -322,7 +322,6 @@ static int snd_aw2_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
 	*rchip = chip;
 
 	printk(KERN_INFO
@@ -349,7 +348,8 @@ static int snd_aw2_probe(struct pci_dev *pci,
 	}
 
 	/* (2) Create card instance */
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 1aef7128f7ca..641c235ab4d8 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2599,8 +2599,6 @@ snd_azf3328_create(struct snd_card *card,
 		spin_unlock_irq(codec->lock);
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 
 	err = 0;
@@ -2635,7 +2633,8 @@ snd_azf3328_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		goto out;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		goto out;
 
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 18802039497a..06dc7d97cc0c 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -773,7 +773,6 @@ static int snd_bt87x_create(struct snd_card *card,
 	if (err < 0)
 		goto fail;
 
-	snd_card_set_dev(card, &pci->dev);
 	*rchip = chip;
 	return 0;
 
@@ -888,7 +887,8 @@ static int snd_bt87x_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index f4db5587e86e..f659c7a89c0c 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1843,7 +1843,8 @@ static int snd_ca0106_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
@@ -1878,8 +1879,6 @@ static int snd_ca0106_probe(struct pci_dev *pci,
 	snd_ca0106_proc_init(chip);
 #endif
 
-	snd_card_set_dev(card, &pci->dev);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 2755ec5bcc25..66c0558ce449 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3254,8 +3254,6 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 	if (snd_cmipci_create_gameport(cm, dev) < 0)
 		snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rcmipci = cm;
 	return 0;
 }
@@ -3280,7 +3278,8 @@ static int snd_cmipci_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 1dc793e742d7..2bd55177b1ae 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1402,8 +1402,6 @@ static int snd_cs4281_create(struct snd_card *card,
 
 	snd_cs4281_proc_init(chip);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 }
@@ -1917,7 +1915,8 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index b03498325d66..af0eacbc8bd2 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -88,7 +88,8 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	if ((err = snd_cs46xx_create(card, pci,
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 062398ec5335..28766478f81c 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -4058,8 +4058,6 @@ int snd_cs46xx_create(struct snd_card *card,
 
 	chip->active_ctrl(chip, -1); /* disable CLKRUN */
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 }
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index c6b82c85e044..8037e8600a72 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -244,7 +244,6 @@ static int snd_cs5530_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
 	*rchip = chip;
 	return 0;
 }
@@ -264,7 +263,8 @@ static int snd_cs5530_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 
 	if (err < 0)
 		return err;
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index c0d2835344da..051b3e28e341 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -324,8 +324,6 @@ static int snd_cs5535audio_create(struct snd_card *card,
 				  cs5535au, &ops)) < 0)
 		goto sndfail;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rcs5535au = cs5535au;
 	return 0;
 
@@ -353,7 +351,8 @@ static int snd_cs5535audio_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index eb86829529eb..af632bd08323 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1739,8 +1739,6 @@ int ct_atc_create(struct snd_card *card, struct pci_dev *pci,
 	if (err < 0)
 		goto error1;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*ratc = atc;
 	return 0;
 
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index d464ad2fc7b7..98426d09c8bd 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -71,7 +71,8 @@ ct_card_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		dev++;
 		return -ENOENT;
 	}
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err)
 		return err;
 	if ((reference_rate != 48000) && (reference_rate != 44100)) {
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 05cfe551ce42..1ef77c0d39ec 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2058,12 +2058,11 @@ static int snd_echo_probe(struct pci_dev *pci,
 
 	DE_INIT(("Echoaudio driver starting...\n"));
 	i = 0;
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	chip = NULL;	/* Tells snd_echo_create to allocate chip */
 	if ((err = snd_echo_create(card, pci, &chip)) < 0) {
 		snd_card_free(card);
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 9e1bd0c39a8c..5c0413b40dc3 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -117,7 +117,8 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	if (max_buffer_size[dev] < 32)
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index bdd888ec9a84..75504da63613 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -2021,7 +2021,6 @@ int snd_emu10k1_create(struct snd_card *card,
 	snd_emu10k1_proc_init(emu);
 #endif
 
-	snd_card_set_dev(card, &pci->dev);
 	*remu = emu;
 	return 0;
 
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 56ad9d6f200d..3988eaa778cf 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1564,7 +1564,8 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
@@ -1608,8 +1609,6 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx irq %i",
 		card->shortname, chip->port, chip->irq);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 61262f396004..0f89d2a2090e 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2180,8 +2180,6 @@ static int snd_ensoniq_create(struct snd_card *card,
 
 	snd_ensoniq_proc_init(ensoniq);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rensoniq = ensoniq;
 	return 0;
 }
@@ -2437,7 +2435,8 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 9213fb38921c..33489bcc0aff 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1658,8 +1658,6 @@ static int snd_es1938_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 }
@@ -1808,7 +1806,8 @@ static int snd_es1938_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	for (idx = 0; idx < 5; idx++) {
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 772cc36f951d..87e9cd5d3ceb 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2783,8 +2783,6 @@ static int snd_es1968_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 #ifdef CONFIG_SND_ES1968_RADIO
 	/* don't play with GPIOs on laptops */
 	if (chip->pci->subsystem_vendor != 0x125d)
@@ -2836,7 +2834,8 @@ static int snd_es1968_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
                 
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 45bc8a95b7c4..8b6af212cbfe 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1251,8 +1251,6 @@ static int snd_fm801_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 #ifdef CONFIG_SND_FM801_TEA575X_BOOL
 	err = v4l2_device_register(&pci->dev, &chip->v4l2_dev);
 	if (err < 0) {
@@ -1312,7 +1310,8 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	if ((err = snd_fm801_create(card, pci, tea575x_tuner[dev], radio_nr[dev], &chip)) < 0) {
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d8d9bf3c3787..0870f5f3ed1c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3823,14 +3823,13 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "hda-intel: Error creating card!\n");
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
 	if (err < 0)
 		goto out_free;
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 28ec872e54c0..99c022a0d612 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2639,8 +2639,6 @@ static int snd_ice1712_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_ice1712 = ice;
 	return 0;
 }
@@ -2670,7 +2668,8 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 500471778291..cf1ba116a772 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2609,8 +2609,6 @@ static int snd_vt1724_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_ice1712 = ice;
 	return 0;
 }
@@ -2638,7 +2636,8 @@ static int snd_vt1724_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 08d8733604a2..ff24acf06bdd 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3217,8 +3217,6 @@ static int snd_intel8x0_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_intel8x0 = chip;
 	return 0;
 }
@@ -3285,7 +3283,7 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 	int err;
 	struct shortname_table *name;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 3573c1193665..f8c72bd8a3cd 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1243,8 +1243,6 @@ static int snd_intel8x0m_create(struct snd_card *card,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_intel8x0m = chip;
 	return 0;
 }
@@ -1283,7 +1281,7 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	int err;
 	struct shortname_table *name;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 9cf9829555d4..8f36d77f01e5 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2418,8 +2418,6 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
         snd_korg1212_proc_init(korg1212);
         
-	snd_card_set_dev(card, &pci->dev);
-
         * rchip = korg1212;
 	return 0;
 
@@ -2445,7 +2443,8 @@ snd_korg1212_probe(struct pci_dev *pci,
 		dev++;
 		return -ENOENT;
 	}
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 0568540dc8d3..56d4f94daea2 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -717,14 +717,13 @@ static int lola_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR SFX "Error creating card!\n");
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	err = lola_create(card, pci, dev, &chip);
 	if (err < 0)
 		goto out_free;
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 5fcaaa6da4a8..b9743d4fa1cc 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1062,8 +1062,6 @@ static int snd_lx6464es_create(struct snd_card *card,
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 
@@ -1099,7 +1097,8 @@ static int snd_lx6464es_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index d5417360f51f..076c3ec000c0 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2693,8 +2693,6 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	snd_m3_enable_ints(chip);
 	snd_m3_assp_continue(chip);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*chip_ret = chip;
 
 	return 0; 
@@ -2721,7 +2719,8 @@ snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 1e0f6ee193f0..9ab057bb9859 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1028,8 +1028,6 @@ static int snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int
 	}
 
 	mgr->chip[idx] = chip;
-	snd_card_set_dev(card, &mgr->pci->dev);
-
 	return 0;
 }
 
@@ -1308,7 +1306,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		else
 			idx = index[dev] + i;
 		snprintf(tmpid, sizeof(tmpid), "%s-%d", id[dev] ? id[dev] : "MIXART", i);
-		err = snd_card_create(idx, tmpid, THIS_MODULE, 0, &card);
+		err = snd_card_new(&pci->dev, idx, tmpid, THIS_MODULE,
+				   0, &card);
 
 		if (err < 0) {
 			snd_printk(KERN_ERR "cannot allocate the card %d\n", i);
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index fe79fff4c6dc..b7afd9c8dcd7 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1626,8 +1626,6 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*chip_ret = chip;
 	return 0;
 
@@ -1676,7 +1674,7 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		}
 	}
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index b0cb48adddc7..efa610cd735c 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -595,7 +595,8 @@ int oxygen_pci_probe(struct pci_dev *pci, int index, char *id,
 	const struct pci_device_id *pci_id;
 	int err;
 
-	err = snd_card_create(index, id, owner, sizeof(*chip), &card);
+	err = snd_card_new(&pci->dev, index, id, owner,
+			   sizeof(*chip), &card);
 	if (err < 0)
 		return err;
 
@@ -648,7 +649,6 @@ int oxygen_pci_probe(struct pci_dev *pci, int index, char *id,
 	}
 
 	pci_set_master(pci);
-	snd_card_set_dev(card, &pci->dev);
 	card->private_free = oxygen_card_free;
 
 	configure_pcie_bridge(pci);
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index d379b284955b..3880f6da9a87 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1239,7 +1239,6 @@ static int pcxhr_create(struct pcxhr_mgr *mgr,
 	}
 
 	mgr->chip[idx] = chip;
-	snd_card_set_dev(card, &mgr->pci->dev);
 
 	return 0;
 }
@@ -1638,7 +1637,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 
 		snprintf(tmpid, sizeof(tmpid), "%s-%d",
 			 id[dev] ? id[dev] : card_name, i);
-		err = snd_card_create(idx, tmpid, THIS_MODULE, 0, &card);
+		err = snd_card_new(&pci->dev, idx, tmpid, THIS_MODULE,
+				   0, &card);
 
 		if (err < 0) {
 			snd_printk(KERN_ERR "cannot allocate the card %d\n", i);
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 56cc891e395e..b4a8278241b1 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1916,8 +1916,6 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 }
@@ -2086,7 +2084,8 @@ snd_card_riptide_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	err = snd_riptide_create(card, pci, &chip);
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index cc26346ae66b..77465cc03e95 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1938,15 +1938,14 @@ snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct rme32), &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct rme32), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_rme32_card_free;
 	rme32 = (struct rme32 *) card->private_data;
 	rme32->card = card;
 	rme32->pci = pci;
-	snd_card_set_dev(card, &pci->dev);
         if (fullduplex[dev])
 		rme32->fullduplex_mode = 1;
 	if ((err = snd_rme32_create(rme32)) < 0) {
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 0236363c301f..00d46116e04a 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2475,15 +2475,14 @@ snd_rme96_probe(struct pci_dev *pci,
 		dev++;
 		return -ENOENT;
 	}
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct rme96), &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct rme96), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_rme96_card_free;
 	rme96 = card->private_data;
 	rme96->card = card;
 	rme96->pci = pci;
-	snd_card_set_dev(card, &pci->dev);
 	if ((err = snd_rme96_create(rme96)) < 0) {
 		snd_card_free(card);
 		return err;
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index bd90c80bb494..825fbbea7f6f 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5375,8 +5375,8 @@ static int snd_hdsp_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct hdsp), &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct hdsp), &card);
 	if (err < 0)
 		return err;
 
@@ -5384,7 +5384,6 @@ static int snd_hdsp_probe(struct pci_dev *pci,
 	card->private_free = snd_hdsp_card_free;
 	hdsp->dev = dev;
 	hdsp->pci = pci;
-	snd_card_set_dev(card, &pci->dev);
 
 	if ((err = snd_hdsp_create(card, hdsp)) < 0) {
 		snd_card_free(card);
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e98dc008de0b..76016287e46f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -7016,8 +7016,8 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev],
-			THIS_MODULE, sizeof(struct hdspm), &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev],
+			   THIS_MODULE, sizeof(struct hdspm), &card);
 	if (err < 0)
 		return err;
 
@@ -7026,8 +7026,6 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	hdspm->dev = dev;
 	hdspm->pci = pci;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	err = snd_hdspm_create(card, hdspm);
 	if (err < 0) {
 		snd_card_free(card);
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 1503ee3585fd..a62d6e13d8ce 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2587,8 +2587,8 @@ static int snd_rme9652_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_rme9652), &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_rme9652), &card);
 
 	if (err < 0)
 		return err;
@@ -2597,7 +2597,6 @@ static int snd_rme9652_probe(struct pci_dev *pci,
 	card->private_free = snd_rme9652_card_free;
 	rme9652->dev = dev;
 	rme9652->pci = pci;
-	snd_card_set_dev(card, &pci->dev);
 
 	if ((err = snd_rme9652_create(card, rme9652, precise_ptr[dev])) < 0) {
 		snd_card_free(card);
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index e413b4e2c819..6b26b93e001d 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1404,8 +1404,6 @@ static int sis_chip_create(struct snd_card *card,
 	if (rc)
 		goto error_out_cleanup;
 
-	snd_card_set_dev(card, &pci->dev);
-
 	return 0;
 
 error_out_cleanup:
@@ -1440,7 +1438,8 @@ static int snd_sis7019_probe(struct pci_dev *pci,
 	if (!codecs)
 		codecs = SIS_PRIMARY_CODEC_PRESENT;
 
-	rc = snd_card_create(index, id, THIS_MODULE, sizeof(*sis), &card);
+	rc = snd_card_new(&pci->dev, index, id, THIS_MODULE,
+			  sizeof(*sis), &card);
 	if (rc < 0)
 		goto error_out;
 
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 2a46bf98af30..9ff408fff7b0 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1392,8 +1392,6 @@ static int snd_sonicvibes_create(struct snd_card *card,
 
 	snd_sonicvibes_proc_init(sonic);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rsonic = sonic;
 	return 0;
 }
@@ -1459,7 +1457,8 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
  
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	for (idx = 0; idx < 5; idx++) {
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index b3b588bc94c3..d852458caf38 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -89,7 +89,8 @@ static int snd_trident_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index fb0e1586a6f8..4f3c4be30a48 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3664,7 +3664,6 @@ int snd_trident_create(struct snd_card *card,
 	snd_trident_enable_eso(trident);
 
 	snd_trident_proc_init(trident);
-	snd_card_set_dev(card, &pci->dev);
 	*rtrident = trident;
 	return 0;
 }
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 5ae6f042c586..20d2eeeecf47 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2441,8 +2441,6 @@ static int snd_via82xx_create(struct snd_card *card,
 	 * We call pci_set_master here because it does not hurt. */
 	pci_set_master(pci);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_via = chip;
 	return 0;
 }
@@ -2544,7 +2542,7 @@ static int snd_via82xx_probe(struct pci_dev *pci,
 	unsigned int i;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index ca190283cbd7..519740154824 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1161,8 +1161,6 @@ static int snd_via82xx_create(struct snd_card *card,
 	 * We call pci_set_master here because it does not hurt. */
 	pci_set_master(pci);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*r_via = chip;
 	return 0;
 }
@@ -1177,7 +1175,7 @@ static int snd_via82xx_probe(struct pci_dev *pci,
 	unsigned int i;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index ab8a9b1bfb8e..4323556c13f8 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -181,8 +181,6 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = vx;
 	return 0;
 }
@@ -204,7 +202,8 @@ static int snd_vx222_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index e8932b2e4a5d..6ff4ea389b02 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -187,7 +187,8 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index d591c154fc58..c7e98ff4f80f 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2487,8 +2487,6 @@ int snd_ymfpci_create(struct snd_card *card,
 
 	snd_ymfpci_proc_init(card, chip);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	return 0;
 }
-- 
1.8.5.2
