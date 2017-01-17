From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] RFC: ASoC: dapm: handle probe deferrals
Date: Tue, 17 Jan 2017 17:59:49 +0000
Message-ID: <20170117175949.qv5rxypbrgzmclsk@sirena.org.uk>
References: <20170113092352.22474-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6238888161864820619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 960CF26725F
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 18:59:57 +0100 (CET)
In-Reply-To: <20170113092352.22474-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6238888161864820619==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f3bk72yidg6ng5vn"
Content-Disposition: inline


--f3bk72yidg6ng5vn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 10:23:52AM +0100, Linus Walleij wrote:

> I want an indication from the maintainers whether I should just
> go in and augment all these call sites, or if deferred probe
> is frowned upon when it leads to this much overhead.

We probably should handle errors properly like you're doing here but as
you say it's a big undertaking.

--f3bk72yidg6ng5vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+W5QACgkQJNaLcl1U
h9D2OAf/f7LDAxVaw8o/c0SZvXrqSu37Ju/SK7AkVsLyAirLFMMmMiEpDWz/hzxk
TuhSbmcmGiRLpfuiTlxGHLLKB6bAUUm7hlWMyJ3cUDA8dmEVC4GXOTCJXzdYwcZU
l8X3towVX6CRN8dl0Gph6j2e45a3dy5th8mfO4LoB4xXqD0jpQqyLQUFIlz1KnnH
oHOUWTaIcDsFSbw+CDxp/jeyn/SHoAkCt30/RdWoefH5FFf/in2NuBid+H6/mIRO
aEpbfjMTyb7GVYe5o1ck8vB6JIqZC9cQPEsUy2pFk61yxUsLD105m0aRLlkFp3+1
ryXQx1ANevpp2UjIRWhoXxXpk7ORzA==
=sP1E
-----END PGP SIGNATURE-----

--f3bk72yidg6ng5vn--

--===============6238888161864820619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6238888161864820619==--
