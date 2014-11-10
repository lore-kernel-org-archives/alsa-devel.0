From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: davinci-mcasp: Validate
 tdm_slots parameter at probe time
Date: Mon, 10 Nov 2014 15:00:17 +0000
Message-ID: <20141110150017.GX3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0959631360591178566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E221C26154C
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:01:34 +0100 (CET)
In-Reply-To: <1415615540-28981-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0959631360591178566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l8K7Jruglmu/f1iT"
Content-Disposition: inline


--l8K7Jruglmu/f1iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:32:15PM +0200, Peter Ujfalusi wrote:
> Instead of validating the tdm_slots parameter every time at hw_params we
> can do it once during probe. If the parameter is not valid (<2 or >32)
> print an error and fix it up.

Applied, thanks.

--l8K7Jruglmu/f1iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNMAAAoJECTWi3JdVIfQ5EcH/iy8FSl0oC2H07V33tiJbeMy
wZTW6YFn5h95di+b9KpS8/9L7LLdWwl9qW3PpT0ebjgC41g1l8zoCLlW7x1sxTlO
CTw7RjdlfNRdaDJ5pLtPCnKxJWoNj5UCAbtT3Er8dG0yfdH6kcg4SgBVl2HI0o6R
o3zsFcOO0+f37g8t3qTmASpHfX2Y0OGXSklg/dOPqknrX0kfAGRB4TP3evjTXNLc
S5QKtykXEC19wy7JefI2yw/3m07+tRGo9UvCGHGlAGO993KxBlm1v/ygS9mRkktT
2+1854DhzWtvPrKahXlw7V8wX4M7WrUQSVpZvV897b/s1jWrAf45rnBxyFak91Y=
=306O
-----END PGP SIGNATURE-----

--l8K7Jruglmu/f1iT--

--===============0959631360591178566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0959631360591178566==--
