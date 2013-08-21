From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 06/10] ALSA: usb-audio: clear
	SUBSTREAM_FLAG_SYNC_EP_STARTED on error
Date: Wed, 21 Aug 2013 23:38:01 +0200
Message-ID: <1377121085-20563-7-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D327F2652DC
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:49 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so396232bkb.3
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:49 -0700 (PDT)
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

If setting the interface fails, the SUBSTREAM_FLAG_SYNC_EP_STARTED
should be cleared.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 19b0eb4..bdc3325 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -246,6 +246,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 						subs->sync_endpoint->iface,
 						subs->sync_endpoint->alt_idx);
 			if (err < 0) {
+				clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 				snd_printk(KERN_ERR
 					   "%d:%d:%d: cannot set interface (%d)\n",
 					   subs->dev->devnum,
-- 
1.8.1.5
