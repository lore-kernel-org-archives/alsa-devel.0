From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 05/15] ALSA: usb-audio: void return type of
	snd_usb_endpoint_deactivate()
Date: Sun,  6 Oct 2013 22:31:10 +0200
Message-ID: <1381091480-23636-6-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 24133261A5B
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:32 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id 6so2252599bkj.5
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:31 -0700 (PDT)
In-Reply-To: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
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
index e84732c..2685660 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -946,28 +946,23 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
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
index 3bd02f0..1c7e8ee 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -22,7 +22,7 @@ int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
-int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
+void snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_free(struct list_head *head);
 
 int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep);
-- 
1.8.1.5
