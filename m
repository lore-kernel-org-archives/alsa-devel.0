From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Delete unneeded test
 before of_node_put
Date: Tue, 7 Oct 2014 19:59:25 +0100
Message-ID: <20141007185925.GA4609@sirena.org.uk>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573882937966594506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42297260440
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:59:38 +0200 (CEST)
In-Reply-To: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0573882937966594506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXwywHnYJ7GE90zd"
Content-Disposition: inline


--CXwywHnYJ7GE90zd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:29:55PM -0300, Fabio Estevam wrote:

>  out:
> -	if (np)
> -		of_node_put(np);
> +	of_node_put(np);

This doesn't apply against current code, there's no np check?

--CXwywHnYJ7GE90zd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDgNAAoJECTWi3JdVIfQDm8IAIAdPCULvN0sQ3vBqm+mCJPg
DC0s1A+/29IyozOWTnWSki+LlHzslsI/lyT44xfR8kfrwNnavmUbVoAM9yVi6SUN
sIutoTpuCgChxMAtvjGGwrxirfoyTbgH59FXFHgq9f62tmSn7GBwk7Qj7U3R/9A4
OA0ZvARb+AH0NXaAKAnxpYTx7ii6YSlHbRdsqDQ8UZiWBHCEn1LtZnAAxtkRMrSB
30jbHV9noXJE0UkT7OecigfFHUQlxD1OBdvG8lt6A6hFb+6aVlllobw5rQUaNRxS
psAO+YSBA0ZLl1Wq2Yum9asKNadjdihvKrfNhWqnoxkF4M5l23v2euj7gn1t2m8=
=/58q
-----END PGP SIGNATURE-----

--CXwywHnYJ7GE90zd--

--===============0573882937966594506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0573882937966594506==--
