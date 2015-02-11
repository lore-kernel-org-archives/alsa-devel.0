From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2] ALSA: line6: Improve line6_read/write_data() interfaces
Date: Wed, 11 Feb 2015 06:03:31 -0600
Message-ID: <1423656211-31349-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

The address cannot be negative so make it unsigned.  Also, an unsigned
int is always sufficient for the length, so no need to overdo it with a
size_t.  Finally, add in range checks to see if the values passed in
actually fit where they are used.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
This was dropped from an earlier series ("Cleanup reads/writes to Line 6
device memory".)  This version leaves the arguements wide (within reason)
and does range checking.

Regards,

Chris

 sound/usb/line6/driver.c | 14 ++++++++++----
 sound/usb/line6/driver.h |  8 ++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 99b63a7..4f82b57 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -302,14 +302,17 @@ static void line6_data_received(struct urb *urb)
 /*
 	Read data from device.
 */
-int line6_read_data(struct usb_line6 *line6, int address, void *data,
-		    size_t datalen)
+int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
+		    unsigned datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
 	unsigned char len;
 	unsigned count;
 
+	if (address > 0xffff || datalen > 0xff)
+		return EINVAL;
+
 	/* query the serial number: */
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
@@ -370,14 +373,17 @@ EXPORT_SYMBOL_GPL(line6_read_data);
 /*
 	Write data to device.
 */
-int line6_write_data(struct usb_line6 *line6, int address, void *data,
-		     size_t datalen)
+int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
+		     unsigned datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
 	unsigned char status;
 	int count;
 
+	if (address > 0xffff || datalen > 0xffff)
+		return EINVAL;
+
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 			      0x0022, address, data, datalen,
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 5d20294..7da643e 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -147,8 +147,8 @@ struct usb_line6 {
 
 extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
 				      int code2, int size);
-extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
-			   size_t datalen);
+extern int line6_read_data(struct usb_line6 *line6, unsigned address,
+			   void *data, unsigned datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    u32 *serial_number);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
@@ -161,8 +161,8 @@ extern void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 			      void (*function)(unsigned long),
 			      unsigned long data);
 extern int line6_version_request_async(struct usb_line6 *line6);
-extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
-			    size_t datalen);
+extern int line6_write_data(struct usb_line6 *line6, unsigned address,
+			    void *data, unsigned datalen);
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
-- 
2.1.0
