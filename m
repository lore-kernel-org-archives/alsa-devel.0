From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 6/9] ALSA: usb-audio: clear
	SUBSTREAM_FLAG_SYNC_EP_STARTED on error
Date: Sun, 18 Aug 2013 22:22:40 +0200
Message-ID: <1376857363-1116-7-git-send-email-eldad@fogrefinery.com>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0A0261684
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:23:17 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so1154627bkh.40
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:23:17 -0700 (PDT)
In-Reply-To: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
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

If setting the interface fails, the SUBSTREAM_FLAG_SYNC_EP_STARTED
should be cleared.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index aa1e21f..b610231 100644
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
