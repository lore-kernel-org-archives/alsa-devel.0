Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897CC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:06:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D412076C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IhTwtj9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D412076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4028D1690;
	Tue, 21 Apr 2020 08:05:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4028D1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587449180;
	bh=kZuYn8kQP13hRw/Lzuw9bbE5Tamh5euycYn0ntDury4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IhTwtj9ybMaAP1Dle2m3MFIhZPaDP/f+ifXb86Gl1iTWgIMworBFSCNmWkmgb5QJT
	 0xOTe7Syci0QAnAAN69STvoOtnRAaFeYV0nQFt435BeB+VDlZ0XkybOSoA6kc6D8U3
	 Y1XI8vDDX4ASG6BzEflG74b+/KOKDlZrCOo4ZphQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB31F80212;
	Tue, 21 Apr 2020 08:04:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEE4FF801D9; Mon, 20 Apr 2020 18:28:12 +0200 (CEST)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa1.perex.cz (Postfix) with ESMTP id 36688F800C8
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 18:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36688F800C8
Received: from localhost (p54B335B8.dip0.t-ipconnect.de [84.179.53.184])
 by pokefinder.org (Postfix) with ESMTPSA id DF97D2C1F58;
 Mon, 20 Apr 2020 18:28:06 +0200 (CEST)
Date: Mon, 20 Apr 2020 18:28:06 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: Remove cases of 'allOf' containing a
 '$ref'
Message-ID: <20200420162806.GB3721@ninjato>
References: <20200416005549.9683-1-robh@kernel.org>
 <20200416005549.9683-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 21 Apr 2020 08:04:34 +0200
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org,
 Maxime Ripard <mripard@kernel.org>, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
 linux-spi@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 netdev@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
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


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 07:55:49PM -0500, Rob Herring wrote:
> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed
> in the 2019-09 json-schema spec and '$ref' can be mixed with other
> keywords. The json-schema library doesn't yet support this, but the
> tooling now does a fixup for this and either way works.
>=20
> This has been a constant source of review comments, so let's change this
> treewide so everyone copies the simpler syntax.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Same preamble for my ack as in patch 1:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6dzZYACgkQFA3kzBSg
KbZHYg//W5YxCeazbDM94E6YBsxW12FqWEDS34r8khleoxdl3PUw+iNq6ZW20vVf
iukBEN6kySmVQjCoT4FHxxZSd3MuOxISlT7jpTr1qlWZAYjKBQ2hreJ53IoSwac5
KLqfatKLSIIDvnPPOrvqqVOLCD998wpaLJlfoXiIPNwnaU7j+nB0lFjsv5gA+eeN
jKUFY8cv0b3pY9aUhatVnodM421EWf9pH5K6hkhbxhtS2E/Sb+zw4v6ewUuxnMIH
rJxcdnWBUtqDh26y7ezSSLNUgU7TDYnuT3v5Zi8m7HaZ1npdGb5EJwg7Jvr5yi2k
qBeYtB5Ed9+IjPit/Y1GLJamCVdohdPxiPCzdqr5iSdH3+DsbmWJjxN7NjfJvnGu
M5wmk4m3pSEcYGy7cRZQPzv2AjHPYgqxJIxBzXpejNT1U0BJpJEKXqDAJrRGBBOR
Mb16mCEDGZZxw+m1DN6gftPiLMRFaqYgjkkdEMma9EbW2Of7y9gzdYqRU5HyaiBM
WB3yUbcoM9ySLCQHX75Xg7UsLzVw2N5SA24diMdKPGhUfEpSgZ+DtlJZ3h4o4fos
GC6i6hC0shFUcpoZM9XQs+ZhJ38/bfRxOqdy/K4Ali+0G7PZzf5/4fcyi7TvG7wc
qXAYGaxFehFemV8oQZxLxFtvQYlCom+MLAVEbzF4P/9hI9PlcZk=
=3u/Q
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
