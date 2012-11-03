From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,
	RFC 3/6] usb-audio: M-Audio Fast Track C400 quirks table
Date: Sat,  3 Nov 2012 14:40:08 +0100
Message-ID: <1351950011-8915-4-git-send-email-eldad@fogrefinery.com>
References: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF78261710
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 14:40:33 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so1459057bku.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 06:40:33 -0700 (PDT)
In-Reply-To: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Chris Cavey <chris-alsa@rauros.net>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Adds a quirks table for the M-Audio Fast Track C400.

Based on the following patch from the alsa-devel list:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-May/051676.html

See also:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-April/051219.html

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/quirks-table.h |   71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 88d8ceb..7ec7b7f 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2296,6 +2296,77 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "M-Audio", */
+		/* .product_name = "Fast Track C400", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			/* Playback */
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_AP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x01,
+					.ep_attr = 0x09,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_88200 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+							44100, 48000, 88200, 96000
+					},
+					.clock = 0x81,
+				}
+			},
+			/* Capture */
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 4,
+					.iface = 3,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x81,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_88200 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					},
+					.clock = 0x81,
+				}
+			},
+			/* MIDI */
+			{
+				.ifnum = -1 /* Interface = 4 */
+			}
+		}
+	}
+},
 
 /* Casio devices */
 {
-- 
1.7.8.6
