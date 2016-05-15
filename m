From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH] sound: oss: Use setup_timer and mod_timer.
Date: Sun, 15 May 2016 16:26:51 +0530
Message-ID: <1463309821-10911-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, "GitAuthor: Muhammad Falak R Wani" <falakreyaz@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The function setup_timer combines the initialization of a timer with the
initialization of the timer's function and data fields. The mulitiline
code for timer initialization is now replaced with function setup_timer.

Also, quoting the mod_timer() function comment:
-> mod_timer() is a more efficient way to update the expire field of an
   active timer (if the timer is inactive it will be activated).

Use setup_timer() and mod_timer() to setup and arm a timer, making the
code compact and aid readablity.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 sound/oss/waveartist.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index b36ea47..0b8d0de 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1414,11 +1414,9 @@ attach_waveartist(struct address_info *hw, const struct waveartist_mixer_info *m
 	else {
 #ifdef CONFIG_ARCH_NETWINDER
 		if (machine_is_netwinder()) {
-			init_timer(&vnc_timer);
-			vnc_timer.function = vnc_slider_tick;
-			vnc_timer.expires  = jiffies;
-			vnc_timer.data     = nr_waveartist_devs;
-			add_timer(&vnc_timer);
+			setup_timer(&vnc_timer, vnc_slider_tick,
+				    nr_waveartist_devs);
+			mod_timer(&vnc_timer, jiffies);
 
 			vnc_configure_mixer(devc, 0);
 
-- 
1.9.1
