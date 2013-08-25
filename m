From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 08/11] ALSA: usb-audio: conditional
	interface altsetting
Date: Sun, 25 Aug 2013 17:45:52 +0200
Message-ID: <1377445555-5923-3-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A06552619DF
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:46:09 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id mz13so785361bkb.2
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:46:09 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

On some devices, if the endpoint for the other direction is in use,
setting one interface will shutdown the other (in use) endpoint.
This patch moves all of the alternate setting operations for pcm
ops to one function which checks if we can do so.

If current alternate is 0, it is safe to set.

Thanks to Clemens Ladisch for pointing out that cur_altsetting
in usb_interface can be used to determine the current altsetting
index as well as the correct naming convention for the altsetting
number.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
v2:
* Removed get_interface usage.
* Fixed NULL dereference for explicit feedback - now other_subs will
  be set only after testing that subs is not NULL.
v3:
* Changed "altset_idx" to "altsetting".
---
 sound/usb/pcm.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ef9664f..a1332d0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -216,6 +216,71 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
+static int get_cur_altsetting(struct usb_device *dev, int ifnum)
+{
+	struct usb_interface *iface;
+	struct usb_interface_descriptor *altsd;
+
+	if (ifnum == -1)
+		return 0;
+
+	iface = usb_ifnum_to_if(dev, ifnum);
+	if (!iface)
+		return -EINVAL;
+
+	if (!iface->cur_altsetting)
+		return -EINVAL;
+	altsd = &(iface->cur_altsetting->desc);
+
+	return altsd->bAlternateSetting;
+}
+
+static int subs_set_interface(struct snd_usb_substream *subs, int ifnum,
+			      int altsetting)
+{
+	struct snd_usb_substream *other_subs;
+	int err;
+
+	snd_printdd(KERN_DEBUG "%s: Requested set interface %d alts %d\n",
+		    __func__, ifnum, altsetting);
+
+	if (subs == NULL)
+		return usb_set_interface(subs->dev, ifnum, altsetting);
+	other_subs = &(subs->stream->substream[subs->direction ^ 1]);
+
+	if (other_subs->data_endpoint &&
+	    other_subs->data_endpoint->use_count != 0) {
+		int cur_altsetting = get_cur_altsetting(subs->dev, ifnum);
+
+		if (cur_altsetting == altsetting)
+			return 0;
+
+		if (cur_altsetting > 0 && altsetting == 0)
+			return 0;
+	}
+
+	err = usb_set_interface(subs->dev, ifnum, altsetting);
+	snd_printdd(KERN_DEBUG "%s: Interface %d alts set to %d (err %d)\n",
+		    __func__, ifnum, altsetting, err);
+	if (err < 0)
+		return err;
+
+	subs->interface = altsetting == 0 ? -1 : ifnum;
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
@@ -242,9 +307,9 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 
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
@@ -467,20 +532,19 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
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
 		subs->altset_idx = 0;
 	}
 
 	/* set interface */
 	if (subs->interface != fmt->iface ||
 	    subs->altset_idx != fmt->altset_idx) {
-		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+		err = snd_usb_set_interface(subs, fmt->iface, fmt->altsetting);
 		if (err < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
 				   dev->devnum, fmt->iface, fmt->altsetting, err);
@@ -488,7 +552,6 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		snd_printdd(KERN_INFO "setting usb interface %d:%d\n",
 				fmt->iface, fmt->altsetting);
-		subs->interface = fmt->iface;
 		subs->altset_idx = fmt->altset_idx;
 
 		snd_usb_set_interface_quirk(dev);
@@ -1196,7 +1259,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 	stop_endpoints(subs, true);
 
 	if (!as->chip->shutdown && subs->interface >= 0) {
-		usb_set_interface(subs->dev, subs->interface, 0);
+		snd_usb_close_interface(subs, subs->interface);
 		subs->interface = -1;
 	}
 
-- 
1.8.1.5
