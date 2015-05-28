From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP
	shutdown
Date: Thu, 28 May 2015 14:57:51 +0100
Message-ID: <20150528135751.GV21577@sirena.org.uk>
References: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8163219842570182129=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B751265E06
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 15:57:57 +0200 (CEST)
In-Reply-To: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8163219842570182129==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ypW9Hd+IdONQkcOt"
Content-Disposition: inline


--ypW9Hd+IdONQkcOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 02:45:14PM +0100, Richard Fitzgerald wrote:

> +#define ADSP2_SCRATCH0        0x40
> +#define ADSP2_SCRATCH1        0x41
> +#define ADSP2_SCRATCH2        0x42
> +#define ADSP2_SCRATCH3        0x43

May as well dump the other scratches while you're at it?

> +	unsigned int scratch1 = 0xFFFFFFFF;

Why is this being initialized?

> -		adsp_dbg(dsp, "Shutdown complete\n");
> +		adsp_info(dsp, "Shutdown complete (SCRATCH1:0x%x)\n", scratch1);

That seems a bit loud for a diagnostic message, why raise the severity?

--ypW9Hd+IdONQkcOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZx7eAAoJECTWi3JdVIfQGCIH/iLgLHAVeiY8waIT/QCkNJWs
M9NoaYwPP7rWu3PMYbTGqAyiWvJEBcaTeml8PrUtsECV5HlC0jPVjxEsaZ4JVNGj
TBLOvPHVjqg3pQY6STt91c5eqwYma966sztqa1RUUv8vz8KdQYu/aJtoUHxfZuxo
w3vDta05lNVgMcP9I8lgpJQURtm+C6JKNCWfj2qLFAbgv1kiYWvlMbT2aa3MVa9Q
5ysgD/CV44qRPhjKm1P+qL/G9klJwRc/OTYLnakjvEVJYKNEcEmx1VdCfMO8h5Xz
vSO8P5Ag17J9O/GrU5ZRyWfQtDbW8JeUU4vRb7+i5Vij3bu4YhSwC/LiOVLKZVA=
=PhVJ
-----END PGP SIGNATURE-----

--ypW9Hd+IdONQkcOt--

--===============8163219842570182129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8163219842570182129==--
