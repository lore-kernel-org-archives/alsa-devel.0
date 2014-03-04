From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: rsnd: run rsnd_path_init() when
	probe() timing
Date: Tue, 4 Mar 2014 12:13:50 +0800
Message-ID: <20140304041350.GF2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <871tyjybhr.wl%kuninori.morimoto.gx@gmail.com>
 <87zjl7wwwc.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4463624693848473261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2082656CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 05:14:08 +0100 (CET)
In-Reply-To: <87zjl7wwwc.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4463624693848473261==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSyhTGF9VKBQ91i8"
Content-Disposition: inline


--mSyhTGF9VKBQ91i8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 11:42:47PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current rsnd SSIU/SSI/SCU/SRU path is set
> when playback/capture starts up.
> But it is meaningless method, since the path is based
> on platform and can be set in probe() timing.
> This patch sets the path on probe() timing.

Applied all, thanks.

--mSyhTGF9VKBQ91i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVL7AAoJELSic+t+oim9R3cP/15uJ8aa0H26PkDYApQTkfrY
wEFNwrK6haq0GDjAm9sydIrEWSxUTgltnd1r1Sqa+mWJsytDGBZfR7PHpQrRc4et
kkf7Q7TNC/jO98jRlptzx/bII0t2UvL9N9+Xg6jzi4QJDUR6cOB9Lq/4z7JqIUuv
TddBd78FWYlhkMgwglrVT7DX+2jMaLsY7WehEGrhXE1/VOnr12xPBUi7Bk4xsn7m
GwlHNsLbBvuYzt6pFLmvNBEclCNmHtP0Nh9gegy1yIA1KYmGRyXOyKwswqVWo2TQ
6eXs+CW5TC/IrzWmNV3Gv23mCP1AijnJTX1r2qhYySCGwiwfoR1Z52od1Kmic4sz
3e/uCB21a6HFrWZlHuFS96p7Sd9eW7DI02bvoWrB/LpUgPNjJ747P9qwnL/CCk5G
OqFIAQixGA262V5LtHZdVWQ8Ga6XpAeUXnqQGUnS8I6Kxc/44eVKAMHbX46xzYea
//ggIrWuH3ErhIh4a/bjYq63mSsT5iq2Y2ZgTeCrMdSrq51I+4gaGvDmc6p4Tuew
78Lj7QvpHPEX/GMvkU41B0Yq+VrZCAcLhwTJ+h4G1hMW1cTy0qWmFuPxrpVt4lLO
cI6QO8og9D+kt3MbLYMUDzj9YKz1MC4xEj8qhEQ1otNT3e4F8XhYnj96H5dF77fw
Mg2HtNcjoE8XNocTBO93
=Qpgt
-----END PGP SIGNATURE-----

--mSyhTGF9VKBQ91i8--

--===============4463624693848473261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4463624693848473261==--
