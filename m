From: Julian Wiesener <jw@vtoc.de>
Subject: [PATCH RFC RESEND] ALSA: usb-audio: quirks for Roland
	MX-1
Date: Mon, 29 Apr 2019 13:01:49 +0300
Message-ID: <20190429130149.2074b987@ardbeg.dac.vtoc.de>
References: <20190210001643.3e4f3f15@ardbeg.dac.vtoc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vtoc.de (mail.vtoc.de [IPv6:2a01:4f8:a0:4ffe::9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2AB4F80641
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 12:01:51 +0200 (CEST)
Received: from ardbeg.dac.vtoc.de (unknown
 [IPv6:2a02:2f0e:204:2300:84d9:248a:23d8:abff])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by mail.vtoc.de (Postfix) with ESMTPSA id 23F5D70B6
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 12:01:51 +0200 (CEST)
In-Reply-To: <20190210001643.3e4f3f15@ardbeg.dac.vtoc.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

i did send the patch a few month ago, however i didn't got any feedback.

The Patch workarrounds the fact that the device appears to be working ASYNC, however it will be hanging, not playing or capturing a single byte. The 2 channel Altset kind of works, but sound is distorded. The 18 channel Altset works as intended.


diff --git a/quirks-table.h.orig b/quirks-table.h
index b345beb..7272b46 100644
--- a/quirks-table.h.orig
+++ b/quirks-table.h
@@ -1777,6 +1777,109 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/* has ID 0x006e when not in "Advanced Driver" mode */
+	USB_DEVICE(0x0582, 0x01a3),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Roland",
+		.product_name = "MX-1",
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
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 0x12,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x0d,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_NONE,
+					.rates = SNDRV_PCM_RATE_96000,
+					.rate_min = 96000,
+					.rate_max = 96000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 96000 }
+				}
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 2,
+					.altset_idx = 2,
+					.endpoint = 0x0d,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_NONE,
+					.rates = SNDRV_PCM_RATE_96000,
+					.rate_min = 96000,
+					.rate_max = 96000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 96000 }
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 0x12,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x8e,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_NONE,
+					.rates = SNDRV_PCM_RATE_96000,
+					.rate_min = 96000,
+					.rate_max = 96000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 96000 }
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 2,
+					.altset_idx = 2,
+					.endpoint = 0x8e,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_NONE,
+					.rates = SNDRV_PCM_RATE_96000,
+					.rate_min = 96000,
+					.rate_max = 96000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 96000 }
+				}
+			},
+			{
+				.ifnum = 3,
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
 /* this catches most recent vendor-specific Roland devices */
 {
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
