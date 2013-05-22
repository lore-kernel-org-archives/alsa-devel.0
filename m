From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 4/4] ALSA: hda - Continue probe in work context
	to avoid request_module deadlock
Date: Thu, 23 May 2013 01:04:16 +0800
Message-ID: <1369242256-32112-5-git-send-email-xingchao.wang@linux.intel.com>
References: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1D52610A7
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:31:20 +0200 (CEST)
In-Reply-To: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

There's deadlock when request_module(i915) in azx_probe.
It looks like:
device_lock(audio pci device) -> azx_probe -> module_request
(or symbol_request) -> modprobe (userspace) -> i915 init ->
drm_pci_init -> pci_register_driver -> bus_add_driver -> driver_attach ->
which in turn tries all locks on pci bus, and when it tries the one on the
audio device, it will deadlock.

This patch introduce a work to store remaining probe stuff, and let
request_module run in safe work context.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 105 +++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f20a88c..1bc7c3b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -76,6 +76,7 @@ static int probe_only[SNDRV_CARDS];
 static int jackpoll_ms[SNDRV_CARDS];
 static bool single_cmd;
 static int enable_msi = -1;
+static int dev;
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 static char *patch[SNDRV_CARDS];
 #endif
@@ -542,6 +543,8 @@ struct azx {
 	/* for pending irqs */
 	struct work_struct irq_pending_work;
 
+	struct delayed_work probe_work;
+
 	/* reboot notifier (for mysterious hangup problem at power-down) */
 	struct notifier_block reboot_notifier;
 
@@ -3670,58 +3673,22 @@ static void azx_firmware_cb(const struct firmware *fw, void *context)
 }
 #endif
 
-static int azx_probe(struct pci_dev *pci,
-		     const struct pci_device_id *pci_id)
+static void azx_probe_work(struct work_struct *work)
 {
-	static int dev;
-	struct snd_card *card;
-	struct azx *chip;
+	struct azx *chip =
+		container_of(work, struct azx, probe_work.work);
+	struct snd_card *card = chip->card;
+	struct pci_dev *pci = chip->pci;
 	bool probe_now;
 	int err;
 
-	if (dev >= SNDRV_CARDS)
-		return -ENODEV;
-	if (!enable[dev]) {
-		dev++;
-		return -ENOENT;
-	}
-
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
-	if (err < 0) {
-		snd_printk(KERN_ERR "hda-intel: Error creating card!\n");
-		return err;
-	}
-
-	snd_card_set_dev(card, &pci->dev);
-
-	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
-	if (err < 0)
-		goto out_free;
-	card->private_data = chip;
-
-	pci_set_drvdata(pci, card);
-
-	err = register_vga_switcheroo(chip);
-	if (err < 0) {
-		snd_printk(KERN_ERR SFX
-			   "%s: Error registering VGA-switcheroo client\n", pci_name(pci));
-		goto out_free;
-	}
-
-	if (check_hdmi_disabled(pci)) {
-		snd_printk(KERN_INFO SFX "%s: VGA controller is disabled\n",
-			   pci_name(pci));
-		snd_printk(KERN_INFO SFX "%s: Delaying initialization\n", pci_name(pci));
-		chip->disabled = true;
-	}
-
 	/* Request power well for Haswell HDA controller and codec */
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init();
 		if (err < 0) {
 			snd_printk(KERN_ERR SFX "Error request power-well from i915\n");
-			return err;
+			goto out_free;
 		}
 		hda_display_power(true);
 #else
@@ -3760,7 +3727,7 @@ static int azx_probe(struct pci_dev *pci,
 
 	dev++;
 	complete_all(&chip->probe_wait);
-	return 0;
+	return;
 out_free_power:
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(false);
@@ -3769,6 +3736,58 @@ out_free_power:
 out_free:
 	snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
+}
+
+static int azx_probe(struct pci_dev *pci,
+		     const struct pci_device_id *pci_id)
+{
+	struct snd_card *card;
+	struct azx *chip;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	if (err < 0) {
+		snd_printk(KERN_ERR "hda-intel: Error creating card!\n");
+		return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+
+	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
+	if (err < 0)
+		goto out_free;
+	card->private_data = chip;
+
+	pci_set_drvdata(pci, card);
+
+	err = register_vga_switcheroo(chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR SFX
+			   "%s: Error registering VGA-switcheroo client\n", pci_name(pci));
+		goto out_free;
+	}
+
+	if (check_hdmi_disabled(pci)) {
+		snd_printk(KERN_INFO SFX "%s: VGA controller is disabled\n",
+			   pci_name(pci));
+		snd_printk(KERN_INFO SFX "%s: Delaying initialization\n", pci_name(pci));
+		chip->disabled = true;
+	}
+
+	/* continue probing in work context as may trigger request module */
+	INIT_DELAYED_WORK(&chip->probe_work, azx_probe_work);
+	schedule_delayed_work(&chip->probe_work, 0);
+	return 0;
+out_free:
+	snd_card_free(card);
+	pci_set_drvdata(pci, NULL);
 	return err;
 }
 
-- 
1.8.1.2
