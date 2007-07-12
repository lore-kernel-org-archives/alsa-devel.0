From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: RE : RE :  M-Audio Audiophile USB,
	native little	endian  (S16_LE) ?
Date: Thu, 12 Jul 2007 23:21:19 +0200
Message-ID: <20070712232119.59bibpnreo84s0sc@webmail.supelec.fr>
References: <012401c7c3a7$a1719a00$161ce4a0@supelec.fr>
	<012501c7c3a8$77077d10$161ce4a0@supelec.fr>
	<s5hwsx7i5e7.wl%tiwai@suse.de>
	<20070711234803.ar9mahpbks0sogc0@webmail.supelec.fr>
	<s5hbqeihsx4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_6hdhnk75u30o"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 142DB103843
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 23:21:21 +0200 (CEST)
In-Reply-To: <s5hbqeihsx4.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, 'Hakan Lennestal' <Hakan.Lennestal@brfsodrahamn.se>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--=_6hdhnk75u30o
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-
>> Summary: Audiophile-usb fix (corrects little-endianness in 16bit
>> modes, resets interfaces at device initialization, and updates the
>> documentation)
>>
>> Signed-Of-By: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
>
> Thanks, applied now.
>
>
> Takashi

Hi,

Hakan reported to me (off-list) that the AC3 function works correctly  
with the device except in device_setup=0x00 mode because the interface  
is reported to be little endian whereas it is in fact big-endian (in  
this mode only).

With the help of Hakan I made a fix and updated the doc accordingly.
Hakan could you test this fix (to be applied after my last one) and  
report if it is ok for you ?

Takashi, in case everything is ok and you want to apply the patch:

Summary: Fixed AC3 interface in device_setup=0x00 mode thanks to Hakan  
Lennestal and updated documentation
Signed-Of-By: Thibault Le Meur <Thibault.LeMeur@supelec.fr>


Thanks in advance,
Thibault



--=_6hdhnk75u30o
Content-Type: text/x-patch;
	charset=UTF-8;
	name="ma-audiophile-ac3fix.diff"
Content-Disposition: attachment;
	filename="ma-audiophile-ac3fix.diff"
Content-Transfer-Encoding: quoted-printable

--- alsa-kernel/Documentation/Audiophile-Usb.txt=092007-07-12 23:15:04.00000=
0000 +0200
+++ new/alsa-kernel/Documentation/Audiophile-Usb.txt=092007-07-12 23:00:04.0=
00000000 +0200
@@ -1,4 +1,4 @@
-=09Guide to using M-Audio Audiophile USB with ALSA and Jack=09v1.4
+=09Guide to using M-Audio Audiophile USB with ALSA and Jack=09v1.5
 =09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
 =09    Thibault Le Meur <Thibault.LeMeur@supelec.fr>
@@ -12,6 +12,8 @@
  - Added Low Endianness nature of 16bits-modes
    found by Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
  - Modifying document structure
+* v1.5 - Thibault Le Meur (2007-07-12)
+ - Added AC3/DTS passthru info
=20
=20
 1 - Audiophile USB Specs and correct usage
@@ -105,9 +107,12 @@
=20
 In this mode, the device uses Big Endian byte-encoding so that=20
 supported audio format are S16_BE for 16-bit depth modes and S24_3BE for=20
-24-bits depth mode. One exception is the hw:1,2 port which is reported=20
-to be Little Endian compliant (supposedly supporting S16_LE) but processes=
=20
-in fact only S16_BE streams.
+24-bits depth mode.
+
+One exception is the hw:1,2 port which was reported to be Little Endian=20
+compliant (supposedly supporting S16_LE) but processes in fact only S16_BE =
streams.
+This has been fixed in kernel 2.6.23 and above and now the hw:1,2 interface=
=20
+is reported to be big endian in this default driver mode.
=20
 Examples:
  * playing a S24_3BE encoded raw file to the Ao port
@@ -116,6 +121,8 @@
    % arecord -D hw:1,1 -c2  -t raw -r48000 -fS24_3BE test.raw
  * playing a S16_BE encoded raw file to the Do port
    % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test.raw
+ * playing an ac3 sample file to the Do port
+   % aplay -D hw:1,2 --channels=3D6 ac3_S16_BE_encoded_file.raw
=20
 If you're happy with the default Alsa driver mode and don't experience any=
=20
 issue with this mode, then you can skip the following chapter.
@@ -205,13 +212,16 @@
=20
 3.2.1.3 - AC3 w/ DTS passthru mode
=20
-This mode is untested, I have no AC3 compliant device to test it. I uses:
+Thanks to Hakan Lennestal, I now have a report saying that this mode works.
=20
  * device_setup=3D0x03
    - 16bits 48kHz mode with only the Do port enabled=20
-   - AC3 with DTS passthru (not tested)
+   - AC3 with DTS passthru
    - Caution with this setup the Do port is mapped to the pcm device hw:1,0
=20
+The command line used to playback the AC3/DTS encoded .wav-files in this mo=
de:
+   % aplay -D hw:1,0 --channels=3D6 ac3_S16_LE_encoded_file.raw
+
 3.2.2 - How to use the device_setup parameter
 ----------------------------------------------
=20
--- alsa-kernel/usb/usbaudio.c=092007-07-12 23:15:05.000000000 +0200
+++ new/alsa-kernel/usb/usbaudio.c=092007-07-12 22:33:32.000000000 +0200
@@ -2532,7 +2532,18 @@
 =09=09 *        but we give normal PCM format to get the existing
 =09=09 *        apps working...
 =09=09 */
-=09=09pcm_format =3D SNDRV_PCM_FORMAT_S16_LE;
+=09=09switch (chip->usb_id) {
+
+=09=09case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
+=09=09=09if (device_setup[chip->index] =3D=3D 0x00 &&=20
+=09=09=09    fp->altsetting =3D=3D 6)
+=09=09=09=09pcm_format =3D SNDRV_PCM_FORMAT_S16_BE;
+=09=09=09else
+=09=09=09=09pcm_format =3D SNDRV_PCM_FORMAT_S16_LE;
+=09=09=09break;
+=09=09default:
+=09=09=09pcm_format =3D SNDRV_PCM_FORMAT_S16_LE;
+=09=09}
 =09} else {
 =09=09pcm_format =3D parse_audio_format_i_type(chip, fp, format, fmt);
 =09=09if (pcm_format < 0)

--=_6hdhnk75u30o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_6hdhnk75u30o--
