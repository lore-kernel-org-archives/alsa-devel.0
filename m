From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v3 2/5] snd-usb-6fire: add tlv to controls
Date: Wed, 22 Feb 2012 15:20:54 +0100
Message-ID: <20120222152054.2ef303842197075c44d2ce62@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D7C98104067
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 15:20:58 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Remove the soft log-conversion and add a dB scale according to
the DAC documentation instead.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-09 22:33:01.512182294 +0100
+++ b/sound/usb/6fire/control.c	2012-01-17 18:36:14.480508754 +0100
@@ -15,6 +15,7 @@
 
 #include <linux/interrupt.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 
 #include "control.h"
 #include "comm.h"
@@ -24,26 +25,6 @@
 static char *line_phono_texts[2] = { "Line", "Phono" };
 
 /*
- * calculated with $value\[i\] = 128 \cdot sqrt[3]{\frac{i}{128}}$
- * this is done because the linear values cause rapid degredation
- * of volume in the uppermost region.
- */
-static const u8 log_volume_table[128] = {
-	0x00, 0x19, 0x20, 0x24, 0x28, 0x2b, 0x2e, 0x30, 0x32, 0x34,
-	0x36, 0x38, 0x3a, 0x3b, 0x3d, 0x3e, 0x40, 0x41, 0x42, 0x43,
-	0x44, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e,
-	0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53, 0x53, 0x54, 0x55, 0x56,
-	0x56, 0x57, 0x58, 0x58, 0x59, 0x5a, 0x5b, 0x5b, 0x5c, 0x5c,
-	0x5d, 0x5e, 0x5e, 0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62,
-	0x63, 0x63, 0x64, 0x65, 0x65, 0x66, 0x66, 0x67, 0x67, 0x68,
-	0x68, 0x69, 0x69, 0x6a, 0x6a, 0x6b, 0x6b, 0x6c, 0x6c, 0x6c,
-	0x6d, 0x6d, 0x6e, 0x6e, 0x6f, 0x6f, 0x70, 0x70, 0x70, 0x71,
-	0x71, 0x72, 0x72, 0x73, 0x73, 0x73, 0x74, 0x74, 0x75, 0x75,
-	0x75, 0x76, 0x76, 0x77, 0x77, 0x77, 0x78, 0x78, 0x78, 0x79,
-	0x79, 0x7a, 0x7a, 0x7a, 0x7b, 0x7b, 0x7b, 0x7c, 0x7c, 0x7c,
-	0x7d, 0x7d, 0x7d, 0x7e, 0x7e, 0x7e, 0x7f, 0x7f };
-
-/*
  * data that needs to be sent to device. sets up card internal stuff.
  * values dumped from windows driver and filtered by trial'n'error.
  */
@@ -69,6 +50,8 @@
 static const u16 rates_6fire_vl[] = {0x00, 0x01, 0x00, 0x01, 0x00, 0x01};
 static const u16 rates_6fire_vh[] = {0x11, 0x11, 0x10, 0x10, 0x00, 0x00};
 
+static DECLARE_TLV_DB_MINMAX(tlv_output, -9000, 0);
+
 enum {
 	DIGITAL_THRU_ONLY_SAMPLERATE = 3
 };
@@ -78,8 +61,7 @@
 	struct comm_runtime *comm_rt = rt->chip->comm;
 	if (comm_rt) {
 		/* set volume */
-		comm_rt->write8(comm_rt, 0x12, 0x0f, 0x7f -
-				log_volume_table[rt->master_vol]);
+		comm_rt->write8(comm_rt, 0x12, 0x0f, 180 - rt->master_vol);
 		 /* unmute */
 		comm_rt->write8(comm_rt, 0x12, 0x0e, 0x00);
 	}
@@ -170,7 +152,7 @@
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 127;
+	uinfo->value.integer.max = 180;
 	return 0;
 }
 
@@ -291,10 +273,12 @@
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Volume",
 		.index = 0,
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 		.info = usb6fire_control_master_vol_info,
 		.get = usb6fire_control_master_vol_get,
-		.put = usb6fire_control_master_vol_put
+		.put = usb6fire_control_master_vol_put,
+		.tlv = { .p = tlv_output }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
