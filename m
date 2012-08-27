From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 11/11] ALSA: hda-intel: implement card
	get_info callback
Date: Tue, 28 Aug 2012 00:36:48 +0200
Message-ID: <503BF680.4050206@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4C198265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:37:45 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a helper for retrieving information about PCI devices.

(Codec topology information is not yet implemented.)

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/media.h     |   16 ++++++++++++++++
 sound/core/media.c        |   36 ++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_intel.c |    2 ++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/include/sound/media.h b/include/sound/media.h
index 5339acb..e030e4c 100644
--- a/include/sound/media.h
+++ b/include/sound/media.h
@@ -39,6 +39,15 @@ typedef int (*snd_media_entity_get_desc_t)(struct snd_card *card,

 #define snd_card_set_media_ops(card, ops) ((card)->media_ops = (ops))

+#ifdef CONFIG_PCI
+int snd_media_get_pci_card_info(struct snd_card *card,
+				struct media_device_info *info);
+
+extern const struct snd_media_card_ops snd_media_default_pci_ops;
+#define snd_card_set_media_ops_default_pci(card) \
+		snd_card_set_media_ops((card), &snd_media_default_pci_ops)
+#endif
+
 #if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 int snd_media_get_usb_card_info(struct snd_card *card,
 				struct media_device_info *info);
@@ -67,6 +76,13 @@ void __exit snd_media_exit(void);

 #define snd_card_set_media_ops(card, ops)

+#ifdef CONFIG_PCI
+#define snd_card_set_media_ops_default_pci(card)
+static inline int snd_media_get_pci_card_info(struct snd_card *card,
+					      struct media_device_info *info)
+{ return 0; }
+#endif
+
 #if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 #define snd_card_set_media_ops_default_usb(card)
 static inline int snd_media_get_usb_card_info(struct snd_card *card,
diff --git a/sound/core/media.c b/sound/core/media.c
index f42e00b..9da058d 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -18,10 +18,12 @@
  */

 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/media.h>
+#include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
@@ -329,6 +331,40 @@ static int snd_media_setup_link(struct snd_card *card,
 	return err;
 }

+#ifdef CONFIG_PCI
+int snd_media_get_pci_card_info(struct snd_card *card,
+				struct media_device_info *info)
+{
+	struct pci_dev *pci;
+
+	if (snd_BUG_ON(!card->dev))
+		return -ENXIO;
+	pci = to_pci_dev(card->dev);
+
+	if (pci_is_pcie(pci)) {
+		int pos = pci_find_ext_capability(pci, PCI_EXT_CAP_ID_DSN);
+		if (pos) {
+			u32 eui[2];
+
+			pci_read_config_dword(pci, pos + 4, &eui[0]);
+			pci_read_config_dword(pci, pos + 8, &eui[1]);
+			sprintf(info->serial, "%08x%08x", eui[1], eui[0]);
+		}
+	}
+	snprintf(info->bus_info, sizeof(info->bus_info), "%s:%s",
+		 pci_is_pcie(pci) ? "PCIe" : "PCI", pci_name(pci));
+	info->hw_revision = pci->revision;
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_media_get_pci_card_info);
+
+const struct snd_media_card_ops snd_media_default_pci_ops = {
+	.get_info = snd_media_get_pci_card_info,
+};
+EXPORT_SYMBOL(snd_media_default_pci_ops);
+#endif
+
 #if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 int snd_media_get_usb_card_info(struct snd_card *card,
 				struct media_device_info *info)
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1c9c779..a01a43c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -54,6 +54,7 @@
 #endif
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/media.h>
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
@@ -3305,6 +3306,7 @@ static int __devinit azx_probe(struct pci_dev *pci,
 	}

 	snd_card_set_dev(card, &pci->dev);
+	snd_card_set_media_ops_default_pci(card);

 	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
 	if (err < 0)
