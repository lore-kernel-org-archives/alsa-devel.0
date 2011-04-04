From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 4/5] TerraTec DMX 6Fire USB updates
Date: Mon, 04 Apr 2011 11:49:57 +0200
Message-ID: <12f1feb30c7.-5993834303264871022.359084891425151717@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
	<12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
	<s5hwrjamq64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EEED1038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:49:58 +0200 (CEST)
In-Reply-To: <s5hwrjamq64.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Firmware loader: magical device bytes check updated (accepts all device versions now and accepts possibly loaded firmware, if it is knowing to be working)

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
--- a/sound/usb/6fire/firmware.c	2011-04-04 11:26:54.528833002 +0200
+++ b/sound/usb/6fire/firmware.c	2011-04-04 11:25:27.014833002 +0200
@@ -3,12 +3,6 @@
  *
  * Firmware loader
  *
- * Currently not working for all devices. To be able to use the device
- * in linux, it is also possible to let the windows driver upload the firmware.
- * For that, start the computer in windows and reboot.
- * As long as the device is connected to the power supply, no firmware reload
- * needs to be performed.
- *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
  * Version:	0.3.0
@@ -72,6 +66,10 @@
 	0x94, 0x01, 0x5c, 0x02  /* alt 3: 404 EP2 and 604 EP6 (25 fpp) */
 };
 
+static const u8 known_fw_versions[][4] = {
+	{ 0x03, 0x01, 0x0b, 0x00 }
+};
+
 struct ihex_record {
 	u16 address;
 	u8 len;
@@ -364,6 +362,25 @@
 	return 0;
 }
 
+/* check, if the firmware version the devices has currently loaded
+ * is known by this driver. 'version' needs to have 4 bytes version
+ * info data. */
+static int usb6fire_fw_check(u8 *version)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(known_fw_versions); i++)
+		if (!memcmp(version, known_fw_versions + i, 4))
+			return 0;
+
+	snd_printk(KERN_ERR PREFIX "invalid fimware version in device: "
+			"%02x %02x %02x %02x. "
+			"please reconnect to power. if this failure "
+			"still happens, check your firmware installation.",
+			version[0], version[1], version[2], version[3]);
+	return -EINVAL;
+}
+
 int usb6fire_fw_init(struct usb_interface *intf)
 {
 	int i;
@@ -379,9 +396,7 @@
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
@@ -390,7 +405,7 @@
 		return -EIO;
 	}
 	/* do we need fpga loader ezusb firmware? */
-	if (buffer[3] == 0x01 && buffer[6] == 0x19) {
+	if (buffer[3] == 0x01) {
 		ret = usb6fire_fw_ezusb_upload(intf,
 				"6fire/dmx6firel2.ihx", 0, NULL, 0);
 		if (ret < 0)
@@ -398,7 +413,10 @@
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
@@ -411,8 +429,8 @@
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
