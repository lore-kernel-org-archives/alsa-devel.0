From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: cs4265: Add native 32bit I2S
	transport
Date: Thu, 30 Aug 2018 16:41:40 +0100
Message-ID: <20180830154140.GG7301@sirena.org.uk>
References: <20180829233802.22032-1-flatmax@flatmax.org>
 <20180829233802.22032-2-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3947963094146624696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C781F267668
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 17:41:45 +0200 (CEST)
In-Reply-To: <20180829233802.22032-2-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============3947963094146624696==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 09:38:01AM +1000, Matt Flax wrote:
> The cs4265 uses 32 bit transport on the I2S bus. This patch enables native
> 32 bit mode for machine drivers which use this sound card driver.
>=20
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>=20
> No changes from v1, however have tested the intended functionality and
> list discussion had firmed up its purpose.
> ---

Charles?

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluIEDMACgkQJNaLcl1U
h9DOagf/b17NUMxyBIOUvwVzxm07Z6EdOJOr5itrsp+6gCiWNqSCgPKtDJ4UDpTL
ZVVsymN7PLhqv3WIVGlIvSs5aEd/h1/F9ejz2uIMJP6HEEsfibkal/NTTTjF1iub
ii//I4StRZBtbuT4C/65tlT/AwEcT/R95ibC1cHd2TdreYZE5ADo7WcBS7IklIR6
PzzuWFWVNbEJ81f0a+2C2mAeMlpnt9wZJFrwzoQ4UvRY3m5EGr/6ubGzWeJeIKNG
+jhKwJGdZ8M053iDpuOD4UkkfU24Ct1CIDNFfrpH4t8TblYkvvuNx+iuQRCuUkmW
L1I4Qgu4Z4sD6Szxs9fWN5qFVg7JJg==
=IA0i
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--

--===============3947963094146624696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3947963094146624696==--
