From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 05/10] ALSA: usb-audio: void return type of
	snd_usb_endpoint_deactivate()
Date: Wed, 21 Aug 2013 23:38:00 +0200
Message-ID: <1377121085-20563-6-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 5147E26500F
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:44 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so389544bkg.22
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:44 -0700 (PDT)
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

The return value of snd_usb_endpoint_deactivate() is not used,
make the function have no return value.
Update the documentation to reflect what the function is actually
doing.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 15 +++++----------
 sound/usb/endpoint.h |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 420df01..c6fcb7b 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -930,28 +930,23 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
  *
  * @ep: the endpoint to deactivate
  *
- * If the endpoint is not currently in use, this functions will select the
- * alternate interface setting 0 for the interface of this endpoint.
+ * If the endpoint is not currently in use, this functions will
+ * deactivate its associated URBs.
  *
  * In case of any active users, this functions does nothing.
- *
- * Returns an error if usb_set_interface() failed, 0 in all other
- * cases.
  */
-int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
+void snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 {
 	if (!ep)
-		return -EINVAL;
+		return;
 
 	if (ep->use_count != 0)
-		return 0;
+		return;
 
 	deactivate_urbs(ep, true);
 	wait_clear_urbs(ep);
 
 	clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
-
-	return 0;
 }
 
 /**
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 2287adf..c928e0c 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -20,7 +20,7 @@ int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
-int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
+void snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_free(struct list_head *head);
 
 int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep);
-- 
1.8.1.5
