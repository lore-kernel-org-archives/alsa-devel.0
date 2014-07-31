From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: mfld-pcm: Allocate platform
	data
Date: Thu, 31 Jul 2014 20:19:21 +0100
Message-ID: <20140731191921.GJ17528@sirena.org.uk>
References: <1406725745-30776-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7551114349352081383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 580AA2619F7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 21:19:35 +0200 (CEST)
In-Reply-To: <1406725745-30776-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7551114349352081383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKtkeOaH6ZQlCGRZ"
Content-Disposition: inline


--tKtkeOaH6ZQlCGRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2014 at 06:39:05PM +0530, Subhransu S. Prusty wrote:
> Platform data may be null during platform_device_add. Allocate platform
> data before using.

Applied, thanks.  Looking at the change I hope that "may" should be
"will" - this will unconditionally overwrite any platform data that's
there.

--tKtkeOaH6ZQlCGRZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2pa2AAoJELSic+t+oim9TEwP/i4iXqqiVi6HF1s/qDryHsTf
HW02GALctTh7BTplq5/IIiF86G09Tej+i4rjJqTrK5BiEY/37c1rlUbd3M6ih17g
VRILuemfSd+KVpHkK6Pv8Iaaa0c8EsPNGJSWIdRz2YackXxQgl29ltzGaWGpCUCa
B0vt6+H3P5PNyT74Y8rFOnJQ0Xmj0A3RsW3tLQK0uOP3Y8H5jfC6uVsm2oXBElJK
wGDR3kLfir6RE9m34iOrYt1d24m4x9mwdCje/K0THvXhApbZ3J8lKAJkTxVYjU2E
sQNenanxJaQOKG5gpaPx/w45iv8B5ae6DKiJbpa1rcnN6Fx12OKlH1u2lTa2o1v3
ydpBhjMf8oPYNuFIDjTAAaKN8SjD9+NB3+45vVvCg+oCsgb9K6d88akWG1vDlQTc
lBRc6r9lDRnCwDncsUF9x7CIxJdaqnr9Gm3BgEMUP7aJK0Ji4du+S+lCQIx5pAe2
onnQJOyo8ILxsqVWNso5pL+geegpRzYE1qc+8GZvWZWhj3DELcFV/w1+UGmzM2AX
SlnFEJWfqdi1yqcGm956svIURAelTheL3tbEx4vSa/SwDnW6k9CidiX26HfzTOfb
FGoN86dZvgqTd8qcQzxVsWouui/cAbnVqAGHzGtWa+xq5eNUMSucTOYJNMHh45yP
o0XwZVgSU5W1rRUAy6mg
=MI7X
-----END PGP SIGNATURE-----

--tKtkeOaH6ZQlCGRZ--

--===============7551114349352081383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7551114349352081383==--
