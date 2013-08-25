From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 04/11] ALSA: usb-audio: don't deactivate
	URBs on in-use EP
Date: Sun, 25 Aug 2013 17:45:25 +0200
Message-ID: <1377445532-5876-1-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 426E82619F0
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:45:38 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so787893bkb.21
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:45:37 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
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
