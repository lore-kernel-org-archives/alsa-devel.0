From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 4/7] ALSA: usb: Only get AudioControl header for UAC1 class.
Date: Fri,  4 May 2018 04:24:01 +0300
Message-ID: <1525397044-15080-5-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, Andrew Chant <achant@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>

The control header needs to be read from buffer at this point only
in the case of UAC1 protocol. Move it inside the switch case as other
protocols such as the Basic Audio Device spec will have an empty buffer
that is latter filled as inferred.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
[Ruslan: updated with recently added sanity checks]
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/card.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 36c289b..0d7a5d7 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -221,32 +221,13 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	struct usb_device *dev = chip->dev;
 	struct usb_host_interface *host_iface;
 	struct usb_interface_descriptor *altsd;
-	void *control_header;
 	int i, protocol;
-	int rest_bytes;
 
 	/* find audiocontrol interface */
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
-	control_header = snd_usb_find_csint_desc(host_iface->extra,
-						 host_iface->extralen,
-						 NULL, UAC_HEADER);
 	altsd = get_iface_desc(host_iface);
 	protocol = altsd->bInterfaceProtocol;
 
-	if (!control_header) {
-		dev_err(&dev->dev, "cannot find UAC_HEADER\n");
-		return -EINVAL;
-	}
-
-	rest_bytes = (void *)(host_iface->extra + host_iface->extralen) -
-		control_header;
-
-	/* just to be sure -- this shouldn't hit at all */
-	if (rest_bytes <= 0) {
-		dev_err(&dev->dev, "invalid control header\n");
-		return -EINVAL;
-	}
-
 	switch (protocol) {
 	default:
 		dev_warn(&dev->dev,
@@ -255,7 +236,25 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		/* fall through */
 
 	case UAC_VERSION_1: {
-		struct uac1_ac_header_descriptor *h1 = control_header;
+		struct uac1_ac_header_descriptor *h1;
+		int rest_bytes;
+
+		h1 = snd_usb_find_csint_desc(host_iface->extra,
+							 host_iface->extralen,
+							 NULL, UAC_HEADER);
+		if (!h1) {
+			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
+			return -EINVAL;
+		}
+
+		rest_bytes = (void *)(host_iface->extra +
+				host_iface->extralen) - (void *)h1;
+
+		/* just to be sure -- this shouldn't hit at all */
+		if (rest_bytes <= 0) {
+			dev_err(&dev->dev, "invalid control header\n");
+			return -EINVAL;
+		}
 
 		if (rest_bytes < sizeof(*h1)) {
 			dev_err(&dev->dev, "too short v1 buffer descriptor\n");
-- 
1.9.1
