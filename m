From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: usb-audio: fix BOSS ME-25 MIDI regression
Date: Sat, 09 Aug 2014 17:19:41 +0200
Message-ID: <53E63C0D.2020809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 47C622610C5
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 17:20:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The BOSS ME-25 turns out not to have any useful descriptors in its MIDI
interface, so its needs a quirk entry after all.

Reported-and-tested-by: Kees van Veen <kees.vanveen@gmail.com>
Fixes: 8e5ced83dd1c ("ALSA: usb-audio: remove superfluous Roland quirks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/quirks-table.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f652b10..223c47b 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1581,6 +1581,35 @@
 	}
 },
 {
+	/* BOSS ME-25 */
+	USB_DEVICE(0x0582, 0x0113),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
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
+{
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x0120),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
