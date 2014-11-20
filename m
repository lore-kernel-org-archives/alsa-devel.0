From: eliot@blennerhassett.gen.nz
Subject: [PATCH 08/10] ALSA: asihpi: Use standard printk helpers
Date: Thu, 20 Nov 2014 16:22:55 +1300
Message-ID: <1416453777-7155-9-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 032D6265879
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:44 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB00JUAITNDX50@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:42 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/asihpi.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 4200fec..616d953 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -380,7 +380,7 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 					  HPI_CONTROL_SAMPLECLOCK, &h_control);
 		if (err) {
-			snd_printk(KERN_ERR
+			dev_err(&asihpi->pci->dev,
 				"No local sampleclock, err %d\n", err);
 		}
 
@@ -1441,7 +1441,7 @@ static inline int ctl_add(struct snd_card *card, struct snd_kcontrol_new *ctl,
 	if (err < 0)
 		return err;
 	else if (mixer_dump)
-		snd_printk(KERN_INFO "added %s(%d)\n", ctl->name, ctl->index);
+		dev_info(&asihpi->pci->dev, "added %s(%d)\n", ctl->name, ctl->index);
 
 	return 0;
 }
@@ -2655,7 +2655,7 @@ static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 		if (err) {
 			if (err == HPI_ERROR_CONTROL_DISABLED) {
 				if (mixer_dump)
-					snd_printk(KERN_INFO
+					dev_info(&asihpi->pci->dev,
 						   "Disabled HPI Control(%d)\n",
 						   idx);
 				continue;
@@ -2720,9 +2720,8 @@ static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 		case HPI_CONTROL_COMPANDER:
 		default:
 			if (mixer_dump)
-				snd_printk(KERN_INFO
-					"Untranslated HPI Control"
-					"(%d) %d %d %d %d %d\n",
+				dev_info(&asihpi->pci->dev,
+					"Untranslated HPI Control (%d) %d %d %d %d %d\n",
 					idx,
 					hpi_ctl.control_type,
 					hpi_ctl.src_node_type,
@@ -2737,7 +2736,7 @@ static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 	if (HPI_ERROR_INVALID_OBJ_INDEX != err)
 		hpi_handle_error(err);
 
-	snd_printk(KERN_INFO "%d mixer controls found\n", idx);
+	dev_info(&asihpi->pci->dev, "%d mixer controls found\n", idx);
 
 	return 0;
 }
@@ -2900,8 +2899,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 				   &card);
 		if (err < 0)
 			return err;
-		snd_printk(KERN_WARNING
-			"**** WARNING **** Adapter index %d->ALSA index %d\n",
+		dev_warn(&pci_dev->dev, "Adapter index %d->ALSA index %d\n",
 			adapter_index, card->number);
 	}
 
@@ -2911,9 +2909,6 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	asihpi->hpi = hpi;
 	hpi->snd_card = card;
 
-	snd_printk(KERN_INFO "adapter ID=%4X index=%d\n",
-			asihpi->hpi->adapter->type, adapter_index);
-
 	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_CAPS1,
 		NULL, &asihpi->support_grouping);
@@ -2971,22 +2966,21 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->in_min_chans = 1;
 	}
 
-	snd_printk(KERN_INFO "update_interval_frames: %d",
-		asihpi->update_interval_frames);
-	snd_printk(KERN_INFO "Has dma:%d, grouping:%d, mrx:%d\n",
+	dev_info(&pci_dev->dev, "Has dma:%d, grouping:%d, mrx:%d, uif:%d\n",
 			asihpi->can_dma,
 			asihpi->support_grouping,
-			asihpi->support_mrx
+			asihpi->support_mrx,
+			asihpi->update_interval_frames
 	      );
 
 	err = snd_card_asihpi_pcm_new(asihpi, 0);
 	if (err < 0) {
-		snd_printk(KERN_ERR "pcm_new failed\n");
+		dev_err(&pci_dev->dev, "pcm_new failed\n");
 		goto __nodev;
 	}
 	err = snd_card_asihpi_mixer_new(asihpi);
 	if (err < 0) {
-		snd_printk(KERN_ERR "mixer_new failed\n");
+		dev_err(&pci_dev->dev, "mixer_new failed\n");
 		goto __nodev;
 	}
 
@@ -3018,7 +3012,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	}
 __nodev:
 	snd_card_free(card);
-	snd_printk(KERN_ERR "snd_asihpi_probe error %d\n", err);
+	dev_err(&pci_dev->dev, "snd_asihpi_probe error %d\n", err);
 	return err;
 
 }
-- 
1.9.1
