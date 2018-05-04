From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 1/7] ALSA: usb: stream: move audioformat alloc/init into separate function
Date: Fri,  4 May 2018 04:23:58 +0300
Message-ID: <1525397044-15080-2-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, Andrew Chant <achant@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Offload snd_usb_parse_audio_interface() function which
became quite long after adding UAC3 spec support.

Move audioformat allocation and initialization
into separate function, this will make easier
future refactoring.
Attributes left in the original func because it'll
be used for UAC3 BADD profiles suport in the future

There is no functional change.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 956be9f..8ec0a52 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -626,6 +626,37 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return NULL;
 }
 
+static struct audioformat *
+audio_format_alloc_init(struct snd_usb_audio *chip,
+		       struct usb_host_interface *alts,
+		       int protocol, int iface_no, int altset_idx,
+		       int altno, int num_channels, int clock)
+{
+	struct audioformat *fp;
+
+	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
+	if (!fp)
+		return NULL;
+
+	fp->iface = iface_no;
+	fp->altsetting = altno;
+	fp->altset_idx = altset_idx;
+	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
+	fp->protocol = protocol;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	fp->channels = num_channels;
+	if (snd_usb_get_speed(chip->dev) == USB_SPEED_HIGH)
+		fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
+				* (fp->maxpacksize & 0x7ff);
+	fp->clock = clock;
+	INIT_LIST_HEAD(&fp->list);
+
+	return fp;
+}
+
+
 int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 {
 	struct usb_device *dev;
@@ -928,25 +959,14 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 				continue;
 		}
 
-		fp = kzalloc(sizeof(*fp), GFP_KERNEL);
+		fp = audio_format_alloc_init(chip, alts, protocol, iface_no, i,
+					     altno, num_channels, clock);
 		if (!fp)
 			return -ENOMEM;
 
-		fp->iface = iface_no;
-		fp->altsetting = altno;
-		fp->altset_idx = i;
-		fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
-		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
-		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
-		fp->protocol = protocol;
-		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
-		fp->channels = num_channels;
-		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
-			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
-					* (fp->maxpacksize & 0x7ff);
-		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
-		fp->clock = clock;
-		INIT_LIST_HEAD(&fp->list);
+		fp->attributes = parse_uac_endpoint_attributes(chip, alts,
+							       protocol,
+							       iface_no);
 
 		/* some quirks for attributes here */
 		snd_usb_audioformat_attributes_quirk(chip, fp, stream);
-- 
1.9.1
