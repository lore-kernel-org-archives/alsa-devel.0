From: =?ISO-8859-2?Q?Oto_Pet=F8=EDk?= <oto.petrik@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add TASCAM US122 MKII playback
Date: Mon, 24 Sep 2012 14:25:04 +0200
Message-ID: <CAO073OuiRmoopGpZfc-B0V00obC6EeCSH073nqM691jCAdrRvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 211BC2615C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 14:25:04 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so1922897pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 05:25:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Added quirk to provide at least playback-only support.

Signed-off-by: Oto Petrik <oto.petrik@gmail.com>
---
 sound/usb/quirks-table.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 79780fa..eb03541 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2780,6 +2780,52 @@ YAMAHA_DEVICE(0x7010, "UB99"),

 	}
 },
+{
+	/* Tascam US122 MKII - playback-only support */
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor = 0x0644,
+	.idProduct = 0x8021,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "TASCAM",
+		.product_name = "US122 MKII",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x02,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_88200 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					}
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},

 {
 	/*
-- 
1.7.10.4
