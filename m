From: Martin Schwenke <martin@meltin.net>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for Focusrite
 Scarlett 18i6
Date: Tue, 13 Nov 2012 19:38:03 +1100
Message-ID: <20121113193803.2e0d7c4a@martins.ozlabs.org>
References: <20121109202023.60f6dcdc@martins.ozlabs.org>
 <s5hvcdavwoy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 180A5265117
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 09:38:05 +0100 (CET)
In-Reply-To: <s5hvcdavwoy.wl%tiwai@suse.de>
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

On Tue, 13 Nov 2012 07:33:33 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> Unfortunately your MUA broke lines so the patch cannot be applied
> cleanly.  Please fix your MUA setup and resend, or use an attachment
> if it doesn't work.

Sorry, that's irritating!  Is this better?

peace & happiness,
martin

p.s. I can't see another way of adding a comment like this above the
patch, other than the scissors thing that is processed by "git am -c".
Sorry, I don't know how standard this is...

--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--8<--
Probing this device currently fails in snd_usb_audio_probe() because
the call to snd_usb_create_mixer() fails.  This is due to unknown or
non-standard interface descriptor subtypes in parse_audio_unit():

  usbaudio: unit 51: unexpected type 0x09
  snd-usb-audio: probe of 1-8:1.0 failed with error -5

Some people are working around this by recompiling usb-audio with the
call to snd_usb_create_mixer() commented out.  It would be nice to
avoid that.

While the best idea would be to look into the mixer creation failure,
a reasonable short-term solution is to use quirks to only probe the
trouble-free interfaces.  This allows audio and MIDI interfaces to be
used without any obvious issues.

Interface 0 is the main one to ignore.  It contains lots of
control-fu, including the unexpected interface descriptor subtypes.
Interface 5 is for firmware updates and I'm not sure how to get
support for this.  Interface 3 is some sort of control interface that
I don't understand:

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       1

Signed-off-by: Martin Schwenke <martin@meltin.net>
---
 sound/usb/quirks-table.h |   52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 88d8ceb..c9dde5f 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2882,6 +2882,58 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	/*
+	 * Focusrite Scarlett 18i6
+	 *
+	 * Avoid mixer creation, which otherwise fails because some of
+	 * the interface descriptor subtypes for interface 0 are
+	 * unknown.  That should be fixed or worked-around but this at
+	 * least allows the device to be used successfully with a DAW
+	 * and an external mixer.  See comments below about other
+	 * ignored interfaces.
+	 */
+	USB_DEVICE(0x1235, 0x8004),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Focusrite",
+		.product_name = "Scarlett 18i6",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const struct snd_usb_audio_quirk[]) {
+			{
+				/* InterfaceSubClass 1 (Control Device) */
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
+				/* InterfaceSubClass 1 (Control Device) */
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_MIDI_STANDARD_INTERFACE
+			},
+			{
+				/* InterfaceSubClass 1 (Device Firmware Update) */
+				.ifnum = 5,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
+{
+	/*
 	 * Some USB MIDI devices don't have an audio control interface,
 	 * so we have to grab MIDI streaming interfaces here.
 	 */
-- 
1.7.10.4
