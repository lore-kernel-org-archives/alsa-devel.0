From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/4] USB: Add endpoint usage definitions to
	ch9.h
Date: Mon, 12 Sep 2011 18:54:10 +0200
Message-ID: <1315846453-5036-2-git-send-email-zonque@gmail.com>
References: <1315846453-5036-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 7857E244CD
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 18:53:55 +0200 (CEST)
In-Reply-To: <1315846453-5036-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Greg Kroah-Hartman <gregkh@suse.de>, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The endpoint usage field is described in the USB 2.0 specification,
chapter 9.6.6.

Also, move the sync type fields block down by some lines to reflect the
fact that these are also stuffed in bmAttributes.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/ch9.h |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 0fd3fbd..f302535 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -377,12 +377,6 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_NUMBER_MASK	0x0f	/* in bEndpointAddress */
 #define USB_ENDPOINT_DIR_MASK		0x80
 
-#define USB_ENDPOINT_SYNCTYPE		0x0c
-#define USB_ENDPOINT_SYNC_NONE		(0 << 2)
-#define USB_ENDPOINT_SYNC_ASYNC		(1 << 2)
-#define USB_ENDPOINT_SYNC_ADAPTIVE	(2 << 2)
-#define USB_ENDPOINT_SYNC_SYNC		(3 << 2)
-
 #define USB_ENDPOINT_XFERTYPE_MASK	0x03	/* in bmAttributes */
 #define USB_ENDPOINT_XFER_CONTROL	0
 #define USB_ENDPOINT_XFER_ISOC		1
@@ -390,6 +384,17 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_XFER_INT		3
 #define USB_ENDPOINT_MAX_ADJUSTABLE	0x80
 
+#define USB_ENDPOINT_SYNCTYPE		0x0c
+#define USB_ENDPOINT_SYNC_NONE		(0 << 2)
+#define USB_ENDPOINT_SYNC_ASYNC		(1 << 2)
+#define USB_ENDPOINT_SYNC_ADAPTIVE	(2 << 2)
+#define USB_ENDPOINT_SYNC_SYNC		(3 << 2)
+
+#define USB_ENDPOINT_USAGE_MASK		0x30
+#define USB_ENDPOINT_USAGE_DATA		0x00
+#define USB_ENDPOINT_USAGE_FEEDBACK	0x10
+#define USB_ENDPOINT_USAGE_IMPLICIT_FB	0x20	/* Implicit feedback Data endpoint */
+
 /*-------------------------------------------------------------------------*/
 
 /**
-- 
1.7.5.4
