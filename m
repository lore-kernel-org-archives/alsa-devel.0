From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 7/8] ALSA: usb-audio: add support for
	samplerate setting on v2 devices
Date: Fri,  5 Mar 2010 08:41:24 +0100
Message-ID: <1267774885-16266-8-git-send-email-daniel@caiaq.de>
References: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
	<1267774885-16266-2-git-send-email-daniel@caiaq.de>
	<1267774885-16266-3-git-send-email-daniel@caiaq.de>
	<1267774885-16266-4-git-send-email-daniel@caiaq.de>
	<1267774885-16266-5-git-send-email-daniel@caiaq.de>
	<1267774885-16266-6-git-send-email-daniel@caiaq.de>
	<1267774885-16266-7-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B1D10103A41
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 08:42:14 +0100 (CET)
In-Reply-To: <1267774885-16266-7-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Sample rate setting is done with a 4-byte long class request that
addresses the interface.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c |    4 +-
 sound/usb/pcm.c      |  173 ++++++++++++++++++++++++++++++++++++-------------
 sound/usb/pcm.h      |    4 +-
 sound/usb/quirks.c   |    4 +-
 4 files changed, 133 insertions(+), 52 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index d65235c..91850f8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -350,8 +350,8 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		}
 		/* try to set the interface... */
 		usb_set_interface(chip->dev, iface_no, altno);
-		snd_usb_init_pitch(chip->dev, iface_no, alts, fp);
-		snd_usb_init_sample_rate(chip->dev, iface_no, alts, fp, fp->rate_max);
+		snd_usb_init_pitch(chip, iface_no, alts, fp);
+		snd_usb_init_sample_rate(chip, iface_no, alts, fp, fp->rate_max);
 	}
 	return 0;
 }
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index bd0f84f..e0f3f87 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -107,69 +107,150 @@ static struct audioformat *find_format(struct snd_usb_substream *subs, unsigned
 	return found;
 }
 
+static int init_pitch_v1(struct snd_usb_audio *chip, int iface,
+			 struct usb_host_interface *alts,
+			 struct audioformat *fmt)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned int ep;
+	unsigned char data[1];
+	int err;
+
+	ep = get_endpoint(alts, 0)->bEndpointAddress;
+
+	/* if endpoint doesn't have pitch control, bail out */
+	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
+		return 0;
+
+	data[0] = 1;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
+				   UAC_EP_CS_ATTR_PITCH_CONTROL << 8, ep,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set enable PITCH\n",
+			   dev->devnum, iface, ep);
+		return err;
+	}
+
+	return 0;
+}
 
 /*
  * initialize the picth control and sample rate
  */
-int snd_usb_init_pitch(struct usb_device *dev, int iface,
+int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
 		       struct audioformat *fmt)
 {
+	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
+
+	switch (altsd->bInterfaceProtocol) {
+	case UAC_VERSION_1:
+		return init_pitch_v1(chip, iface, alts, fmt);
+
+	case UAC_VERSION_2:
+		/* not implemented yet */
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
+			      struct usb_host_interface *alts,
+			      struct audioformat *fmt, int rate)
+{
+	struct usb_device *dev = chip->dev;
 	unsigned int ep;
-	unsigned char data[1];
-	int err;
+	unsigned char data[3];
+	int err, crate;
 
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
-	/* if endpoint has pitch control, enable it */
-	if (fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL) {
-		data[0] = 1;
-		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-					   UAC_EP_CS_ATTR_PITCH_CONTROL << 8, ep, data, 1, 1000)) < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: cannot set enable PITCH\n",
-				   dev->devnum, iface, ep);
-			return err;
-		}
+	/* if endpoint doesn't have sampling rate control, bail out */
+	if (!(fmt->attributes & UAC_EP_CS_ATTR_SAMPLE_RATE)) {
+		snd_printk(KERN_WARNING "%d:%d:%d: endpoint lacks sample rate attribute bit, cannot set.\n",
+				   dev->devnum, iface, fmt->altsetting);
+		return 0;
+	}
+
+	data[0] = rate;
+	data[1] = rate >> 8;
+	data[2] = rate >> 16;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
+				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
+			   dev->devnum, iface, fmt->altsetting, rate, ep);
+		return err;
 	}
