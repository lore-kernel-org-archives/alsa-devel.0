From: Didier Villevalois <ptitjes@free.fr>
Subject: [PATCH] ALSA: usb-audio: Add quirk for Reloop Play
Date: Sun, 21 Oct 2012 18:29:12 +0200
Message-ID: <1350836952-4858-1-git-send-email-ptitjes@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id AD4F7265159
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 18:29:27 +0200 (CEST)
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
Cc: Didier Villevalois <ptitjes@free.fr>
List-Id: alsa-devel@alsa-project.org

The Reloop Audio needs a fixed endpoint quirk with S24_3LE format and
UAC_EP_CS_ATTR_SAMPLE_RATE attribute.

Signed-off-by: Didier Villevalois <ptitjes@free.fr>
---
 sound/usb/quirks-table.h |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d73ac9b..48ede8b 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2834,6 +2834,47 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* Reloop Play */
+{
+	USB_DEVICE(0x200c, 0x100b),
+	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 4,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_SYNC_ADAPTIVE,
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
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
-- 
1.7.10.4
