From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 04/19] ALSA: hda - Use device pointer from the
	card instead of pci
Date: Thu, 27 Feb 2014 22:35:47 -0800
Message-ID: <1393569362-27285-5-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f201.google.com (mail-ie0-f201.google.com
 [209.85.223.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BA4726508D
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-ie0-f201.google.com with SMTP id at1so712829iec.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This removes calls to get the device via PCI from other parts of the
code that will be able to be re-used by the platform driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8eec5cb..053137e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -405,7 +405,7 @@ static int azx_alloc_cmd_io(struct azx *chip)
 
 	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  snd_dma_pci_data(chip->pci),
+				  chip->card->dev,
 				  PAGE_SIZE, &chip->rb);
 	if (err < 0) {
 		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
@@ -1051,7 +1051,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 
 #ifdef CONFIG_PM_RUNTIME
 	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
-		if (chip->pci->dev.power.runtime_status != RPM_ACTIVE)
+		if (chip->card->dev->power.runtime_status != RPM_ACTIVE)
 			return IRQ_NONE;
 #endif
 
@@ -2306,7 +2306,7 @@ azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 	if (size > MAX_PREALLOC_SIZE)
 		size = MAX_PREALLOC_SIZE;
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      snd_dma_pci_data(chip->pci),
+					      chip->card->dev,
 					      size, MAX_PREALLOC_SIZE);
 	/* link to codec */
 	pcm->dev = &codec->dev;
@@ -2421,7 +2421,7 @@ static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
 	spin_unlock_irq(&chip->reg_lock);
 
 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
-				  snd_dma_pci_data(chip->pci),
+				  chip->card->dev,
 				  byte_size, bufp);
 	if (err < 0)
 		goto err_alloc;
@@ -2514,9 +2514,9 @@ static void azx_power_notify(struct hda_bus *bus, bool power_up)
 		return;
 
 	if (power_up)
-		pm_runtime_get_sync(&chip->pci->dev);
+		pm_runtime_get_sync(chip->card->dev);
 	else
-		pm_runtime_put_sync(&chip->pci->dev);
+		pm_runtime_put_sync(chip->card->dev);
 }
 
 static DEFINE_MUTEX(card_list_lock);
@@ -2781,8 +2781,8 @@ static void azx_vs_set_state(struct pci_dev *pci,
 		dev_info(chip->card->dev, "%s via VGA-switcheroo\n",
 			 disabled ? "Disabling" : "Enabling");
 		if (disabled) {
-			pm_runtime_put_sync_suspend(&pci->dev);
-			azx_suspend(&pci->dev);
+			pm_runtime_put_sync_suspend(card->dev);
+			azx_suspend(card->dev);
 			/* when we get suspended by vga switcheroo we end up in D3cold,
 			 * however we have no ACPI handle, so pci/acpi can't put us there,
 			 * put ourselves there */
@@ -2793,9 +2793,9 @@ static void azx_vs_set_state(struct pci_dev *pci,
 					 "Cannot lock devices!\n");
 		} else {
 			snd_hda_unlock_devices(chip->bus);
-			pm_runtime_get_noresume(&pci->dev);
+			pm_runtime_get_noresume(card->dev);
 			chip->disabled = false;
-			azx_resume(&pci->dev);
+			azx_resume(card->dev);
 		}
 	}
 }
@@ -2849,7 +2849,8 @@ static int register_vga_switcheroo(struct azx *chip)
 	chip->vga_switcheroo_registered = 1;
 
 	/* register as an optimus hdmi audio power domain */
-	vga_switcheroo_init_domain_pm_optimus_hdmi_audio(&chip->pci->dev, &chip->hdmi_pm_domain);
+	vga_switcheroo_init_domain_pm_optimus_hdmi_audio(chip->card->dev,
+							 &chip->hdmi_pm_domain);
 	return 0;
 }
 #else
@@ -3364,7 +3365,7 @@ static int azx_first_init(struct azx *chip)
 		dsp_lock_init(&chip->azx_dev[i]);
 		/* allocate memory for the BDL for each stream */
 		err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					  snd_dma_pci_data(chip->pci),
+					  chip->card->dev,
 					  BDL_SIZE, &chip->azx_dev[i].bdl);
 		if (err < 0) {
 			dev_err(card->dev, "cannot allocate BDL\n");
@@ -3374,7 +3375,7 @@ static int azx_first_init(struct azx *chip)
 	}
 	/* allocate memory for the position buffer */
 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  snd_dma_pci_data(chip->pci),
+				  chip->card->dev,
 				  chip->num_streams * 8, &chip->posbuf);
 	if (err < 0) {
 		dev_err(card->dev, "cannot allocate posbuf\n");
-- 
1.8.1.3.605.g02339dd
