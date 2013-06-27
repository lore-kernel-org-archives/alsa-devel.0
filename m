From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 5/7] ALSA: usb-audio: remove superfluous Roland
	quirks
Date: Thu, 27 Jun 2013 22:19:51 +0200
Message-ID: <51CC9E67.3030004@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C37C3265672
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:18:59 +0200 (CEST)
In-Reply-To: <51CC9D8B.7060601@ladisch.de>
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

Remove all quirks that are no longer needed now that the generic Roland
quirks can handle the vendor-specific descriptors correctly.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/quirks-table.h | 471 -----------------------------------------------
 1 file changed, 471 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f1c73fb..da4d87f 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1147,7 +1147,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-	/* TODO: add Roland M-1000 support */
 {
 	/*
 	 * Has ID 0x0038 when not in "Advanced Driver" mode;
@@ -1262,7 +1261,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-	/* TODO: add Edirol M-100FX support */
 {
 	/* has ID 0x004e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004c),
@@ -1382,20 +1380,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	/* has ID 0x006b when not in "Advanced Driver" mode */
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x006a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "SP-606",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
-		}
-	}
-},
-{
 	/* has ID 0x006e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x006d),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
@@ -1482,8 +1466,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-	/* TODO: add Roland V-SYNTH XT support */
-	/* TODO: add BOSS GT-PRO support */
 {
 	/* has ID 0x008c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x008b),
@@ -1498,42 +1480,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-	/* TODO: add Edirol PC-80 support */
-{
-	USB_DEVICE(0x0582, 0x0096),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "EDIROL",
-		.product_name = "UA-1EX",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x009a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "EDIROL",
-		.product_name = "UM-3EX",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x000f,
-			.in_cables  = 0x000f
-		}
-	}
-},
 {
 	/*
 	 * This quirk is for the "Advanced Driver" mode. If off, the UA-4FX
@@ -1564,124 +1510,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-	/* TODO: add Edirol MD-P1 support */
-{
-	USB_DEVICE(0x582, 0x00a6),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "Juno-G",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
-		}
-	}
-},
-{
-	/* Roland SH-201 */
-	USB_DEVICE(0x0582, 0x00ad),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "SH-201",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	/* Advanced mode of the Roland VG-99, with MIDI and 24-bit PCM at 44.1
-	 * kHz. In standard mode, the device has ID 0582:00b3, and offers
-	 * 16-bit PCM at 44.1 kHz with no MIDI.
-	 */
-	USB_DEVICE(0x0582, 0x00b2),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "VG-99",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0003,
-					.in_cables  = 0x0003
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	/* Roland SonicCell */
-	USB_DEVICE(0x0582, 0x00c2),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "SonicCell",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
 {
 	/* Edirol M-16DX */
-	/* FIXME: This quirk gives a good-working capture stream but the
-	 *        playback seems problematic because of lacking of sync
-	 *        with capture stream.  It needs to sync with the capture
-	 *        clock.  As now, you'll get frequent sound distortions
-	 *        via the playback.
-	 */
 	USB_DEVICE(0x0582, 0x00c4),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1710,35 +1540,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	/* BOSS GT-10 */
-	USB_DEVICE(0x0582, 0x00da),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
 	/* Advanced modes of the Edirol UA-25EX.
 	 * For the standard mode, UA-25EX has ID 0582:00e7, which
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
@@ -1769,42 +1570,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	/* has ID 0x00ea when not in Advanced Driver mode */
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x00e9),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "Roland", */
-		/* .product_name = "UA-1G", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0104),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "Roland", */
-		/* .product_name = "UM-1G", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
-		}
-	}
-},
-{
 	/* Edirol UM-3G */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0108),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
@@ -1816,242 +1581,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-{
-	/* Boss JS-8 Jam Station  */
-	USB_DEVICE(0x0582, 0x0109),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "BOSS", */
-		/* .product_name = "JS-8", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	/* has ID 0x0110 when not in Advanced Driver mode */
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x010f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "Roland", */
-		/* .product_name = "A-PRO", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x0003,
-			.in_cables  = 0x0007
-		}
-	}
-},
-{
-	/* Roland GAIA SH-01 */
-	USB_DEVICE(0x0582, 0x0111),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Roland",
-		.product_name = "GAIA",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
-				.out_cables = 0x0003,
-				.in_cables  = 0x0003
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x0113),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "BOSS", */
-		/* .product_name = "ME-25", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x0127),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "Roland", */
-		/* .product_name = "GR-55", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	/* Added support for Roland UM-ONE which differs from UM-1 */
-	USB_DEVICE(0x0582, 0x012a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "ROLAND", */
-		/* .product_name = "UM-ONE", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0003
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x011e),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "BOSS", */
-		/* .product_name = "BR-800", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x0130),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "BOSS", */
-		/* .product_name = "MICRO BR-80", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
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
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
-{
-	USB_DEVICE(0x0582, 0x014d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		/* .vendor_name = "BOSS", */
-		/* .product_name = "GT-100", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
 /* this catches most recent vendor-specific Roland devices */
 {
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
