From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH 1/4 v5] Revert "ALSA: usb-audio: Add quirk for
	Focusrite Scarlett
Date: Thu,  6 Nov 2014 08:33:35 -0600
Message-ID: <1415284418-13605-2-git-send-email-chris.j.arges@canonical.com>
References: <s5hppd39sm8.wl-tiwai@suse.de>
 <1415284418-13605-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 28722260695
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 15:33:46 +0100 (CET)
In-Reply-To: <1415284418-13605-1-git-send-email-chris.j.arges@canonical.com>
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
Cc: tiwai@suse.de, th55@gmx.de, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This reverts commit 1762a59d8e8b5e99f6f4a0f292b40f3cacb108ba.

This quirk is not needed because support for the Scarlett mixers will be added.

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 sound/usb/quirks-table.h | 51 ------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c657752..51686c7 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2667,57 +2667,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.type = QUIRK_MIDI_NOVATION
 	}
 },
-{
-	/*
-	 * Focusrite Scarlett 18i6
-	 *
-	 * Avoid mixer creation, which otherwise fails because some of
-	 * the interface descriptor subtypes for interface 0 are
-	 * unknown.  That should be fixed or worked-around but this at
-	 * least allows the device to be used successfully with a DAW
-	 * and an external mixer.  See comments below about other
-	 * ignored interfaces.
-	 */
-	USB_DEVICE(0x1235, 0x8004),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Focusrite",
-		.product_name = "Scarlett 18i6",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				/* InterfaceSubClass 1 (Control Device) */
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				/* InterfaceSubClass 1 (Control Device) */
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				/* InterfaceSubClass 1 (Device Firmware Update) */
-				.ifnum = 5,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
 
 /* Access Music devices */
 {
-- 
2.1.3
