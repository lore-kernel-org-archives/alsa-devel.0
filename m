From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 10/10] ALSA: usb-audio: check alts is not
	NULL before adding ep
Date: Fri, 19 Jul 2013 20:23:30 +0200
Message-ID: <1374258210-14486-11-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 9714D2657EB
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:24:11 +0200 (CEST)
Received: by mail-ee0-f42.google.com with SMTP id c4so2522666eek.15
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:24:11 -0700 (PDT)
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

snd_usb_add_endpoint assumes alts is not NULL. Before passing alts,
check if it is the case (for future-proofing).
Since it is also an indication that a quirk is needed, remove the
redundant goto statements.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0704823..e70f70b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -332,7 +332,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 					 struct usb_interface_descriptor *altsd,
 					 unsigned int attr)
 {
-	struct usb_host_interface *alts;
+	struct usb_host_interface *alts = NULL;
 	struct usb_interface *iface;
 	unsigned int ep;
 
@@ -350,7 +350,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 			return -EINVAL;
 
 		alts = &iface->altsetting[1];
-		goto add_sync_ep;
 		break;
 	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
 	case USB_ID(0x0763, 0x2081):
@@ -361,7 +360,6 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 			return -EINVAL;
 
 		alts = &iface->altsetting[1];
-		goto add_sync_ep;
 	}
 
 	if (USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582) { /* Roland */
@@ -374,15 +372,13 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 						        &alts, &ep);
 			if (err < 0)
 				return err;
-
-			goto add_sync_ep;
 		}
 	}
 
 	/* No quirk */
-	return 0;
+	if (alts == NULL)
+		return 0;
 
-add_sync_ep:
 	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 						   alts, ep, !subs->direction,
 						   SND_USB_ENDPOINT_TYPE_DATA);
-- 
1.8.1.5
