From: Chris J Arges <christopherarges@gmail.com>
Subject: [PATCH] ALSA: usbaudio Mbox support, output only
Date: Wed, 17 Feb 2010 12:26:15 -0600
Message-ID: <1266431175.3167.118.camel@macgyver>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-g9t4QPaQL9hW42/Pyv3o"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id F1009243F8
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 19:26:21 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so1148095qwf.56
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 10:26:20 -0800 (PST)
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
Cc: tiwai@suse.de, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--=-g9t4QPaQL9hW42/Pyv3o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This minimal patch has been tested on my laptop and currently output
only works. This patch is based off of code that Clemens Ladisch posted
on the alsa-devel mailing list way back in 2004.

--chris j arges

--=-g9t4QPaQL9hW42/Pyv3o
Content-Disposition: attachment; filename="0001-ALSA-usbaudio-Mbox-support-output-only.patch"
Content-Type: text/x-patch; name="0001-ALSA-usbaudio-Mbox-support-output-only.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From d079f1d7298d06597fa7d4c3c4aa8979864342ac Mon Sep 17 00:00:00 2001
From: Chris J Arges <christopherarges@gmail.com>
Date: Wed, 17 Feb 2010 12:12:52 -0600
Subject: [PATCH] ALSA: usbaudio Mbox support, output only

Signed-off-by: Chris J Arges <christopherarges@gmail.com>

---
 sound/usb/usbquirks.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index e691eba..14552d2 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -2215,6 +2215,51 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* Digidesign Mbox */
+{
+	/* Thanks to Clemens Ladisch <clemens@ladisch.de> */
+	USB_DEVICE(0x0dba, 0x1000),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Digidesign",
+		.product_name = "MBox",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]){
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S24_3BE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x02,
+					.ep_attr = 0x01,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000,
+					.rate_min = 44100,
+					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					}
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
-- 
1.6.3.3


--=-g9t4QPaQL9hW42/Pyv3o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-g9t4QPaQL9hW42/Pyv3o--
