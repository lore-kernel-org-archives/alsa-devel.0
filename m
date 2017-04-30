From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4613: disable asymmetric audio
	interface format
Date: Sun, 30 Apr 2017 21:52:02 +0900
Message-ID: <20170430125202.quxnx7jawl3k5gen@sirena.org.uk>
References: <87efweqvh3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5362648106542306527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9FFD2664EB
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 14:52:09 +0200 (CEST)
In-Reply-To: <87efweqvh3.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============5362648106542306527==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sb6kycznxm2qlvzi"
Content-Disposition: inline


--sb6kycznxm2qlvzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:22:51AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Asymmetric audio interface formats exist in ak4613 by same
> register settings.

So long as nobody is actively using this disabling things is fine but
it's better to just remove the code rather than commenting it out,
people can always get the old code in git if they want.  Adding a
comment explaining why asymmetric modes aren't supported would eb good
though.

--sb6kycznxm2qlvzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkF3fEACgkQJNaLcl1U
h9D0NAf+O/IP/AmrXnvgTIZwXbrpxoRV0yfLGfeLgeNSKjEtclZeswWj7PPYKizE
Ai1R4y7Db2jArq3BJgHnhXsXOr/vNgAZvCDA4SSq3LCC82g9NtTUV49Dkd3Z2Yq7
Ft2/fLmCuCMU6dwqTieKuLSmhdU+W8PT7jGnlOvyBMX6coVHq9Y3Wfww5wuN+4hO
rVj4xHx240yQbWh0ElOoOeHbPXEoWD5l8F0B52ShrowRSJv3wlslAa/ITTPj60wD
x4swwAUilRqxuwe9o0PF5xdZxppvbM2LJQ/FQMJfx51nlbSdYy15Y9yQTnCyQFtI
fK3tA4WrAKzFdgyDAhHsoloiSLITow==
=wg+T
-----END PGP SIGNATURE-----

--sb6kycznxm2qlvzi--

--===============5362648106542306527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5362648106542306527==--
