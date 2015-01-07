From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Wed, 7 Jan 2015 17:45:47 +0000
Message-ID: <20150107174547.GE2634@sirena.org.uk>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8029688274516312671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6312A2605DC
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:45:53 +0100 (CET)
In-Reply-To: <20141226044457.GA12777@vaishali-Ideapad-Z570>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8029688274516312671==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9PByzOP77wFNgJ0y"
Content-Disposition: inline


--9PByzOP77wFNgJ0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2014 at 10:14:57AM +0530, Vaishali Thakkar wrote:
> This patch introduces the use of function put_unaligned_be16.
>=20
> This is done using Coccinelle and semantic patch used is as follows:

This doesn't apply against current code (-next, or my git tree), please
check and resend.

--9PByzOP77wFNgJ0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrXDKAAoJECTWi3JdVIfQs/8IAIJM2/BbY8em3WyYAPaLa10b
l0pFLa2+DirK2DYmhROHgcCfp6si4zYKBgnF+iVNg/f2r7ZfwX+uAGxalZeOXAgn
6GOJlpANRuert+IIhK5gUv2zPBMH9JZL554N3hkvKkj0ZzSNsMTOiTT55gHott5p
RDH4xs998tZalaOlJAt0lq66KzBkBXMNINStXF2ICuQzWelFscTlgy6OJOSHan+w
0NyDQVQGEopxWNObHl96UosaCA9CiysL4bH/T26eUCrXVHnZ4flgvl+VqF8/iJ9O
fsLuIG/zymWZnsVj+vp9Hf6K3E1zxLTz/TGArCsbylW1p6ZMuXOfattaKembFig=
=ZbCr
-----END PGP SIGNATURE-----

--9PByzOP77wFNgJ0y--

--===============8029688274516312671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8029688274516312671==--
