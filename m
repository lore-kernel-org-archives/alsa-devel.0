From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if
	already idle
Date: Wed, 8 May 2013 13:39:02 +0100
Message-ID: <20130508123902.GL7478@sirena.org.uk>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
 <20130508103401.GX7478@sirena.org.uk>
 <20130508110451.GC3459@gmail.com>
 <20130508113124.GH7478@sirena.org.uk>
 <20130508120326.GF3459@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0005492746692814940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9105C2608C9
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 14:39:13 +0200 (CEST)
In-Reply-To: <20130508120326.GF3459@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0005492746692814940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBMNUjqROSlRgKnE"
Content-Disposition: inline


--gBMNUjqROSlRgKnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 01:03:26PM +0100, Lee Jones wrote:

> Besides, I was more referencing the massively increased effort
> imparted to the developer by applying patches in an arbitrary order.
> Forcing the developer to rearranging and rebase the patch-set causing
> unnecessary merge conflicts. It's better if the maintainer takes the
> patch-set in the order it was written to prevent unnecessary (which is
> the key word here) such things.

Meh, rebase takes care of all this stuff for you and you really need to
be rebasing anyway to take account of changes sent by other people.  The
problem you were having was that you weren't rebasing at all.

--gBMNUjqROSlRgKnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRikdiAAoJELSic+t+oim9R3MP/0sTjHV1ChLjwjJvP16w/Sou
7l2ifGG/eaZqmlaLoETLdI3A4DEq0NGuqP4g1gm7xYkUSivLpKcvSP3r1unEohEA
fNno5BhmpVsmTL2LBNiylqVO3Nr+OG7LC08m3Fwwej4j4RzsUmYjb6W6JzWmgyri
ZWKhLdzhxnWVtugmmb7HFIxk4tao/EFxCMiGRV7XdvXdkPbFMMj/wkQTPVblPBFw
Alkn/N6VoFXdb+ajn55FMlIuvn13qBwzZ9RldRGhd1wQyqklCg7SYqT2+F0BAYlQ
L0fKd97B2fTeLlncM4MkrwrvbGjKn1CWCofN6b1Pr4uhsIN41uD9cwFWxQOkI38h
gISJ583iVJxondlgVHYOz6O5QCRFbPf36uvvVAaxOXAFGwBdTp6ioFubZKMJ81Vc
suV4h3sYV3RQ620cItL0RVb/98CfPGKM4mEH719LEjFku0/NM76aJmp9HW8Jz7la
fOYDayxIvkgmcLxtJj0zEm+Myd8jwoBKivI3IGOsZGcMi45RT+CBuwriLziDzkAb
c1xc4FxpYc4/EGlPI2caB4bwK/xwyhY/1ZIwcIHAcxhFw8bPdEqSUTcjgJsUFt9v
xUXGuBzficn2WDXpwbJ+GQqqfDqVUWn7Q1pp6OMlz96nWOby76krGj6PsN0z1ihd
ET7uh7gPiVQ60sgXnGf2
=wwle
-----END PGP SIGNATURE-----

--gBMNUjqROSlRgKnE--

--===============0005492746692814940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0005492746692814940==--
