From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 3/6] ALSA: line6: Return error if device not responding
Date: Tue, 10 Feb 2015 23:03:14 -0600
Message-ID: <1423630997-25464-4-git-send-email-chris@rorvick.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Put an upper bound on how long we will wait for the device to respond to
a read/write request (i.e., 100 milliseconds) and return an error if
this is reached.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 222c14f..2a33f3e 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -297,6 +297,7 @@ static void line6_data_received(struct urb *urb)
 }
 
 #define LINE6_READ_WRITE_STATUS_DELAY 2  /* milliseconds */
+#define LINE6_READ_WRITE_MAX_RETRIES 50
 
 /*
 	Read data from device.
@@ -307,6 +308,7 @@ int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
 	unsigned char len;
+	unsigned count;
 
 	/* query the serial number: */
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
@@ -320,7 +322,7 @@ int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
 	}
 
 	/* Wait for data length. We'll get 0xff until length arrives. */
-	do {
+	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
 		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
 
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
@@ -333,9 +335,16 @@ int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
 				"receive length failed (error %d)\n", ret);
 			return ret;
 		}
-	} while (len == 0xff);
 
-	if (len != datalen) {
+		if (len != 0xff)
+			break;
+	}
+
+	if (len == 0xff) {
+		dev_err(line6->ifcdev, "read failed after %d retries\n",
+			count);
+		return -EIO;
+	} else if (len != datalen) {
 		/* should be equal or something went wrong */
 		dev_err(line6->ifcdev,
 			"length mismatch (expected %d, got %d)\n",
@@ -367,6 +376,7 @@ int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
 	unsigned char status;
+	int count;
 
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
@@ -379,7 +389,7 @@ int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
 		return ret;
 	}
 
-	do {
+	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
 		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
 
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
@@ -394,9 +404,16 @@ int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
 				"receiving status failed (error %d)\n", ret);
 			return ret;
 		}
-	} while (status == 0xff);
 
-	if (status != 0) {
+		if (status != 0xff)
+			break;
+	}
+
+	if (status == 0xff) {
+		dev_err(line6->ifcdev, "write failed after %d retries\n",
+			count);
+		return -EIO;
+	} else if (status != 0) {
 		dev_err(line6->ifcdev, "write failed (error %d)\n", ret);
 		return -EINVAL;
 	}
-- 
2.1.0
