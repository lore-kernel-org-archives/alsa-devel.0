From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: About graph node issue without 'reg' property
Date: Thu, 13 Dec 2018 18:27:39 +0000
Message-ID: <20181213182739.GZ10669@sirena.org.uk>
References: <20181213193944.CCC9.4A936039@socionext.com>
 <20181213162428.GR10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4337223466521513132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D02F26789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:27:40 +0100 (CET)
In-Reply-To: <20181213162428.GR10669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: alsa-devel@alsa-project.org


--===============4337223466521513132==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+vcRm3WFmV0Q/ShD"
Content-Disposition: inline


--+vcRm3WFmV0Q/ShD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 04:24:28PM +0000, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:
>=20
> > Maybe I think that we'd better add 'reg' properties to each port,
> > however, there might be same matter in other SoCs, so I'm not sure
> > whether your patch breaks the backword compatibility or
> > our devicetrees are wrong.

> > I'd be glad if I could hear something about this issue from you.

> There's an ongoing thread between Morimoto-san and Tony Lindgren around
> the graph card including this issue, there Morimoto-san proposed some
> code which would let the reg property be optional.  Device trees should
> still be updated but that way we wouldn't actually break anything which
> would be good.

There's a patch now - "[PATCH][RFC] ASoC: simple-card-utils: fixup
asoc_simple_card_get_dai_id() ID method".

--+vcRm3WFmV0Q/ShD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSpJoACgkQJNaLcl1U
h9AZSgf8DJV2egX6ENTCZAe8EPXaS+WF0cef6t51L9ocKvhAOeHoUehO7HvT9gMG
xBO9cd7tIfw7+HwqH0sBSdDAKBP246DDM08+oQyVKhr+w61RVd8mV/nUA9JBtNVC
yA9H3bryGOQck8Z01mHvL9D+ksFdsVQSBXprSiHb/YjxVcVwJSeoS5rXOZbrB+qL
VP9+z5P6dqs3Fbw21dE3TrfayK32TyYPbGrV138KpQRjdNDSVDkTrnivlg8sMrfV
MbEWHxcTcAOYxJIHSudYnXzNyea5c6YTFrz+0eCWSMGISEQ8GFtqcL+AMhb9fsWk
qJmrndRUNuiWBbOkVM0tngVTGdd8Bg==
=/9Qs
-----END PGP SIGNATURE-----

--+vcRm3WFmV0Q/ShD--

--===============4337223466521513132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4337223466521513132==--
