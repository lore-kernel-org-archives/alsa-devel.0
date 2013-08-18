From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 7/9] ALSA: usb-audio: conditional interface
	altsetting
Date: Sun, 18 Aug 2013 22:22:41 +0200
Message-ID: <1376857363-1116-8-git-send-email-eldad@fogrefinery.com>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A7426168B
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:23:21 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id my10so1235709bkb.1
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:23:20 -0700 (PDT)
In-Reply-To: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

On some devices, if the endpoint for the other direction is in use,
setting one interface will shutdown the other (in use) endpoint.
This patch moves all of the alternate setting operations for pcm
ops to one function which checks if we can do so.

If current alternate is 0, it is safe to set.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
This patch needs revising. It adds a get_interface function, which
should not be neccesary (possibly unreliable on some devices?).
---
 sound/usb/pcm.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b610231..ff74e89 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -216,6 +216,69 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
+static int get_interface(struct usb_device *dev, int ifnum)
+{
+	int ret;
+	char buf;
+	struct usb_interface *iface = usb_ifnum_to_if(dev, ifnum);
+	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
+			      0, iface->altsetting[0].desc.bInterfaceNumber,
+			      &buf, sizeof(buf), USB_CTRL_GET_TIMEOUT);
+
+	if (ret == sizeof(buf))
+		return buf;
+
+	return -ERANGE;
+}
+
+static int subs_set_interface(struct snd_usb_substream *subs, int ifnum,
+			      int altset_idx)
+{
+	struct snd_usb_substream *other_subs =
+		&subs->stream->substream[subs->direction ^ 1];
+	int err;
+
+	snd_printdd(KERN_DEBUG "%s: set interface ifnum %d altset_idx %d\n", __func__, ifnum, altset_idx);
+
+	if (subs == NULL)
+		return usb_set_interface(subs->dev, ifnum, altset_idx);
+
+	if (other_subs->data_endpoint && other_subs->data_endpoint->use_count != 0) {
+		int cur_altset_idx = get_interface(subs->dev, ifnum);
+
+		snd_printdd(KERN_DEBUG "%s: set interface (cur %d) ifnum %d altset_idx %d\n", __func__,
+			cur_altset_idx, ifnum, altset_idx);
+
+		if (cur_altset_idx == altset_idx)
+			return 0;
+
+		if (cur_altset_idx > 0 && altset_idx == 0)
+			return 0;
+	}
+
+	err = usb_set_interface(subs->dev, ifnum, altset_idx);
+	snd_printdd(KERN_DEBUG "%s: set interface ifnum %d altset_idx %d err %d\n", __func__, ifnum, altset_idx, err);
+	if (err < 0)
+		return err;
+
+	subs->interface = altset_idx == 0 ? -1 : ifnum;
+	subs->altset_idx = altset_idx;
+
+	return 0;
+}
+
+int snd_usb_set_interface(struct snd_usb_substream *subs, int ifnum,
+			  int altset_idx)
+{
+	return subs_set_interface(subs, ifnum, altset_idx);
+}
+
+int snd_usb_close_interface(struct snd_usb_substream *subs, int ifnum)
+{
+	return subs_set_interface(subs, ifnum, 0);
+}
+
 static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 {
 	int err;
@@ -242,9 +305,9 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 
 		if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
 		    subs->data_endpoint->alt_idx != subs->sync_endpoint->alt_idx) {
-			err = usb_set_interface(subs->dev,
-						subs->sync_endpoint->iface,
-						subs->sync_endpoint->alt_idx);
+			err = snd_usb_set_interface(subs,
+						    subs->sync_endpoint->iface,
+						    subs->sync_endpoint->alt_idx);
 			if (err < 0) {
 				clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 				snd_printk(KERN_ERR
@@ -338,20 +401,18 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
 	/* close the old interface */
 	if (subs->interface >= 0 && subs->interface != fmt->iface) {
-		err = usb_set_interface(subs->dev, subs->interface, 0);
+		err = snd_usb_close_interface(subs, subs->interface);
 		if (err < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: return to setting 0 failed (%d)\n",
 				dev->devnum, fmt->iface, fmt->altsetting, err);
 			return -EIO;
 		}
-		subs->interface = -1;
-		subs->altset_idx = 0;
 	}
 
 	/* set interface */
 	if (subs->interface != fmt->iface ||
 	    subs->altset_idx != fmt->altset_idx) {
-		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+		err = snd_usb_set_interface(subs, fmt->iface, fmt->altsetting);
 		if (err < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
 				   dev->devnum, fmt->iface, fmt->altsetting, err);
@@ -359,8 +420,6 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		snd_printdd(KERN_INFO "setting usb interface %d:%d\n",
 				fmt->iface, fmt->altsetting);
-		subs->interface = fmt->iface;
-		subs->altset_idx = fmt->altset_idx;
 
 		snd_usb_set_interface_quirk(dev);
 	}
@@ -1163,7 +1222,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 	stop_endpoints(subs, true);
 
 	if (!as->chip->shutdown && subs->interface >= 0) {
-		usb_set_interface(subs->dev, subs->interface, 0);
+		snd_usb_close_interface(subs, subs->interface);
 		subs->interface = -1;
 	}
 
-- 
1.8.1.5
