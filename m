From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix kernel panic in probe
	function
Date: Mon, 22 Sep 2014 18:58:25 -0700
Message-ID: <20140923015825.GH27755@sirena.org.uk>
References: <1411065489-21496-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7271366540281193948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80C85261703
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:58:39 +0200 (CEST)
In-Reply-To: <1411065489-21496-1-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7271366540281193948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:38:09PM +0200, Michael Trimarchi wrote:
> code can raise a panic when the ssi_private->pdev is null

Applied, thanks.  It's not clear why this might ever be NULL though...

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUINPAAAoJECTWi3JdVIfQqXIH/0W25yEzI8l5fmIHQjCpXQpj
4DRzw59ZIZ1/55pp9G87ktJCubd6iADe3ApIVwO0JAt55o4ZIqGjW0bAW8fDGeaX
YzPjbUnBV9oIBVThXZIWS7yqX7PSEgV3dETVdgXXlM871NPATH84fu+HzlED+4s7
EYD88eKCSku4jXI+I1PRoLu6zqc9F/JmW02eAwu+VK+4dhWTaxmZ6K8E71t2yAMl
KuCNKCp2LTnzRt1MA1WxBe1JjMTr2IsMRg7CMG8RBbByQelXEAR1Jp7igOzP9trf
EhK6JXPGsYZlx+VR4jORXqX6CQ5LE1/L0YnbRLpmYEphnmLaOYGU0hES0Ui7nwk=
=9mT0
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

--===============7271366540281193948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7271366540281193948==--
