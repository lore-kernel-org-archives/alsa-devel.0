From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] oss: avoid time_t usage
Date: Fri, 17 Jun 2016 16:30:03 +0200
Message-ID: <20160617143020.3151017-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We want to remove all time_t users from the kernel because of
y2038 compatibility. This particular instance does not even
use time_t to store a seconds value, so we can simply use
'unsigned int', which seems more fitting anywhere.

The same code is used in two OSS files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/oss/sound_timer.c | 2 +-
 sound/oss/sys_timer.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/sound_timer.c b/sound/oss/sound_timer.c
index 8021c85f076d..3a444a6f10eb 100644
--- a/sound/oss/sound_timer.c
+++ b/sound/oss/sound_timer.c
@@ -17,7 +17,7 @@
 #include "sound_config.h"
 
 static volatile int initialized, opened, tmr_running;
-static volatile time_t tmr_offs, tmr_ctr;
+static volatile unsigned int tmr_offs, tmr_ctr;
 static volatile unsigned long ticks_offs;
 static volatile int curr_tempo, curr_timebase;
 static volatile unsigned long curr_ticks;
diff --git a/sound/oss/sys_timer.c b/sound/oss/sys_timer.c
index 2226dda0eff0..d17019d25b99 100644
--- a/sound/oss/sys_timer.c
+++ b/sound/oss/sys_timer.c
@@ -19,7 +19,7 @@
 #include "sound_config.h"
 
 static volatile int opened, tmr_running;
-static volatile time_t tmr_offs, tmr_ctr;
+static volatile unsigned int tmr_offs, tmr_ctr;
 static volatile unsigned long ticks_offs;
 static volatile int curr_tempo, curr_timebase;
 static volatile unsigned long curr_ticks;
-- 
2.9.0
