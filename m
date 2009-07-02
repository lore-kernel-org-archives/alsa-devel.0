From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Thu, 2 Jul 2009 12:54:47 +0200
Message-ID: <200907021254.51495.nutz@unfoog.de>
References: <4A493A56.1050504@gmail.com> <200907011700.43178.nutz@unfoog.de>
	<s5hskhf5sg5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2733738809389323671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id AC399246F8
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 12:54:53 +0200 (CEST)
In-Reply-To: <s5hskhf5sg5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============2733738809389323671==
Content-Type: multipart/signed;
  boundary="nextPart2126661.1ErKhleGbi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2126661.1ErKhleGbi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

wow thanks a lot! =3D)

> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-u=
ns
>table-snapshot.tar.gz
>
> Let me know if it works or not.

sadly: no.. well the chip gets recognized now:
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: Cirrus Analog [Cirrus Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and alsamixer also shows a bunch of channels now as well as=20
"Card: HDA NVidia                                                          =
                                                                           =
      =20
Chip: Cirrus Logic CS4206"

but i can't get any sound eventhough all channels are unmuted and turned up=
 to=20
100.

i also aplay -Dfoo file.wav again, where foo =3D default,front,surround40,.=
=2E.. ,=20
but i always get: aplay: main:608: audio open error: Invalid argument

> Also, prepare to install hda-verb program.  I'd like to confirm the
> behavior of the codec, and I'll ask it later once after the driver
> works somehow.

installing hda-verb and waiting for orders ;)



thanks a lot

nutz

--nextPart2126661.1ErKhleGbi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkpMkfsACgkQGIPRDsWq366yTACfdl5a6rlGYYlC3RgxsQ+pGurP
APYAn2k/YPSV6ElxPR8rxkekA6S9DKZr
=b7l+
-----END PGP SIGNATURE-----

--nextPart2126661.1ErKhleGbi--

--===============2733738809389323671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2733738809389323671==--
