From: Jochen Voss <voss@seehuhn.de>
Subject: M-Audio Revolution 5.1 support status
Date: Fri, 8 Sep 2006 00:10:07 +0100
Message-ID: <20060907231004.GA2607@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1150908172=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1150908172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this is just a short summary of the current state of ALSA support for
the M-Audio Revolution 5.1 card.

1) Recording works now almost perfectly, thanks to Takashi's latest
patches.  Generally the card is now quite usable (but I ony tested
analog stereo output and microphone input).

2) Bug #312 is still present: the left channel is mute on start-up.
This is also triggered by unloading and then reloading the ALSA
modules.  No idea what to do about this.

3) Some mixer control names are still a bit strange:=20

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

These seem to control the digital loop-back feature, which is
described in section 4.2.4 of the Envy24HT data sheet.  The first two
"H/W" seem to correspond to the left and right stereo channel.  I
guess that the others correspond to center, LFE, and rear.

Also I find it a but suspicious that there is only one "PCM Out" value
and not "PCM Out L" and "PCM Out R".

4) The integrated VU peak meter of the Envy24GT (see section 4.2.6 of
the Envy24HT data sheet) shows up in strange places: In amixer it is

    Simple mixer control 'Multi Track Peak',0
      Capabilities: volume
      Playback channels: Front Left - Front Right - Rear Left - Rear Right =
- Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? =
- ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
      Capture channels: Front Left - Front Right - Rear Left - Rear Right -=
 Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? -=
 ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
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
      ?: 1 [0%]
      ?: 1 [0%]
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

In alsamixer it gives me sliders which I can adjust!

5) The card has a separate headphone output which seems not to work.
I did not yet investigate further, but this seems to be bug #1754.

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFAKbMf+iD8yEbECURAopnAJ49Lg/LCaPghdiVJ1A8wcRwIZ7FvACgmBUA
S/SV/YzWdXcza6zziunwWIk=
=XRuZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


--===============1150908172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1150908172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1150908172==--
