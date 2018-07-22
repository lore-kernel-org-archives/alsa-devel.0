From: Christopher Head <alsa@chead.ca>
Subject: Incorrect name of PCM
Date: Sun, 22 Jul 2018 08:38:50 -0700
Message-ID: <20180722083850.5283c197@amdahl.home.chead.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507087945181371962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lovelace.chead.ca (lovelace.chead.ca [162.223.226.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED7C26763A
 for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2018 17:38:57 +0200 (CEST)
Received: from [192.252.228.35] (helo=amdahl.home.chead.ca)
 by lovelace.chead.ca with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.91) (envelope-from <alsa@chead.ca>) id 1fhGRh-0000Gy-Qx
 for alsa-devel@alsa-project.org; Sun, 22 Jul 2018 08:38:53 -0700
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
List-Id: alsa-devel@alsa-project.org

--===============0507087945181371962==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//BW0u4Xbs02dKvLjjyriLZK"; protocol="application/pgp-signature"

--Sig_//BW0u4Xbs02dKvLjjyriLZK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi folks,
I have an Asus P8H77-I motherboard. On board is an Intel HDA connected
to a Via VT1708S codec. There are a number of analogue ports. In
addition to them, on the back panel are an HDMI port (from an
integrated GPU) and a TOSLINK port. The motherboard manual isn=E2=80=99t to=
tally
clear on whether the HDMI port can also carry sound or only video, but
Windows claims to be able to send sound there, so probably yes. I don=E2=80=
=99t
use the integrated GPU, though.

Here=E2=80=99s the problem:
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: VT1708S Alt Analog [VT1708S Alt
Analog] Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: VT1708S Digital [VT1708S Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

OK, a little bit unexpected that there is only one digital device
listed rather than two. The codec datasheet says it should have two
digital output widgets. Maybe it=E2=80=99s due to the integrated GPU being
disabled though.

$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=3DPCH
    HDA Intel PCH, VT1708S Analog
    Default Audio Device
sysdefault:CARD=3DPCH
    HDA Intel PCH, VT1708S Analog
    Default Audio Device
front:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    Front speakers
surround21:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    2.1 Surround output to Front and Subwoofer speakers
surround40:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
hdmi:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, VT1708S Digital
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D0
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D1
    HDA NVidia, HDMI 1
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D2
    HDA NVidia, HDMI 2
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D3
    HDA NVidia, HDMI 3
    HDMI Audio Output

Why is this wrong? Because when I play to the =E2=80=9Chdmi=E2=80=9D PCM, a=
t least with
the S/PDIF switch turned on in mixer controls, the sound comes out the
TOSLINK port! It seems that the PCM naming is wrong. This is all
without any configuration file. Everything works fine, just the name is
wrong.

I don=E2=80=99t know whether turning off the S/PDIF switch results in the s=
ound
coming out the HDMI port instead; maybe it does (I don=E2=80=99t have anyth=
ing
that speaks HDMI and can also play sound to test with). Either way,
seems like it should be called either =E2=80=9Cspdif=E2=80=9D (if it=E2=80=
=99s only the TOSLINK
port) or some combination of the two (if it=E2=80=99s both and switchable by
the mixer switch).

If replying, please note that I=E2=80=99m not subscribed.

Thanks!
--=20
Christopher Head

--Sig_//BW0u4Xbs02dKvLjjyriLZK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQQl7biEw6IqP57fjDtLFNZko10+CwUCW1SlCgAKCRBLFNZko10+
C7NLAQDqVAPEaYm1SYOdJ59zRtXg3VNrvyG5K2zUCemnoN6MUwD/Top3O1TvPYf7
Ctbj005s2jFBkfR2UXt9LuOQTgIefA4=
=zRbq
-----END PGP SIGNATURE-----

--Sig_//BW0u4Xbs02dKvLjjyriLZK--

--===============0507087945181371962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0507087945181371962==--
