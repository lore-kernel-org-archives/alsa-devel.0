From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 08/10] ALSA: usb-audio: remove implicit_fb
	from quirk
Date: Fri, 19 Jul 2013 20:23:28 +0200
Message-ID: <1374258210-14486-9-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 02DB32657CE
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:24:03 +0200 (CEST)
Received: by mail-ee0-f47.google.com with SMTP id e49so2509749eek.20
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:24:03 -0700 (PDT)
In-Reply-To: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Since the quirks all apply to implicit feedback, there's no
need to set and check for it later.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c14cb78..9f9639d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -334,7 +334,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 {
 	struct usb_host_interface *alts;
 	struct usb_interface *iface;
-	int implicit_fb = 0;
 	unsigned int ep;
 
 	/* Implicit feedback sync EPs consumers are always playback EPs */
@@ -344,7 +343,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	switch (subs->stream->chip->usb_id) {
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
-		implicit_fb = 1;
 		ep = 0x81;
 		iface = usb_ifnum_to_if(dev, 3);
 
@@ -356,7 +354,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		break;
 	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
 	case USB_ID(0x0763, 0x2081):
-		implicit_fb = 1;
 		ep = 0x81;
 		iface = usb_ifnum_to_if(dev, 2);
 
@@ -374,7 +371,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	    search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
 				      altsd->bAlternateSetting,
 				      &alts, &ep) >= 0) {
-		implicit_fb = 1;
 		goto add_sync_ep;
 	}
 
@@ -384,9 +380,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 add_sync_ep:
 	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 						   alts, ep, !subs->direction,
-						   implicit_fb ?
-							SND_USB_ENDPOINT_TYPE_DATA :
-							SND_USB_ENDPOINT_TYPE_SYNC);
+						   SND_USB_ENDPOINT_TYPE_DATA);
 	if (!subs->sync_endpoint)
 		return -EINVAL;
 
-- 
1.8.1.5
