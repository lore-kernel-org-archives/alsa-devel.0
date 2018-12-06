From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] ASoC: qcom: sdm845: Create and
 setup jack in init callback
Date: Thu, 6 Dec 2018 20:21:56 +0000
Message-ID: <20181206202156.GD3084@sirena.org.uk>
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5480961472215484330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 954EF267C9D
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:21:57 +0100 (CET)
In-Reply-To: <20181128090037.257359-2-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, dgreid@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, linux-kernel@vger.kernel.org, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============5480961472215484330==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:00:34PM +0800, Cheng-Yi Chiang wrote:
> Add a callback for init ops on dai_link to create and setup jack.
>=20
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

This looks like you're forwarding a patch from Rohit but shows you as
the author?

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhOMACgkQJNaLcl1U
h9B3HwgAgSUfesUl1mC2hmvQH9U14XEb+AXI4vTU5SCG2o4BlUuhZn2I0TceIrk0
DA5NkQENbBiMd97ne+fxf1igJGMFjt9puf5deEVjAwqeOh07uZ4DkNbzHLlM/J6j
gCzvW0eByY9cPa1+IZM6oe0tEwS48yutSbm220pS5Bp9r+6Zs4JcXoo5BZw/MGSn
x+aarS+ZUId2dmg48kziOckCjFFFbuaEmuK19gZHa0qquC2b6984eZW986VoSqSU
JedNPeXRhI3S5bEgXg0N+KtBWDmmF3TRg2s+mKlVHepUHDe9dSAXyVlTXzoD+ZCn
SsZsRZiDrd0akM7xZZfbRyfz3KIn9g==
=tXqd
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

--===============5480961472215484330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5480961472215484330==--
