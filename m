From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix the runtime error in the
	booting
Date: Fri, 2 Oct 2015 11:11:41 +0100
Message-ID: <20151002101141.GO12635@sirena.org.uk>
References: <1443763829-9359-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2573945329602582269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D489266857
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 12:11:48 +0200 (CEST)
In-Reply-To: <1443763829-9359-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flubba86@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2573945329602582269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2015 at 01:30:29PM +0800, Oder Chiou wrote:
> The struct rt286_index_def was used by the cache function, so it cannot be
> declared as const.

> -static const struct reg_default rt286_index_def[] = {
> +static struct reg_default rt286_index_def[] = {
>  	{ 0x01, 0xaaaa },
>  	{ 0x02, 0x8aaa },
>  	{ 0x03, 0x0002 },

This isn't obvious and seems likely to break - why is this ever being
modified and how is that safe?

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDlhdAAoJECTWi3JdVIfQZsoH/2WKsJdmwCMXi80t7FZWeCIZ
3qwcglQwR3H2otZW6rgCMUBWLLPViH8ObWJzQaMxtzBAhZWgFQzmhJU/jj6O9qh2
JSy/NWXz9Og6Wlhhi2dLlmGrZbOjklgc94vNH4z/N6sXwEdCS7JTH2VEUiHRDjGF
Y0pTl12KNuoClYKj13Gjfylv4GV3Sly3JBljBWP0D72mWitaTFcHGGORw39Y3HUV
c0VfdXpy/945mvs9rFW7GDGaJjMplMNoP1fOtQecxjh4USRb+jgVSG45cLuo1AD9
2sxEakaJrWe6cMBlqZOq9qZMAplnHd78Gn8LoTy4VSdA6yVuzcZLNuRX5utx0HY=
=DsM6
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--

--===============2573945329602582269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2573945329602582269==--
