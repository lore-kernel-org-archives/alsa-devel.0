From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] sound: oss: waveartist: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:35:21 -0700
Message-ID: <20171024153521.GA112921@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, David Howells <dhowells@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/oss/waveartist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index 4f0c3a232e41..c051c8e6023e 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -151,6 +151,7 @@ static DEFINE_SPINLOCK(waveartist_lock);
 #define machine_is_netwinder() 0
 #else
 static struct timer_list vnc_timer;
+static int timer_nr_waveartist_devs;
 static void vnc_configure_mixer(struct wavnc_info *devc,
 				unsigned int input_mask);
 static int vnc_private_ioctl(int dev, unsigned int cmd, int __user *arg);
@@ -1414,8 +1415,8 @@ attach_waveartist(struct address_info *hw, const struct waveartist_mixer_info *m
 	else {
 #ifdef CONFIG_ARCH_NETWINDER
 		if (machine_is_netwinder()) {
-			setup_timer(&vnc_timer, vnc_slider_tick,
-				    nr_waveartist_devs);
+			timer_nr_waveartist_devs = nr_waveartist_devs;
+			timer_setup(&vnc_timer, vnc_slider_tick, 0);
 			mod_timer(&vnc_timer, jiffies);
 
 			vnc_configure_mixer(devc, 0);
@@ -1799,11 +1800,11 @@ vnc_slider(struct wavnc_info *devc)
 }
 
 static void
-vnc_slider_tick(unsigned long data)
+vnc_slider_tick(struct timer_list *unused)
 {
 	int next_timeout;
 
-	if (vnc_slider(adev_info + data))
+	if (vnc_slider(adev_info + timer_nr_waveartist_devs))
 		next_timeout = 5;	// mixer reported change
 	else
 		next_timeout = VNC_TIMER_PERIOD;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
