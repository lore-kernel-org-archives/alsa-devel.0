From: Chris Mennie <cmennie@rogers.com>
Subject: [PATCH] Support for Roland SonicCell sound module
Date: Sun, 18 May 2008 13:22:11 -0400
Message-ID: <200805181322.11486.cmennie@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp116.rog.mail.re2.yahoo.com (smtp116.rog.mail.re2.yahoo.com
	[68.142.225.232]) by alsa0.perex.cz (Postfix) with SMTP id 1637324370
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 19:23:02 +0200 (CEST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

	I'm not sure if this is the right place for it, but I've added support for 
the Roland SonicCell sound module. Patches were made against 
alsa-driver-1.0.16 source. Please let me know if there's a better place to 
post this:


--- usbquirks.h	2008-02-05 04:23:24.000000000 -0500
+++ usbquirks.h	2008-05-18 13:02:32.000000000 -0400
@@ -1367,6 +1367,39 @@
 	}
 },
 
+{
+	/* Roland SonicCell */
+	USB_DEVICE(0x0582, 0x00c2),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Roland",
+		.product_name = "SonicCell",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
+
 /* Guillemot devices */
 {
 	/*
