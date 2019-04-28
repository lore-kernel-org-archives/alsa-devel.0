From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] ALSA: usx2y: fix a memory leak bug
Date: Sun, 28 Apr 2019 01:42:32 -0500
Message-ID: <1556433754-3291-1-git-send-email-wang6495@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35D00F80C0D
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 08:42:51 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id BE484CA0
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 06:42:49 +0000 (UTC)
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KVGZJD4hGPa for <alsa-devel@alsa-project.org>;
 Sun, 28 Apr 2019 01:42:49 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com
 [209.85.166.200])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 97DAECC3
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 01:42:49 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id w1so6875144itk.4
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 23:42:49 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Wenwen Wang <wang6495@umn.edu>
Cc: open list <linux-kernel@vger.kernel.org>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
kmalloc() and saved to 'usX2Y->In04Buf'. After the urb is initialized, a
sanity check is performed for the endpoint in the urb by invoking
usb_urb_ep_type_check(). If the check fails, the error code EINVAL will be
returned. In that case, however, the created urb and the allocated buffer
are not freed, leading to memory leaks.

To fix the above issue, free the urb and the buffer if the check fails.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/usx2y/usbusx2y.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index da4a5a5..0817018 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -303,8 +303,11 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 			 usX2Y->In04Buf, 21,
 			 i_usX2Y_In04Int, usX2Y,
 			 10);
-	if (usb_urb_ep_type_check(usX2Y->In04urb))
+	if (usb_urb_ep_type_check(usX2Y->In04urb)) {
+		kfree(usX2Y->In04Buf);
+		usb_put_urb(usX2Y->In04urb);
 		return -EINVAL;
+	}
 	return usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
 }
 
-- 
2.7.4
