From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH] usb-6fire: Modify firmware version check
Date: Thu, 23 May 2013 13:38:29 +0200
Message-ID: <20130523133829.71e40688a43163bec22d17b9@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 86735261736
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 13:38:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Check only the uppermost 16 bits instead of the whole 32 bits of
the version information. Do this because all firmware version tested
with this version information worked correctly and the strict check
causes problems for several users.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
--- a/sound/usb/6fire/firmware.c	2013-05-23 13:32:39.432545897 +0200
+++ b/sound/usb/6fire/firmware.c	2013-05-23 13:33:21.998193012 +0200
@@ -42,8 +42,8 @@
 	0x94, 0x01, 0x5c, 0x02  /* alt 3: 404 EP2 and 604 EP6 (25 fpp) */
 };
 
-static const u8 known_fw_versions[][4] = {
-	{ 0x03, 0x01, 0x0b, 0x00 }
+static const u8 known_fw_versions[][2] = {
+	{ 0x03, 0x01 }
 };
 
 struct ihex_record {
@@ -343,7 +343,7 @@
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(known_fw_versions); i++)
-		if (!memcmp(version, known_fw_versions + i, 4))
+		if (!memcmp(version, known_fw_versions + i, 2))
 			return 0;
 
 	snd_printk(KERN_ERR PREFIX "invalid fimware version in device: %*ph. "
