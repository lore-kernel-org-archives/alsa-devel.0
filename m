Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC982EDEC58
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Sep 2023 13:44:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52961A4D;
	Wed, 13 Sep 2023 15:43:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52961A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694612673;
	bh=lFraKzdNfExngIGaIv/1K58suMvu++hc1nKgmQ0iXQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sJv4j6H5k7/zbe9x1mfGytSO+Ku2j8bGNaO4dAn4WTKSf2CL1ZfWbJBApUL7z4j4J
	 CSPqe+rmX6wWB9/p1otHf5uJumaouUTYqU817vZrPzFOf9cPUtaR+ELlpjkqPhdYMC
	 ZsoHklCEPrIW0w66LWDsqYZkh8zPPmrBCMMjBo+Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C77AF80551; Wed, 13 Sep 2023 15:43:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ACA87F80425;
	Wed, 13 Sep 2023 15:43:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9B69F80425; Wed, 13 Sep 2023 15:43:10 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D05CCF8007C
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 15:43:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D05CCF8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iRikp+ct
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D9141CE210B;
	Wed, 13 Sep 2023 13:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC45C433C7;
	Wed, 13 Sep 2023 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694612579;
	bh=lFraKzdNfExngIGaIv/1K58suMvu++hc1nKgmQ0iXQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRikp+ctqfYM5nwvev0vmw1nveMqm+sw2yKSNsonXUlMahLHJF7ucVKX98G+txgkF
	 K62GisiU5xPDXcLI3UFlKnlWPITWbX1U/JVDNda7o/youuEm8H+9bloP+KKgtxSg/A
	 X6UYHNWPxzK5lCS3s8ZN1efrBbAiDUcTjWzSPaTtZy6/lsM9wgn+TokLNJE/16/sue
	 QTLIQIe3fIlUkdLIQejJcLZuTcN39IAZ3m9h9hyaZwa9nCu/Uk+f7NaedFkpvWLQ1D
	 +gErPJokNMYPNKZMwbzOSJ0NwRqlNVtx1i7N4S3pSGnaIg0MbvE9FxtfjydPgsARo9
	 hISqQFw6Yyd8g==
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add PWM-DAC audio support for StarFive
 JH7110 RISC-V SoC
Date: Wed, 13 Sep 2023 14:42:50 +0100
Message-Id: <20230913-capital-skiing-1b504653358c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230814080618.10036-1-hal.feng@starfivetech.com>
References: <20230814080618.10036-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=conor.dooley@microchip.com; h=from:subject:message-id;
 bh=Dk53k5rmUx7nlZbwvEoZddi3urCZf9sprXbm0Xahd8U=;
 b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmMeyK38Vg8XDP9ycTFbhttxeYbi8ZVxB3kv6naNlV07
 Y54m2jdjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyE6zIjw8EjHkdOMK3dId06
 X519wpIDtUduBKd0XVTdxXxueUkrQyAjw9Ukc8aOR8/Ej4QYbfjN/GntYbGKDS+/zVA52tc/WSY
 3kw8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp;
 fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZRE4DFK2IH5FI37PGBTJ3MVNGKZWQZJL
X-Message-ID-Hash: ZRE4DFK2IH5FI37PGBTJ3MVNGKZWQZJL
X-MailFrom: conor@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZRE4DFK2IH5FI37PGBTJ3MVNGKZWQZJL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 14 Aug 2023 16:06:15 +0800, Hal Feng wrote:
> This patchset adds PWM-DAC audio support for the StarFive JH7110 SoC.
> The PWM-DAC module does not require a hardware codec, but a dummy codec is
> needed for the driver. The dummy spdif codec driver, which is already
> upstream, is compatible with the one which JH7110 PWM-DAC needed. So we
> use it as the dummy codec driver for the JH7110 PWM-DAC module.
> 
> The third patch depends on tag next-20230809 in linux-next branch.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[3/3] riscv: dts: starfive: Add JH7110 PWM-DAC support
      https://git.kernel.org/conor/c/be326bee0937

Thanks,
Conor.
