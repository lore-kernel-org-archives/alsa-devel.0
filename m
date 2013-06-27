From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/7] ALSA: usb-audio: detect implicit feedback
	on Roland devices
Date: Thu, 27 Jun 2013 22:18:31 +0200
Message-ID: <51CC9E17.2040102@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B7E02265665
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:17:36 +0200 (CEST)
In-Reply-To: <51CC9D8B.7060601@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

All the Roland/Edirol/BOSS USB audio devices that need implicit feedback
show this unambiguously in their descriptors, so it might be a good idea
to let the driver detect this.

This should make playback work correctly (at least with Jack) with the
following devices:
- BOSS GT-100
- BOSS JS-8 Jam Station
- Edirol M-16DX
- Roland GAIA SH-01

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/pcm.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 776c58c..15b151e 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -298,6 +298,35 @@ static int deactivate_endpoints(struct snd_usb_substream *subs)
 	return 0;
 }

+static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
+				     unsigned int altsetting,
+				     struct usb_host_interface **alts,
+				     unsigned int *ep)
+{
+	struct usb_interface *iface;
+	struct usb_interface_descriptor *altsd;
+	struct usb_endpoint_descriptor *epd;
+
+	iface = usb_ifnum_to_if(dev, ifnum);
+	if (!iface || iface->num_altsetting < altsetting + 1)
+		return -ENOENT;
+	*alts = &iface->altsetting[altsetting];
+	altsd = get_iface_desc(*alts);
+	if (altsd->bAlternateSetting != altsetting ||
+	    altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC ||
+	    (altsd->bInterfaceSubClass != 2 &&
+	     altsd->bInterfaceProtocol != 2   ) ||
+	    altsd->bNumEndpoints < 1)
+		return -ENOENT;
+	epd = get_endpoint(*alts, 0);
+	if (!usb_endpoint_is_isoc_in(epd) ||
+	    (epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
+					USB_ENDPOINT_USAGE_IMPLICIT_FB)
+		return -ENOENT;
+	*ep = epd->bEndpointAddress;
+	return 0;
+}
+
 /*
  * find a matching format and set up the interface
  */
@@ -393,6 +422,18 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 			goto add_sync_ep;
 		}
 	}
+	if (is_playback &&
+	    attr == USB_ENDPOINT_SYNC_ASYNC &&
+	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+	    altsd->bInterfaceProtocol == 2 &&
+	    altsd->bNumEndpoints == 1 &&
+	    USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582 /* Roland */ &&
+	    search_roland_implicit_fb(dev, altsd->bInterfaceNumber + 1,
+				      altsd->bAlternateSetting,
+				      &alts, &ep) >= 0) {
+		implicit_fb = 1;
+		goto add_sync_ep;
+	}

 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
