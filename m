Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465A4C7EE23
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 07:39:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9DA21E0;
	Wed,  7 Jun 2023 09:38:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9DA21E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686123541;
	bh=We1LMex9yhsKmyYXk8/DnhjuCw7VxT0SfYAx1PiV6ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O8OWMsqK4FDy43Tpyq59bZ7YZcSnZRQer61sb/tS5YCDTd6VsfdvB7oFIrMcdhzjc
	 AE+QNbp+FcOWl2lnf6O+4FbbZ9YdRX5q8TMx+Gm+wzuB0Xglhc0b8Xxw5P9+Z0nroH
	 jCpzb8s+hGnybB1Upnc/e4q6dnZ5dJkc+BblwWs4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08569F80520; Wed,  7 Jun 2023 09:37:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69D91F8016C;
	Wed,  7 Jun 2023 09:37:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3F4FF80199; Wed,  7 Jun 2023 09:37:32 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57798F80155
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 09:37:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57798F80155
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1q6niy-0003Fq-Gk; Wed, 07 Jun 2023 09:36:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1q6niv-005gu6-Dy; Wed, 07 Jun 2023 09:36:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1q6niu-00BwY7-5i; Wed, 07 Jun 2023 09:36:52 +0200
Date: Wed, 7 Jun 2023 09:36:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>, Dipen Patel <dipenp@nvidia.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dilip Kota <eswara.kota@linux.intel.com>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
	linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 2/7] dt-bindings: pwm: restrict node name suffixes
Message-ID: <20230607073652.hoyrernfcuoryrqs@pengutronix.de>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53ce3yyaolwya5ci"
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: CPJII3Z3EWPEFSLUWTBEXORKONRJYBU6
X-Message-ID-Hash: CPJII3Z3EWPEFSLUWTBEXORKONRJYBU6
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPJII3Z3EWPEFSLUWTBEXORKONRJYBU6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--53ce3yyaolwya5ci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 04:48:46PM +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>=20
> ---
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentati=
on/devicetree/bindings/pwm/pwm.yaml
> index 3c01f85029e5..abd9fa873354 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -13,7 +13,7 @@ select: false
> =20
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@.*|-([0-9]|[1-9][0-9]+))?$"

With this patch we forbid now the following patterns:

	pwm-[0-9a-f][@-].*
	pwm-0[0-9a-f]+
	pwm-[a-f]([@-].*)?

Checking for such names:

	$ git grep -oP '\bpwm-([0-9a-f][@-].*|0[0-9a-f]+|[0-9]*[a-f][0-9a-f]*)(*pl=
a:\s*\{)' arch/*/boot/dts
	arch/arm/boot/dts/meson8.dtsi:pwm-f-ao
	arch/arm/boot/dts/meson8.dtsi:pwm-e
	arch/arm/boot/dts/meson8b.dtsi:pwm-d
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x7
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x19
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-c
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x5
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x8
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x3
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x6
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-e
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-z
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-a
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-x
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-h
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a-e

These are all pinmux-settings and no pwm nodes, so the change is fine.
(But arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi isn't properly
sorted alphabetically.)

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--53ce3yyaolwya5ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSAM5MACgkQj4D7WH0S
/k7r5ggApZ2+XCI0I3PKhfnhGNckF4ZiCto9+JLH90d1BNst1xY7hWlJ167vUCbC
mTgPD2HQHlKyPJoKmhRbTRF2ZYtdxN7fkJSqpz5RIhZwpuQjmaC7sfWcLSun07v+
1XzaZA4WQTsuvIw7mKZD0juHmlOK+kNRYLKyIgnN10uB8CGGHzv2zbG+WUJHxOhG
vNVwYz4TD1ScNmj9YJm+isi2OOrmsoXW6XeAQO1wxqP6iMUr6fjKcI7dxvirIXm4
diVZ7dr/5OY+vG0Y9bZKpp43GswLtmqCowdrBtxHr5EYhjR5BUfWMPvwCj4s2JK0
ta30Rl7GObRgiuLVYr2pbDMZPuVqOw==
=fGeW
-----END PGP SIGNATURE-----

--53ce3yyaolwya5ci--
