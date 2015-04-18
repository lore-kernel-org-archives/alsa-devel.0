From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/13] ASoC: wm_adsp: Warn that firmware
 file format 0 is depreciated
Date: Sat, 18 Apr 2015 18:26:41 +0100
Message-ID: <20150418172641.GD26185@sirena.org.uk>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1428928085-20250-14-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7045614418870273882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B964026262A
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 19:26:48 +0200 (CEST)
In-Reply-To: <1428928085-20250-14-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7045614418870273882==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZNveOOYjKturpEFp"
Content-Disposition: inline


--ZNveOOYjKturpEFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 01:28:05PM +0100, Charles Keepax wrote:
> There are very few version 0 firmwares in the wild and at some point in
> the future it would be nice to remove support for them from the driver,
> as they require several work arounds to be present to create controls
> properly.

Applied, thanks.

--ZNveOOYjKturpEFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpPRAAoJECTWi3JdVIfQEDcH/i8xYesiYKyedUT6preCAxxl
AgHIEhGczztRqr7lZ8ey8BWbyEad7Mx/7yDMohdXeCFt6sswrvb+N4Q1lGwC+/Fc
96U/uz+n9w5t8j4coC73ug4G80Z9Qe8IUiSi+Y6ItqflBbv0WQCPb8OQmmsVuNov
aYGl9gvgZUjaP8HgSPtfnQTC5H0KM3javSUvDCualhANBMfYvazScz7v6Lx/N2e3
WfOBIRLiqDp+xx3FEtICHRFWeNSeG9L7qSeVSZUtw2xVvm6vBray0QnV6uk4Zgcz
grjOpQuGb6eTaOmrg1B2mFnffAljWfS+gUAHeI2UyCn00jqWo15l6GbZf2TcP7c=
=hLIM
-----END PGP SIGNATURE-----

--ZNveOOYjKturpEFp--

--===============7045614418870273882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7045614418870273882==--
