From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Mon, 4 Sep 2006 20:27:41 +0100
Message-ID: <20060904192738.GA16291@tarte.seehuhn.de>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
	<20060904174121.GA4736@quiche.seehuhn.de>
	<s5hpsebjxkf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1381234567=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsebjxkf.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1381234567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Sep 04, 2006 at 08:28:32PM +0200, Takashi Iwai wrote:
> OK, maybe the problem is its naming.
I ignored this for the moment.  Once we are sure how many controls
there are, we can think about the naming.

> 	% amixer set "PCM Gain" 2
> 	% amixer set "PCM Gain" 0
> 	% amixer set "Capture" 0
> 	% amixer set "Capture" 80%
> 	recording...
>=20
> 	% amixer set "PCM Gain" 0
> 	% amixer set "PCM Gain" 2
> 	% amixer set "Capture" 0
> 	% amixer set "Capture" 80%
> 	recording...
>=20
> If the volumes of two cases are same, the IPGA isn't independent and
> both controls should be merged to a single control.

I read the AK4524 data sheet and I see now what you mean.  The
descriptions there are almost identical.

I tried the following.  My amixer output is at the end of the mail for
reference.  first I created two shell scripts:

-- s1.sh -------------------------------------------------------------
#! /bin/sh
amixer set "PCM Capture Gain" 2
amixer set "PCM Capture Gain" 0
amixer set "PCM" 0
amixer set "PCM" 80%
----------------------------------------------------------------------

-- s2.sh -------------------------------------------------------------
#! /bin/sh
amixer set "PCM Capture Gain" 0
amixer set "PCM Capture Gain" 2
amixer set "PCM" 0
amixer set "PCM" 80%
----------------------------------------------------------------------

and then I run the following command on the shell

    while true; do ./s1.sh; sleep 1; ./s2.sh; sleep 1; done

While this was running I recorded a wav file with arecord.  The volume
of the recorded file was extremely low (is this normal?) so I
normalised it with audacity.  I looked at the wave form in audacity
and I played the normalised file with alsamixer.

Results:

1) I cannot hear or see the difference between the settings from s1.sh
and s2.sh.

2) As a test I tried the following: I can hear (and maybe just see)
the difference between 80% (value 102) and 82% (value 104).  I cannot
notice any difference between 80% (value 102) and 81% (value 103).

Do you have any idea how different the volumes would be if IPGA and
DATT were independent?

All the best,
Jochen



-- amixer output -----------------------------------------------------
Simple mixer control 'PCM',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 127 Capture 0 - 127
  Front Left: Playback 102 [80%] Capture 102 [80%] [on]
  Front Right: Playback 102 [80%] Capture 102 [80%] [on]
Simple mixer control 'PCM Capture Gain',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 36
  Front Left: 2 [6%]
  Front Right: 2 [6%]
Simple mixer control 'PCM Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%]
Simple mixer control 'PCM LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%]
Simple mixer control 'PCM Rear',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%]
  Front Right: Playback 127 [100%]
Simple mixer control 'IEC958',0
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'H/W In 0'
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'H/W In 1'
Simple mixer control 'Deemphasis',0
  Capabilities: enum
  Items: '44.1kHz' 'Off' '48kHz' '32kHz'
  Item0: 'Off'
Simple mixer control 'H/W',0
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',1
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',2
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'H/W In 0'
Simple mixer control 'H/W',3
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'H/W In 1'
Simple mixer control 'H/W',4
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'IEC958 In L'
Simple mixer control 'H/W',5
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'IEC958 In R'
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities: enum
  Items: '8000' '9600' '11025' '12000' '16000' '22050' '24000' '32000' '441=
00' '48000' '64000' '88200' '96000' '176400' '192000' 'IEC958 Input'
  Item0: '44100'
Simple mixer control 'Multi Track Peak',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Fr=
ont Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? =
- ? - ? - ? - ? - ? - ? - ? - ? - ?
  Capture channels: Front Left - Front Right - Rear Left - Rear Right - Fro=
nt Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? -=
 ? - ? - ? - ? - ? - ? - ? - ? - ?
  Limits: 0 - 255
  Front Left: 0 [0%]
  Front Right: 0 [0%]
  Rear Left: 0 [0%]
  Rear Right: 0 [0%]
  Front Center: 0 [0%]
  Woofer: 0 [0%]
  Side Left: 0 [0%]
  Side Right: 0 [0%]
  Rear Center: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
----------------------------------------------------------------------

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/H4qf+iD8yEbECURAmnPAKCT+yR4D6w8a/CQDQ335xn95oMpWQCghNcW
+SNTZHEz81hvAv4jQ9IVVls=
=/3hF
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


--===============1381234567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1381234567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1381234567==--
