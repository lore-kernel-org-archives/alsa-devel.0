From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Fix build warning
Date: Mon, 7 Jul 2014 17:06:55 +0200
Message-ID: <20140707150655.GN30458@sirena.org.uk>
References: <1404739099-20717-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404739099-20717-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 03:18:19PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The max98090_{suspend,resume}() functions are used for system sleep and
> therefore need to be guarded by CONFIG_PM_SLEEP rather than CONFIG_PM.

Applied, thanks.

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTureGAAoJELSic+t+oim9kXoP/17Tj9SU1LtKiC9DRfPzXZnO
1yJqtprF4Ki+TkJ1Ui0AkNjUvNpOcMiC121uVkKPO+OvtVus6xwKBNR8r4N80G3y
YJG+vDwZkCBNrJqOfIwhRNpeaCFrpKerJtIdeXRYDgcCeHaQG7q+DQqeZhPajHVS
fvSXuQnS1MPYt9KhRttuw+P8qVTzK7mRtWfziZKnOuOAnjztOccTliWDXlLzhE19
B7nQzkjW1ba1F8RQoLkUPWoS0TCqrOAcP8iEklnij9zaPB4tSmV4coi6PKMaanfK
8YfVMq2JiecQV0nxAv+Bon8JSOSS3wCOZmRO4VaLNlT8XUmcoegcNSzQnbwMDLh1
DDRbpx4iErOKY1/ndDziN9F6WCIpyJQv9sAzxKG43yUAn3Gkjx6LvnQ2tg3pTJgZ
/vZAgWvVMOIRe/Lp/neCxre/hGfeTWJZ4IayHNukKg0XUkbK9gekHamdYSRAwX0Z
CfWhyI/j6yUYbhml9NF7Smncv61Gr+ghTCsKdom1lK+qx15vzIl/MTDSi2WuM5s+
8wdv3JoWvoOCqmKD4BMRERrC7S5WTSP5potftcWncKxZiOP+gEUH9xlvKS0bYRTR
J6FOKTeEOJqojM2s1s6WDhAkCmsc23fHmU5Zc/Gf30HWPAuBpD5aVz8oNZheQLQD
l9Nc3ZhQW9cGXjvSxGT6
=VTp2
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
