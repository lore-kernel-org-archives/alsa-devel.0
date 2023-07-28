Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900A0C001DF
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 09:22:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA55D836;
	Mon, 31 Jul 2023 11:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA55D836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690795366;
	bh=FnMFqj/s49TzaM6yfmyNpQSSy8bKQ5ugm5trajmOYB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J6ysxb4gZlHF4lqC9GZm+2JvnTI3fcIBD8xIchH/TcNokhDXDKPgAKYLEa5m7H5Go
	 kwX2BqjGt3Elfxz58A9Lzl89t6ZEukwIhZcCSSag57VT8e7heu7QzZFWwgumOh0Ml7
	 3CHAboNM025CuqMp4l1ape9CbWuzrmBQzW+l/3Ts=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F2A4F8060E; Mon, 31 Jul 2023 11:18:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89469F80615;
	Mon, 31 Jul 2023 11:18:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 097C8F8019B; Fri, 28 Jul 2023 17:50:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8A2BF800C7
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2023 17:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8A2BF800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P35iWrPT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8AB462184;
	Fri, 28 Jul 2023 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C90EC433C9;
	Fri, 28 Jul 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690559439;
	bh=FnMFqj/s49TzaM6yfmyNpQSSy8bKQ5ugm5trajmOYB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P35iWrPTULn82aCR/saWbIvbhgW9FBRWLcm7T6831r1mxA0XYv+wihRnJ+bpe/h3j
	 SQI3nQMltLvs9348RcuJx3yB58okKZtFAr67/yunNdLCTQ2ZAlpKy0CNnGvyQUq65x
	 UrAO5Epy3B3om7fYqnjZtzYBwh45VSZ631NEvGXKAPrDQSjTxJAjUh1rN7eW+yXxHJ
	 eLRbo5WOQNZFnIGkYWrKLd8HdNhtbK4c/sT60Vc/9pvTSwX0j9KuCzgDlonRK7extE
	 8tHwl7EsCsHE8lDYNbtsAppmrzbvldMf2em+uOSVDgypVZkFhhh5VSQPOOlCZKdviU
	 v1FgZjXrTMz3A==
Date: Fri, 28 Jul 2023 16:50:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org,
	lee@kernel.org, ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linus.walleij@linaro.org, sre@kernel.org, p.zabel@pengutronix.de,
	olivia@selenic.com, a.zummo@towertech.it, radu_nicolae.pirea@upb.ro,
	richard.genoud@gmail.com, gregkh@linuxfoundation.org,
	lgirdwood@gmail.com, broonie@kernel.org, wim@linux-watchdog.org,
	linux@roeck-us.net, linux@armlinux.org.uk,
	durai.manickamkr@microchip.com, andrew@lunn.ch,
	jerry.ray@microchip.com, andre.przywara@arm.com, mani@kernel.org,
	alexandre.torgue@st.com, gregory.clement@bootlin.com, arnd@arndb.de,
	rientjes@google.com, deller@gmx.de, 42.hyeyoo@gmail.com,
	vbabka@suse.cz, mripard@kernel.org, mihai.sain@microchip.com,
	codrin.ciubotariu@microchip.com, eugen.hristev@collabora.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Message-ID: <20230728-floss-stark-889158f968ea@spud>
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
 <c0792cfd-db4f-7153-0775-824912277908@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Z+IvU8OCRbt7H1L"
Content-Disposition: inline
In-Reply-To: <c0792cfd-db4f-7153-0775-824912277908@linaro.org>
X-MailFrom: conor@kernel.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: PE54XLU3PHCPET2T2OSDCVCYJIBZA3V6
X-Message-ID-Hash: PE54XLU3PHCPET2T2OSDCVCYJIBZA3V6
X-Mailman-Approved-At: Mon, 31 Jul 2023 09:18:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PE54XLU3PHCPET2T2OSDCVCYJIBZA3V6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--1Z+IvU8OCRbt7H1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 01:32:12PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:22, Varshini Rajendran wrote:
> > This patch series adds support for the new SoC family - sam9x7.
> >  - The device tree, configs and drivers are added
> >  - Clock driver for sam9x7 is added
> >  - Support for basic peripherals is added
> >  - Target board SAM9X75 Curiosity is added
> >=20
>=20
> Your threading is absolutely broken making it difficult to review and app=
ly.

I had a chat with Varshini today, they were trying to avoid sending the
patches to a massive CC list, but didn't set any in-reply-to header.
For the next submission whole series could be sent to the binding &
platform maintainers and the individual patches additionally to their
respective lists/maintainers. Does that sound okay to you, or do you
think it should be broken up?

Cheers,
Conor.


--1Z+IvU8OCRbt7H1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPjwAAKCRB4tDGHoIJi
0t3wAQDbx8dLxPQPnIoDByHTBcuDjvFBZTpWUg4bhE01/+BpfQEArGia1WutY/7n
UhhVDqMheWjj/xZNVFl/ZTTiVbw1vwI=
=NVNa
-----END PGP SIGNATURE-----

--1Z+IvU8OCRbt7H1L--
