Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 08:27:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0384016A1;
	Tue, 23 Nov 2021 09:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0384016A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637656040;
	bh=iFOBiXk1C/As6/il8FGU5DiqUhIBtU/YMVkyvDJzQME=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gyUBhokQT3VS3iTsHyTV9q9TI3dZVCTQDhiTWACF1nPQ/h6g6L/XZUA3HeMZC8fls
	 /q6+U85dRTZs2BckjRHibtwF0DyoJYFqwNZexLbxW3TJn4xGwqJRdAfGBK4bgDeb4K
	 fCH03KR677ziff1VF1QAUJ2gy0fKG370xOPJgvgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC205F80570;
	Tue, 23 Nov 2021 09:21:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9808FF80212; Mon, 22 Nov 2021 17:31:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ABC7F80154
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 17:31:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ABC7F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XYC0QVZe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C2AB60F24;
 Mon, 22 Nov 2021 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637598699;
 bh=iFOBiXk1C/As6/il8FGU5DiqUhIBtU/YMVkyvDJzQME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XYC0QVZe/yHz4tn1Ns+3SkcvOpWvBTvUo3eDiFl+LMVW2VmQVljeAVXqs+uEgWo5j
 Bn3Hr1OA1n9R+SqMDcTIBZ+U4CRlLsz5WrJ5U3phLVmG5YErMn8IAtyWdLD3GEgpTk
 1OFUk2QerMpoYcASzaxIN35W/DlD2VlfD7R7w8gpMfuFRpjGrwzFQRaP0E2f1lYvfD
 8oyujkH+Ipt5JGY4bNgZxPE/yxJYVGlRR+74nkiluH5nzYaUkeR7ovS8Gguch81/zw
 PTDrwU6YHu8IRdG4PltzeEvJO0VZVADDdju2Mi2EJ3rgjxwVY3lzLdY5MnHCtaHk5f
 GtEJSF+kC4eLw==
Date: Mon, 22 Nov 2021 16:31:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH/RFC 14/17] regulator: ti-abb: Use bitfield helpers
Message-ID: <YZvF3yh9XnTcaXe9@sirena.org.uk>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <c8508cae36c52c750dbb12493dd44d92fcf51ad4.1637592133.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jRjZyYaT+L2tgnde"
Content-Disposition: inline
In-Reply-To: <c8508cae36c52c750dbb12493dd44d92fcf51ad4.1637592133.git.geert+renesas@glider.be>
X-Cookie: Lake Erie died for your sins.
X-Mailman-Approved-At: Tue, 23 Nov 2021 09:20:57 +0100
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-aspeed@lists.ozlabs.org,
 Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-wireless@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Amit Kucheria <amitk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-clk@vger.kernel.org,
 Ping-Ke Shih <pkshih@realtek.com>, Lars-Peter Clausen <lars@metafoo.de>,
 openbmc@lists.ozlabs.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-iio@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>,
 Joel Stanley <joel@jms.id.au>, Jakub Kicinski <kuba@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-media@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-omap@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
 linux-gpio@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 Eduardo Valentin <edubezval@gmail.com>, Paul Walmsley <paul@pwsan.com>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tero Kristo <kristo@kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>, Keerthy <j-keerthy@ti.com>,
 linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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


--jRjZyYaT+L2tgnde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 22, 2021 at 04:54:07PM +0100, Geert Uytterhoeven wrote:
> Use the field_{get,prep}() helpers, instead of open-coding the same
> operations.

Acked-by: Mark Brown <broonie@kernel.org>

--jRjZyYaT+L2tgnde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbxd8ACgkQJNaLcl1U
h9Au/Qf/V1gk6vuEyYqep3F+nkFeONrTZVKuCnRfhWw5gYk2o7IrGtqaN4L0XgcG
LQLotuaAu0BBZX/+cxF2XPbrWNjnR9MQMIUZo98nlGSTjxam1UhUdHJPbpXm2fbk
K8DExTJKv+DKeOGRk8LcmAyVHyrkTmZbcPcEE5qwaQldeS/Iuvmg6i889evqj3oD
FKHeZo8KvkL9B69w+j8bvlnCPiUZJd1spFZc3KMhS1N7HfzQxDGAIsEhezb0vSKa
Vu8+J+B7goS0IcpAHyB8ng4sUvJZAWDWTzaW+VKb818Swfd84YLF8vEEYabZTM9c
OVDG47kEUXwqHRPv3qz2+BqXpg9oYw==
=aIIx
-----END PGP SIGNATURE-----

--jRjZyYaT+L2tgnde--
