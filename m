From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 1/9] ALSA: usb-audio: remove disabled debug
	code in set_format
Date: Sat,  3 Aug 2013 10:50:15 +0200
Message-ID: <1375519823-25718-2-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B66F261987
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:33 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so452137bkg.36
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:33 -0700 (PDT)
In-Reply-To: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Code block does not compile when enabled.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 15b151e..3d3e8d1 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -486,15 +486,6 @@ add_sync_ep:
 
 	snd_usb_set_format_quirk(subs, fmt);
 
-#if 0
-	printk(KERN_DEBUG
-	       "setting done: format = %d, rate = %d..%d, channels = %d\n",
-	       fmt->format, fmt->rate_min, fmt->rate_max, fmt->channels);
-	printk(KERN_DEBUG
-	       "  datapipe = 0x%0x, syncpipe = 0x%0x\n",
-	       subs->datapipe, subs->syncpipe);
-#endif
-
 	return 0;
 }
 
-- 
1.8.1.5
