From: Andrea Borgia <andrea@borgia.bo.it>
Subject: [PATCH - quirk for USB Aureon cards 1/1] Add quirk to
 provide proper naming of the Terratec Aureon 5.1 MkII USB card
Date: Sun, 31 May 2009 23:06:07 +0200
Message-ID: <4A22F13F.6090707@borgia.bo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6299302685747307788=="
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============6299302685747307788==
Content-Type: text/x-diff;
 name="0001-Add-quirk-to-provide-proper-naming-of-the-Terratec-A.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-quirk-to-provide-proper-naming-of-the-Terratec-A.pa";
 filename*1="tch"


Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 5d955aa..d84d6f3 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -1951,6 +1951,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
+	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0028),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "TerraTec",
+		.product_name = "Aureon 5.1 MkII",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+{
 	USB_DEVICE(0x0ccd, 0x0035),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "Miditech",
-- 
1.6.0.4


--===============6299302685747307788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6299302685747307788==--
