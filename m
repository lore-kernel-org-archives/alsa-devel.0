From: me@borgia.bo.it
Subject: [PATCH - errata corrige for quirk 1/1]
Date: Tue,  2 Jun 2009 19:21:17 +0200
Message-ID: <22414.8704008714$1243963287@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

From: Andrea Borgia <andrea@borgia.bo.it>


Cut'n'paste mistake, whose likely result was nothing at all.
Correct version is "USB_DEVICE", not "USB_DEVICE_VENDOR_SPEC".

Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 58f24f5..f0f7624 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -1986,7 +1986,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0028),
+	USB_DEVICE(0x0ccd, 0x0028),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "TerraTec",
 		.product_name = "Aureon 5.1 MkII",
-- 
1.6.0.4
