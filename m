From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] ASoC: sun8i-codec: fix crash on module
	removal
Date: Fri, 9 Nov 2018 08:28:34 +0100
Message-ID: <20181109072834.qyjb5rqlepavemhz@flea>
References: <20181109043135.26200-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9209568300697400352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C26C267AFE
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 08:28:35 +0100 (CET)
In-Reply-To: <20181109043135.26200-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9209568300697400352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c7xvijv65fxgvmn"
Content-Disposition: inline


--6c7xvijv65fxgvmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 08:31:35PM -0800, Vasily Khoruzhick wrote:
> drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
> when calling snd_soc_card_get_drvdata().
>=20
> Drop card and scodec vars anyway since we don't need to
> disable/unprepare clocks - it's already done by calling
> runtime_suspend()
>=20
> Drop clk_disable_unprepare() calls for the same reason.
>=20
> Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6c7xvijv65fxgvmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+U3IgAKCRDj7w1vZxhR
xSfGAQD71Xw1trzkFJi5JJbitemBW3zlJhtM8rwRayzZm9oxnQD+MJmbGLsewEGQ
mRq2W6Jo1Ehcm/gKfbvBRDqTX/aFwwI=
=bdz8
-----END PGP SIGNATURE-----

--6c7xvijv65fxgvmn--

--===============9209568300697400352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9209568300697400352==--