+	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
+				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
+				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
+			   dev->devnum, iface, fmt->altsetting, ep);
+		return 0; /* some devices don't support reading */
+	}
+	crate = data[0] | (data[1] << 8) | (data[2] << 16);
+	if (crate != rate) {
+		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+		// runtime->rate = crate;
+	}
+
 	return 0;
 }
 
-int snd_usb_init_sample_rate(struct usb_device *dev, int iface,
+static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
+			      struct usb_host_interface *alts,
+			      struct audioformat *fmt, int rate)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned char data[4];
+	int err, crate;
+
+	data[0] = rate;
+	data[1] = rate >> 8;
+	data[2] = rate >> 16;
+	data[3] = rate >> 24;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+				   0x0100, chip->clock_id << 8,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
+			   dev->devnum, iface, fmt->altsetting, rate);
+		return err;
+	}
+	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+				   0x0100, chip->clock_id << 8,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
+			   dev->devnum, iface, fmt->altsetting);
+		return err;
+	}
+	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	if (crate != rate)
+		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+
+	return 0;
+}
+
+int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 			     struct usb_host_interface *alts,
 			     struct audioformat *fmt, int rate)
 {
-	unsigned int ep;
-	unsigned char data[3];
-	int err;
+	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
 
-	ep = get_endpoint(alts, 0)->bEndpointAddress;
-	/* if endpoint has sampling rate control, set it */
-	if (fmt->attributes & UAC_EP_CS_ATTR_SAMPLE_RATE) {
-		int crate;
-		data[0] = rate;
-		data[1] = rate >> 8;
-		data[2] = rate >> 16;
-		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-					   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3, 1000)) < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
-				   dev->devnum, iface, fmt->altsetting, rate, ep);
-			return err;
-		}
-		if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
-					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
-					   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3, 1000)) < 0) {
-			snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
-				   dev->devnum, iface, fmt->altsetting, ep);
-			return 0; /* some devices don't support reading */
-		}
-		crate = data[0] | (data[1] << 8) | (data[2] << 16);
-		if (crate != rate) {
-			snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
-			// runtime->rate = crate;
-		}
+	switch (altsd->bInterfaceProtocol) {
+	case UAC_VERSION_1:
+		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
+
+	case UAC_VERSION_2:
+		return set_sample_rate_v2(chip, iface, alts, fmt, rate);
 	}
-	return 0;
+
+	return -EINVAL;
 }
 
 /*
@@ -280,7 +361,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX)
 		subs->fill_max = 1;
 
-	if ((err = snd_usb_init_pitch(dev, subs->interface, alts, fmt)) < 0)
+	if ((err = snd_usb_init_pitch(subs->stream->chip, subs->interface, alts, fmt)) < 0)
 		return err;
 
 	subs->cur_audiofmt = fmt;
@@ -343,7 +424,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		struct usb_interface *iface;
 		iface = usb_ifnum_to_if(subs->dev, fmt->iface);
 		alts = &iface->altsetting[fmt->altset_idx];
-		ret = snd_usb_init_sample_rate(subs->dev, subs->interface, alts, fmt, rate);
+		ret = snd_usb_init_sample_rate(subs->stream->chip, subs->interface, alts, fmt, rate);
 		if (ret < 0)
 			return ret;
 		subs->cur_rate = rate;
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 8585601..1c931b6 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -3,11 +3,11 @@
 
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 
-int snd_usb_init_pitch(struct usb_device *dev, int iface,
+int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
 		       struct audioformat *fmt);
 
-int snd_usb_init_sample_rate(struct usb_device *dev, int iface,
+int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 			     struct usb_host_interface *alts,
 			     struct audioformat *fmt, int rate);
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 99a19ba..0c0b23b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -159,8 +159,8 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 	usb_set_interface(chip->dev, fp->iface, 0);
-	snd_usb_init_pitch(chip->dev, fp->iface, alts, fp);
-	snd_usb_init_sample_rate(chip->dev, fp->iface, alts, fp, fp->rate_max);
+	snd_usb_init_pitch(chip, fp->iface, alts, fp);
+	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
 	return 0;
 }
 
-- 
1.6.6.2
