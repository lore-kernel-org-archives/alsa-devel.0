From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 08/11] ALSA: usb-audio: implement card
	get_info callback
Date: Tue, 28 Aug 2012 00:33:46 +0200
Message-ID: <503BF5CA.2050001@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AE909265F52
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:34:43 +0200 (CEST)
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

Add a helper for retrieving information about USB devices.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/media.h |   16 ++++++++++++++++
 sound/core/media.c    |   28 ++++++++++++++++++++++++++++
 sound/usb/card.c      |    2 ++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/sound/media.h b/include/sound/media.h
index ebb7c7d..5339acb 100644
--- a/include/sound/media.h
+++ b/include/sound/media.h
@@ -39,6 +39,15 @@ typedef int (*snd_media_entity_get_desc_t)(struct snd_card *card,

 #define snd_card_set_media_ops(card, ops) ((card)->media_ops = (ops))

+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+int snd_media_get_usb_card_info(struct snd_card *card,
+				struct media_device_info *info);
+
+extern const struct snd_media_card_ops snd_media_default_usb_ops;
+#define snd_card_set_media_ops_default_usb(card) \
+		snd_card_set_media_ops((card), &snd_media_default_usb_ops)
+#endif
+
 int snd_media_entity_create(struct snd_card *card,
 			    snd_media_entity_get_desc_t get_desc,
 			    unsigned int id,
@@ -58,6 +67,13 @@ void __exit snd_media_exit(void);

 #define snd_card_set_media_ops(card, ops)

+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+#define snd_card_set_media_ops_default_usb(card)
+static inline int snd_media_get_usb_card_info(struct snd_card *card,
+					      struct media_device_info *info)
+{ return 0; }
+#endif
+
 static inline int snd_media_entity_create(struct snd_card *card,
 					  snd_media_entity_get_desc_t get_desc,
 					  unsigned int id,
diff --git a/sound/core/media.c b/sound/core/media.c
index cbc51d9..f42e00b 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -24,6 +24,7 @@
 #include <linux/media.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/usb.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/media.h>
@@ -328,6 +329,33 @@ static int snd_media_setup_link(struct snd_card *card,
 	return err;
 }

+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+int snd_media_get_usb_card_info(struct snd_card *card,
+				struct media_device_info *info)
+{
+	struct usb_interface *intf;
+	struct usb_device *usb;
+
+	if (snd_BUG_ON(!card->dev))
+		return -ENXIO;
+	intf = to_usb_interface(card->dev);
+	usb = interface_to_usbdev(intf);
+
+	if (usb->serial)
+		strlcpy(info->serial, usb->serial, sizeof(info->serial));
+	usb_make_path(usb, info->bus_info, sizeof(info->bus_info));
+	info->hw_revision = le16_to_cpu(usb->descriptor.bcdDevice);
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_media_get_usb_card_info);
+
+const struct snd_media_card_ops snd_media_default_usb_ops = {
+	.get_info = snd_media_get_usb_card_info,
+};
+EXPORT_SYMBOL(snd_media_default_usb_ops);
+#endif
+
 static int snd_media_control_ioctl(struct snd_card *card,
 				   struct snd_ctl_file *ctl_file,
 				   unsigned int cmd, unsigned long arg)
diff --git a/sound/usb/card.c b/sound/usb/card.c
index d5b5c33..311366b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -52,6 +52,7 @@
 #include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
+#include <sound/media.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
@@ -490,6 +491,7 @@ snd_usb_audio_probe(struct usb_device *dev,
 					goto __error;
 				}
 				snd_card_set_dev(chip->card, &intf->dev);
+				snd_card_set_media_ops_default_usb(chip->card);
 				chip->pm_intf = intf;
 				break;
 			}
