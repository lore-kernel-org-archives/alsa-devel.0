From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: timer: Fix UBSAN warning at
	SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
Date: Mon, 25 Jun 2018 11:19:08 +0200
Message-ID: <20180625091909.5915-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F0452673F2
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:19:12 +0200 (CEST)
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
Cc: air icy <icytxw@gmail.com>
List-Id: alsa-devel@alsa-project.org

The kernel may spew a WARNING about UBSAN undefined behavior at
handling ALSA timer ioctl SNDRV_TIMER_IOCTL_NEXT_DEVICE:

UBSAN: Undefined behaviour in sound/core/timer.c:1524:19
signed integer overflow:
2147483647 + 1 cannot be represented in type 'int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x1c8 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x86 lib/ubsan.c:159
 handle_overflow+0x1c2/0x21f lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 snd_timer_user_next_device sound/core/timer.c:1524 [inline]
 __snd_timer_user_ioctl+0x204d/0x2520 sound/core/timer.c:1939
 snd_timer_user_ioctl+0x67/0x95 sound/core/timer.c:1994
 ....

It happens only when a value with INT_MAX is passed, as we're
incrementing it unconditionally.  So the fix is trivial, check the
value with INT_MAX.  Although the bug itself is fairly harmless, it's
better to fix it so that fuzzers won't hit this again later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200213
Reported-and-tested-by: Team OWL337 <icytxw@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 665089c45560..b6f076bbc72d 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1520,7 +1520,7 @@ static int snd_timer_user_next_device(struct snd_timer_id __user *_tid)
 				} else {
 					if (id.subdevice < 0)
 						id.subdevice = 0;
-					else
+					else if (id.subdevice < INT_MAX)
 						id.subdevice++;
 				}
 			}
-- 
2.17.1
