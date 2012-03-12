From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] add a mc13783 codec driver
Date: Mon, 12 Mar 2012 10:58:53 +0000
Message-ID: <20120312105852.GE3110@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
	<20120311113848.GA3233@opensource.wolfsonmicro.com>
	<1496586.ebXd01ibP4@laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0597820271175290471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0D9B24474
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 11:58:54 +0100 (CET)
In-Reply-To: <1496586.ebXd01ibP4@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0597820271175290471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2012 at 09:11:08AM +0100, Philippe R=E9tornaz wrote:

> Thank you for this detailed review. I will redo the patch based on your=
=20
> comments. I had a quick look at DAPM (dapm.txt in asoc documentation), bu=
t is=20
> there any good "reference" implementation which is in the kernel where I =
could=20
> have a look ?=20

Pretty much all ASoC drivers use DAPM and there's really not much
variation in quality in terms of how they do so, it's mostly an either
it works or doesn't thing.  Just look for something maintained that you
can follow and/or which is fairly close to your hardware.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXdbmAAoJEBus8iNuMP3dh0sP/jgD5ygsIuLIMof/AM498/Dl
eZuGEUPlr19HeePP7gyEGurKdAW7Y64TRvhn6WjIDcy0B8rHL5UwvebbcayOfZMg
DVqf51cBoACHDfmeoeSx68e6JpLiNSJGpBsVM+DOMDXcB59FEHpGFVi34k4asIic
kIh0hw4gAdAvBJzzlUXjOVmxgZs5xfSlqccaS4CLCPlVdxPayw/j0+ycibOBCLXG
4+eXV23mUpbt1OlnnPoVyLIuj39n+ldFC8m2RlnLLhCbCvFXaniZg9zWKDBpBiH0
zbl1yD7agmQqeFoVlw+6o2AVUGAldSDZWU397TbK08uY5ISggsW6TJDmIq8UTgo4
gORrp6ntse168tjlu3D194czR9CmXvoGWewZmCQgls47e4XgSencR23VImjU/oka
qqeCgQANkOoR8p5ay0Qbq3oXO1ezowvYj0AhNtbdRVIGvmHzrZLgyVTDj118dX4+
9p+3Yji96nlXgxUf3IKn93vMuMNqE5N0Fqao8ZaYI3dPEn9734qCiFqrj5WaSBsi
HM+2AbB+5wxXoHu+JESIJLEmKi5r8V1rTD0sRacE3JGlQ5NwQeUmSCHFFUF1cCV4
5WqeA3pVWxprULRCpfnsQRae0i1waFEYmQI1DcHS92OigGz/pexN7sZtB1QBuGiG
5Rlvhi6zqjBLEJKOmC/s
=lK3i
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============0597820271175290471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0597820271175290471==--
