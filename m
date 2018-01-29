From: Mark Brown <broonie@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add
 set_tdm_slot functionality
Date: Mon, 29 Jan 2018 11:32:48 +0000
Message-ID: <20180129113248.GA10969@sirena.org.uk>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1927612983295544157=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F900266D06
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 12:32:57 +0100 (CET)
In-Reply-To: <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Code Kipper <codekipper@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1927612983295544157==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 29, 2018 at 08:34:00AM +0100, Code Kipper wrote:

> I'm not sure..I was looking for a clean example of being able to
> override the number of bclks in the lrclk width and some other
> devices(Rpi) were doing it this way.  I open to suggestions,

You're looking for set_bclk_ratio() I think.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpvBl8ACgkQJNaLcl1U
h9A10gf/X2zBMMhJrFtK2q//DC+y34FUWsABjPbt12/C5XRscoQ0hVJC5YFM7zFb
xQ4C80O3KPHBxajqAU9Mw2+f3CFzi2uC1XvrwL9lVxitIVNAnil6wVp+FRMwnuEy
ZoqIS69aLLW2dsI9ihxW4a6cgxCD5u41ocSKb194exKN0G/BhAjO4MIrS9Bq/8nW
scw4zuKHgJSonsodUaloKX87GNSYBapO5X1ps9XlrUp3cU0d5zTNAIbaG+8EZVeV
KaqbKnqq1CA6cFIbyBV02UzS9xrr80qXxT9kNjLzT+ryGIvoiJqoUU1FohqXU6N4
fiq7aKd3tEqvrhmlSeGyBMoWZzeEjg==
=NCjC
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============1927612983295544157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1927612983295544157==--
