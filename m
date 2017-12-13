From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: ASoC: rsnd: Add device tree support for
 r8a774[35]
Date: Wed, 13 Dec 2017 12:55:31 +0000
Message-ID: <20171213125531.GJ6416@sirena.org.uk>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
 <20171213122052.GG6416@sirena.org.uk>
 <CAMuHMdVY5PwEvZYBzC_f-W_n9ATST4_tfPBO4CakYo-93DvLtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVY5PwEvZYBzC_f-W_n9ATST4_tfPBO4CakYo-93DvLtA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das@bp.renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 01:34:40PM +0100, Geert Uytterhoeven wrote:

> The confusing part here is that for most[*] subsystems, patches touching
> only DT bindings should have a "dt-bindings" prefix, while patches touching
> both DT bindings and driver code should have the drivers' subsystem prefix.

> [*] I think you're about the only maintainer who insists on patches touching
> only DT bindings having the drivers' subsystem prefix, which people tend to
> forget, if they're even aware of that rule...

> Can we improve this?

This is something Rob's been pushing which seems like a step back to me
so I've been pushing back on it - it's causing problems for me spotting
things I need to look at and later on in review (including my scripting,
which does pay attention to subject lines).  I suspect I'm at the upper
end of people getting lots of irrelevant stuff in copy which doesn't
help here.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxI0IACgkQJNaLcl1U
h9BKCAf47lxpHCkYtB1x2pTXTj8Om2nmb/iNAAVwCqP4+/fl2d0NQBMQbTteNc25
P4eX0Hl2blRSzqXhtKf1Iwgernjhdkn+nZRy0qbMjUWkuyOuDlmEaCJI9+8ER2tD
e1JBeEnweIrQ2xTYbxnG+gi1TqQRQbTUqvpfcRfUTuHButYXCns5Ipn+zI+W4+0r
uJFIA7Z7+rPPQXrx5f4NberweFczhzGL+vGm1zZFxglnkCPh1l9vSDmyY08Rx8M1
2y6voiawbFpq3zfXznba3giK4eg75CNaswF93uz3X5q2/wocbz3RA2VD6SzSjEsG
cOc1kLLQd8MyA6jIziNt28qiA++s
=cjld
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
