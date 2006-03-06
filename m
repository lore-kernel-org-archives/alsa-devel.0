From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: [RFC][PATCH] snd-usb-audio and audiophile usb analog capture
Date: Mon, 6 Mar 2006 10:49:52 +0100
Message-ID: <05a301c64103$53fe4d40$a578e4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from laposte.supelec.fr (laposte.supelec.fr [160.228.120.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25B631C1
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2006 10:50:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: 'Thibault LE MEUR' <Thibault.LeMeur@supelec.fr>
List-Id: alsa-devel@alsa-project.org

Hi,=20

Here is the patch I'm working on for audiophile usb: It solves bug id =
1801.

I'm sorry for the long post, but I prefer give as much information as
possible to let you understand the patch (and maybe update the docs for =
this
device). You'll find in this mail:
 - A Short and long (very long) description of the patch
 - The patch ;-)

Takashi, I've not added a "true" quirk (function pointer parameter) to =
the
"parse_audio_endpoints" function. Instead I've just made the patch fit =
into
a simple function so that parse_audio_enpoints needs only 2 lines of =
modifs.
 - Do you still think it's necessary to implement a "true" quirk?

Of course any comment is welcome.

Regards,
Thibault

PS: In parse_audio_enpoints I've changed a "snd_printdd" to use "altno" =
(the
true altsetting value) instead of "i" (the index parameter in the =
altsetting
aray) since they may differ in some cases and I think "altno" is more
interresting that "i".


-------------------------------------------------------------------------=
---
--------------------------------------
Short description:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Adds a generic device_setup parameter to be able to alter the way
snd-usb-audio initialize the driver. Together with a quirk for =
audiophile
usb, this solves bugid 1801 for analog capture on this device.

Log story:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
	At initialization of the M-Audio Audiophile usb device, a specific
altSettings subset must be selected to ensure a correct device
synchronization: this subset depends on the audio functions and
"Rate/Resolution mode" that will be used. Thus, this initialization =
setting
must be sent as a parameter to the driver before the actual device's
initialization take place.

	This patch adds a new module parameter called "device_setup"
(integer) that might be used for any device. As a convention, I propose =
that
when this parameter is omitted, its default value remains 0x00 which may
always mean "do not change Alsa driver's default behaviour". This way, =
new
driver versions will not break previously working setups.=20

	The meaning of the device parameter depends on the device. For the
audiophile usb, the device_setup is one byte long and its structure is =
the
following:

	+---+---+---+---+---+---+---+---+
	| b7| b6| b5| b4| b3| b2| b1| b0|
	+---+---+---+---+---+---+---+---+
	| 0 | 0 | 0 | Di|24B|96K|DTS|SET|
	+---+---+---+---+---+---+---+---+
Where:
	- b0 is the "SET" bit: it MUST be set if device_parameter is not
0x00
	- b1 is the "DTS" bit: it is set only if Digital output with DTS/AC3
is needed (though I'm not sure it is working)
	- b2 is the Rate selection flag. When set to "1" the range
"48-96KHz" is used. Otherwise the sample rate range is 8-48KHz
	- b3 is the Resolution selection flag. When set to "1" samples are
encoded 24bits long, otherwise they are 16bits long
	- b4 is the Digital input flag: When set to "1" the device assumes
that an active digital source is connected (this may lead to =
synchronization
issues if it is not the case).=20
	- b5 to b7 are reserved for future uses, and must be set to "0"
(might become Ao, Do, Ai, for b7, b6, b4 respectively)

The parameter can be given when manually probing the device:
	"# modprobe snd-usb-audio index=3D1 device_setup=3D0x9"

or in /etc/modprobe.conf (example for Fedora):
--------------------------------------------------
alias snd-card-1 snd-usb-audio
options snd-usb-audio index=3D1 device_setup=3D0x09
-------------------------------------------------

The patch also adds a quirk for audiophile usb, in order to only let =
Alsa
register interfaces that do correspond to "device_setup", so that no
initialization error is done.

Supported modes are:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	- Default Alsa behaviour: "device_setup=3D0x00" (this is the default
if device_setup is not given)
		* all interfaces capabilities are registered in Alsa as they
were before the patch
		* Caution: Analog capture is rarely well initialized (bug id
1801)
		* hw:1,0 is Analog playback and Digital Capture, and hw:1,1
is Digital playback and Analog Capture
		* hw:1,2 is digital playback in DTS mode
	- 24bits 96KHz mode: "device_setup=3D0x05"
		* each audio function is working for 8Khz-96Khz
		* But due to usb bandwith constraints only one interface can
be set at the same time
		* hw:1,0 is Analog playback and Digital Capture, and hw:1,1
is Digital playback and Analog Capture
	- 24bits 48KHz without Digital Input connected: "device_setup=3D0x09"
		* Analog and digital playback, as well as Analog capture can
be activated at the same time
		* hw:1,0 is not enabled as a capture device (Digital Input)
		* hw:1,0 is Analog playback, and hw:1,1 is Digital playback
and Analog Capture
	- 24bits 48KHz with Digital Input connected: "device_setup=3D0x19"
                * Though hw:1,0 and hw:1,1 are available as both =
playback
and capture device, only 3 functions can be activated at the same time =
due
to usb bandwidth limitations
		* hw:1,0 is Analog playback and Digital Capture, and hw:1,1
is Digital playback and Analog Capture
		* Caution: if no active digital signal is seen on the
Digital input interface, synchronization issues may occur (see the
audiophile usb documentation)
	- 16bits 48KHz with Digital Input connected: "device_setup=3D0x11"
                * hw:1,0 and hw:1,1 are available as both playback and
capture device, all 4 functions can be activated at the same time
		* hw:1,0 is Analog playback and Digital Capture, and hw:1,1
is Digital playback and Analog Capture
		* Caution: if no active digital signal is seen on the
Digital input interface, synchronization issues may occur (see the
audiophile usb documentation)
	- 16bits 48KHz without Digital Input connected: "device_setup=3D0x01"
		* Analog and digital playback, as well as Analog capture can
be activated at the same time
		* hw:1,0 is not enabled as a capture device (Digital Input)
		* hw:1,0 is Analog playback, and hw:1,1 is Digital playback
and Analog Capture
	- DTS (AC3 encoding on Digital output only in 16bits Little endian):
"device_setup=3D0x03"
		* I don't know if it is really supported by Alsa
		* Caution: hw:1,0 is Digital playback

Technical Details for Audiophile Usb:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following specs have been discovered by usb-snooping the windows and
linux drivers.

The M-Audio Audiophile USB has 4 audio functions, each one corresponding =
to
a USB interface:
	- Analog Output  is Usb Interface n=B02
	- Digital Output is Usb Interface n=B03
	- Analog Input   is Usb Interface n=B04
	- Digital Input  is Usb Interface n=B05

Each interface has 5 altsettings (AltSet 1,2,3,4,5) except:
	- Interface 3 (Digital Out) has an extra Alset n=B06 that correspond
to DTS output
	- Interface 5 (Digital In) Do not have Alset n=B03 and 5 (chich are
synchronous inputs or adaptive outputs for other interfaces)

At initialization time, the driver _must_know_ how the device will be =
used
(this is a hardware constraint):
	- if DTS is choosen, only Interface 2 with AltSet n=B06 must be
registered
	- if 96KHz only AltSets n=B01 of each interface must be selected
	- if samples are using 24bits/48KHz then AltSet 2 must me used if
Digital input is connected, and only AltSet n=B03 if Digital input is =
not
connected=20
	- if samples are using 16bits/48KHz then AltSet 4 must me used if
Digital input is connected, and only AltSet n=B05 if Digital input is =
not
connected
	=20




Summary: Fixes Analog capture for audiophile usb and adds a new module
parameter device_setup=20
Signed-off-by: Thibault LE MEUR <Thibault.LeMeur@supelec.fr>
-------------------------------------------------------------------------=
---
--------------------------------------

--- /usr/src/alsa/alsa-cvs-02282006/alsa-driver/usb/usbaudio.c	=
2006-03-05
21:41:48.000000000 +0100
+++ /usr/src/alsa/alsa-cvs-02282006.patched/alsa-driver/usb/usbaudio.c
2006-03-05 21:52:14.000000000 +0100
@@ -76,6 +76,7 @@
 #else
 0; /* disabled as default for buggy async-unlink handling */
 #endif
+static int device_setup =3D 0x00; /* device specific setup (parameter's
meaning depends on the physical devicer) */
=20
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -91,6 +92,8 @@
 MODULE_PARM_DESC(nrpacks, "Max. number of packets per URB.");
 module_param(async_unlink, bool, 0444);
 MODULE_PARM_DESC(async_unlink, "Use async unlink mode.");
+module_param(device_setup, int, 0444);
+MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
=20
=20
 /*
@@ -2547,6 +2550,7 @@
 	return 0;
 }
=20
+int audiophile_skip_setting_quirk(int iface, int altno);
 static int parse_audio_endpoints(struct snd_usb_audio *chip, int =
iface_no)
 {
 	struct usb_device *dev;
@@ -2585,6 +2589,10 @@
 		stream =3D (get_endpoint(alts, 0)->bEndpointAddress &
USB_DIR_IN) ?
 			SNDRV_PCM_STREAM_CAPTURE :
SNDRV_PCM_STREAM_PLAYBACK;
 		altno =3D altsd->bAlternateSetting;
+=09
+		/* quirk for audiophile usb: skip AltSets not corresponding
to device_setup */
+		if (chip->usb_id =3D=3D USB_ID(0x0763, 0x2003) &&=20
+		    audiophile_skip_setting_quirk(iface_no,altno)) continue;
=20
 		/* get audio formats */
 		fmt =3D snd_usb_find_csint_desc(alts->extra, alts->extralen,
NULL, AS_GENERAL);
@@ -2683,7 +2691,7 @@
 			continue;
 		}
=20
-		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n",
dev->devnum, iface_no, i, fp->endpoint);
+		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n",
dev->devnum, iface_no, altno, fp->endpoint);
 		err =3D add_audio_endpoint(chip, stream, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);
