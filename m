From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Avoid calling
 snd_compr_stop_error from WDT expiry
Date: Thu, 4 Apr 2019 20:39:20 +0700
Message-ID: <20190404133920.GA2803@sirena.org.uk>
References: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3208929077083736138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB463F8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 15:39:27 +0200 (CEST)
In-Reply-To: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3208929077083736138==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 01:56:01PM +0100, Charles Keepax wrote:

> Fixes: 56bc22bd1dac ("ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout")

This commit doesn't exist upstream...

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlymCQUACgkQJNaLcl1U
h9D/5gf5AW76p9Lqm9dUh3Hr2fngZVuEk0EaBrT/liAZNdc3cp0UerwzZCEJZuaS
ahPr6+c1o+xsiz7FCT4nb3TxwEgQHeZtTSdQZuBJiqX4xmFWIfBiD12uMTaohpyi
MqTIxBY2cJaGObYQBy26u1Y7V2n8isuJJP0sksvJ5B7f8sjbns84HGPpoHLc9Dxj
j+MJDjB0iEslH1qOPulzcTyKnI6ntzDHyP5pxPygCKSlck+BrIe2idYU1dYUIvLt
rVV/A5mp2RkQLlBVDj3e9hojcb2EsfKN+pBk8BdMf9cby6j6eZFmeEyEzNjx0caO
dhVjsPajOgzSwWl6YSmKIJLBlL1/Jw==
=NRZR
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============3208929077083736138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3208929077083736138==--
