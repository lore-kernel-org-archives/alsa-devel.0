From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: snd-usb: move calls to
	usb_set_interface
Date: Thu, 12 Jul 2012 15:19:47 +0200
Message-ID: <1342099187-6978-2-git-send-email-zonque@gmail.com>
References: <1342099187-6978-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F9272440D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 15:29:22 +0200 (CEST)
In-Reply-To: <1342099187-6978-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, philipp@dreimann.net, joseph.salisbury@canonical.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The rework of the snd-usb endpoint logic moved the calls to
snd_usb_set_interface() into the snd_usb_endpoint implemenation. This
changed the order in which these calls are issued to the device, and
thereby caused regressions for some webcams.

Fix this by moving the calls back to pcm.c for now to make it work again
and use snd_usb_endpoint_activate() to really tear down all remaining
URBs in the flight, consequently fixing another regression caused by USB
packets on the wire after altsetting 0 has been selected.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Philipp Dreimann <philipp@dreimann.net>
Reported-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 sound/usb/endpoint.c |   73 +++++---------------------------------------------
 sound/usb/pcm.c      |   55 ++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 89 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a75bdf4..4bc5778 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -415,7 +415,7 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 {
 	struct list_head *p;
 	struct snd_usb_endpoint *ep;
-	int ret, is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
+	int is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&chip->mutex);
 
@@ -435,16 +435,6 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 		    type == SND_USB_ENDPOINT_TYPE_DATA ? "data" : "sync",
 		    ep_num);
 
-	/* select the alt setting once so the endpoints become valid */
-	ret = usb_set_interface(chip->dev, alts->desc.bInterfaceNumber,
-				alts->desc.bAlternateSetting);
-	if (ret < 0) {
-		snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
-					__func__, ret);
-		ep = NULL;
-		goto __exit_unlock;
-	}
-
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		goto __exit_unlock;
@@ -832,9 +822,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 	if (++ep->use_count != 1)
 		return 0;
 
-	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
-		return -EINVAL;
-
 	/* just to be sure */
 	deactivate_urbs(ep, 0, 1);
 	wait_clear_urbs(ep);
@@ -912,9 +899,6 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 	if (snd_BUG_ON(ep->use_count == 0))
 		return;
 
-	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
-		return;
-
 	if (--ep->use_count == 0) {
 		deactivate_urbs(ep, force, can_sleep);
 		ep->data_subs = NULL;
@@ -928,42 +912,6 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 }
 
 /**
- * snd_usb_endpoint_activate: activate an snd_usb_endpoint
- *
- * @ep: the endpoint to activate
- *
- * If the endpoint is not currently in use, this functions will select the
- * correct alternate interface setting for the interface of this endpoint.
- *
- * In case of any active users, this functions does nothing.
- *
- * Returns an error if usb_set_interface() failed, 0 in all other
- * cases.
- */
-int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
-{
-	if (ep->use_count != 0)
-		return 0;
-
-	if (!ep->chip->shutdown &&
-	    !test_and_set_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
-		int ret;
-
-		ret = usb_set_interface(ep->chip->dev, ep->iface, ep->alt_idx);
-		if (ret < 0) {
-			snd_printk(KERN_ERR "%s() usb_set_interface() failed, ret = %d\n",
-						__func__, ret);
-			clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
-			return ret;
-		}
-
-		return 0;
-	}
-
-	return -EBUSY;
-}
-
-/**
  * snd_usb_endpoint_deactivate: deactivate an snd_usb_endpoint
  *
  * @ep: the endpoint to deactivate
@@ -981,24 +929,15 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 	if (!ep)
 		return -EINVAL;
 
+	deactivate_urbs(ep, 1, 1);
+	wait_clear_urbs(ep);
+
 	if (ep->use_count != 0)
 		return 0;
 
-	if (!ep->chip->shutdown &&
-	    test_and_clear_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
-		int ret;
-
-		ret = usb_set_interface(ep->chip->dev, ep->iface, 0);
-		if (ret < 0) {
-			snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
-						__func__, ret);
-			return ret;
-		}
+	clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
 
-		return 0;
-	}
-
-	return -EBUSY;
+	return 0;
 }
 
 /**
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f0ede13..26778a9 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -261,19 +261,6 @@ static void stop_endpoints(struct snd_usb_substream *subs,
 				      force, can_sleep, wait);
 }
 
-static int activate_endpoints(struct snd_usb_substream *subs)
-{
-	if (subs->sync_endpoint) {
-		int ret;
-
-		ret = snd_usb_endpoint_activate(subs->sync_endpoint);
-		if (ret < 0)
-			return ret;
-	}
-
-	return snd_usb_endpoint_activate(subs->data_endpoint);
-}
-
 static int deactivate_endpoints(struct snd_usb_substream *subs)
 {
 	int reta, retb;
@@ -314,6 +301,31 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt == subs->cur_audiofmt)
 		return 0;
 
+        /* close the old interface */
+        if (subs->interface >= 0 && subs->interface != fmt->iface) {
+                err = usb_set_interface(subs->dev, subs->interface, 0);
+		if (err < 0) {
+                        snd_printk(KERN_ERR "%d:%d:%d: return to setting 0 failed (%d)\n",
+                                dev->devnum, fmt->iface, fmt->altsetting, err);
+                        return -EIO;
+                }
+                subs->interface = -1;
+                subs->altset_idx = 0;
+        }
+
+        /* set interface */
+        if (subs->interface != fmt->iface || subs->altset_idx != fmt->altset_idx) {
+                err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+		if (err < 0) {
+                        snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
+                                   dev->devnum, fmt->iface, fmt->altsetting, err);
+                        return -EIO;
+                }
+                snd_printdd(KERN_INFO "setting usb interface %d:%d\n", fmt->iface, fmt->altsetting);
+                subs->interface = fmt->iface;
+                subs->altset_idx = fmt->altset_idx;
+        }
+
 	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 						   alts, fmt->endpoint, subs->direction,
 						   SND_USB_ENDPOINT_TYPE_DATA);
@@ -460,12 +472,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		mutex_lock(&subs->stream->chip->shutdown_mutex);
 		/* format changed */
 		stop_endpoints(subs, 0, 0, 0);
-		deactivate_endpoints(subs);
-
-		ret = activate_endpoints(subs);
-		if (ret < 0)
-			goto unlock;
-
 		ret = snd_usb_endpoint_set_params(subs->data_endpoint, hw_params, fmt,
 						  subs->sync_endpoint);
 		if (ret < 0)
@@ -500,6 +506,7 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	subs->period_bytes = 0;
 	mutex_lock(&subs->stream->chip->shutdown_mutex);
 	stop_endpoints(subs, 0, 1, 1);
+	deactivate_endpoints(subs);
 	mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
@@ -938,16 +945,20 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 
 static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 {
-	int ret;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
 
 	stop_endpoints(subs, 0, 0, 0);
-	ret = deactivate_endpoints(subs);
+
+        if (!as->chip->shutdown && subs->interface >= 0) {
+                usb_set_interface(subs->dev, subs->interface, 0);
+                subs->interface = -1;
+        }
+
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
 
-	return ret;
+	return 0;
 }
 
 /* Since a URB can handle only a single linear buffer, we must use double
-- 
1.7.10.4
