From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/9] ALSA: line6: Add a sanity check for invalid EPs
Date: Tue, 10 Oct 2017 15:38:14 +0200
Message-ID: <20171010133819.10567-5-tiwai@suse.de>
References: <20171010133819.10567-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171010133819.10567-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

As syzkaller spotted, currently line6 drivers submit a URB with the
fixed EP without checking whether it's actually available, which may
result in a kernel warning like:
  usb 1-1: BOGUS urb xfer, pipe 3 != type 1
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:449
  usb_submit_urb+0xf8a/0x11d0
  Modules linked in:
  CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42613-g1488251d1a98 #238
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   line6_start_listen+0x55f/0x9e0 sound/usb/line6/driver.c:82
   line6_init_cap_control sound/usb/line6/driver.c:690
   line6_probe+0x7c9/0x1310 sound/usb/line6/driver.c:764
   podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
   usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
   ....

This patch adds a sanity check of validity of EPs at the device
initialization phase for avoiding the call with an invalid EP.

Reported-by: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/line6/driver.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index c8f723c3a033..167aebf8276e 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -78,6 +78,13 @@ static int line6_start_listen(struct usb_line6 *line6)
 			line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
 			line6_data_received, line6);
 	}
+
+	/* sanity checks of EP before actually submitting */
+	if (usb_urb_ep_type_check(line6->urb_listen)) {
+		dev_err(line6->ifcdev, "invalid control EP\n");
+		return -EINVAL;
+	}
+
 	line6->urb_listen->actual_length = 0;
 	err = usb_submit_urb(line6->urb_listen, GFP_ATOMIC);
 	return err;
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
