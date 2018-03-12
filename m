From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: soc-io: Fix
 snd_soc_component_update_bits_legacy
Date: Mon, 12 Mar 2018 09:58:49 -0700
Message-ID: <20180312165849.GK2186@sirena.org.uk>
References: <20180312142423.13177-1-peter.ujfalusi@ti.com>
 <20180312142423.13177-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8673226203404175265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B068266E63
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:58:55 +0100 (CET)
In-Reply-To: <20180312142423.13177-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============8673226203404175265==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:24:23PM +0200, Peter Ujfalusi wrote:

> Fixes: e2c330b9b5665 ("ASoC: Move IO abstraction to the component level")
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

When you add a Fixes line for some reason you always seem to add a blank
line before the signoff which is a bit weird and I'm worried will
confuse some scripts.

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmsckACgkQJNaLcl1U
h9Dsygf8DMPW7fqR1+HQCUxgBsUyOFfjN063mQ9+SB/ZXo25+smzxhP4dGAth/bJ
3ZXYPP+1eo/S7qUnH/Lh6agYXXtXjvaG8NZTNWZ3+Vapb/0Kt9ug6Wui72DVnonB
yQls0W1zeIyJopjw5AZKGhepqvgGCiQ/ww5Zmnufava4La/0oX15M7fKhN1heXU6
j+Uahc1Ta8DlRmUHKtk8ste1U15/X3T1AsTpR8zcQgHqE5MrJE+kcKtaN1q1vQym
wMwkvO9R9WDDvhUzRlHaug82NbzRzkOkBeq9gRvSlt+7CWLMoX0uHqWRUrBErYB9
wluB+7v3I9ASiciKhRWD/LJhRKqh0A==
=gr5l
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--

--===============8673226203404175265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8673226203404175265==--
