From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: fix shift used for second item
 in snd_soc_get_enum_double
Date: Tue, 9 Aug 2016 19:54:14 +0100
Message-ID: <20160809185414.GF9347@sirena.org.uk>
References: <1470766145-3340-1-git-send-email-jjassal@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6138149620168813151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C27D926662F
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 20:54:27 +0200 (CEST)
In-Reply-To: <1470766145-3340-1-git-send-email-jjassal@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jjassal <jaswinderjassal@gmail.com>
Cc: jjassal <jjassal@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6138149620168813151==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 07:09:05PM +0100, jjassal wrote:
> Incorrect shift value was being used to extract the second item.
>=20
> Signed-off-by: jjassal <jjassal@opensource.wolfsonmicro.com>

This doesn't match the e-mail address this was sent from and so looks
like a non-author signoff though I'm guessing both addresses belong to a
single person.  You should ensure that your git configuration is
consistent in which e-mail address it uses.  Making sure that the
signoff comes from the author is important for licensing reasons, see
SubmttingPatches for details, and so using different e-mail addresses
sets off alarm bells.

You really should also use something other than your login for the real
name - it's the more common thing and it's less likely to be
misidentified as spam.

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqibVAAoJECTWi3JdVIfQS1gH/ji/vNqj3E8pJwigZ9YOCnC+
ND7Z98FOLS5vZhakUUxrHvplhFmvHwQq/YKX7ZcWZBuAQi/CqSiHOdJNZnn+pJdQ
NYpzGKjt0ESQDCq/8RIB+jDD4gMLqlCCTkrezivWRySV8+9n1D4D5QS1ObDY1UZS
2l7/j2rDOnF07Gw4ojFmkRgTft7pwYVejXdSPS6pGIoJBZmTfMJ1tBie4la5I1t1
yiQLaD9GLJx9GTD3vs6ghhN1ESp/VWpAnoBHBIFsA8+xj5U2sTCg4WcGkvNSf2yC
NkdebWyUuoZZZzCv1BYRTCMritmVQmgn0TCjcA5EU0txMQ/X02rzEheg9kV42OY=
=dNSU
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--

--===============6138149620168813151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6138149620168813151==--
