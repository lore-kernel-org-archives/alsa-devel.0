From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: disallow building designware_pcm as a module
Date: Tue, 18 Apr 2017 16:18:34 +0100
Message-ID: <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
References: <20170418105954.23368-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mpolbius4llls74t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170418105954.23368-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--mpolbius4llls74t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 12:59:54PM +0200, Lubomir Rintel wrote:
> It makes not sense: the whether the PIO PCM extension is used is
> hardcoded to the designware_i2s driver and designware_pcm doesn't
> have any module metadata, causing a kernel taint:
>=20
>   [   44.287000] designware_pcm: module license 'unspecified' taints kern=
el.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This is not a a good approach, there is no technical reason to force the
driver to be built in.  If you need a license tag in the module then add
that.

--mpolbius4llls74t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj2LkYACgkQJNaLcl1U
h9ANCAf9GJEMGaA6We3/Hy7xhnglT5bB7IaUeLWcox8MWq8e7nhw2kKWhdeqzo58
Nx1sE6pE7JahLVsHoT6Jow1+7hLK/fKWIfTVcQjTEJcdpQtU25x+yz0CDIKF7dVb
K0l1iUof74bb8GjHbVde+RrBQM9PgvncQ6N8vI6NCNvjq0U7JZf2cvFGOFxcfSlG
HJPXpsEk/kUdiClQPFkYCg7hf67kX6e2rqsYmESFNdR1X/RHPjat3POaArkfWysz
dD1cTT89yoqk7DLGAj/NW/+0+eJt1dhgJwDqTQ4qeX9VNCX/W/n08oR6MfCkst6B
VuhyrX34Sniy+aWnSDEFC7EO5hNiVA==
=hhYk
-----END PGP SIGNATURE-----

--mpolbius4llls74t--
