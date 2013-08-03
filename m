From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 3/9] ALSA: usb-audio: separate sync endpoint
	setting from set_format
Date: Sat,  3 Aug 2013 10:50:17 +0200
Message-ID: <1375519823-25718-4-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B57F2617B4
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:39 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id ji2so453493bkc.24
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:39 -0700 (PDT)
In-Reply-To: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Setting the sync endpoint currently takes up about half of set_format().
Move it to a dedicated function.
No functional change.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 128 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 55 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index be5c7c2..e24ce7d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -327,64 +327,17 @@ static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
 	return 0;
 }
 
-/*
- * find a matching format and set up the interface
- */
-static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
+
+static int set_sync_endpoint(struct snd_usb_substream *subs,
+			     struct audioformat *fmt,
+			     struct usb_device *dev,
+			     struct usb_host_interface *alts,
+			     struct usb_interface_descriptor *altsd)
 {
-	struct usb_device *dev = subs->dev;
-	struct usb_host_interface *alts;
-	struct usb_interface_descriptor *altsd;
 	struct usb_interface *iface;
-	unsigned int ep, attr;
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
-	int err, implicit_fb = 0;
-
-	iface = usb_ifnum_to_if(dev, fmt->iface);
-	if (WARN_ON(!iface))
-		return -EINVAL;
-	alts = &iface->altsetting[fmt->altset_idx];
-	altsd = get_iface_desc(alts);
-	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
-		return -EINVAL;
-
-	if (fmt == subs->cur_audiofmt)
-		return 0;
-
-	/* close the old interface */
-	if (subs->interface >= 0 && subs->interface != fmt->iface) {
-		err = usb_set_interface(subs->dev, subs->interface, 0);
-		if (err < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: return to setting 0 failed (%d)\n",
-				dev->devnum, fmt->iface, fmt->altsetting, err);
-			return -EIO;
-		}
-		subs->interface = -1;
-		subs->altset_idx = 0;
-	}
-
-	/* set interface */
-	if (subs->interface != fmt->iface ||
-	    subs->altset_idx != fmt->altset_idx) {
-		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
-		if (err < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
-				   dev->devnum, fmt->iface, fmt->altsetting, err);
-			return -EIO;
-		}
-		snd_printdd(KERN_INFO "setting usb interface %d:%d\n",
-				fmt->iface, fmt->altsetting);
-		subs->interface = fmt->iface;
-		subs->altset_idx = fmt->altset_idx;
-
-		snd_usb_set_interface_quirk(dev);
-	}
-
-	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
-						   alts, fmt->endpoint, subs->direction,
-						   SND_USB_ENDPOINT_TYPE_DATA);
-	if (!subs->data_endpoint)
-		return -EINVAL;
+	unsigned int ep, attr;
+	int implicit_fb = 0;
 
 	/* we need a sync pipe in async OUT or adaptive IN mode */
 	/* check the number of EP, since some devices have broken
@@ -479,6 +432,71 @@ add_sync_ep:
 		subs->data_endpoint->sync_master = subs->sync_endpoint;
 	}
 
+	return 0;
+}
+
+/*
+ * find a matching format and set up the interface
+ */
+static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
+{
+	struct usb_device *dev = subs->dev;
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct usb_interface *iface;
+	int err;
+
+	iface = usb_ifnum_to_if(dev, fmt->iface);
+	if (WARN_ON(!iface))
+		return -EINVAL;
+	alts = &iface->altsetting[fmt->altset_idx];
+	altsd = get_iface_desc(alts);
+	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
+		return -EINVAL;
+
+	if (fmt == subs->cur_audiofmt)
+		return 0;
+
+	/* close the old interface */
+	if (subs->interface >= 0 && subs->interface != fmt->iface) {
+		err = usb_set_interface(subs->dev, subs->interface, 0);
+		if (err < 0) {
+			snd_printk(KERN_ERR "%d:%d:%d: return to setting 0 failed (%d)\n",
+				dev->devnum, fmt->iface, fmt->altsetting, err);
+			return -EIO;
+		}
+		subs->interface = -1;
+		subs->altset_idx = 0;
+	}
+
+	/* set interface */
+	if (subs->interface != fmt->iface ||
+	    subs->altset_idx != fmt->altset_idx) {
+		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+		if (err < 0) {
+			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
+				   dev->devnum, fmt->iface, fmt->altsetting, err);
+			return -EIO;
+		}
+		snd_printdd(KERN_INFO "setting usb interface %d:%d\n",
+				fmt->iface, fmt->altsetting);
+		subs->interface = fmt->iface;
+		subs->altset_idx = fmt->altset_idx;
+
+		snd_usb_set_interface_quirk(dev);
+	}
+
+	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+						   alts, fmt->endpoint, subs->direction,
+						   SND_USB_ENDPOINT_TYPE_DATA);
+
+	if (!subs->data_endpoint)
+		return -EINVAL;
+
+	err = set_sync_endpoint(subs, fmt, dev, alts, altsd);
+	if (err < 0)
+		return err;
+
 	err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt);
 	if (err < 0)
 		return err;
-- 
1.8.1.5
