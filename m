From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: timer: Sync timer deletion at closing
	the system timer
Date: Tue,  2 Feb 2016 16:14:22 +0100
Message-ID: <1454426062-20985-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E16CA265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 16:14:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 76B6EABE5
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:14:23 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

ALSA timer core framework has no sync point at stopping because it's
called inside the spinlock.  Thus we need a sync point at close for
avoiding the stray timer task.  This is simply done by implementing
the close callback just calling del_timer_sync().  (It's harmless to
call it unconditionally, as the core timer itself cares of the already
deleted timer instance.)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 12db60dd147b..b419e612f987 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1058,11 +1058,21 @@ static int snd_timer_s_stop(struct snd_timer * timer)
 	return 0;
 }
 
+static int snd_timer_s_close(struct snd_timer *timer)
+{
+	struct snd_timer_system_private *priv;
+
+	priv = (struct snd_timer_system_private *)timer->private_data;
+	del_timer_sync(&priv->tlist);
+	return 0;
+}
+
 static struct snd_timer_hardware snd_timer_system =
 {
 	.flags =	SNDRV_TIMER_HW_FIRST | SNDRV_TIMER_HW_TASKLET,
 	.resolution =	1000000000L / HZ,
 	.ticks =	10000000L,
+	.close =	snd_timer_s_close,
 	.start =	snd_timer_s_start,
 	.stop =		snd_timer_s_stop
 };
-- 
2.7.0
