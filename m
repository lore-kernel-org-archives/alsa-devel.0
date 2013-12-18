From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/2] ASoC: SPEAr: get rid of
 spear-pcm-audio struct device
Date: Wed, 18 Dec 2013 18:55:34 +0000
Message-ID: <20131218185534.GK31886@sirena.org.uk>
References: <1386704125-28698-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6215648634026804700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F6D02617B6
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 19:55:38 +0100 (CET)
In-Reply-To: <1386704125-28698-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org


--===============6215648634026804700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Content-Disposition: inline


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 12:35:24PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Modify the SPEAr PCM driver so that it's a utility library that can be
> registered on each DAI, rather than a separate struct device. This is
> more in line with how many recent DT-converted platforms operate, and
> avoids the need for yet another struct device.

Applied both, thanks.

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSse+jAAoJELSic+t+oim9NY4P/ibD17PLC3u0hh5PZb4VGsB3
B8JTyAXmFTW9MaH05OCce7DalWuCWSxEXBmBWdNgMd1ltM1IIQLqyBwYs6S8BncI
iZUFdEnTz35LnCa65e5vQYpl6jjG8AjwPTpitVHxVfK0ieLDW2JU4OVeUm4JJuLg
eMyqUCDRopgLdIcZYyIAfcpHEKr5kPEdAVgoOeBViQIbXvudsSfRJn+xIMO+Tv7s
+haVZBVXQKNmjYowMM/cc0pG9l2xmOa0ILjpRk+uxnoAphQHn1brn8F00CXxpw0e
K3PsYR8v8WrJIqUgYgKcrraVp8SbRNn+6b5bZILEfScI7UaEyRBgS+dwTyvGhbVz
4fVQqIG/2mmDTsiIEwXVpEmVazzhJrsAxkhaU81YO/l/fu6mKFcuyITeNSAkQaCb
DwtxQscFzERbtvHcEZnLzcF0lEJdI23hFJvdS+ziLT9OKSvgjMGiHlqpn013wr0Y
mQdUTNunJQdp6BC1hWiAPpT/nNS/pVKH7pdreHWuOt6Nc0MMwqbwSciIE7Qq7gK9
w3y1mNufcFjS8Pm1fLSZbygmdYCh49f0c2l3805gKkDcY/iXvSid2pXoXY2uJ7z9
21+a2jaa0IKNqAQ8rg4qJY+8gizOK4w+oleuwAz3WfR/AdLI7J4JgLzKFgDLX8a0
u2q+slxkaF6FSbfZY/Lv
=M1eR
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--

--===============6215648634026804700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6215648634026804700==--
