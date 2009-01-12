From: Andrea Borgia <andrea@borgia.bo.it>
Subject: [PATCH - SB0500 2/2] rename "Device" to "Toshiba
	SB-0500" via quirks
Date: Mon, 12 Jan 2009 23:17:47 +0100
Message-ID: <1231798667-8870-1-git-send-email-andrea@borgia.bo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Andrea Borgia <andrea@borgia.bo.it>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>

diff --git a/usb/usbquirks.h b/usb/usbquirks.h
index 9211575..d59323e 100644
--- a/usb/usbquirks.h
+++ b/usb/usbquirks.h
@@ -39,6 +39,16 @@
 	.idProduct = prod, \
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC
 
+/* Creative/Toshiba Multimedia Center SB-0500 */
+{
+	USB_DEVICE(0x041e, 0x3048),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Toshiba",
+		.product_name = "SB-0500",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+
 /* Creative/E-Mu devices */
 {
 	USB_DEVICE(0x041e, 0x3010),
-- 
1.5.4.3
