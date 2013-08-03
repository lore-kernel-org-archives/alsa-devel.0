From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 2/9] ALSA: usb-audio: remove assignment from
	if condition
Date: Sat,  3 Aug 2013 10:50:16 +0200
Message-ID: <1375519823-25718-3-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E78C2619D6
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:36 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so451108bkh.12
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:36 -0700 (PDT)
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

Following general kernel style.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 3d3e8d1..be5c7c2 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -479,7 +479,8 @@ add_sync_ep:
 		subs->data_endpoint->sync_master = subs->sync_endpoint;
 	}
 
-	if ((err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt)) < 0)
+	err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt);
+	if (err < 0)
 		return err;
 
 	subs->cur_audiofmt = fmt;
-- 
1.8.1.5
