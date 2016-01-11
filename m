From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 2/3] ALSA: usb-audio: Add quirk_alias option
Date: Mon, 11 Jan 2016 17:59:15 +0100
Message-ID: <1452531556-32622-3-git-send-email-tiwai@suse.de>
References: <1452531556-32622-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E91E3264F2F
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 17:59:22 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87546AD78
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 16:59:21 +0000 (UTC)
In-Reply-To: <1452531556-32622-1-git-send-email-tiwai@suse.de>
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

This patch adds a new option "quirk_alias" to snd-usb-audio driver for
allowing user to pass the quirk alias list.  A quirk alias consists of
a string form like 0123abcd:5678beef, which makes to apply a quirk to
a device with USB ID 0123:abcd treated as if it were 5678:beef.
This feature is useful to test an existing quirk, typically for a
newer model of the same vendor, without patching / rebuilding the
kernel driver.

The current implementation is fairly simplistic: since there is no API
for matching a usb_device_id to the given ID pair, it has an open code
to loop over the id table and matches only with vendor:product pair.
So far, this is OK, as all existing entries are with vendor:product
pairs, indeed.  Once when we have another matching entry, however,
we'd need to update get_alias_quirk() as well.

Note that this option is provided only for testing / development.  If
you want to have a proper support, contact to upstream for adding the
matching quirk in the driver code statically.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7b5648b98ea4..f1d08d8681f8 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -82,6 +82,7 @@ static int pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
 static int device_setup[SNDRV_CARDS]; /* device parameter for this card */
 static bool ignore_ctl_error;
 static bool autoclock = true;
+static char *quirk_alias[SNDRV_CARDS];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -100,6 +101,8 @@ MODULE_PARM_DESC(ignore_ctl_error,
 		 "Ignore errors from USB controller for mixer interfaces.");
 module_param(autoclock, bool, 0444);
 MODULE_PARM_DESC(autoclock, "Enable auto-clock selection for UAC2 devices (default: yes).");
+module_param_array(quirk_alias, charp, NULL, 0444);
+MODULE_PARM_DESC(quirk_alias, "Quirk aliases, e.g. 0123abcd:5678beef.");
 
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
@@ -457,6 +460,48 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	return 0;
 }
 
+/* look for a matching quirk alias id */
+static bool get_alias_id(struct usb_device *dev, unsigned int *id)
+{
+	int i;
+	unsigned int src, dst;
+
+	for (i = 0; i < ARRAY_SIZE(quirk_alias); i++) {
+		if (!quirk_alias[i] ||
+		    sscanf(quirk_alias[i], "%x:%x", &src, &dst) != 2 ||
+		    src != *id)
+			continue;
+		dev_info(&dev->dev,
+			 "device (%04x:%04x): applying quirk alias %04x:%04x\n",
+			 USB_ID_VENDOR(*id), USB_ID_PRODUCT(*id),
+			 USB_ID_VENDOR(dst), USB_ID_PRODUCT(dst));
+		*id = dst;
+		return true;
+	}
+
+	return false;
+}
+
+static struct usb_device_id usb_audio_ids[]; /* defined below */
+
+/* look for the corresponding quirk */
+static const struct snd_usb_audio_quirk *
+get_alias_quirk(struct usb_device *dev, unsigned int id)
+{
+	const struct usb_device_id *p;
+
+	for (p = usb_audio_ids; p->match_flags; p++) {
+		/* FIXME: this checks only vendor:product pair in the list */
+		if ((p->match_flags & USB_DEVICE_ID_MATCH_DEVICE) ==
+		    USB_DEVICE_ID_MATCH_DEVICE &&
+		    p->idVendor == USB_ID_VENDOR(id) &&
+		    p->idProduct == USB_ID_PRODUCT(id))
+			return (const struct snd_usb_audio_quirk *)p->driver_info;
+	}
+
+	return NULL;
+}
+
 /*
  * probe the active usb device
  *
@@ -483,6 +528,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 	ifnum = get_iface_desc(alts)->bInterfaceNumber;
 	id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 		    le16_to_cpu(dev->descriptor.idProduct));
+	if (get_alias_id(dev, &id))
+		quirk = get_alias_quirk(dev, id);
 	if (quirk && quirk->ifnum >= 0 && ifnum != quirk->ifnum)
 		return -ENXIO;
 
-- 
2.7.0
