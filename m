From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/17] ALSA: line6: Drop line6_send_program()
	and line6_transmit_parameter()
Date: Mon, 19 Jan 2015 16:54:51 +0100
Message-ID: <1421682891-11594-18-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A61C261484
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Both functions are used nowhere.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 59 ------------------------------------------------
 sound/usb/line6/driver.h |  3 ---
 2 files changed, 62 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index a2f72cc2bf96..a3da18b876d1 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -299,65 +299,6 @@ static void line6_data_received(struct urb *urb)
 }
 
 /*
-	Send channel number (i.e., switch to a different sound).
-*/
-int line6_send_program(struct usb_line6 *line6, u8 value)
-{
-	int retval;
-	unsigned char *buffer;
-	int partial;
-
-	buffer = kmalloc(2, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	buffer[0] = LINE6_PROGRAM_CHANGE | LINE6_CHANNEL_HOST;
-	buffer[1] = value;
-
-	retval = usb_interrupt_msg(line6->usbdev,
-				   usb_sndintpipe(line6->usbdev,
-						  line6->properties->ep_ctrl_w),
-				   buffer, 2, &partial, LINE6_TIMEOUT * HZ);
-
-	if (retval)
-		dev_err(line6->ifcdev, "usb_interrupt_msg failed (%d)\n",
-			retval);
-
-	kfree(buffer);
-	return retval;
-}
-
-/*
-	Transmit Line6 control parameter.
-*/
-int line6_transmit_parameter(struct usb_line6 *line6, int param, u8 value)
-{
-	int retval;
-	unsigned char *buffer;
-	int partial;
-
-	buffer = kmalloc(3, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	buffer[0] = LINE6_PARAM_CHANGE | LINE6_CHANNEL_HOST;
-	buffer[1] = param;
-	buffer[2] = value;
-
-	retval = usb_interrupt_msg(line6->usbdev,
-				   usb_sndintpipe(line6->usbdev,
-						  line6->properties->ep_ctrl_w),
-				   buffer, 3, &partial, LINE6_TIMEOUT * HZ);
-
-	if (retval)
-		dev_err(line6->ifcdev, "usb_interrupt_msg failed (%d)\n",
-			retval);
-
-	kfree(buffer);
-	return retval;
-}
-
-/*
 	Read data from device.
 */
 int line6_read_data(struct usb_line6 *line6, int address, void *data,
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 8fd65f2e1f06..d539c11d333d 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -168,7 +168,6 @@ extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
 			   size_t datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    int *serial_number);
-extern int line6_send_program(struct usb_line6 *line6, u8 value);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
 					const char *buffer, int size);
 extern int line6_send_sysex_message(struct usb_line6 *line6,
@@ -178,8 +177,6 @@ extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
 extern void line6_start_timer(struct timer_list *timer, unsigned int msecs,
 			      void (*function)(unsigned long),
 			      unsigned long data);
-extern int line6_transmit_parameter(struct usb_line6 *line6, int param,
-				    u8 value);
 extern int line6_version_request_async(struct usb_line6 *line6);
 extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
 			    size_t datalen);
-- 
2.2.1
