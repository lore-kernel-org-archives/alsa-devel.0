From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: ASoC: wm5110: Extend SYSCLK patch file for rev D
Date: Thu, 06 Mar 2014 12:20:20 +0000
Message-ID: <1394108420.2861.38.camel@deadeye.wl.decadent.org.uk>
References: <1394070425.2861.35.camel@deadeye.wl.decadent.org.uk>
	 <20140306093247.GI8570@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LYc7PGXyLbuzIhMsFnCf"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <20140306093247.GI8570@opensource.wolfsonmicro.com>
Resent-Message-ID: <2gyQmYd1LME.A.ZcB.cgGGTB@bendel>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@linaro.org>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: alsa-devel@alsa-project.org


--=-LYc7PGXyLbuzIhMsFnCf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-03-06 at 09:32 +0000, Charles Keepax wrote:
> On Thu, Mar 06, 2014 at 01:47:05AM +0000, Ben Hutchings wrote:
> > I'm looking at commit 34354792432b6e0a3b156819a1a19716c50d3473 and
> > include/linux/mfd/arizona/registers.h, and wondering what exactly this
> > the register patch is changing.
> >=20
> > It looks like there are some registers not named elsewhere (addresses
> > 0x0049, 0x004a, 0x0057, 0x0058).  What about the higher addresses?  Are
> > these more registers, or is this patching firmware in device memory?
>=20
> These are all internal registers that we don't usually expose, in
> the case of the Rev D some of these are not initialised to
> optimum values by the hardware the patch provides better audio
> performance and path transitions.

Thanks.

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-LYc7PGXyLbuzIhMsFnCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUxhoBOe/yOyVhhEJAQowDQ//YqMRwN8YlNZkJS5UEcGubR9Yy6nZxyji
8Nx9k9VOOQahMBXSqmZZ6eV4fOeDnYNKyCPpTmm+IVkSNTn+kSmrd9jnY64jp3p0
KhtUd8RBDzwnhr1pLdpMZvi960d7iFVx6d4PJoO3no2B6/M6B30ZDJKAmNRW6mvc
CsfeI0B3YaoX5jhPmnlli0ihIVQNg/fK86YFkhCSmMhWl2FJDECZAEwzRg5wXbWG
F0IkFv+M2BdqhkplUzCeSXLJi0nQOusxXV165DJubh0rd9iFgRZ9Ishul2lYACaS
equhSqw/wWvhj2524G6AwFCfjodT/uJJKz9vD4UZSX1oLxyIs0miXPNa5JHHW2ns
Jwr2elowtg3kep9wrNVhpMAz/pzHdMUti/bI+Lbbi5uG8Xo16wkEDT+iMHAcUJ9F
7OqdtHl2sSZwwq4LV+1XUOx8q0Y9gPM+Ik8W2Em+kN4eXZti9qxoLIe1PSk/BjgW
jUGtvD+7/Qr+Q94zOOFkM79wJ2fhsQ2R+7Thj00xst4ofNgAJr4HJLanfmltstXq
P4jwhyT++O13xik8j5meITEw/Rv4w0ZV/PL6rphMC1I6vmnTowKA6UYK4xqS/xrA
OlkSTimwagr6a6dF5OZbkhbdO3NNotBdf6XLPmiP2EJj3pogarY8otTB7jCrCAWJ
VL8ZX6AIC6s=
=21nG
-----END PGP SIGNATURE-----

--=-LYc7PGXyLbuzIhMsFnCf--
