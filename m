From: Felix Homann <fexpop@web.de>
Subject: [PATCH - ALSA: usbaudio: Add basic support for
	M-AudioAdd basic support for M-Audio Fast Track Ultra series
Date: Thu, 25 Mar 2010 11:29:14 +0100
Message-ID: <1269512954-4122-1-git-send-email-fexpop@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <fexpop@web.de>
List-Id: alsa-devel@alsa-project.org

This adds basic support for M-Audio's Fast Track Ultra series of USB audio interfaces. It is a refactored version of
the patch Clemens Ladisch posted some time ago. Neither playback nor capturing work properly at 44100 Hz (don't know why).
The other sampling rates work properly. There's no support for the DSP mixer, yet.

Kind regards,

Felix

Signed-off-by: Felix Homann <fexpop@web.de>

diff --git a/usb/endpoint.c b/usb/endpoint.c
index b1309cd..7b84b61 100644
--- a/usb/endpoint.c
+++ b/usb/endpoint.c
@@ -317,6 +317,8 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			break;
 		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
 		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
+		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra 8 */
+		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
 			/* doesn't set the sample rate attribute, but supports it */
 			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
 			break;
diff --git a/usb/quirks-table.h b/usb/quirks-table.h
index 81c5f8a..91ddef3 100644
--- a/usb/quirks-table.h
+++ b/usb/quirks-table.h
@@ -1826,6 +1826,60 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0763, 0x2080),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "M-Audio", */
+		/* .product_name = "Fast Track Ultra 8", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const struct snd_usb_audio_quirk[]) {
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
+			/* interface 3 (MIDI) is standard compliant */
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0763, 0x2081),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "M-Audio", */
+		/* .product_name = "Fast Track Ultra 8R", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const struct snd_usb_audio_quirk[]) {
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
+			/* interface 3 (MIDI) is standard compliant */
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 /* Casio devices */
 {
diff --git a/usb/urb.c b/usb/urb.c
index ad50d43..e2b7c47 100644
--- a/usb/urb.c
+++ b/usb/urb.c
@@ -918,6 +918,11 @@ void snd_usb_init_substream(struct snd_usb_stream *as,
 		case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
 			subs->ops.retire_sync = retire_playback_sync_urb_hs_emu;
 			break;
+		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra 8  */
+		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
+			subs->ops.prepare_sync = prepare_playback_sync_urb;
+			subs->ops.retire_sync = retire_playback_sync_urb;
+			break;
 		}
 	}
 
-- 
1.7.0.3
