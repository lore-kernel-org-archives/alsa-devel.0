From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/6] ALSA: line6: Add delay before reading status
Date: Tue, 10 Feb 2015 23:03:13 -0600
Message-ID: <1423630997-25464-3-git-send-email-chris@rorvick.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

The device indicates the result of a read/write operation by making the
status available on a subsequent request from the driver.  This is not
ready immediately, though, so the driver is currently slamming the
device with hundreds of pointless requests before getting the expected
response.  Add a two millisecond delay before each attempt.  This is
approximately the behavior observed with version 4.2.7.1 of the Windows
driver.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index aac1e35..222c14f 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -296,6 +296,8 @@ static void line6_data_received(struct urb *urb)
 	line6_start_listen(line6);
 }
 
+#define LINE6_READ_WRITE_STATUS_DELAY 2  /* milliseconds */
+
 /*
 	Read data from device.
 */
@@ -319,6 +321,8 @@ int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
 
 	/* Wait for data length. We'll get 0xff until length arrives. */
 	do {
+		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
+
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				      USB_DIR_IN,
@@ -376,6 +380,8 @@ int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
 	}
 
 	do {
+		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
+
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
 				      0x67,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
-- 
2.1.0
