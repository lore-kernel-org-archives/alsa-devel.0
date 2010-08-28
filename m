From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] sound: oss: fix uninitialized spinlock
Date: Sat, 28 Aug 2010 13:25:33 +0900
Message-ID: <1282969533-8784-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4A175244F8
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 06:32:28 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1658241pzk.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 21:32:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: alsa-devel@alsa-project.org

The spinlock lock in sound_timer.c is used without initialization.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
---
 sound/oss/sound_timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/oss/sound_timer.c b/sound/oss/sound_timer.c
index f0f0c19..48cda6c 100644
--- a/sound/oss/sound_timer.c
+++ b/sound/oss/sound_timer.c
@@ -26,7 +26,7 @@ static unsigned long prev_event_time;
 static volatile unsigned long usecs_per_tmr;	/* Length of the current interval */
 
 static struct sound_lowlev_timer *tmr;
-static spinlock_t lock;
+static DEFINE_SPINLOCK(lock);
 
 static unsigned long tmr2ticks(int tmr_value)
 {
-- 
1.6.0.6
