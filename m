From: Stephen Barber <smbarber@chromium.org>
Subject: [PATCH] ALSA: usb-audio: don't retry snd_usb_ctl_msg after timeout
Date: Thu, 17 Aug 2017 15:17:46 -0700
Message-ID: <20170817221746.45403-1-smbarber@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Con Kolivas <con@kolivas.org>, Dylan Reid <dgreid@chromium.org>, Stephen Barber <smbarber@chromium.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A few calls to snd_usb_ctl_msg wrap the function in a retry loop. In
the worst case, the timeout for snd_usb_ctl_msg is 5 seconds, which when
retried 10 times (for example, if a device is removed) could cause a
probe to hang for ~50 seconds.

Example stack trace from 3.14 which triggered a hung task timeout:
Call Trace:
 [<ffffffffa2c1f720>] ? inet6_set_link_af.part.35+0x12/0x12
 [<ffffffffa2c20309>] schedule+0x6e/0x70
 [<ffffffffa2c1f81c>] schedule_timeout+0xfc/0x13c
 [<ffffffffa2667bbc>] ? rcu_read_unlock_sched_notrace+0x17/0x17
 [<ffffffffa2c20d68>] __wait_for_common+0x153/0x190
 [<ffffffffa2c20d68>] ? __wait_for_common+0x153/0x190
 [<ffffffffa26890e5>] ? wake_up_state+0x12/0x12
 [<ffffffffa2c20e0e>] wait_for_completion_timeout+0x1d/0x1f
 [<ffffffffa2a07c70>] usb_start_wait_urb+0x93/0xf1
 [<ffffffffa2a07daf>] usb_control_msg+0xe1/0x11d
 [<ffffffffc02cd254>] snd_usb_ctl_msg+0x9c/0xf1 [snd_usb_audio]
 [<ffffffffc02ce191>] snd_usb_mixer_set_ctl_value+0x124/0xab1 [snd_usb_audio]
 [<ffffffffc02ce230>] snd_usb_mixer_set_ctl_value+0x1c3/0xab1 [snd_usb_audio]
 [<ffffffffc02ce58e>] snd_usb_mixer_set_ctl_value+0x521/0xab1 [snd_usb_audio]
 [<ffffffffc02cee88>] snd_usb_mixer_add_control+0x36a/0x1264 [snd_usb_audio]
 [<ffffffffc02cf323>] snd_usb_mixer_add_control+0x805/0x1264 [snd_usb_audio]
 [<ffffffffa2a06e11>] ? usb_free_urb+0x1a/0x1c
 [<ffffffffc02cfcf7>] snd_usb_mixer_add_control+0x11d9/0x1264 [snd_usb_audio]
 [<ffffffffc02d000f>] snd_usb_create_mixer+0xbc/0x286 [snd_usb_audio]
 [<ffffffffc02cac18>] 0xffffffffc02cac17
 [<ffffffffa2a0aaf1>] usb_probe_interface+0x17c/0x21c
 [<ffffffffa29a65bc>] driver_probe_device+0xae/0x1fa
 [<ffffffffa29a6767>] __device_attach_driver+0x5f/0x66
 [<ffffffffa29a6708>] ? driver_probe_device+0x1fa/0x1fa
 [<ffffffffa29a4a60>] bus_for_each_drv+0x87/0xaa
 [<ffffffffa29a688a>] __device_attach+0x9d/0x101
 [<ffffffffa29a6913>] device_initial_probe+0x13/0x15
 [<ffffffffa29a5ae6>] bus_probe_device+0x33/0x96
 [<ffffffffa29a3d19>] device_add+0x328/0x547
 [<ffffffffa2a09355>] usb_set_configuration+0x624/0x674
 [<ffffffffa2a11949>] generic_probe+0x45/0x77
 [<ffffffffa2a0a962>] usb_probe_device+0x2d/0x40
 [<ffffffffa29a65bc>] driver_probe_device+0xae/0x1fa
 [<ffffffffa29a6767>] __device_attach_driver+0x5f/0x66
 [<ffffffffa29a6708>] ? driver_probe_device+0x1fa/0x1fa
 [<ffffffffa29a4a60>] bus_for_each_drv+0x87/0xaa
 [<ffffffffa29a688a>] __device_attach+0x9d/0x101
 [<ffffffffa29a6913>] device_initial_probe+0x13/0x15
 [<ffffffffa29a5ae6>] bus_probe_device+0x33/0x96
 [<ffffffffa29a3d19>] device_add+0x328/0x547
 [<ffffffffa29030bc>] ? add_device_randomness+0x111/0x130
 [<ffffffffa2a00967>] usb_new_device+0x2a2/0x3c0
 [<ffffffffa2a02ddc>] hub_thread+0xa3d/0xeed
 [<ffffffffa2c2010d>] ? __schedule+0x41e/0x5ac
 [<ffffffffa26957ce>] ? finish_wait+0x62/0x62
 [<ffffffffa2a0239f>] ? usb_reset_device+0x16a/0x16a
 [<ffffffffa267b255>] kthread+0x108/0x110
 [<ffffffffa267b14d>] ? __kthread_parkme+0x67/0x67
 [<ffffffffa2c23b2c>] ret_from_fork+0x7c/0xb0
 [<ffffffffa267b14d>] ? __kthread_parkme+0x67/0x67

Signed-off-by: Stephen Barber <smbarber@chromium.org>
---
 sound/usb/mixer.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 082736c539bc..253fc946db29 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -318,12 +318,15 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request,
 
 	while (timeout-- > 0) {
 		idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
-		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
-				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-				    validx, idx, buf, val_len) >= val_len) {
+		err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
+				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+				      validx, idx, buf, val_len);
+		if (err >= val_len) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
 			err = 0;
 			goto out;
+		} else if (err == -ETIMEDOUT) {
+			goto out;
 		}
 	}
 	usb_audio_dbg(chip,
@@ -483,12 +486,15 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 
 	while (timeout-- > 0) {
 		idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
-		if (snd_usb_ctl_msg(chip->dev,
-				    usb_sndctrlpipe(chip->dev, 0), request,
-				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-				    validx, idx, buf, val_len) >= 0) {
+		err = snd_usb_ctl_msg(chip->dev,
+				      usb_sndctrlpipe(chip->dev, 0), request,
+				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+				      validx, idx, buf, val_len);
+		if (err >= 0) {
 			err = 0;
 			goto out;
+		} else if (err == -ETIMEDOUT) {
+			goto out;
 		}
 	}
 	usb_audio_dbg(chip, "cannot set ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d, data = %#x/%#x\n",
-- 
2.14.1.480.gb18f417b89-goog
