From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/17] ASoC: tlv320aic31xx: General source
 formatting cleanup
Date: Thu, 9 Nov 2017 12:41:43 +0000
Message-ID: <20171109124143.mpolqcvsdzj2t6tv@sirena.co.uk>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4860103946263265523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FED266F89
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 13:41:51 +0100 (CET)
In-Reply-To: <20171109002741.10897-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============4860103946263265523==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2eiv4wnvkyqnbbj"
Content-Disposition: inline


--r2eiv4wnvkyqnbbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 06:27:25PM -0600, Andrew F. Davis wrote:
> Simple non-functional changes including:
>=20
>  * Fix header copyright tags
>  * Fix spelling errors
>  * Reformat code for easier reading
>  * Move some code blocks to a more natural ordering
>  * Remove unneeded code
>  * Remove assignments that are always overridden
>  * Normalize function return paths
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>

There's other things in here like adding error reporting...  please
don't send changes like this, if you want to do cleanups you should
split them up in the same way you would other changes.  Bigger patches
are harder to review especially if they're not repetitive examples of
the same pattern. =20

--r2eiv4wnvkyqnbbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloETQYACgkQJNaLcl1U
h9Bj2wf/WSq0Nv2h3DBZSFu6PzUWpOsuarkxzYbINzKGIMVDzAtwuEfJLzTH/Tv6
J/qz+7DiEYjVdLQv7vO6hSMrIn+4WYyUDs/BcJ6SyNkhlOOmY84s2E2g0WdgTi1D
glTZsqkeliT1qfN+N3fqkCGwIoZi3+LuGhNF1BoSpfyExOvAYHoPLuyRWcc9M4rm
wo9wDqweQTq8SdP1QY0gdpGFsae+UHRdCLgrQqz3BN25PayXseIbBYvex1aYzVJf
xv+bvxVj+5LohZzh2V/8T/7ZlC27UQmpmgegE0K7ecbhC9UerFb8t6BsTGfIfg7U
gvxW/fbmisFwSIw1SStXmMyCZ5AYvQ==
=E1YO
-----END PGP SIGNATURE-----

--r2eiv4wnvkyqnbbj--

--===============4860103946263265523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4860103946263265523==--
