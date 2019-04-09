From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: timer: Coding style fixes
Date: Tue,  9 Apr 2019 19:02:35 +0200
Message-ID: <20190409170235.20783-3-tiwai@suse.de>
References: <20190409170235.20783-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D22FEF896F6
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:02:39 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 48767B07D
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:02:39 +0000 (UTC)
In-Reply-To: <20190409170235.20783-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Avoid old school C style but do plain and clear way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index e8d9577a2ee4..43e1265825d8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1909,7 +1909,10 @@ static int snd_timer_user_start(struct file *file)
 	snd_timer_stop(tu->timeri);
 	tu->timeri->lost = 0;
 	tu->last_resolution = 0;
-	return (err = snd_timer_start(tu->timeri, tu->ticks)) < 0 ? err : 0;
+	err = snd_timer_start(tu->timeri, tu->ticks);
+	if (err < 0)
+		return err;
+	return 0;
 }
 
 static int snd_timer_user_stop(struct file *file)
@@ -1920,7 +1923,10 @@ static int snd_timer_user_stop(struct file *file)
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
-	return (err = snd_timer_stop(tu->timeri)) < 0 ? err : 0;
+	err = snd_timer_stop(tu->timeri);
+	if (err < 0)
+		return err;
+	return 0;
 }
 
 static int snd_timer_user_continue(struct file *file)
@@ -1935,7 +1941,10 @@ static int snd_timer_user_continue(struct file *file)
 	if (!(tu->timeri->flags & SNDRV_TIMER_IFLG_PAUSED))
 		return snd_timer_user_start(file);
 	tu->timeri->lost = 0;
-	return (err = snd_timer_continue(tu->timeri)) < 0 ? err : 0;
+	err = snd_timer_continue(tu->timeri);
+	if (err < 0)
+		return err;
+	return 0;
 }
 
 static int snd_timer_user_pause(struct file *file)
@@ -1946,7 +1955,10 @@ static int snd_timer_user_pause(struct file *file)
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
-	return (err = snd_timer_pause(tu->timeri)) < 0 ? err : 0;
+	err = snd_timer_pause(tu->timeri);
+	if (err < 0)
+		return err;
+	return 0;
 }
 
 enum {
-- 
2.16.4
