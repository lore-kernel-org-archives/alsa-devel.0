From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: extend FLL function
Date: Thu, 10 Mar 2016 12:24:48 +0700
Message-ID: <20160310052448.GM3898@sirena.org.uk>
References: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032316.GG18327@sirena.org.uk> <56DEBE7D.70100@nuvoton.com>
 <20160309024034.GC3898@sirena.org.uk>
 <56E0F8BA.4010209@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7861804261352156605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66832260694
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 06:24:52 +0100 (CET)
In-Reply-To: <56E0F8BA.4010209@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7861804261352156605==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="37nyS7qXrnu4wN2o"
Content-Disposition: inline


--37nyS7qXrnu4wN2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2016 at 12:31:54PM +0800, John Hsu wrote:
> On 3/9/2016 10:40 AM, Mark Brown wrote:

> >This really isn't a good way to be handling things, you should be
> >ensuring that platforms that have an MCLK provide one via the clock API.
> >If the clock is missing that should indicate that it's the second case
> >where it's not used at all.

> Do you mean I should use devm_clk_get to check mclk exist instead of
> nau8825->mclk in nau8825_mclk_prepare function? And return a warn-
> ing message if mclk is missing?

That might make sense, yes.  Let's see the code.

--37nyS7qXrnu4wN2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4QUeAAoJECTWi3JdVIfQMhYH/253Q4mvaSq5CqruPTHdKdZW
YzZ6enw/jL2QQnTfiiPiHElnz7WU7608OJ81ZJvkpPQcJ4NsxZxYx/aV8kLa6Xnv
UE/cJOwZJRN/bcm1CVrRYdmRu/K2g3+Wc0PHwKTkpyonC80rg8QcHOvTR/R8GOEP
+OQ3pcnZiMS5WgyCHz1JlzCcUhGIp8y16fy8i0IlB2qVr+GkSvrI+cirxUIkRk0i
b5YK9SxQA18618onu8fC9FvGNLQB97tlDRxM0kLdIedE+ZZeENBe3y2gOpVNQIim
KQtYeciBZC0EP2Y+LT6ssI1IxvnsEc1n2Q4hPksusUWexgHt+sDzXI4wRctzfOQ=
=RhMt
-----END PGP SIGNATURE-----

--37nyS7qXrnu4wN2o--

--===============7861804261352156605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7861804261352156605==--
