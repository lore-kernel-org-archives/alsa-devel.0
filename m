From: Andrea Borgia <andrea@borgia.bo.it>
Subject: [PATCH - quirk for USB Aureon cards 0/1] reworked
	naming
Date: Sun, 14 Jun 2009 12:31:16 +0200
Message-ID: <4A34D174.6040609@borgia.bo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000205060801080305030206"
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
--------------000205060801080305030206
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch changes yet again the ID for the TTA cards, resulting in a
more reasonable name:
 1 [Aureon51MkII   ]: USB-Audio - Aureon5.1MkII
    TerraTec Aureon5.1MkII at usb-0000:00:03.0-2, full speed

Andrea Borgia (1):
  rework quirk for TerraTec Aureon USB 5.1 MkII

 sound/usb/usbquirks.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--------------000205060801080305030206
Content-Type: text/x-diff;
 name="0001-rework-quirk-for-TerraTec-Aureon-USB-5.1-MkII.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-rework-quirk-for-TerraTec-Aureon-USB-5.1-MkII.patch"

>From 5cae9e0ec7384e02d28d41789c9f126008d97284 Mon Sep 17 00:00:00 2001
From: Andrea Borgia <andrea@borgia.bo.it>
Date: Sun, 14 Jun 2009 12:16:17 +0200
Subject: [PATCH - quirk for USB Aureon cards 1/1] rework quirk for TerraTec Aureon USB 5.1 MkII


Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index f0f7624..f6f201e 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -1989,7 +1989,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	USB_DEVICE(0x0ccd, 0x0028),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "TerraTec",
-		.product_name = "Aureon 5.1 MkII",
+		.product_name = "Aureon5.1MkII",
 		.ifnum = QUIRK_NO_INTERFACE
 	}
 },
-- 
1.6.0.4


--------------000205060801080305030206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000205060801080305030206--
