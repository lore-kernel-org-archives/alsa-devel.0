From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: fsl_ssi: remove explicit
	register defaults"
Date: Mon, 7 Mar 2016 09:20:41 +0700
Message-ID: <20160307022041.GO18327@sirena.org.uk>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
 <20160222025930.GO18327@sirena.org.uk>
 <CAOMZO5BNY6V-Qbo+gBY1dW-9bHgBusXXAmEiG45BzuoZeKSm8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7215853965477755072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F3112605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 03:25:17 +0100 (CET)
Received: from 110-170-137-3.static.asianet.co.th ([110.170.137.3]
 helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1ackrB-0001Pk-TR
 for alsa-devel@alsa-project.org; Mon, 07 Mar 2016 02:25:14 +0000
In-Reply-To: <CAOMZO5BNY6V-Qbo+gBY1dW-9bHgBusXXAmEiG45BzuoZeKSm8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7215853965477755072==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XVy146w4QFEnwrLT"
Content-Disposition: inline


--XVy146w4QFEnwrLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 06, 2016 at 09:11:56PM -0300, Fabio Estevam wrote:
> On Sun, Feb 21, 2016 at 11:59 PM, Mark Brown <broonie@kernel.org> wrote:

> > There's no problem adding it back for v4.6 for that matter, the changes
> > will all have long enough to soak (and have already been soaking for a
> > little while).  I'll do that.

> I see you applied this one as 56e5fd8feb286ab7 ("ASoC: fsl_ssi: Go
> back to explicit register defaults") into your fix/fsl-ssi branch, but
> it is still not present in 4.5-rc7.

> Any plans to make this one into 4.5 final?

It'll go next time I send fixes.

--XVy146w4QFEnwrLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3OVnAAoJECTWi3JdVIfQkgoH/AzEZgt76s6hZ6w74OA188pk
v5yarTgHyqKncHzQUha2MiY9sXwhBviR6XHpPb3pgImgyfW0rTuU256qxeJZrmrr
6FWqzYJlRHBEHECBdSnJ4CmFUplt2F24WJ6rBA+B7/e3Lgdqv2KKsYHkv3dg0YJS
uDprsl5L4+eXjPoLJMxGktQYCxsDz4oJTo+f6tSfg+j4rLas9N40dJ1txhBshvMe
zHfFKFmf/peJpy9JdwcY44aPwpubGVxuzXJ1H8HYRCY+0DZxctOxNZoVIiAf6jFZ
czHW5FvD0/WiqR+nAIvVmL7NEz9zkTVLpkv/RcHS0eD0dOOEkDbhCtERYsj2jEQ=
=dcpi
-----END PGP SIGNATURE-----

--XVy146w4QFEnwrLT--

--===============7215853965477755072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7215853965477755072==--
