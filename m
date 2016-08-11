From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 14/15] ALSA: line6: Give up hwdep spinlock
	temporarily during read operation
Date: Thu, 11 Aug 2016 21:02:26 +0200
Message-ID: <1470942147-19848-15-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5B8267779
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 21:04:12 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id i5so933404wmg.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:04:12 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Without it, the code hits the 'might_sleep while atomic' debug warning.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 142e0e3..286b6e1 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -600,6 +600,10 @@ line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		goto end;
 	}
 
+	/* Release lock while copying the stuff. Since there is only one reader,
+	 * the data is going nowhere, so this should be safe. */
+	spin_unlock(&line6->buffer_circular.read_lock);
+
 	if (copy_to_user(buf,
 		&line6->buffer_circular.data[tail * LINE6_MESSAGE_MAXLEN],
 		line6->buffer_circular.data_len[tail])
@@ -610,6 +614,7 @@ line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		rv = line6->buffer_circular.data_len[tail];
 	}
 
+	spin_lock(&line6->buffer_circular.read_lock);
 	smp_store_release(&line6->buffer_circular.tail,
 				(tail + 1) & (LINE6_MESSAGE_MAXCOUNT - 1));
 
-- 
1.9.1
