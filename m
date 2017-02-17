From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of
 pr_warning to pr_warn
Date: Fri, 17 Feb 2017 23:48:54 +0000
Message-ID: <20170217234854.spi62waguwd7kpno@sirena.org.uk>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3704670059281026302=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA23266649
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 00:49:21 +0100 (CET)
In-Reply-To: <20170217202844.GA8215@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============3704670059281026302==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7rsewhxpczujpc6x"
Content-Disposition: inline


--7rsewhxpczujpc6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > To enable eventual removal of pr_warning
> >=20
> > This makes pr_warn use consistent for sound/soc
> >=20
> > Prior to this patch, there were 5 uses of pr_warning and
> > 10 uses of pr_warn in sound/soc
> >=20
> > Signed-off-by: Joe Perches <joe@perches.com>
>=20
> For imx-audmux.c,

I don't have this patch, perhaps it got caught in a spam filter or
perhaps it got deleted because as ever you're not using subject lines
reflecting the style for the subsystem.

--7rsewhxpczujpc6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlini+YACgkQJNaLcl1U
h9Dp6Qf/eJnCkxvGqbhbZfW3s4xTK/yhKzQw8PcPME2e0j1wYJaFIJHFUc5T01NQ
Ra/D31mtAXb7RHvZo57T4pfLElaW8SFQ3Ttz2qJLDcEHkkvAPyJcgnuzOR3TwKHz
lTSZnfNo7MTLsZl3DbuViRkNrf9P0vU8RjWGR0XTxoF6Av7pMc0DF7RmelLIpMk8
8a9rrMZ9cdFecrs3+vMKqPZFPGeDUx3kk9lI6CSOgssKoZzRccghS3+CxoXYf7Me
zF/MiWnWXi7y4ja5PPQFgHZd6nlOUp/a6KpDsrJn/BQUdnCSpDW7rRstS4BL/nQL
u3GldzCsyQCDUTf5p1MYv/HhEoex7A==
=PBjj
-----END PGP SIGNATURE-----

--7rsewhxpczujpc6x--

--===============3704670059281026302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3704670059281026302==--
