From: Paul Zimmerman <Paul.Zimmerman-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH V2] sound: usb: USB3 SuperSpeed sound support
Date: Fri, 13 Aug 2010 12:42:07 -0700
Message-ID: <F6C4814A9B336243ABC3D1FB44E08AE8012C3462C1@US01WXMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is V2 of the patch, after feedback from Clemens and Daniel.

This patch adds SuperSpeed support to the USB drivers under sound/. It adds
tests for USB_SPEED_SUPER to the appropriate places that check for the USB
speed.

This patch has been tested with our SS USB3 device emulating a set of Yamaha
speakers and a Logitech microphone, but with the descriptors modified to add
USB3 support. It has also been tested with the real speakers and microphone,
to make sure that USB2 devices still work.

Signed-off-by: Paul Zimmerman <paulz-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
--- 
 sound/usb/card.c   |   31 +++++++++++++++++++++++--------
 sound/usb/helper.c |   17 +++++++++++------
 sound/usb/midi.c   |    9 ++++++++-
 sound/usb/pcm.c    |    4 ++--
 sound/usb/proc.c   |    2 +-
 sound/usb/urb.c    |    2 +-
 6 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7a8ac1d..6c49763 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -299,9 +299,13 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 
 	*rchip = NULL;
 
-	if (snd_usb_get_speed(dev) != USB_SPEED_LOW &&
-	    snd_usb_get_speed(dev) != USB_SPEED_FULL &&
-	    snd_usb_get_speed(dev) != USB_SPEED_HIGH) {
+	switch (snd_usb_get_speed(dev)) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		break;
+	default:
 		snd_printk(KERN_ERR "unknown device speed %d\n", snd_usb_get_speed(dev));
 		return -ENXIO;
 	}
@@ -377,11 +381,22 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	if (len < sizeof(card->longname))
 		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
 
-	strlcat(card->longname,
-		snd_usb_get_speed(dev) == USB_SPEED_LOW ? ", low speed" :
-		snd_usb_get_speed(dev) == USB_SPEED_FULL ? ", full speed" :
-		", high speed",
-		sizeof(card->longname));
+	switch (snd_usb_get_speed(dev)) {
+	case USB_SPEED_LOW:
+		strlcat(card->longname, ", low speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_FULL:
+		strlcat(card->longname, ", full speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_HIGH:
+		strlcat(card->longname, ", high speed", sizeof(card->longname));
+		break;
+	case USB_SPEED_SUPER:
+		strlcat(card->longname, ", super speed", sizeof(card->longname));
+		break;
+	default:
+		break;
+	}
 
 	snd_usb_audio_create_proc(chip);
 
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index d48d6f8..f280c19 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -103,11 +103,16 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 					 struct usb_host_interface *alts)
 {
-	if (snd_usb_get_speed(chip->dev) == USB_SPEED_HIGH &&
-	    get_endpoint(alts, 0)->bInterval >= 1 &&
-	    get_endpoint(alts, 0)->bInterval <= 4)
-		return get_endpoint(alts, 0)->bInterval - 1;
-	else
-		return 0;
+	switch (snd_usb_get_speed(chip->dev)) {
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		if (get_endpoint(alts, 0)->bInterval >= 1 &&
+		    get_endpoint(alts, 0)->bInterval <= 4)
+			return get_endpoint(alts, 0)->bInterval - 1;
+		break;
+	default:
+		break;
+	}
+	return 0;
 }
 
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 4678564..6b42ce6 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -834,7 +834,14 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
 
 	if (!ep->ports[0].active)
 		return;
-	count = snd_usb_get_speed(ep->umidi->dev) == USB_SPEED_HIGH ? 1 : 2;
+	switch (snd_usb_get_speed(ep->umidi->dev)) {
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		count = 1;
+		break;
+	default:
+		count = 2;
+	}
 	count = snd_rawmidi_transmit(ep->ports[0].substream,
 				     urb->transfer_buffer,
 				     count);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4568298..ebd09ac 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -467,7 +467,7 @@ static int hw_check_valid_format(struct snd_usb_substream *subs,
 		return 0;
 	}
 	/* check whether the period time is >= the data packet interval */
-	if (snd_usb_get_speed(subs->dev) == USB_SPEED_HIGH) {
+	if (snd_usb_get_speed(subs->dev) != USB_SPEED_FULL) {
 		ptime = 125 * (1 << fp->datainterval);
 		if (ptime > pt->max || (ptime == pt->max && pt->openmax)) {
 			hwc_debug("   > check: ptime %u > max %u\n", ptime, pt->max);
@@ -735,7 +735,7 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 	}
 
 	param_period_time_if_needed = SNDRV_PCM_HW_PARAM_PERIOD_TIME;
-	if (snd_usb_get_speed(subs->dev) != USB_SPEED_HIGH)
+	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL)
 		/* full speed devices have fixed data packet interval */
 		ptmin = 1000;
 	if (ptmin == 1000)
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index f5e3f35..3c650ab 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -107,7 +107,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 			}
 			snd_iprintf(buffer, "\n");
 		}
-		if (snd_usb_get_speed(subs->dev) == USB_SPEED_HIGH)
+		if (snd_usb_get_speed(subs->dev) != USB_SPEED_FULL)
 			snd_iprintf(buffer, "    Data packet interval: %d us\n",
 				    125 * (1 << fp->datainterval));
 		// snd_iprintf(buffer, "    Max Packet Size = %d\n", fp->maxpacksize);
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index de607d4..8deeaad 100644
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -244,7 +244,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 	else
 		subs->curpacksize = maxsize;
 
-	if (snd_usb_get_speed(subs->dev) == USB_SPEED_HIGH)
+	if (snd_usb_get_speed(subs->dev) != USB_SPEED_FULL)
 		packs_per_ms = 8 >> subs->datainterval;
 	else
 		packs_per_ms = 1;
-- 

Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
