From: noreply@alsa-project.org
Subject: [ALSA - driver 0000270]: Audigy 2 ZS side surround channels not supported
Date: Tue, 15 Jun 2004 16:41:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <94a13bfc4cf6d66cca5e99e1f3711dbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug=
_id=3D0000270
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                wraiden
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     270
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               LFS
Kernel Version:             2.6.5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-11-2004 11:14 CEST
Last Modified:              06-15-2004 16:41 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Audigy 2 ZS side surround channels not suppor=
ted
Description:=20
There is no Support for the side surround channels on SB Audigy 2 ZS (
Platinum Pro ) in Alsa.

I'll try to get it work and test everything you give me to test.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 pzad - 05-11-2004 14:41 CEST=20
----------------------------------------------------------------------
First you must find where are these outputs connected.

in file alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
is row with
A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback +
SND_EMU10K1_PLAYBACK_CHANNELS);=20

append after it this row
A_PUT_STEREO_OUTPUT(0x0c, 0x0d, playback + SND_EMU10K1_PLAYBACK_CHANNELS)=
;


compile, instal, play something. If they are working, let me know.
If not then try change=20
0x0c to 0x12 and 0x0d to 0x13
if stil not working try these too
0x12,0x13
0x14,0x15
0x19,0x1a
0x1b,0x1c
0x1d,0x1e

----------------------------------------------------------------------
 wraiden - 05-21-2004 16:21 CEST=20
----------------------------------------------------------------------
side L ans R channels are working.
patch used for testing is attached.
is 6.1 and 7.1 Surround support in alsa planed?

----------------------------------------------------------------------
 pzad - 05-24-2004 09:21 CEST=20
----------------------------------------------------------------------
I can create volume control (+ controls for mirroring stereo -> 7.1) for
these speakers, and devices something like rearside, and surround71. I
think under linux not many apps uses 7.1 speaker configuration.

----------------------------------------------------------------------
 wraiden - 05-24-2004 16:18 CEST=20
----------------------------------------------------------------------
Nice :)

let me know when it's done and i'll test it.

7.1 related:
- dts and dolby codecs have support up to 7.1 ( and more ).
- sooner or later an decoder will support that.
- support for this speaker configuration would be a benefit for alsa.

----------------------------------------------------------------------
 pzad - 05-31-2004 08:38 CEST=20
----------------------------------------------------------------------
Could you test attached patch audigy2zs_driver.diff ???
Mirroring should work.
There are two new controls:
PCM Side Playback Volume - this is not working for now.
Side Playback Volume - this controls mirroring to side speakers.

This is not final version.
TODO:
- Audigy 2 ZS detection
- alsa lib part

----------------------------------------------------------------------
 bryanhundven - 06-10-2004 22:48 CEST=20
----------------------------------------------------------------------
I tried audigy2zs_driver.diff with alsa-driver-1.0.5a.
Seems to work, but as noted above PCM Side doesn't seem to work.

If you would like me to test anything specific other than xmms...
...Just Ask. :-D

----------------------------------------------------------------------
 wraiden - 06-15-2004 15:56 CEST=20
----------------------------------------------------------------------
i've tested the patch against 1.0.5 and can verify the
above post.

i'll rebuild my entire system over the next weekend
and upgrade to the latest releases of everything.

I want to support alsa with code contributions and plan
to look at the API Documentation however i didn't know
where to begin ( any hints or links ? ).

7.1 related:
xine player seems to support 7.1 a/52 sound
i'm hounting for a good test 7.1 DVD ( a/52 and dts ) now.

----------------------------------------------------------------------
 pzad - 06-15-2004 16:41 CEST=20
----------------------------------------------------------------------
I don't think that xine supports 7.1 (maybe I am wrong)

For 7.1 playback only changes in .conf files are needed in alsa-lib.
Driver should be ok with this patch.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-11-04 11:14 wraiden        New Bug                                    =
 =20
05-11-04 11:14 wraiden        Distribution              =3D> LFS         =
   =20
05-11-04 11:14 wraiden        Kernel Version            =3D> 2.6.5       =
   =20
05-11-04 14:41 pzad           Bugnote Added: 0001084                     =
 =20
05-21-04 16:15 wraiden        File Added: wraiden-alsa-emu10k1-side.patch=
      =20
           =20
05-21-04 16:21 wraiden        Bugnote Added: 0001166                     =
 =20
05-24-04 09:21 pzad           Bugnote Added: 0001181                     =
 =20
05-24-04 16:18 wraiden        Bugnote Added: 0001188                     =
 =20
05-31-04 08:32 pzad           File Added: audigy2zs_driver.diff          =
      =20
 =20
05-31-04 08:38 pzad           Bugnote Added: 0001281                     =
 =20
06-10-04 22:48 bryanhundven   Bugnote Added: 0001298                     =
 =20
06-15-04 15:56 wraiden        Bugnote Added: 0001309                     =
 =20
06-15-04 16:41 pzad           Bugnote Added: 0001310                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
