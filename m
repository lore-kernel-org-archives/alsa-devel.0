From: Sean McCully <sean_mccully@yahoo.com>
Subject: CA0132 6 Channel Output
Date: Tue, 25 Feb 2014 20:34:21 -0600
Message-ID: <1620347.aAIQAEJUSk@seanmccully>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6604388244785026660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm4.bullet.mail.bf1.yahoo.com (nm4.bullet.mail.bf1.yahoo.com
 [98.139.212.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 482BA2619E1
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 03:34:27 +0100 (CET)
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


--===============6604388244785026660==
Content-Type: multipart/signed; boundary="nextPart13272323.ZfdsYXrMPC"; micalg="pgp-sha256"; protocol="application/pgp-signature"


--nextPart13272323.ZfdsYXrMPC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I have  one of these sound cards that came with my motherboard,

/http://www.asrock.com/microsite/intelx79/GameBlaster.html/[1]


Two Channel Output from one audio Jack works perfectly, but there seems to be a 
problem with using the additional audio jacks for 6 channel "surround sound".

http://www.alsa-project.org/db/?f=a8ae0aa3c0da4d697c1df5f403001dff50bb6e51


 pasuspender -- speaker-test --channels=6 --device=surround51:0

speaker-test 1.0.27.2

Playback device is surround51:0
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Channels count (6) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument


$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
oss
    Open Sound System
pulse
    PulseAudio Sound Server
sysdefault:CARD=PCH
    HDA Intel PCH, CA0132 Analog
    Default Audio Device
front:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Front speakers
surround40:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Digital
    IEC958 (S/PDIF) Digital Audio Output
hdmi:CARD=NVidia,DEV=0
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=NVidia,DEV=1
    HDA NVidia, HDMI 1
    HDMI Audio Output
hdmi:CARD=NVidia,DEV=2
    HDA NVidia, HDMI 2
    HDMI Audio Output

-- 
-- Sean McCully

--------
[1] http://www.asrock.com/microsite/intelx79/GameBlaster.html

--nextPart13272323.ZfdsYXrMPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EABEIAAYFAlMNUrAACgkQXBHqi5XCyTvmxQD9GqJt6cj2LwmkR8452I2UjVjO
wkKhsELkp3/Hv6OaVm0BAKEfbuPjsnmeVyChdSZuOhYhm77fQSuPEGbG6YsAL6iB
=0R/O
-----END PGP SIGNATURE-----

--nextPart13272323.ZfdsYXrMPC--


--===============6604388244785026660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6604388244785026660==--
