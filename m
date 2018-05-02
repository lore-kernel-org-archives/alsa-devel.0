From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: usb-audio: Allow to override the
	longname string
Date: Wed,  2 May 2018 16:11:15 +0200
Message-ID: <20180502141116.31966-6-tiwai@suse.de>
References: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C174266C1C
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:21 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7E76EAF0D
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:20 +0000 (UTC)
In-Reply-To: <20180502141116.31966-1-tiwai@suse.de>
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

Historically USB-audio driver sets the card's longname field with the
details of the device and the bus information.  It's good per se, but
not preferable when it's referred as the identifier for UCM profile.

This patch adds a quirk profile_name field to override the card's
longname string to a pre-defined one, so that one can create a unique
and consistent ID string for the specific USB device via a quirk table
to be used as a UCM profile name.

The patch does a slight code refactoring to split out the functions to
set shortname and longname fields as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c     | 146 ++++++++++++++++++++++++++++++---------------------
 sound/usb/usbaudio.h |   1 +
 2 files changed, 88 insertions(+), 59 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4a1c6bb3dfa0..36c289bae169 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -349,6 +349,90 @@ static int snd_usb_audio_dev_free(struct snd_device *device)
 	return snd_usb_audio_free(chip);
 }
 
+static void usb_audio_make_shortname(struct usb_device *dev,
+				     struct snd_usb_audio *chip,
+				     const struct snd_usb_audio_quirk *quirk)
+{
+	struct snd_card *card = chip->card;
+
+	if (quirk && quirk->product_name && *quirk->product_name) {
+		strlcpy(card->shortname, quirk->product_name,
+			sizeof(card->shortname));
+		return;
+	}
+
+	/* retrieve the device string as shortname */
+	if (!dev->descriptor.iProduct ||
+	    usb_string(dev, dev->descriptor.iProduct,
+		       card->shortname, sizeof(card->shortname)) <= 0) {
+		/* no name available from anywhere, so use ID */
+		sprintf(card->shortname, "USB Device %#04x:%#04x",
+			USB_ID_VENDOR(chip->usb_id),
+			USB_ID_PRODUCT(chip->usb_id));
+	}
+
+	strim(card->shortname);
+}
+
+static void usb_audio_make_longname(struct usb_device *dev,
+				    struct snd_usb_audio *chip,
+				    const struct snd_usb_audio_quirk *quirk)
+{
+	struct snd_card *card = chip->card;
+	int len;
+
+	/* shortcut - if any pre-defined string is given, use it */
+	if (quirk && quirk->profile_name && *quirk->profile_name) {
+		strlcpy(card->longname, quirk->profile_name,
+			sizeof(card->longname));
+		return;
+	}
+
+	if (quirk && quirk->vendor_name && *quirk->vendor_name) {
+		len = strlcpy(card->longname, quirk->vendor_name, sizeof(card->longname));
+	} else {
+		/* retrieve the vendor and device strings as longname */
+		if (dev->descriptor.iManufacturer)
+			len = usb_string(dev, dev->descriptor.iManufacturer,
+					 card->longname, sizeof(card->longname));
+		else
+			len = 0;
+		/* we don't really care if there isn't any vendor string */
+	}
+	if (len > 0) {
+		strim(card->longname);
+		if (*card->longname)
+			strlcat(card->longname, " ", sizeof(card->longname));
+	}
+
+	strlcat(card->longname, card->shortname, sizeof(card->longname));
+
+	len = strlcat(card->longname, " at ", sizeof(card->longname));
+
+	if (len < sizeof(card->longname))
+		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
+
+	switch (snd_usb_get_speed(dev)) {
+	case USB_SPEED_LOW:
+		strlcat(card->longname, ", low speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_FULL:
+		strlcat(card->longname, ", full speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_HIGH:
+		strlcat(card->longname, ", high speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_SUPER:
+		strlcat(card->longname, ", super speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_SUPER_PLUS:
+		strlcat(card->longname, ", super speed plus", sizeof(card->longname));
+		break;
+	default:
+		break;
+	}
+}
+
 /*
  * create a chip instance and set its names.
  */
@@ -360,7 +444,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 {
 	struct snd_card *card;
 	struct snd_usb_audio *chip;
-	int err, len;
+	int err;
 	char component[14];
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_usb_audio_dev_free,
@@ -422,64 +506,8 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 		USB_ID_VENDOR(chip->usb_id), USB_ID_PRODUCT(chip->usb_id));
 	snd_component_add(card, component);
 
-	/* retrieve the device string as shortname */
-	if (quirk && quirk->product_name && *quirk->product_name) {
-		strlcpy(card->shortname, quirk->product_name, sizeof(card->shortname));
-	} else {
-		if (!dev->descriptor.iProduct ||
-		    usb_string(dev, dev->descriptor.iProduct,
-		    card->shortname, sizeof(card->shortname)) <= 0) {
-			/* no name available from anywhere, so use ID */
-			sprintf(card->shortname, "USB Device %#04x:%#04x",
-				USB_ID_VENDOR(chip->usb_id),
-				USB_ID_PRODUCT(chip->usb_id));
-		}
-	}
-	strim(card->shortname);
-
-	/* retrieve the vendor and device strings as longname */
-	if (quirk && quirk->vendor_name && *quirk->vendor_name) {
-		len = strlcpy(card->longname, quirk->vendor_name, sizeof(card->longname));
-	} else {
-		if (dev->descriptor.iManufacturer)
-			len = usb_string(dev, dev->descriptor.iManufacturer,
-					 card->longname, sizeof(card->longname));
-		else
-			len = 0;
-		/* we don't really care if there isn't any vendor string */
-	}
-	if (len > 0) {
-		strim(card->longname);
-		if (*card->longname)
-			strlcat(card->longname, " ", sizeof(card->longname));
-	}
-
-	strlcat(card->longname, card->shortname, sizeof(card->longname));
-
-	len = strlcat(card->longname, " at ", sizeof(card->longname));
-
-	if (len < sizeof(card->longname))
-		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
-
-	switch (snd_usb_get_speed(dev)) {
-	case USB_SPEED_LOW:
-		strlcat(card->longname, ", low speed", sizeof(card->longname));
-		break;
-	case USB_SPEED_FULL:
-		strlcat(card->longname, ", full speed", sizeof(card->longname));
-		break;
-	case USB_SPEED_HIGH:
-		strlcat(card->longname, ", high speed", sizeof(card->longname));
-		break;
-	case USB_SPEED_SUPER:
-		strlcat(card->longname, ", super speed", sizeof(card->longname));
-		break;
-	case USB_SPEED_SUPER_PLUS:
-		strlcat(card->longname, ", super speed plus", sizeof(card->longname));
-		break;
-	default:
-		break;
-	}
+	usb_audio_make_shortname(dev, chip, quirk);
+	usb_audio_make_longname(dev, chip, quirk);
 
 	snd_usb_audio_create_proc(chip);
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 32f4a5425536..1cb6b3e9483c 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -112,6 +112,7 @@ enum quirk_type {
 struct snd_usb_audio_quirk {
 	const char *vendor_name;
 	const char *product_name;
+	const char *profile_name;	/* override the card->longname */
 	int16_t ifnum;
 	uint16_t type;
 	const void *data;
-- 
2.16.3
