From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] ASoC: Consolidate enum controls and
	DAPM MUXs
Date: Tue, 25 Feb 2014 10:57:43 +0900
Message-ID: <20140225015743.GM25940@sirena.org.uk>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699821975256439457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A59126536C
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 02:58:05 +0100 (CET)
In-Reply-To: <1393168221-23018-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============0699821975256439457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="suF1EXQKA2Mmys/Q"
Content-Disposition: inline


--suF1EXQKA2Mmys/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2014 at 04:10:10PM +0100, Lars-Peter Clausen wrote:
> We currently have 5 nearly identical implementations of enum controls. Two for
> normal controls and three for DAPM controls. The only difference between them is
> how and if the selected enum item is mapped to a register value.

This all looks like progress modulo the issue Takashi identified with
the rename.

--suF1EXQKA2Mmys/Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTC/iUAAoJELSic+t+oim9Ln0P/2+W19sKrAPFLG6cVQUm5vUp
9XWoo4fnKHPTu4Dm4VylLJDv9bMeGxrKS/bULKD9Yl6q8/rzBMNmGfisX+rOmjqD
HhrScmKVQOlFghkDroxuy7o0+0wQkZNGn6Gy1h6o1MIqzPnNguuRKO2gJ0io141a
KL1ZOe6E1AmtlrNNV1wU4K092y2MN8x0NMnSgRjtfDbXBPN3zV2sQAh04s4s5nBs
ctuGvW2omA4HwWVXyj+TVi+EqPpF90oT5zZ9d+XJJWcr+PdTgiql4UfNVKB7YeRf
kHcio6zYIAKy2HW7fn2AjWpuv2V3fFgWQCiDpVtcgimiHQdzvSJKY4YbGP5wRn/p
C7o5m7ynVdGL6Pe/Q/uikfRY28hd0MUj92/W6Ra2I6f7FPXKiXdE0Whrevf5+tf3
bS4VIL9dpsJJvDaCKl/i6R/FiRYgllu/TEauxZMIXikvo6exPKGII74C82Q7Lkx7
Jk7CQ6XF6pUGflCgnBdT2Ocu5ItoaMsPsMD/Fd9RelGO52XckH6K4rDr4c9HGO4t
AouCuOejSXED7PWT3mlliTnQ1fKGyqdjfFwIIAE7FcJjUV/AsAFjHvGmWE5RerL4
m4NQj8GywFpk1CkQz91GHnrvnZ+qVMXtNH9Z4ghzAuOXzUOQFxrz3bs/ji+oirV9
aMgH/KdOxHaomaJ3RgTF
=znjs
-----END PGP SIGNATURE-----

--suF1EXQKA2Mmys/Q--

--===============0699821975256439457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0699821975256439457==--
