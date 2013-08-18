From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 9/9] ALSA: usb-audio: correct ep use_count
	semantics (add set_param flag)
Date: Sun, 18 Aug 2013 22:25:54 +0200
Message-ID: <1376857554-1303-2-git-send-email-eldad@fogrefinery.com>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
 <1376857554-1303-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D74592619D6
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:26:07 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so1158756bkb.21
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:26:07 -0700 (PDT)
In-Reply-To: <1376857554-1303-1-git-send-email-eldad@fogrefinery.com>
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

Currently, use_count is used in snd_usb_endpoint_set_params to
ensure the parameters don't get changed for an in-use endpoint.

However, there is a subtle condition where this check fails -
if hw_params is called on both substreams before calling prepare (for
playback) or start trigger (for capture): the endpoint is not yet
started, i.e., snd_usb_endpoint_start() does not yet increment use_count.

This adds a flag to check if the parameters are set, but does not
omit checking the use_count.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.h     |  1 +
 sound/usb/endpoint.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 5ecacaa..4061ee1 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -51,6 +51,7 @@ struct snd_usb_endpoint {
 	struct snd_usb_audio *chip;
 
 	int use_count;
+	bool param_set;
 	int ep_num;		/* the referenced endpoint number */
 	int type;		/* SND_USB_ENDPOINT_TYPE_* */
 	unsigned long flags;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 4241154..a56e769 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -469,6 +469,8 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
 	}
 
+	ep->param_set = false;
+
 	list_add_tail(&ep->list, &chip->ep_list);
 
 __exit_unlock:
@@ -792,13 +794,15 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 {
 	int err;
 
-	if ((!subs && ep->use_count != 0) ||
-	    !snd_usb_endpoint_may_set_params(subs, pcm_format, channels,
-					     period_bytes, rate)) {
+	if (ep->param_set &&
+	   ((!subs && ep->use_count != 0) ||
+	     !snd_usb_endpoint_may_set_params(subs, pcm_format, channels,
+					     period_bytes, rate))) {
 		snd_printk(KERN_WARNING "Unable to change format on ep #%x: already in use\n",
 			   ep->ep_num);
 		return -EBUSY;
 	}
+	ep->param_set = true;
 
 	/* release old buffers, if any */
 	release_urbs(ep, 0);
@@ -950,6 +954,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
 		ep->sync_slave = NULL;
 		ep->retire_data_urb = NULL;
 		ep->prepare_data_urb = NULL;
+		ep->param_set = false;
 		set_bit(EP_FLAG_STOPPING, &ep->flags);
 	}
 }
-- 
1.8.1.5
