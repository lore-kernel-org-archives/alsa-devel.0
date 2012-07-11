From: Daniel Mack <zonque@gmail.com>
Subject: Re: Regression in sound/usb/
Date: Thu, 12 Jul 2012 01:10:39 +0200
Message-ID: <4FFE07EF.6070900@gmail.com>
References: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
	<4FF18FCF.6020306@gmail.com>
	<CADYPuQ5RFJAaFDpT+4XM-JDWzDO5czVAU3A++_HVHjhN=VBhvQ@mail.gmail.com>
	<s5hvci55l68.wl%tiwai@suse.de>
	<CADYPuQ4Uj8pq9nZOJemY9kZtSrG-WfG4s90b+a00_KteJXU_Sg@mail.gmail.com>
	<s5hr4st5jx1.wl%tiwai@suse.de>
	<CADYPuQ6DT4=NW2tzCLrKYnUHQ6p5qONZjY8PeKq-Z4HAk68tpw@mail.gmail.com>
	<s5hk3yl5ibt.wl%tiwai@suse.de> <s5hhatmjmna.wl%tiwai@suse.de>
	<CADYPuQ7yWpnPSvoVQDV+EyJfC39MDxhP9r5Jiqk_Jh8g65Xd4g@mail.gmail.com>
	<s5h8vey43ve.wl%tiwai@suse.de> <4FFC9B4F.6060600@gmail.com>
	<CADYPuQ6XRSAxKvctCr3FrJ71smk-xOEMF_5VAv-6F5gdM7dwuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020107050408050906020606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 53C6524697
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 01:10:44 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1274989bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2012 16:10:44 -0700 (PDT)
In-Reply-To: <CADYPuQ6XRSAxKvctCr3FrJ71smk-xOEMF_5VAv-6F5gdM7dwuQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Dreimann <philipp@dreimann.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020107050408050906020606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11.07.2012 09:30, Philipp Dreimann wrote:

> The camera is now working for a short time:
> [   56.421399] usb 2-1.2: new high-speed USB device number 4 using ehci_hcd
> [   57.224234] uvcvideo: Found UVC 1.00 device <unnamed> (046d:0821)
> [   57.237221] input: UVC Camera (046d:0821) as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/input/input15
> Camera and microphone are working. Some time later we're back to the old issue:

So I found the reason for this breakage now. It's about orphaned packets
that are sent over the wire after alt setting 0 has been selected. The
chipset doesn't like these at and bails out with protocol errors. Fixing
this involves some rework of the logic. The patch is unfortunately a
little big, but I see no option than getting it merged for 3.6.

Everyone, please test - and sorry for the trouble caused.


Thanks,
Daniel

--------------020107050408050906020606
Content-Type: text/x-patch;
 name="snd-usb-endpoint-fixups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="snd-usb-endpoint-fixups.diff"

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e690690..4bc5778 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -350,7 +350,8 @@ static void snd_complete_urb(struct urb *urb)
 		     urb->status == -ENODEV ||		/* device removed */
 		     urb->status == -ECONNRESET ||	/* unlinked */
 		     urb->status == -ESHUTDOWN ||	/* device disabled */
-		     ep->chip->shutdown))		/* device disconnected */
+		     ep->chip->shutdown) ||		/* device disconnected */
+		     !test_bit(EP_FLAG_RUNNING, &ep->flags))
 		goto exit_clear;
 
 	if (usb_pipeout(ep->pipe)) {
@@ -414,7 +415,7 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 {
 	struct list_head *p;
 	struct snd_usb_endpoint *ep;
-	int ret, is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
+	int is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&chip->mutex);
 
@@ -434,16 +435,6 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
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
@@ -522,13 +513,13 @@ static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int can_sleep
 	unsigned int i;
 	int async;
 
+	clear_bit(EP_FLAG_RUNNING, &ep->flags);
+
 	if (!force && ep->chip->shutdown) /* to be sure... */
 		return -EBADFD;
 
 	async = !can_sleep && ep->chip->async_unlink;
 
-	clear_bit(EP_FLAG_RUNNING, &ep->flags);
-
 	INIT_LIST_HEAD(&ep->ready_playback_urbs);
 	ep->next_packet_read_pos = 0;
 	ep->next_packet_write_pos = 0;
@@ -831,9 +822,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 	if (++ep->use_count != 1)
 		return 0;
 
-	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
-		return -EINVAL;
-
 	/* just to be sure */
 	deactivate_urbs(ep, 0, 1);
 	wait_clear_urbs(ep);
@@ -911,9 +899,6 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 	if (snd_BUG_ON(ep->use_count == 0))
 		return;
 
-	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
-		return;
-
 	if (--ep->use_count == 0) {
 		deactivate_urbs(ep, force, can_sleep);
 		ep->data_subs = NULL;
@@ -927,42 +912,6 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
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
@@ -980,24 +929,15 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
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
index 54607f8..536b706 100644
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

--------------020107050408050906020606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020107050408050906020606--
