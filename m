From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: au88x0: Use common error handling
 code in two functions
Date: Sun, 12 Nov 2017 22:40:04 +0100
Message-ID: <1ff028cc-eac8-f5c8-9149-5df6e44cfba8@users.sourceforge.net>
References: <e42f1434-f1d7-a43b-d887-a82b50158280@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BFCB267257
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 22:40:08 +0100 (CET)
In-Reply-To: <e42f1434-f1d7-a43b-d887-a82b50158280@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 22:22:15 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/au88x0/au88x0.c      | 72 ++++++++++++++++++------------------------
 sound/pci/au88x0/au88x0_core.c | 34 ++++++++------------
 2 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index fc5c47ace64f..aa0dbd4e152e 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -257,10 +257,9 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 
 	// (3)
 	err = snd_vortex_create(card, pci, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	snd_vortex_workaround(pci, pcifix[dev]);
 
 	// Card details needed in snd_vortex_midi
@@ -271,29 +270,23 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 
 	// (4) Alloc components.
 	err = snd_vortex_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	// ADB pcm.
 	err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_PCM);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #ifndef CHIP_AU8820
 	// ADB SPDIF
 	err = snd_vortex_new_pcm(chip, VORTEX_PCM_SPDIF, 1);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	// A3D
 	err = snd_vortex_new_pcm(chip, VORTEX_PCM_A3D, NR_A3D);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #endif
 	/*
 	   // ADB I2S
@@ -305,16 +298,12 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 #ifndef CHIP_AU8810
 	// WT pcm.
 	err = snd_vortex_new_pcm(chip, VORTEX_PCM_WT, NR_WT);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #endif
 	err = snd_vortex_midi(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	vortex_gameport_register(chip);
 
@@ -337,16 +326,13 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 
 	// (5)
 	err = pci_read_config_word(pci, PCI_DEVICE_ID, &(chip->device));
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}	
+	if (err < 0)
+		goto free_card;
 
 	err = pci_read_config_word(pci, PCI_VENDOR_ID, &(chip->vendor));
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	chip->rev = pci->revision;
 #ifdef CHIP_AU8830
 	if ((chip->rev) != 0xfe && (chip->rev) != 0xfa) {
@@ -355,24 +341,26 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		       chip->rev);
 		dev_alert(card->dev,
 			  "Please email the results of 'lspci -vv' to openvortex-dev@nongnu.org.\n");
-		snd_card_free(card);
 		err = -ENODEV;
-		return err;
+		goto free_card;
 	}
 #endif
 
 	// (6)
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	// (7)
 	pci_set_drvdata(pci, card);
 	dev++;
 	vortex_connect_default(chip, 1);
 	vortex_enable_int(chip);
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 // destructor -- see "Destructor" sub-section
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index cdb1c227442b..6615b0933801 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2151,11 +2151,9 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 							       ->resources,
 							       en,
 							       VORTEX_RESOURCE_SRC);
-				if (src[i] < 0) {
-					memset(stream->resources, 0,
-					       sizeof(stream->resources));
-					return -EBUSY;
-				}
+				if (src[i] < 0)
+					goto reset_memory;
+
 				if (stream->type != VORTEX_PCM_A3D) {
 					mix[i] =
 					      vortex_adb_checkinout(vortex,
@@ -2163,12 +2161,8 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 								    ->resources,
 								    en,
 								    VORTEX_RESOURCE_MIXIN);
-					if (mix[i] < 0) {
-						memset(stream->resources,
-						       0,
-						       sizeof(stream->resources));
-						return -EBUSY;
-					}
+					if (mix[i] < 0)
+						goto reset_memory;
 				}
 			}
 		}
@@ -2293,20 +2287,14 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 			mix[i] = vortex_adb_checkinout(vortex,
 						       stream->resources, en,
 						       VORTEX_RESOURCE_MIXOUT);
-			if (mix[i] < 0) {
-				memset(stream->resources, 0,
-				       sizeof(stream->resources));
-				return -EBUSY;
-			}
+			if (mix[i] < 0)
+				goto reset_memory;
 
 			src[i] = vortex_adb_checkinout(vortex,
 						       stream->resources, en,
 						       VORTEX_RESOURCE_SRC);
-			if (src[i] < 0) {
-				memset(stream->resources, 0,
-				       sizeof(stream->resources));
-				return -EBUSY;
-			}
+			if (src[i] < 0)
+				goto reset_memory;
 		}
 
 		/* Make capture routes. */
@@ -2350,6 +2338,10 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 	}
 #endif
 	return dma;
+
+reset_memory:
+	memset(stream->resources, 0, sizeof(stream->resources));
+	return -EBUSY;
 }
 
 /*
-- 
2.15.0
