From: Christopher Head <alsa@chead.ca>
Subject: aplay: main:722: audio open error: No such file or
	directory
Date: Sun, 25 May 2014 09:11:24 -0700
Message-ID: <20140525091124.01578e75@kruskal.home.chead.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3859816303158261266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from chead.ca (chead.ca [67.220.144.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D94261B0E
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 18:11:32 +0200 (CEST)
Received: from chead.ca (localhost [127.0.0.1])
 by chead.ca (Postfix) with ESMTP id 791089FD22
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 09:11:30 -0700 (PDT)
Received: from kruskal.home.chead.ca (d154-5-96-139.bchsia.telus.net
 [154.5.96.139]) by chead.ca (Postfix) with ESMTPSA id 223E29FAAB
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 09:11:30 -0700 (PDT)
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

--===============3859816303158261266==
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/emKV7KyZJEnp3NSfYFqu1fX"; protocol="application/pgp-signature"

--Sig_/emKV7KyZJEnp3NSfYFqu1fX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello!
Apologies if this is not the right place to report this. I tried to use
the bug tracker at <https://bugtrack.alsa-project.org/alsa-bug>, but
both times I went to it (a couple of weeks ago and again today) it was
offline. Also, I am not subscribed to the list, so please include me in
replies (or tell me if this is not acceptable and I will subscribe).

I can't play audio on non-default devices.

Running aplay with no options, or with -D default, works fine. Running
aplay with -D hdmi does not work, failing with this message:

aplay: main:722: audio open error: No such file or directory

Running it in strace, I see that the last interesting thing it does
before printing that message is it tries to open /dev/snd/pcmC0D3p,
which does not exist; it should probably be addressing pcmC1D3p instead.

I have no ALSA configuration files anywhere.

kruskal asound # aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=3DMID
    HDA Intel MID, ALC663 Analog
    Default Audio Device
sysdefault:CARD=3DMID
    HDA Intel MID, ALC663 Analog
    Default Audio Device
front:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    Front speakers
surround40:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=3DMID,DEV=3D0
    HDA Intel MID, ALC663 Digital
    IEC958 (S/PDIF) Digital Audio Output
hdmi:CARD=3DNVidia,DEV=3D0
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D1
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D2
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=3DNVidia,DEV=3D3
    HDA NVidia, HDMI 0
    HDMI Audio Output

kruskal asound # ls -1 /dev/snd
by-path
controlC0
controlC1
hwC0D0
hwC1D0
hwC1D1
hwC1D2
hwC1D3
pcmC0D0c
pcmC0D0p
pcmC0D1p
pcmC0D2c
pcmC1D3p
pcmC1D7p
pcmC1D8p
pcmC1D9p
seq
timer

kruskal asound # cat cards
 0 [MID            ]: HDA-Intel - HDA Intel MID
                      HDA Intel MID at 0xf4900000 irq 53
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf3080000 irq 17

kruskal asound # cat devices=20
  1:        : sequencer
  2: [ 0- 2]: digital audio capture
  3: [ 0- 1]: digital audio playback
  4: [ 0- 0]: digital audio playback
  5: [ 0- 0]: digital audio capture
  6: [ 0- 0]: hardware dependent
  7: [ 0]   : control
  8: [ 1- 9]: digital audio playback
  9: [ 1- 8]: digital audio playback
 10: [ 1- 7]: digital audio playback
 11: [ 1- 3]: digital audio playback
 12: [ 1- 3]: hardware dependent
 13: [ 1- 2]: hardware dependent
 14: [ 1- 1]: hardware dependent
 15: [ 1- 0]: hardware dependent
 16: [ 1]   : control
 33:        : timer

kruskal asound # cat pcm
00-00: ALC663 Analog : ALC663 Analog : playback 1 : capture 1
00-01: ALC663 Digital : ALC663 Digital : playback 1
00-02: ALC663 Alt Analog : ALC663 Alt Analog : capture 1
01-03: HDMI 0 : HDMI 0 : playback 1
01-07: HDMI 0 : HDMI 0 : playback 1
01-08: HDMI 0 : HDMI 0 : playback 1
01-09: HDMI 0 : HDMI 0 : playback 1
--=20
Christopher Head

--Sig_/emKV7KyZJEnp3NSfYFqu1fX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBCAAGBQJTghYwAAoJEAoxakYXDDIkSrIIAL6eTk+7hZJGiJYT/cpK4h/V
PwGvMgONV09jOPjk7GeAqs9L7nRZwuNCQLAgHffPGoXeKF46kVSRj2BRpciViOvS
HsmqaMI4deuhBGDSoaK3qE9seDLklmqUFu/F2FFcgjwIlZw4yiT7HdsBxm4nDhP4
bSUn9bq3bL14rLe1L/0ajMv0D1ah9Clk4rqoC7Ds+pLIgqBCEpu8iyshT9Aq5amt
vwc0kptg+EHT6ZTm4/8RO95j2CrTKCepLnU5GS/OF9Z/BfI0eYIoJWAX9cb8FUxZ
+UM8qrFIq+5sbIM4208mFhwvyPcl7Ozgb+Z28yJcmPCZ/7PF+vCAy5C2CqiGQo8=
=zKGQ
-----END PGP SIGNATURE-----

--Sig_/emKV7KyZJEnp3NSfYFqu1fX--

--===============3859816303158261266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3859816303158261266==--
