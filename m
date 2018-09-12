From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable runtime PM on AMD/ATI GPU
	only for discrete GPU
Date: Wed, 12 Sep 2018 11:48:33 +0200
Message-ID: <20180912094833.12427-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 532332676B0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 11:48:41 +0200 (CEST)
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
Cc: jian-hong@endlessm.com, Lukas Wunner <lukas@wunner.de>
List-Id: alsa-devel@alsa-project.org

The recent change of vga_switcheroo allowed the runtime PM for
HD-audio on AMD GPU, but this also resulted in a regression.  When the
HD-audio controller driver gets runtime-suspended, HD-audio link is
turned off, and the hotplug notification is ignored.  This leads to
the inconsistent audio state (the connection isn't notified and ELD is
ignored).

The best fix would be to implement the proper ELD notification via the
audio component, but it's still not ready.  As a quick workaround,
this patch adds the check of runtime_idle and allows the runtime
suspend only when the vga_switcheroo is bound with discrete GPU.
That is, a system with a single GPU would be again without runtime PM
(of the controller), as well as the APU that needs to keep the
HD-audio link for the hotplug notification and ELD read out.

For identifying the audio client connection type, a new API is added
to vga_switcheroo.  Other than that, the patch does a pretty simple
job.

Note that this patch won't influence on the HD-audio *codec* runtime
PM.  When a codec is unused and the system goes to S3/S4 and resumed,
the codec won't be resumed immediately because it's unused.  This
likely keeps the hotplug notification broken, but this is basically
the expected behavior, a cost needed for the power-saving.  The
hotplug state will be activated once when you access to the device (or
triggering the power up via reading a codec#* proc file or such).

Again, this issue will be solved by the proper audio component
notification, but it's still not ready.  Until then, user would need
to disable the power-saving explicitly if the ELD hotplug notification
is required.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200945
Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c | 20 ++++++++++++++++++++
 include/linux/vga_switcheroo.h   |  1 +
 sound/pci/hda/hda_intel.c        |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index a96bf46bc483..89598adbf6be 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -485,6 +485,26 @@ enum vga_switcheroo_state vga_switcheroo_get_client_state(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(vga_switcheroo_get_client_state);
 
+/**
+ * vga_switcheroo_get_client_id() - obtain client id of a given client
+ * @pdev: client pci device
+ */
+enum vga_switcheroo_client_id vga_switcheroo_get_client_id(struct pci_dev *pdev)
+{
+	struct vga_switcheroo_client *client;
+	enum vga_switcheroo_client_id ret;
+
+	mutex_lock(&vgasr_mutex);
+	client = find_client_from_pci(&vgasr_priv.clients, pdev);
+	if (!client)
+		ret = VGA_SWITCHEROO_UNKNOWN_ID;
+	else
+		ret = client_id(client);
+	mutex_unlock(&vgasr_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(vga_switcheroo_get_client_id);
+
 /**
  * vga_switcheroo_unregister_client() - unregister client
  * @pdev: client pci device
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index a34539b7f750..e52fcd7b68f3 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -167,6 +167,7 @@ int vga_switcheroo_process_delayed_switch(void);
 
 bool vga_switcheroo_client_probe_defer(struct pci_dev *pdev);
 enum vga_switcheroo_state vga_switcheroo_get_client_state(struct pci_dev *dev);
+enum vga_switcheroo_client_id vga_switcheroo_get_client_id(struct pci_dev *dev);
 
 int vga_switcheroo_init_domain_pm_ops(struct device *dev, struct dev_pm_domain *domain);
 void vga_switcheroo_fini_domain_pm_ops(struct device *dev);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1b2ce304152a..48ab090648a7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1201,6 +1201,14 @@ static int azx_runtime_idle(struct device *dev)
 	    azx_bus(chip)->codec_powered || !chip->running)
 		return -EBUSY;
 
+#ifdef SUPPORT_VGA_SWITCHEROO
+	/* ELD notification gets broken on AMD GPUs when HD-audio bus is off */
+	if ((chip->pci->vendor == PCI_VENDOR_ID_ATI ||
+	     chip->pci->vendor == PCI_VENDOR_ID_AMD) &&
+	    vga_switcheroo_get_client_id(chip->pci) != VGA_SWITCHEROO_DIS)
+		return -EBUSY;
+#endif
+
 	return 0;
 }
 
-- 
2.18.0
