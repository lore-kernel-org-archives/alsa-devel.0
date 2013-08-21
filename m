From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 07/10] ALSA: usb-audio: correct ep use_count
	semantics (add set_param flag)
Date: Wed, 21 Aug 2013 23:38:02 +0200
Message-ID: <1377121085-20563-8-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 21921265338
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:55 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id my10so395064bkb.15
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:54 -0700 (PDT)
In-Reply-To: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
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
v2: Cleaned up the patch, now it does only one thing (add the flag and
the check).
---
 sound/usb/card.h     | 1 +
 sound/usb/endpoint.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index c6fcb7b..6ff36f5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -472,6 +472,8 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
 	}
 
+	ep->param_set = false;
+
 	list_add_tail(&ep->list, &chip->ep_list);
 
 __exit_unlock:
@@ -765,11 +767,12 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 {
 	int err;
 
-	if (ep->use_count != 0) {
+	if (ep->param_set || ep->use_count != 0) {
 		snd_printk(KERN_WARNING "Unable to change format on ep #%x: already in use\n",
 			   ep->ep_num);
 		return -EBUSY;
 	}
+	ep->param_set = true;
 
 	/* release old buffers, if any */
 	release_urbs(ep, 0);
@@ -921,6 +924,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
 		ep->sync_slave = NULL;
 		ep->retire_data_urb = NULL;
 		ep->prepare_data_urb = NULL;
+		ep->param_set = false;
 		set_bit(EP_FLAG_STOPPING, &ep->flags);
 	}
 }
-- 
1.8.1.5
