From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ux500: do not moan on deferrals
Date: Mon, 23 Jan 2017 18:15:16 +0000
Message-ID: <20170123181516.tr55l7mmqkhr25s6@sirena.org.uk>
References: <20170120132011.1147-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1096487879297113911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B794B2667E7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 19:15:24 +0100 (CET)
In-Reply-To: <20170120132011.1147-1-linus.walleij@linaro.org>
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


--===============1096487879297113911==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mbvrvwigst2j5ywm"
Content-Disposition: inline


--mbvrvwigst2j5ywm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 02:20:11PM +0100, Linus Walleij wrote:
> This removes the "error" print on probe deferral, it's
> unnecessary and confusing. Also cut a few debug prints we do
> not need.

I know I took the other patch doing this (along with some other changes)
but in general I'm not super comfortable with just silently ignoring
probe deferral errors as it makes it hard to debug practical systems -
the device is there, the driver is there but it fails to instantiate
with no indication as to why.  The probe ordering stuff that Raphael was
working on looks like the best way of dealing with the noise that we
currently get from not even trying to order things, though there were
some other ideas like Russell's one about suppressing deferred probe
error messages until after the initial init is complete.

--mbvrvwigst2j5ywm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliGSDMACgkQJNaLcl1U
h9CbLgf+L3uxIeNPQSCW2zqnRhJoGHSTFb2aO1l6G2rCiiKrpqy9xTGahI9meV5l
nOT/IMoNIbUDZZRpMTsLwvLcZtHrFKmHGov6lTaPg5CXFZJZkOmNTiAsgT4+KdYS
T+oFhgnlTZjO0x69x+KLIXr6KupnXRA8ALYfkvVNAPej5rRcjt8T1lXhNAgiL3CM
9/8arf8/yfjCO+FiZB54rr6gKpxfHiAy3tmuLbfoz/enUyJVL1ijufHTmRKYWrRF
2lhirc9FQuA3VMt7CFzmbAw12nWFn+vAMLnn7F0umRTPcBPoQFrDOmJOfCN40nAl
dLpzU3e5qHoXvcTEzDxj6NQX2VdrFw==
=K+sY
-----END PGP SIGNATURE-----

--mbvrvwigst2j5ywm--

--===============1096487879297113911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1096487879297113911==--
