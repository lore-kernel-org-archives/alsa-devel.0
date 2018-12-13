From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: About graph node issue without 'reg' property
Date: Thu, 13 Dec 2018 16:24:28 +0000
Message-ID: <20181213162428.GR10669@sirena.org.uk>
References: <20181213193944.CCC9.4A936039@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8585932435585305951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9719A26789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 17:24:30 +0100 (CET)
In-Reply-To: <20181213193944.CCC9.4A936039@socionext.com>
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


--===============8585932435585305951==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:

> Maybe I think that we'd better add 'reg' properties to each port,
> however, there might be same matter in other SoCs, so I'm not sure
> whether your patch breaks the backword compatibility or
> our devicetrees are wrong.

> I'd be glad if I could hear something about this issue from you.

There's an ongoing thread between Morimoto-san and Tony Lindgren around
the graph card including this issue, there Morimoto-san proposed some
code which would let the reg property be optional.  Device trees should
still be updated but that way we wouldn't actually break anything which
would be good.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSh7sACgkQJNaLcl1U
h9Bfbwf8CZwXDJ0O1VnVPP7joVWcrQp5GZJHKL6PohHC4wnYTxdL1upa7gVxSBan
K2KxWJrne+6gyNqnToMgQtO8kXuWvOz7VUrhNeO1GdLx+exyJpDTP89eKT9sV6Rz
2uCxx/Tzzd1B1g7uUPm7nqHvPgxVQive0+LHOEtLG6X732sw4YWgzZ5dX0gvYk6Y
ouVfi+jhEDWmbyW7lphF5KqExsM0+m5WSOdd7iYtdXGe5AFLrJPBGiG8dCsMd/KU
jCjrs1Z7u60yDcOj5gJ5tTy4RTt+JEtCipEC7w+n5RIfxc1d//A/qIwzBeIY5/vb
EVEoARP7HPmnD7EPpo2lUxLXlpyHXw==
=tPIe
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--

--===============8585932435585305951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8585932435585305951==--
