From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [patch] DMX 6Fire USB - firmware loader update
Date: Fri, 28 Jan 2011 19:05:28 +0100
Message-ID: <12dcdcd1f70.-538433390812934540.7013802864555255396@zoho.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6723_1278780990.1296237928301"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 0023B243DE
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 19:05:32 +0100 (CET)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

------=_Part_6723_1278780990.1296237928301
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello all,

I got in contact with a guy for whom the firmware loading didn't work with the current version and I could fix my driver so that firmware loading for all device versions should be supported by now. Here the patch for that.

Also I included some instructions how to install the firmware.

Thanks, Torsten


------=_Part_6723_1278780990.1296237928301
Content-Type: application/octet-stream; name=usb6fire.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=usb6fire.patch

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>
diff -Nur a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
--- a/sound/usb/6fire/chip.c	2011-01-28 09:01:56.000000000 +0100
+++ b/sound/usb/6fire/chip.c	2011-01-28 18:48:19.000000000 +0100
@@ -5,7 +5,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.1
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -29,7 +29,7 @@
 #include <sound/initval.h>
 
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
-MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.0");
+MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.1");
 MODULE_LICENSE("GPL v2");
 MODULE_SUPPORTED_DEVICE("{{TerraTec, DMX 6Fire USB}}");
 
diff -Nur a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
--- a/sound/usb/6fire/firmware.c	2011-01-28 09:01:56.000000000 +0100
+++ b/sound/usb/6fire/firmware.c	2011-01-28 18:50:51.000000000 +0100
@@ -3,15 +3,13 @@
  *
  * Firmware loader
  *
- * Currently not working for all devices. To be able to use the device
- * in linux, it is also possible to let the windows driver upload the firmware.
- * For that, start the computer in windows and reboot.
- * As long as the device is connected to the power supply, no firmware reload
- * needs to be performed.
+ * Firmware installation script and instructions can be found at
+ * http://sourceforge.net/projects/sixfireusb in the files
+ * fwinst.sh and fwinst.txt
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.1
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -59,6 +57,10 @@
 	0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef, 0x1f, 0x9f, 0x5f, 0xdf, 0x3f,
 	0xbf, 0x7f, 0xff };
 
+static const u8 known_fw_versions[][4] = {
+	{ 0x03, 0x01, 0x0b, 0x00 }
+};
+
 /*
  * wMaxPacketSize of pcm endpoints.
  * keep synced with rates_in_packet_size and rates_out_packet_size in pcm.c
@@ -363,6 +365,28 @@
 	return 0;
 }
 
+/* check, if the firmware version the devices has currently loaded
+ * is known by this driver. 'version' needs to have 4 bytes version
+ * info data. */
+static int usb6fire_fw_check(u8 *version)
+{
+	int i;
+	bool found = false;
+
+	for (i = 0; i < ARRAY_SIZE(known_fw_versions); i++)
+		if (!memcmp(version, known_fw_versions, 4)) {
+			found = true;
+			break;
+		}
+	if (!found) {
+		snd_printk(KERN_ERR PREFIX "invalid fimware version in device. "
+			    "please reconnect to power. if this failure "
+			    "still happens, check your firmware installation.");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int usb6fire_fw_init(struct usb_interface *intf)
 {
 	int i;
@@ -378,9 +402,7 @@
 				"firmware state.\n");
 		return ret;
 	}
-	if (buffer[0] != 0xeb || buffer[1] != 0xaa || buffer[2] != 0x55
-			|| buffer[4] != 0x03 || buffer[5] != 0x01 || buffer[7]
-			!= 0x00) {
+	if (buffer[0] != 0xeb || buffer[1] != 0xaa || buffer[2] != 0x55) {
 		snd_printk(KERN_ERR PREFIX "unknown device firmware state "
 				"received from device: ");
 		for (i = 0; i < 8; i++)
@@ -389,7 +411,7 @@
 		return -EIO;
 	}
 	/* do we need fpga loader ezusb firmware? */
-	if (buffer[3] == 0x01 && buffer[6] == 0x19) {
+	if (buffer[3] == 0x01) {
 		ret = usb6fire_fw_ezusb_upload(intf,
 				"6fire/dmx6firel2.ihx", 0, NULL, 0);
 		if (ret < 0)
@@ -397,7 +419,10 @@
 		return FW_NOT_READY;
 	}
 	/* do we need fpga firmware and application ezusb firmware? */
-	else if (buffer[3] == 0x02 && buffer[6] == 0x0b) {
+	else if (buffer[3] == 0x02) {
+		ret = usb6fire_fw_check(buffer + 4);
+		if (ret < 0)
+			return ret;
 		ret = usb6fire_fw_fpga_upload(intf, "6fire/dmx6firecf.bin");
 		if (ret < 0)
 			return ret;
@@ -410,8 +435,8 @@
 		return FW_NOT_READY;
 	}
 	/* all fw loaded? */
-	else if (buffer[3] == 0x03 && buffer[6] == 0x0b)
-		return 0;
+	else if (buffer[3] == 0x03)
+		return usb6fire_fw_check(buffer + 4);
 	/* unknown data? */
 	else {
 		snd_printk(KERN_ERR PREFIX "unknown device firmware state "
diff -Nur a/sound/usb/Kconfig b/sound/usb/Kconfig
--- a/sound/usb/Kconfig	2011-01-28 18:33:39.000000000 +0100
+++ b/sound/usb/Kconfig	2011-01-28 18:59:29.000000000 +0100
@@ -107,9 +107,7 @@
           Say Y here to include support for TerraTec 6fire DMX USB interface.
 
           You will need firmware files in order to be able to use the device
-          after it has been coldstarted. This driver currently does not support
-          firmware loading for all devices. If you own such a device,
-          you could start windows and let the windows driver upload
-          the firmware. As long as you do not unplug your device from power,
-          it should be usable.
+          after it has been coldstarted. To install the firmware, visit the
+	  project page at http://sourceforge.net/projects/sixfireusb
+	  and download the files fwinst.sh and fwinst.txt in the tools folder.
 

------=_Part_6723_1278780990.1296237928301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_6723_1278780990.1296237928301--
