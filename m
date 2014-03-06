From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: ASoC: wm5110: Extend SYSCLK patch file for rev D
Date: Thu, 06 Mar 2014 01:47:05 +0000
Message-ID: <1394070425.2861.35.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026997918422121907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id 0167826516E
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 02:47:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2026997918422121907==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2iklmhbI7D9SECmj3B5F"


--=-2iklmhbI7D9SECmj3B5F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm looking at commit 34354792432b6e0a3b156819a1a19716c50d3473 and
include/linux/mfd/arizona/registers.h, and wondering what exactly this
the register patch is changing.

It looks like there are some registers not named elsewhere (addresses
0x0049, 0x004a, 0x0057, 0x0058).  What about the higher addresses?  Are
these more registers, or is this patching firmware in device memory?

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-2iklmhbI7D9SECmj3B5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUxfTmee/yOyVhhEJAQoF/w/+NvYM9ZZMAmcH8rCoTwmUKq/45ktdZtTs
9xSpsL9Rmn11yXaPDksTG917WwnzC8fiYTkIzp7CN2hPXtn9LVhHRnsqGQBiucyd
LSU30QBkTHVwblYGIf4drzH7hcLjkQvqObk0lKMh1F2U8IXhbhZHSRqe3PJu5rFE
gKYvIOszD1JlSm5nt7Y2VcbpvEjcj4643j7d7tWR3KAWbcVJz6wtnmZEnDcUi1Eb
GUPygFYiwAgiEL0L5O2IvzEeJ9UCXqcBGsEUe2dNhA3TyMnL2vO9V2VaAJ2FNyo6
bL4zaKnFP3UoANqonjyRQU5LdWzMdaurzNqcMFLauO9xhoOPxYGebK3mnrK7Pckn
P0SroaUKwCmOXmXZeyapZVW1d1OpOlcCegb62fuLiSnBBreQfwaPqzWs/P5hrERN
79naAQ641MGemN+cCCDQU3h0aCFqyO4O5+L2u/mGdGRochPWmXx6WtDNCy+5koGI
NA/MuDPqWF/zEdAGc+RgxETUSo125JWX4/uIHjgfcJ5LdHf9XHMcajCMkbhwvp8c
Vxh2vFhkKdJ66bth+sREAatLh206yXGZlYl2xxSnyV0TQdSE6TL1N1Pfh0yYOWh8
SkdgC7SfsDw4UwohsAC0PuPTCQhjF2+2fYgzY6SlgKrbjaIeAYHhc6edQ2XHg18e
su8tXqjhg+0=
=5gOL
-----END PGP SIGNATURE-----

--=-2iklmhbI7D9SECmj3B5F--

--===============2026997918422121907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2026997918422121907==--
