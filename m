From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct
	device
Date: Tue, 5 Dec 2017 13:04:46 +0000
Message-ID: <20171205130446.GI11658@finisterre>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2191989812650888224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0A0266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 14:05:01 +0100 (CET)
In-Reply-To: <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
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
Cc: mail@maciej.szmigiero.name, timur@tabi.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============2191989812650888224==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2017 at 12:46:34PM -0800, Nicolin Chen wrote:
> struct device is defined in system level header files any way.
> As long as fsl_ssi.h is included after those header files, it
> should be safe to remove this line.

It's better practice to either directly include those headers or have a
forward declaration like this, it means there's no way things can go
wrong.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlommW0ACgkQJNaLcl1U
h9DKngf9G0hdTAKCrt5SUpPnTKgEfzhkb8uVISWw9YmR/iqZcz2Aob1jJKc/J5UB
fP+P+Jk+FTHbUPznEowCL7GJtOiB215wYCbb2aSYMV/Y+Q3RpAPEOijEnbWxR/kh
eIzpxIbF+zWeHLqW5GXEQ9fc3w6uvoP3LzZqBX9rClD/GpRar1JJOvCHFt67pYE7
K6ST4N+L5Hf1xmNtfDboNYQHuhkVYZXv1X3AWK1cajpZSfjuFerau232zc8KpiUT
XO3eh3c/BETO4D74ffsMKIz8QobJPjlM4DNlpzhBiD1/5FBp+YjSn72L21G9JP6f
/vWs3Be/ifI8LPq+R42KSpmfmnMmxw==
=z7pP
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--

--===============2191989812650888224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2191989812650888224==--
