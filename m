From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/6] ALSA: line6: Improve line6_read/write_data() interfaces
Date: Tue, 10 Feb 2015 23:03:12 -0600
Message-ID: <1423630997-25464-2-git-send-email-chris@rorvick.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use explicit types to reflect the range of valid values.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c | 10 +++++-----
 sound/usb/line6/driver.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 1e58e92..aac1e35 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -299,8 +299,8 @@ static void line6_data_received(struct urb *urb)
 /*
 	Read data from device.
 */
-int line6_read_data(struct usb_line6 *line6, int address, void *data,
-		    size_t datalen)
+int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
+		    u8 datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
@@ -309,7 +309,7 @@ int line6_read_data(struct usb_line6 *line6, int address, void *data,
 	/* query the serial number: */
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			      (datalen << 8) | 0x21, address,
+			      ((u16) datalen << 8) | 0x21, address,
 			      NULL, 0, LINE6_TIMEOUT * HZ);
 
 	if (ret < 0) {
@@ -357,8 +357,8 @@ EXPORT_SYMBOL_GPL(line6_read_data);
 /*
 	Write data to device.
 */
-int line6_write_data(struct usb_line6 *line6, int address, void *data,
-		     size_t datalen)
+int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
+		     u16 datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 8247a6b..603bdc4 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -147,8 +147,8 @@ struct usb_line6 {
 
 extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
 				      int code2, int size);
-extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
-			   size_t datalen);
+extern int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
+			   u8 datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    int *serial_number);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
@@ -161,8 +161,8 @@ extern void line6_start_timer(struct timer_list *timer, unsigned int msecs,
 			      void (*function)(unsigned long),
 			      unsigned long data);
 extern int line6_version_request_async(struct usb_line6 *line6);
-extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
-			    size_t datalen);
+extern int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
+			    u16 datalen);
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
-- 
2.1.0
