From: Jeremy Nickurak <alsa-devel@rifetech.com>
Subject: Altec Lansing FX5051 USB Speakers
Date: Thu, 17 Jul 2008 18:53:37 -0600
Message-ID: <20080718005336.GA6753@atrus.rifetech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3561234892368992651=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a5.g.dreamhost.com (sd-green-bigip-66.dreamhost.com
	[208.97.132.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 414281037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 02:53:43 +0200 (CEST)
Received: from katran.dni (S0106001ee57a9819.ed.shawcable.net [68.149.183.24])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id 9148A216DD
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 17:53:38 -0700 (PDT)
Received: from atrus by katran.dni with local (Exim 4.69)
	(envelope-from <atrus@atrus.rifetech.com>) id 1KJeE5-0001n0-ED
	for alsa-devel@alsa-project.org; Thu, 17 Jul 2008 18:53:37 -0600
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
List-Id: alsa-devel@alsa-project.org


--===============3561234892368992651==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's been about 7 months since I last brought this up, and didn't really=20
get any success at the time, so I thought I'd check and see if anybody=20
has any insights again.

About a year ago I posted my original request here for any suggestions=20
in getting a set of USB speakers from Altec Lansing, model# FX5051,=20
working with ALSA. They're a set of 5.1 speakers with a built in USB=20
sound card. Sound does appear to work, but the mixer is locked at 100%.=20
There is no analog manual mixer, and the digital control dial exhibits=20
the same problem as alsamixer, so I have to find a way to adjust the usb=20
device's mixer volume in order to make the speakers usable.

The speakers work fine in Windows XP, without installing any drivers, so=20
it would seem that this device is operating based on some standard.

In windows, adjusting the mixer via the digital control dial, or via the=20
windows mixer control both result in the LED display moving in sync to=20
indicate the new volume setting.

In alsa, adjusting the digital control dial doesn't appear to have any=20
effect, other then waking the LED display from its low-light mode.=20
Attempting to adjust volume from alsamixer likewise wakes the display=20
=66rom low-light mode, but also fails to significantly change the mixer=20
setting.  When I say significantly, I mean that the mixer flips between=20
about 98% and 100%, when using the Up/Down keys (or PgUp or PgDown). End=20
appears to drop the volume to 0%, but Home doesn't restore it.

Pressing the device's 'Power' button also behaves strangely. I can turn=20
the device off, but it is turned back on shortly afterward. No usb=20
connect/disconnect events appear here, instead, the power button seems=20
to function more like a mute.

amixer -c 2 contents yields:

atrus@kedri:~$ amixer -c 2 contents
numid=3D3,iface=3DMIXER,name=3D'Tone Control - Bass'
  ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
  : values=3D1
numid=3D4,iface=3DMIXER,name=3D'Tone Control - Treble'
  ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
  : values=3D3
numid=3D1,iface=3DMIXER,name=3D'PCM Playback Switch'
  ; type=3DBOOLEAN,access=3Drw------,values=3D1
  : values=3Don
numid=3D2,iface=3DMIXER,name=3D'PCM Playback Volume'
  ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D49,step=3D0
  : values=3D48,48
  | dBscale-min=3D-49.00dB,step=3D1.00dB,mute=3D0


I'm attaching the contents of 'lsusb -v'.

Any suggestions would be appreciated, and any requests for further=20
information about this device will be accomodated ASAP.

Thanks in advance.

--
Jeremy Nickurak

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIf+mOtjFmtbiy5uYRAk69AJ4jJuHWcaCnUu6pRTrXx2p4sc255wCeL4Il
6EiskQ5DDgeTSIkMEWWYKFQ=
=rdwX
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============3561234892368992651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3561234892368992651==--
