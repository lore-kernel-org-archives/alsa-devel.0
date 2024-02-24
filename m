Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25196C48BF6
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:25:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43E90E0F;
	Mon, 26 Feb 2024 18:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43E90E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708968320;
	bh=0W8qjJDpYcgYroDsZAHS1ygwFOJj7ZrezH6oMeip5ik=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gc1nVbh8wpK3j7QrHNl/eyj9xcN7CI/tytosAdKlNl5iva4ofVbTV6IrjnpALnF1h
	 u0lVQrSpTsflbIZOWnUTBN/sBxbCGNjB3XHB2k/009SK2Rlo88+0JUUdLNkEq/HEp/
	 tMub1jMPaeW+NiqwKCZYbPMhmqqRE0pE3FSSGUvE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C7D9F80689; Mon, 26 Feb 2024 18:23:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC8AF80692;
	Mon, 26 Feb 2024 18:23:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 562CCF80496; Sat, 24 Feb 2024 02:19:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 632E8F800ED
	for <alsa-devel@alsa-project.org>; Sat, 24 Feb 2024 02:19:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 632E8F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ff/ekrVk
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 55F7761CB4;
	Sat, 24 Feb 2024 01:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506E6C433C7;
	Sat, 24 Feb 2024 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737553;
	bh=0W8qjJDpYcgYroDsZAHS1ygwFOJj7ZrezH6oMeip5ik=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ff/ekrVkMNWJBDGkpsP/ovqQh2yy1ijB5ftoTK+/UMaqJWDxNbNOKDQ24y0qlURiT
	 N86GGDRMnW5AEO+3RHaO2XaXOYxDA4ibfnVDmk9OplY/pQbkQdRWg0E13BTRhyo/Ey
	 E7GKyzybhjWoin88WA6LDL8n39i41+9gmBImeMju6zTBmw38Z6z8mKdPpWm1Cai1Dh
	 tLR7TBInqGjbW6nemQL6B37MrpxV1aa2e6/jocEVz4mmQME8ahbk6OREfwpjeHQwqx
	 7OGusmZWog/eiFdepXGySC4Gi90Xc7Qb6ZzLMm5U/Vj7pI5DjSk+10zDXroo9bbYdH
	 4E1uvU+UVBQNg==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mturquette@baylibre.com, sboyd@kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, andi.shyti@kernel.org, tglx@linutronix.de,
 tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, sre@kernel.org, u.kleine-koenig@pengutronix.de,
 p.zabel@pengutronix.de, olivia@selenic.com, radu_nicolae.pirea@upb.ro,
 richard.genoud@gmail.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 lgirdwood@gmail.com, wim@linux-watchdog.org, linux@roeck-us.net,
 linux@armlinux.org.uk, andrei.simion@microchip.com,
 mihai.sain@microchip.com, andre.przywara@arm.com, neil.armstrong@linaro.org,
 tony@atomide.com, durai.manickamkr@microchip.com, geert+renesas@glider.be,
 arnd@arndb.de, Jason@zx2c4.com, rdunlap@infradead.org, rientjes@google.com,
 vbabka@suse.cz, mripard@kernel.org, codrin.ciubotariu@microchip.com,
 eugen.hristev@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v4 00/39] Add support for sam9x7 SoC family
Message-Id: <170873753899.4074329.1874365978346259745.b4-ty@kernel.org>
Date: Sat, 24 Feb 2024 01:18:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: EAQXRRTBZT34JA5QBXDVCYF55YJFU2BW
X-Message-ID-Hash: EAQXRRTBZT34JA5QBXDVCYF55YJFU2BW
X-Mailman-Approved-At: Mon, 26 Feb 2024 17:22:50 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EAQXRRTBZT34JA5QBXDVCYF55YJFU2BW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 23 Feb 2024 22:43:42 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v4:
>  --------------
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[13/39] ASoC: dt-bindings: atmel-classd: add sam9x7 compatible
        commit: 89f3180d5915d4ea40e044ee102cd5c1ec81e7ef
[17/39] ASoC: dt-bindings: microchip: add sam9x7
        commit: c06a7a8e885753a024163bbb0dfd7349e8054643

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

