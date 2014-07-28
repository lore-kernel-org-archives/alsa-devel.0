From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 17:56:14 +0100
Message-ID: <20140728165614.GC17528@sirena.org.uk>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
 <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
 <20140728163645.GA17528@sirena.org.uk>
 <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
 <53D67F0C.3010207@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9049897283889355682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1CF265134
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:56:24 +0200 (CEST)
In-Reply-To: <53D67F0C.3010207@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9049897283889355682==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h+WJKwmBUQshgR/B"
Content-Disposition: inline


--h+WJKwmBUQshgR/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 06:49:16PM +0200, Lars-Peter Clausen wrote:
> On 07/28/2014 06:47 PM, jonsmirl@gmail.com wrote:

> >Where is an example of how to use it in a device tree?

> https://lkml.org/lkml/2014/4/28/318

> Does pretty much them same though to what you proposed.

Right, the bit I was pointing to as problematic was the comment about
removing the description of the internal CODEC from the card if there
was an external component connected to it.

--h+WJKwmBUQshgR/B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1oCrAAoJELSic+t+oim9lawP/04QZRFjXCZJGAaq9xwMc+Iy
c4jAAYu4Pr7pU6E17a4KuRqncjMms1dRGBsglbUqgdSvm1Um1viwbcOpExQXYpjM
y8h1l0VAeNUwg2l2k6c3muJjFp5okb66/AFI/QzC/kJAFgLMtK+t4t2jtcgb6NL8
xsV5Mme6Jn84OS+27h5XTukILUfoXzlstLyzyFbs8fO/T/D9Z8gaBNpXOHHZe0oS
7NKmAJWboZXgzzh+lT6dBifX6p39T1D4E9OaKnJBJZslnEklRAP4egeOb2fNOWPl
Q/9jaHIvH24wuzdtCR1Kin28IsL9n1erMBfA1Ejn7pBJK1+z94vfPnDHWJyHtU4j
KhsOlBpzp+kItqmxai0LWZapcc3oGDkKFueuFUN8f77fMtuusOgO85Z+k15Bm35x
4NSVIhJfVpbgvvu0Xr7ytBFzXL+h2NjZiiTwH7BJJjikabqLhAr/XNHePXy7MZHI
Us3hPbQHi0VIzDDmU5GqOUarfgrRKeYaqZznf6ezjzjkY0HV/P5PYYRpj00j0e/N
9/abLVpTcre/h2nu/7ovKbE5PA5mJgTULdVEi0ySqaC1PqoGZojX0+ua5ax8z1uU
YkDAEYlNbuvYM2OCYA+71yjbQfjjYw8O6IRbi+3IuayfwMtAu8eH/pwfswQLDH0t
b4YOVLQO0v6TMZEo8mpt
=kZI/
-----END PGP SIGNATURE-----

--h+WJKwmBUQshgR/B--

--===============9049897283889355682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9049897283889355682==--
