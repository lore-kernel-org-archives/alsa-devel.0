From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/4] ALSA: usb-audio: add support for UAC2
	pitch control
Date: Wed, 26 May 2010 18:11:39 +0200
Message-ID: <1274890299-8972-4-git-send-email-daniel@caiaq.de>
References: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D66510399E
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 18:11:56 +0200 (CEST)
In-Reply-To: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This request is again handled differently in comparison to UAC1.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/pcm.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 2bf0d77..056587d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -120,10 +120,6 @@ static int init_pitch_v1(struct snd_usb_audio *chip, int iface,
 
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
-	/* if endpoint doesn't have pitch control, bail out */
-	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
-		return 0;
-
 	data[0] = 1;
 	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
 				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
@@ -137,8 +133,32 @@ static int init_pitch_v1(struct snd_usb_audio *chip, int iface,
 	return 0;
 }
 
+static int init_pitch_v2(struct snd_usb_audio *chip, int iface,
+			 struct usb_host_interface *alts,
+			 struct audioformat *fmt)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned char data[1];
+	unsigned int ep;
+	int err;
+
+	ep = get_endpoint(alts, 0)->bEndpointAddress;
+
+	data[0] = 1;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+				   UAC2_EP_CS_PITCH << 8, 0,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set enable PITCH (v2)\n",
+			   dev->devnum, iface, fmt->altsetting);
+		return err;
+	}
+
+	return 0;
+}
+
 /*
- * initialize the picth control and sample rate
+ * initialize the pitch control and sample rate
  */
 int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
@@ -146,13 +166,16 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 {
 	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
 
+	/* if endpoint doesn't have pitch control, bail out */
+	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
+		return 0;
+
 	switch (altsd->bInterfaceProtocol) {
 	case UAC_VERSION_1:
 		return init_pitch_v1(chip, iface, alts, fmt);
 
 	case UAC_VERSION_2:
-		/* not implemented yet */
-		return 0;
+		return init_pitch_v2(chip, iface, alts, fmt);
 	}
 
 	return -EINVAL;
-- 
1.7.1
