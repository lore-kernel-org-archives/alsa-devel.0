From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH 2/2] Signed-off-by: Jurgen Kramer
	<gtmkramer@xs4all.nl>
Date: Fri, 28 Nov 2014 13:31:10 +0100
Message-ID: <1417177870-5844-3-git-send-email-gtmkramer@xs4all.nl>
References: <1417177870-5844-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud3.xs4all.net (lb2-smtp-cloud3.xs4all.net
 [194.109.24.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CBFD26047B
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 13:31:30 +0100 (CET)
In-Reply-To: <1417177870-5844-1-git-send-email-gtmkramer@xs4all.nl>
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

add mode select quirk for Denon/Marantz DACs

Denon/Marantz USB DACs need a specific vendor command to switch between PCM and
DSD mode. This patch adds a new quirk function to switch between the two modes
using the specific USB vendor command.

This patch applies to the following devices:
- Marantz SA-14S1
- Marantz HD-DAC1

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/pcm.c    |  6 ++++++
 sound/usb/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.h |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c62a165..7529679 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -482,6 +482,12 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	/* set interface */
 	if (subs->interface != fmt->iface ||
 	    subs->altset_idx != fmt->altset_idx) {
+
+		err = snd_usb_select_mode_quirk(subs, fmt);
+		if (err < 0) {
+			return -EIO;
+		}
+
 		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
 		if (err < 0) {
 			dev_err(&dev->dev,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cc07388..8fb0936 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1111,6 +1111,48 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	}
 }
 
+
+/* Marantz/Denon USB DACs need a vendor cmd to switch
+ * between PCM and native DSD mode */
+int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
+			      struct audioformat *fmt)
+{
+	struct usb_device *dev = subs->dev;
+	int err;
+
+	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
+	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+
+		/* First switch to alt set 0, otherwise the mode switch cmd
+		 * will not be accepted by the DAC */
+		err = usb_set_interface(dev, fmt->iface, 0);
+		if (err < 0)
+			return err;
+
+		mdelay(20); /* Delay needed after setting the interface */
+
+		switch(fmt->altsetting) {
+		case 2: /* DSD mode requested */
+			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
+					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+					      1, 1, NULL, 0);
+			if (err < 0)
+				return err;
+			break;
+		case 1: /* PCM mode requested */
+			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
+					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+					      0, 1, NULL, 0);
+			if (err > 0)
+				return err;
+			break;
+		}
+		mdelay(20);
+	}
+	return 0;
+}
+
 void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 {
 	/*
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 665e972..1b86238 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -31,6 +31,9 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
 
+int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
+			      struct audioformat *fmt);
+
 u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 					struct audioformat *fp,
 					unsigned int sample_bytes);
-- 
1.9.3
