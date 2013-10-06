From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 12/15] ALSA: usb-audio: remove unused
	endpoint flag EP_FLAG_ACTIVATED
Date: Sun,  6 Oct 2013 22:31:17 +0200
Message-ID: <1381091480-23636-13-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C06261A5B
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:41 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so2364453bkb.9
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:41 -0700 (PDT)
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

EP_FLAG_ACTIVATED is never tested for, remove it.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6cb3137..8379989 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -33,7 +33,6 @@
 #include "pcm.h"
 #include "quirks.h"
 
-#define EP_FLAG_ACTIVATED	0
 #define EP_FLAG_RUNNING		1
 #define EP_FLAG_STOPPING	2
 
@@ -1020,8 +1019,6 @@ void snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 
 	deactivate_urbs(ep, true);
 	wait_clear_urbs(ep);
-
-	clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
 }
 
 /**
-- 
1.8.1.5
