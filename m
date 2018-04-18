From: Alberto Aguirre <albaguirre@gmail.com>
Subject: [PATCH 1/2] ALSA: usb-audio: simplify
	set_sync_ep_implicit_fb_quirk
Date: Wed, 18 Apr 2018 09:35:34 -0500
Message-ID: <20180418143535.11097-2-albaguirre@gmail.com>
References: <20180418143535.11097-1-albaguirre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id A91B0267650
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 16:35:44 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so1772923oih.8
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 07:35:44 -0700 (PDT)
In-Reply-To: <20180418143535.11097-1-albaguirre@gmail.com>
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
Cc: Alberto Aguirre <albaguirre@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alberto Aguirre <albaguirre@gmail.com>
---
 sound/usb/pcm.c | 52 ++++++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 3cbfae6604f9..c0746cc20ac4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -321,6 +321,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	struct usb_host_interface *alts;
 	struct usb_interface *iface;
 	unsigned int ep;
+	unsigned int ifnum;
 
 	/* Implicit feedback sync EPs consumers are always playback EPs */
 	if (subs->direction != SNDRV_PCM_STREAM_PLAYBACK)
@@ -330,44 +331,23 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
 		ep = 0x81;
-		iface = usb_ifnum_to_if(dev, 3);
-
-		if (!iface || iface->num_altsetting == 0)
-			return -EINVAL;
-
-		alts = &iface->altsetting[1];
-		goto add_sync_ep;
-		break;
+		ifnum = 3;
+		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
 	case USB_ID(0x0763, 0x2081):
 		ep = 0x81;
-		iface = usb_ifnum_to_if(dev, 2);
-
-		if (!iface || iface->num_altsetting == 0)
-			return -EINVAL;
-
-		alts = &iface->altsetting[1];
-		goto add_sync_ep;
-	case USB_ID(0x2466, 0x8003):
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x2466, 0x8003): /* Fractal Audio Axe-Fx II */
 		ep = 0x86;
-		iface = usb_ifnum_to_if(dev, 2);
-
-		if (!iface || iface->num_altsetting == 0)
-			return -EINVAL;
-
-		alts = &iface->altsetting[1];
-		goto add_sync_ep;
-	case USB_ID(0x1397, 0x0002):
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x1397, 0x0002): /* Behringer UFX1204 */
 		ep = 0x81;
-		iface = usb_ifnum_to_if(dev, 1);
-
-		if (!iface || iface->num_altsetting == 0)
-			return -EINVAL;
-
-		alts = &iface->altsetting[1];
-		goto add_sync_ep;
-
+		ifnum = 1;
+		goto add_sync_ep_from_ifnum;
 	}
+
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
 	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
 	    altsd->bInterfaceProtocol == 2 &&
@@ -382,6 +362,14 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	/* No quirk */
 	return 0;
 
+add_sync_ep_from_ifnum:
+	iface = usb_ifnum_to_if(dev, ifnum);
+
+	if (!iface || iface->num_altsetting == 0)
+		return -EINVAL;
+
+	alts = &iface->altsetting[1];
+
 add_sync_ep:
 	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 						   alts, ep, !subs->direction,
-- 
2.14.1
