From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 04/10] ALSA: usb-audio: don't deactivate
	URBs on in-use EP
Date: Wed, 21 Aug 2013 23:37:59 +0200
Message-ID: <1377121085-20563-5-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 147282652F1
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:40 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id na10so397429bkb.28
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:39 -0700 (PDT)
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

If an endpoint in use, its associated URBs should not be
deactivated.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 86b23af..420df01 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -943,12 +943,12 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
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
-- 
1.8.1.5
