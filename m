From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH] oss: au1550_ac97: simplify au1550_delay()
Date: Mon, 26 Jul 2010 12:28:32 +0400
Message-ID: <1280132913-8306-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

au1550_delay() uses loop with schedule_timeout() to unconditionally wait
for msec. Use schedule_timeout_uninteruptible() instead.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/oss/au1550_ac97.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index 0fd256c..c4a4cdc 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -163,19 +163,10 @@ ld2(unsigned int x)
 static void
 au1550_delay(int msec)
 {
-	unsigned long   tmo;
-	signed long     tmo2;
-
 	if (in_interrupt())
 		return;
 
-	tmo = jiffies + (msec * HZ) / 1000;
-	for (;;) {
-		tmo2 = tmo - jiffies;
-		if (tmo2 <= 0)
-			break;
-		schedule_timeout(tmo2);
-	}
+	schedule_timeout_uninterruptible(msecs_to_jiffies(msec));
 }
 
 static u16
-- 
1.7.0.4