@@ -3112,6 +3120,35 @@
 	return 0;
 }
=20
+/*
+ * Setup quirks
+ */
+#define AUDIOPHILE_SET			0x01 /* bit mask for device_setup
availability */
+#define AUDIOPHILE_SET_DTS              0x02 /* bit mask for AC3/DTS
Digital Output */
+#define AUDIOPHILE_SET_96K              0x04 /* bit mask for the =
48-96KHz
range (8-48KHz otherwise)*/
+#define AUDIOPHILE_SET_24B              0x08 /* bit mask for 24bits
resolution (16bits otherwise) */
+#define AUDIOPHILE_SET_DI               0x10 /* bit mask for Digital =
Input
activation*/
+#define AUDIOPHILE_SET_MASK      	0x1F /* bit mask for AltSet setup
mode */
+#define AUDIOPHILE_SET_24B_48K_DI	0x19 /* bit check result for
24bits+48KHz+Digital Input */
+#define AUDIOPHILE_SET_24B_48K_NOTDI 	0x09 /* bit check result for
24bits+48KHz+No Digital Input */
+#define AUDIOPHILE_SET_16B_48K_DI    	0x11 /* bit check result for
16bits+48KHz+Digital Input */
+#define AUDIOPHILE_SET_16B_48K_NOTDI 	0x01 /* bit check result for
16bits+48KHz+No Digital Input */
+
+int audiophile_skip_setting_quirk(int iface, int altno) {
+	if (device_setup & AUDIOPHILE_SET) {
+		if ((device_setup & AUDIOPHILE_SET_DTS) && altno !=3D 6)
return 1;=09
+		if ((device_setup & AUDIOPHILE_SET_96K) && altno !=3D 1)
return 1;
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D
AUDIOPHILE_SET_24B_48K_DI &&
+		     altno !=3D 2) return 1;
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D
AUDIOPHILE_SET_24B_48K_NOTDI &&
+		     altno !=3D 3) return 1;
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D
AUDIOPHILE_SET_16B_48K_DI &&
+		     altno !=3D 4) return 1;
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D
AUDIOPHILE_SET_16B_48K_NOTDI &&
+		     altno !=3D 5) return 1;
+	}=09
+	return 0; /*do not skip otherwise*/
+}
=20
 /*
  * audio-interface quirks

-------------------------------------------------------------------------=
---
--






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
