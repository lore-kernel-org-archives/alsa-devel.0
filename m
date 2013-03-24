From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Sun, 24 Mar 2013 23:49:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303242323480.5410@xoschi>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BEC32615D1
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 23:50:01 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id ik5so341423bkc.6
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 15:50:00 -0700 (PDT)
In-Reply-To: <5112B969.50905@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

On Wed, 6 Feb 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > On Tue, 5 Feb 2013, Clemens Ladisch wrote:
> >> I thought I'd try to use implicit feedback with my simple audio device:
> >> [...]
> >> This works fine when playing something:
> > ...
> >> But when I then try to record at the same time, the driver refuses to
> >> configure the input endpoint (to the only format, which is already set):
> >> And despite that "alreay in use" check, the input endpoint is affected
> >> so much that playback breaks.
> >>
> >> Is full duplex supposed to work?  Does it work with other devices?
> >
> > This is probably a "yes, but" :)
> > I use my device mostly full duplex, but with jack opening both
> > playback and capture at the same time.
> >
> > I assume you are opening two different streams, one for playback and
> > one for capture.
> 
> Jack *also* uses two different streams, but it opens them at the same
> time.
> 
> > Can you try using jackd -d alsa -d hw:x with the device and see if that
> > works for you?
> 
> That works.  This means that there is a race condition in the driver, or
> that the different open/hw_params/prepare order trips it up.

Yes, and also on closing (close/hw_free).
I finally had some time to look into this - patch below adds some 
checks and with it:
    
* Starting playback, waiting, starting capture: capture doesn't start,
  playback continues without breaking.
    
* Starting capture, waiting, starting playback: playback doesn't start,
  capture breaks - but it is possible to restart the streams afterwards.
  [On my setup (with xhci), when the streams break I must restart my box
  to get them to work again with current code].

* Starting both - no change, works good.

This is the order the ops get called when both are start at once, if it 
helps anyone:

playback	capture
open
		open
		hw_params
		 set_format
 		prepare
 		 set_format
hw_params
 set_format
prepare
 set_format
prepare
 set_format
		prepare
		 set_format
 trigger
		trigger

I'll try to figure out why capture breaks next.
I still quite slow around the code and don't understand some parts of 
it so this might take me a while.

@Daniel, do you have any hints for this case (capture breaking
when starting playback)?

I can also submit this as a proper patch if it makes sense.

Cheers,
Eldad
    
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 7e9c55a..7cdf9b3 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -934,12 +934,12 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 	if (!ep)
 		return -EINVAL;
 
-	deactivate_urbs(ep, true);
-	wait_clear_urbs(ep);
-
 	if (ep->use_count != 0)
 		return 0;
 
+	deactivate_urbs(ep, true);
+	wait_clear_urbs(ep);
+
 	clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
 
 	return 0;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9531355..76d7e18 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -323,6 +323,19 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt == subs->cur_audiofmt)
 		return 0;
 
+	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+						   alts, fmt->endpoint, subs->direction,
+						   SND_USB_ENDPOINT_TYPE_DATA);
+	if (!subs->data_endpoint)
+		return -EINVAL;
+
+	if (subs->data_endpoint->use_count != 0) {
+		snd_printk("set_format ep use count !0\n");
+		subs->cur_audiofmt = fmt;
+		snd_usb_set_format_quirk(subs, fmt);
+		return 0;
+	}
+
 	/* close the old interface */
 	if (subs->interface >= 0 && subs->interface != fmt->iface) {
 		err = usb_set_interface(subs->dev, subs->interface, 0);
@@ -350,12 +363,6 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		subs->altset_idx = fmt->altset_idx;
 	}
 
-	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
-						   alts, fmt->endpoint, subs->direction,
-						   SND_USB_ENDPOINT_TYPE_DATA);
-	if (!subs->data_endpoint)
-		return -EINVAL;
-
 	/* we need a sync pipe in async OUT or adaptive IN mode */
 	/* check the number of EP, since some devices have broken
 	 * descriptors which fool us.  if it has only one EP,
@@ -1128,7 +1135,8 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 
 	stop_endpoints(subs, true);
 
-	if (!as->chip->shutdown && subs->interface >= 0) {
+	if (!as->chip->shutdown && subs->interface >= 0 &&
+	    subs->data_endpoint->use_count == 0) {
 		usb_set_interface(subs->dev, subs->interface, 0);
 		subs->interface = -1;
 	}
 
