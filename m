Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3868BC48BE6
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:17:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A74613C0
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A74613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F95D178A;
	Mon, 14 Jun 2021 09:16:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F95D178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623655029;
	bh=8KjO9/0Y2pL26PMeT0SR1E79NQuayl6MhVnJQomI5ig=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JTJ3UjtN2xYR6mKsmFCGEPyIrq+wqpxT9OqZzfiz8BhWsML4q7m0fPiFx84YIsUFe
	 rMUJNPvh9dZeIzON7L4LpNlf6VZFVZPpHXfKlGruhyc+LYhswCRiRtr434kvQQhLyZ
	 zFCF6N+mA4WKW6PjoOyVkemCBRJW/wf2v2UHIgx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B54A2F80234;
	Mon, 14 Jun 2021 09:16:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C07DCF8023C; Mon, 14 Jun 2021 09:16:16 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B259F800DD
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 09:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B259F800DD
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1lsgog-0000BB-Lg; Mon, 14 Jun 2021 09:15:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1lsgoe-0005Jf-D8; Mon, 14 Jun 2021 09:15:24 +0200
Date: Mon, 14 Jun 2021 09:15:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 0/7] Prepare EP93xx drivers for Common Clock Framework
Message-ID: <20210614071521.bv6tc5d27tj3yvlv@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tzksnyblxledsl3b"
Content-Disposition: inline
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-pwm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Nikita Shubin <nikita.shubin@maquefel.me>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 Vinod Koul <vkoul@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org,
 dmaengine@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--tzksnyblxledsl3b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 01:30:34AM +0200, Alexander Sverdlin wrote:
> Nikita posted a patch converting EP93xx to use Common Clock Framework. It
> turns out some cleanup is necessary in the EP93xx drivers to avoid
> "Enabling unprepared" clock warnings.
>=20
> Patches with stack traces in the commit messages are tested on EP9302.

One thing to note is: ep93xx currently doesn't provide a clk_prepare
function, this isn't a problem though because include/linux/clk.h
provides a dummy if CONFIG_HAVE_CLK_PREPARE isn't defined. So as ep93xx
doesn't define this symbol the changes here effectively only add a
might_sleep.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tzksnyblxledsl3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDHAgYACgkQwfwUeK3K
7Anz4wf/fZ6UpIbiQ9trvkqr6Bj6ontdmEdjh7ZjZkt/uCGHoWMQ1h2blpmdMD/z
wzcscbTaQkBDOdRPlWqqRB77EOqy7TdJe7vKeGygZflhyBx6so3Yk+Jf9NhZ73sY
WpFRQP5v/utpk7qmx7SXBdlJG3mkWmIujPAJd56OX6RwFped6Bqh+bpRv+jMKhHv
KLWyqkKehDsDd9EQtPokkcgnhvFo584TGv3oWUFi0AtPTgVXCSSNCiIxkR8BKLhs
/pwCZo/rdneUeHPZpvBsR2AAVefwMmCQphi9CA4JaCsxGkA6Hfa5c1YBpsPXKnSZ
aL6XNpm9fn67SU0C3GhW4R4lGjRoMQ==
=giTe
-----END PGP SIGNATURE-----

--tzksnyblxledsl3b--
