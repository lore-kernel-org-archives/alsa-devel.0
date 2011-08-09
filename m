From: Kazutomo Yoshii <kazutomo.yoshii@gmail.com>
Subject: [PATCH] Support for BOSS Micro BR-80
Date: Tue, 09 Aug 2011 03:50:27 -0500
Message-ID: <4E40F4D3.1050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f171.google.com (mail-iy0-f171.google.com
	[209.85.210.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A7891037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 10:50:31 +0200 (CEST)
Received: by iyf13 with SMTP id 13so8863587iyf.2
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 01:50:28 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

This patch adds support for BOSS Micro BR-80, which allows us to use
BR-80 as a USB Audio interface (both playback and capture) and external
MIDI drum sound module(CH10).

Thanks,
Kaz

---
 sound/usb/quirks-table.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 4d4f865..a42e3ef 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1707,6 +1707,40 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0582, 0x0130),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "BOSS", */
+		/* .product_name = "MICRO BR-80", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
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
  /* Guillemot devices */
 {
-- 
1.7.6
