Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552A4C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Nov 2022 08:12:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BCE01877;
	Sat, 26 Nov 2022 09:11:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BCE01877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669450344;
	bh=T0mf0ijZQTzNBNeBPF5fkFm6qTXOYlAmsvGjPYhocZE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1EPm2uJVL4d7Y1b5uWfGcRwO2UXtHN4DESWSBBznlUIV/DMVhbtB2pDIHsGzolmn
	 i6AglRpjg7kVbpXvTnibtXfPptOdxFDI42xxxKdYz5IA53mNwTj0SjRftYHMvXlYqW
	 y7Z+ji1MGo78hqGcBw9vsATYI4jWAnPoIZ7dFujM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5716F80680;
	Sat, 26 Nov 2022 08:59:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00DEBF8025D; Wed, 23 Nov 2022 16:49:46 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62B35F80115
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 16:49:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62B35F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QYvvVVFg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E984F61D50;
 Wed, 23 Nov 2022 15:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5620C433C1;
 Wed, 23 Nov 2022 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669218581;
 bh=T0mf0ijZQTzNBNeBPF5fkFm6qTXOYlAmsvGjPYhocZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QYvvVVFg3xABYgJQEwfoWni/oYrfqNnbcqqcQVrcp6uxcLqxAT3Hv4qpUOukDjTs/
 0p7LoCYEfkSeEAiiX+7nrXQkbqjw1137EJi8AGbebG+uSGbSuFWy6ItixRDZdgYjzd
 wI4+oGGgg+c8KPKVUQ5ZdWR+K+nR9Wh8y+eMc16I0PC838GB+J3v6zlQjhWOtg1c1c
 6e5RsTLcd6FqRQaHdPekbba0bcco/SKnkdwTGzLKgRh+Lpo1he1WOZKJOaw2ZEIIXQ
 GRY+SoMl3sj6Xk7pnSLZNQi8V4EhDNugotUmyQAc8a1pA6HLWIGeNLAtS34DQuw57+
 eXjalnxk49wTQ==
Date: Wed, 23 Nov 2022 15:49:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: drop redundant part of title
 (beginning)
Message-ID: <Y35BCpD/tr/7prMh@sirena.org.uk>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uLB1Llf0h2iQ6rin"
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
X-Cookie: I'm rated PG-34!!
X-Mailman-Approved-At: Sat, 26 Nov 2022 08:58:52 +0100
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mips@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Sebastian Reichel <sre@kernel.org>,
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


--uLB1Llf0h2iQ6rin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2022 at 12:06:13PM +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.

Acked-by: Mark Brown <broonie@kernel.org>

--uLB1Llf0h2iQ6rin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+QQkACgkQJNaLcl1U
h9C5lAf8Dpp6enFuhrAPv0ZsgsZe6xWsOHu4pelgjbPEH8V7tDwUPWITXN5vLI3+
RuqFuOP0hYHIa9rUjaI4dZX0sPV7cFMF2BdyjTFdczyAizXljoNVh2r23soCG0RX
66rxbmsNE++z+1DObKtZgJoutGaB/ZAqMpW0t0XJERPq1KbjBGmy8D/fIq8lvoy/
4297MfYX3okBCVVhPRX/v+unG3sVqED0Bhdjpo/bwY0150YItakf4eVUXwFxfvTK
25XCxunGEShq5zi//+/abs2X89ZjhqLTfJtYtUVnj1xtSfEqoRb6mf82WrkieRvA
dYORYgupqLBXMecamcwbhHMcJBNZ3w==
=hyWV
-----END PGP SIGNATURE-----

--uLB1Llf0h2iQ6rin--
