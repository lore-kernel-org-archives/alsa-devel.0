From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: don't use rtd->codec - step [6/6]
Date: Tue, 5 Dec 2017 12:19:52 +0000
Message-ID: <20171205121952.GE11658@finisterre>
References: <878tehvmv9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0557675100219996712=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E95322671E7
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:19:55 +0100 (CET)
In-Reply-To: <878tehvmv9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============0557675100219996712==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 04:16:32AM +0000, Kuninori Morimoto wrote:

> Kuninori Morimoto (7):
>   ASoC: don't use rtd->codec on soc_dev_attr_is_visible()
>   ASoC: don't use rtd->codec on snd_soc_new_compress()
>   ASoC: don't use rtd->codec on fsl-asoc-card
>   ASoC: don't use rtd->codec on intel/skylake
>   ASoC: don't use rtd->codec on Intel/haswell
>   ASoC: don't use rtd->codec on qcom/apq8016_sbc
>   ASoC: don't use rtd->codec on samsung/bells

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  ASoC: driver:

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlomjucACgkQJNaLcl1U
h9DYLgf+J6LcJHJ8w2mi+faikxEz7XfqL+pzD9a+0vOsCo/PKh4JpxDKSkx4dt38
iwMKcmn9MzAkCbPx5WDY06aCDFYA5uAPYt8n+22OH06TmZDzSvgud8svh/eQTEvR
sDdvcItkVsyXgHS43oz9mJbltNGoC8TdDKg3zEIFEb2o5aomLaouWQkcZ0ZuNkRc
rhY274zXxCCWBXRrwdq0wM1rrYq089HEKCfj8r5m60o5oWhC4KAhhOic/aFC1/mk
QekRSiFw8LetX14jEPERQJPzBO4ekRslkEVGz3yzVp23pF6e4DENG59VeUVlKEXn
wH2pmZWfzXeKwGdgKs0sPnaOmyORjQ==
=i8kp
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--

--===============0557675100219996712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0557675100219996712==--
