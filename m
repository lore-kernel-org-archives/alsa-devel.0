From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] sound: usb: line6: Replace GFP_ATOMIC with GFP_KERNEL in line6_alloc_sysex_buffer
Date: Sun, 18 Mar 2018 22:52:15 +0800
Message-ID: <1521384735-23469-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

line6_alloc_sysex_buffer() is never called in atomic context.

The call chain ending up at line6_alloc_sysex_buffer() are:
[1] line6_alloc_sysex_buffer() <- pod_alloc_sysex_buffer() <- 
	pod_set_system_param_int() <- snd_pod_control_monitor_put()
snd_pod_control_monitor_put() is only set as ".put" in snd_kcontrol_new 
structure "pod_control_monitor".
And ->put() is called in snd_ctl_elem_write() (sound/core/control.c)
snd_ctl_elem_write() are called in ctl_elem_write_user() 
and snd_ctl_elem_write_user().
These functions are not called in atomic context.

Despite never getting called from atomic context, 
line6_alloc_sysex_buffer() calls kmalloc with GFP_ATOMIC, 
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL 
to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/line6/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0ff5a7d..70a509e 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -265,7 +265,7 @@ int line6_send_sysex_message(struct usb_line6 *line6, const char *buffer,
 char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
 			       int size)
 {
-	char *buffer = kmalloc(size + SYSEX_EXTRA_SIZE, GFP_ATOMIC);
+	char *buffer = kmalloc(size + SYSEX_EXTRA_SIZE, GFP_KERNEL);
 
 	if (!buffer)
 		return NULL;
-- 
1.9.1
