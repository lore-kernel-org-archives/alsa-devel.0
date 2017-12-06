From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about soc-utils
Date: Wed, 6 Dec 2017 12:47:42 +0000
Message-ID: <20171206124742.GE1827@finisterre>
References: <87r2s9txwi.wl%kuninori.morimoto.gx@renesas.com>
 <20171205123924.GG11658@finisterre>
 <87po7szq28.wl%kuninori.morimoto.gx@renesas.com>
 <87609kzb7u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830892229951232995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BB007266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:47:44 +0100 (CET)
In-Reply-To: <87609kzb7u.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1830892229951232995==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 05:26:54AM +0000, Kuninori Morimoto wrote:

> > > That's just an oversight, it should be using the sample size.

> The original commit was below.
> It seems original code was also assuming format width.
> Was this also oversight ?
> format_width -> physical_width changes meaning, I think...

> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
> -	case SNDRV_PCM_FORMAT_S16_BE:
> -		sample_size = 16;
> -		break;
> -	case SNDRV_PCM_FORMAT_S20_3LE:
> -	case SNDRV_PCM_FORMAT_S20_3BE:
> -		sample_size = 20;
> -		break;

Ah, sorry - I misread what you were saying.  The above is the intention.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon5u0ACgkQJNaLcl1U
h9Bl7gf/YVZVGXC/XCGrANMVb02DrnzIg6qydVQALhwK9Jm6K+u7BXIJMVAVEt9P
vkHA9YGsww+im86vZk+QYy6TBwMocdUhOJ2UJ9SDnpRQbGcV/+gcU3jU7m4MMIbq
yWOpsSt3/2hkfvPkvFAg3OKfPCl7tkIgw8O/a3MV1Qi08E5+52sTxgD7KvSrrmtv
zGSb1Mq6yROIQKoxudU/xWe9ZttDKXVKeWqWu0IgXuD/PjMJ9ZazlJVcq8/X05Xn
CZmnvnnlXi6UitKOpm8T3RjddmtL4bEO2Srzx8ECA9p/Wua5t2ZOsZq7KTnZDotn
Oaf5JhBGXatqcnwPROTf0w3M8R/8kw==
=L5Ru
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

--===============1830892229951232995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1830892229951232995==--
