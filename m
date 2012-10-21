From: pete.leigh@gmail.com
Subject: [PATCH - my module 1/1] USB audio quirk for Roland
	VG-99 advanced mode
Date: Sun, 21 Oct 2012 10:25:48 +0100
Message-ID: <1350811548-6461-1-git-send-email-pete.leigh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Pete Leigh <pete.leigh@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pete Leigh <pete.leigh@gmail.com>

Without this quirk the VG-99 will work in standard mode (set under
USB on System menu page 2) giving 16 bits at 44.1 Khz audio in/out
but no midi, and is not recognised when set to advanced mode.

After applying this, I can also use the VG-99 in advanced mode: 24
24 bits audio in/out at 44.1 Khz, and midi in/out. Sysex is so far
untested.

In standard mode, the device appears with ID 0x00b3, so the
behaviour isn't affected by this quirk.

Thanks to Clemens Ladisch for simplifying and correcting my initial
attempt!

Signed-off-by: Pete Leigh <pete.leigh@gmail.com>

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 88d8ceb..ffeabf8 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1457,6 +1457,40 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
+	/* Advanced mode of the Roland VG-99, with MIDI and 24-bit PCM at 44.1
+	 * kHz. In standard mode, the device has ID 0582:00b3, and offers
+	 * 16-bit PCM at 44.1 kHz with no MIDI.
+	 */
+	USB_DEVICE(0x0582, 0x00b2),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Roland",
+		.product_name = "VG-99",
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
+					.out_cables = 0x0003,
+					.in_cables  = 0x0003
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+{
 	/* Roland SonicCell */
 	USB_DEVICE(0x0582, 0x00c2),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-- 
1.7.11.7
