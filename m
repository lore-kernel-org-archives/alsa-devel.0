From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Date: Wed, 8 May 2019 16:00:58 +0900
Message-ID: <20190508070058.GQ14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQa7rwQ/GRwZE7J4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190506095815.24578-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org


--YQa7rwQ/GRwZE7J4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 11:58:13AM +0200, Jerome Brunet wrote:

> Remove current_substream pointer and replace the exclusive locking
> mechanism with a simple variable and some atomic operations.

The advantage of mutexes is that they are very simple and clear to
reason about.  It is therefore unclear that this conversion to use
atomic variables is an improvement, they're generally more complex=20
to reason about and fragile.

--YQa7rwQ/GRwZE7J4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSfqkACgkQJNaLcl1U
h9CNHgf8DPUPcHpJuCKPN3bSkYe+k+fejr2ZSHO7YjXjHpH77DkAB87qstFvZ3mO
Y99N2oT9nVhdO/Z0SvUx++6583NK1E9Kgymo4yLbsIYAR3z0lGLi494e8QzvCvov
IyVuT4Bsj0HT/l2j1778lIy6QT7zGMtk+Q87LwWb2AZvlxFNkfjKCg3MiilMA6tu
oFt6FJmazbFH+hhePFVsdaFVTEkn+lxJR7cquICuIHhxenGP3c0z6sTBR6Nn41aK
W4ug1it7JnLohbh9qgQkBlo83GWEWKEC9TgiaN2/ByWDBdADgvC6dE9IPVG2xBD0
jelL896tYbN4WASe9U9mW1CDwi2qhg==
=Cq88
-----END PGP SIGNATURE-----

--YQa7rwQ/GRwZE7J4--
