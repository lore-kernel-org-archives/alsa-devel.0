From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ALSA: USB-audio: Add support for Novation
 Nocturn MIDIcontrol surface
Date: Fri, 16 Oct 2015 13:38:33 +0200
Message-ID: <alpine.DEB.2.02.1510161332480.4075@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 417D4260671
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 13:38:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Ricard at home <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org


The Nocturn needs the MIDI_RAW_BYTES quirk, like other Novation devices.

Tested that the Nocturn shows up in aconnect, and that it can be used
as a control surface (using the xtor synthesizer patch editor).

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---

I've noticed that checkpatch complains about the space between the & and (,
but in the interest of consistency I've not changed this. Is there some
reason for the space, or would it be worth while cleaning up the file?

 sound/usb/quirks-table.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e475665..99de061 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2664,6 +2664,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
+	USB_DEVICE(0x1235, 0x000a),
+	.driver_info =3D (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name =3D "Novation", */
+		/* .product_name =3D "Nocturn", */
+		.ifnum =3D 0,
+		.type =3D QUIRK_MIDI_RAW_BYTES
+	}
+},
+{
 	USB_DEVICE(0x1235, 0x000e),
 	.driver_info =3D (unsigned long) & (const struct snd_usb_audio_quirk) {
 		/* .vendor_name =3D "Novation", */
-- =

2.1.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
