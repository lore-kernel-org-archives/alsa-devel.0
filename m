From: Martin Peres <martin.peres@free.fr>
Subject: [PATCH] ALSA: usb-audio: Add a quirk for Nura's first
	gen headset
Date: Sun, 14 Jan 2018 18:05:53 +0200
Message-ID: <20180114160553.15445-1-martin.peres@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 436A0266CFE
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 17:06:32 +0100 (CET)
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
Cc: Martin Peres <martin.peres@free.fr>
List-Id: alsa-devel@alsa-project.org

The capture interface does not work, and the playback interface
actually supports only 48kHz unlike what is advertised (44.1, 32, 22,
16, 8).

The only unknown here is if there are other devices that use the same
product ID, but given that this ID is currently unknown, I would assume
it is specially allocated for the nura headset.

Signed-off-by: Martin Peres <martin.peres@free.fr>
---
 sound/usb/quirks-table.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8a59d4782a0f..50252046b01d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3277,4 +3277,52 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 	}
 },
 
+{
+	/*
+	 * Nura's first gen headphones use Cambridge Silicon Radio's vendor
+	 * ID, but it looks like the product ID actually is only for Nura.
+	 * The capture interface does not work at all (even on Windows),
+	 * and only the 48 kHz sample rate works for the playback interface.
+	 */
+	USB_DEVICE(0x0a12, 0x1243),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			/* Capture */
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* Playback */
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_FILL_MAX |
+						UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x03,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.15.1
