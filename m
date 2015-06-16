From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/21] ASoC: rsnd: don't care under/over
 run error when PIO
Date: Tue, 16 Jun 2015 12:41:46 +0100
Message-ID: <20150616114146.GK18309@sirena.org.uk>
References: <87twu9v6kn.wl%kuninori.morimoto.gx@renesas.com>
 <87si9tv6iv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3911881689926297580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6235265554
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 13:41:59 +0200 (CEST)
In-Reply-To: <87si9tv6iv.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3911881689926297580==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x2HNTtYOBsOEDsnN"
Content-Disposition: inline


--x2HNTtYOBsOEDsnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 06:20:54AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> PIO is used only for checking data path / codec settings. And underrun
> is very normal when PIO mode. Let's don't care about under/over run
> error when PIO case. Otherwise, 1) too many HW restart happens, 2) some
> sounds which need much data transfer can't play since it falls into
> error detection method which was created for DMA transfer

I've applied the whole series but I'm not thrilled with this one.  I
guess what you mean to say is that this is only used during bringup of a
new platform in which case it's not that big a deal but otherwise then
the usual thing with PIO is to implement FIQ support to keep the
hardware full.

--x2HNTtYOBsOEDsnN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgAt2AAoJECTWi3JdVIfQbi4H/ibxgQ89dwrPBGi8fsG3MDPZ
E90rMdCe06X2so8zjilwRKieUPtdPwl69/QvqCc0izCkrqItVhewnaWXvkV7Gmyg
5QLfeDraJkpy4irP8bmM8KM8gr7a6s/Qc2nY2x63adNx/EjBOYmpcWMicXuOautY
fvt2xZWbkRXDCFDO+OIf1H+z06xsunKbbN2f2vnF1kf/fQ2wMeABz/UZKEwMPKtz
/J/SeZjDD7iEhvvOxADBe7M5ksCYFV//W7F1ExVJG/zSEnwEp7OmUEdey6fnjLu2
H3abRE2v6N35usQJ8NI/atXyBpdK/pzRpcF581trm/aCMOgN+xz0yIkHGJ8Dmw0=
=Uc+4
-----END PGP SIGNATURE-----

--x2HNTtYOBsOEDsnN--

--===============3911881689926297580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3911881689926297580==--
