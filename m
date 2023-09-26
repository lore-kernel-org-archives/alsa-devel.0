Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F03E7E635
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Sep 2023 13:30:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C61EDEB;
	Tue, 26 Sep 2023 15:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C61EDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695735010;
	bh=SrRBK22v6rtXAYyiWB4EKE+zRLxZcnFDYV/DPCjjJC4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=E/5zFkPgDCy4S1pugNHJ8fkkJ2K6Qh8pVFTYo2eZQi0NjhOR1UAocICLlWUF67DCC
	 cOd/eZOTuHoje/79Z2vCUWvhqpFJkPj8CItArnoRs4Mv1rznyaz7Qt2Jp+GXcMDlah
	 EAc51yU7TtNwiymVa9q6xnjvSkLbXDv4ykJqx22c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1914DF8055B; Tue, 26 Sep 2023 15:28:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D65DF8055B;
	Tue, 26 Sep 2023 15:28:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EA08F80551; Tue, 26 Sep 2023 15:26:09 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E825DF8001D
	for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2023 15:25:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E825DF8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=clzp3St4
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so14663783e87.0
        for <alsa-devel@alsa-project.org>;
 Tue, 26 Sep 2023 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695734735; x=1696339535;
 darn=alsa-project.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NRfxGrMOqSfOG3v3ZLD3nG7Q9arSiNCsFf5J1mFyQw=;
        b=clzp3St48E4knTyb0N9HhqtH0LJLQ3gWP6WK/GZMIE7bkTOmut5d/og4KQHuxZ3QfK
         Vf1uQNiXSBXtg6Uwx7+zHWjTvpHTuAsqtfvo0iHHwZGx27SDdob1QH8hnbjy6mnPMg+6
         C6B1RZFuLc2adTpdmcAOL43atmXnjq2dwK8BkHKiu6sn4YjOmFdIxWbWRZtyqr6OdPRu
         YPmCPUfB1sMg14fu+0Si0txGvji3oEtNMbzO/D295AGCOZ/bM+FxFA034b98KL3tBCCj
         5FxPDIMifio9nluJhDffThIEQzVY/sVDeOfx+MrZhukqs3bJUl/1T/QDxl3DU6MvfmQv
         GsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695734735; x=1696339535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NRfxGrMOqSfOG3v3ZLD3nG7Q9arSiNCsFf5J1mFyQw=;
        b=HnE2Mm97YLfq+o2rYcc4THaq0JT4j+hi5diW0T40VJ/fiJtCGxvwyvjlyWlaxY1dmf
         WxtEfg4pNojM59Te/cEJDLCS4ol60y2hN6YGDJYY2T4w16SqAoaNnriv/nz7gA3XP+SR
         cEy/LxcVBKmbzFhKtV1/BB3Hhh8iZMWZq3t9RgtvAvU/msCwclDJr4q+wamRRdjRDP1+
         dJFeUFqvnlwLlmWHzyQ0zcjpg6K3cETjLOU/t9Syw75pImO5x23Ne0agdBIIjG3KzuAM
         oX/uun0mqCcXjPG8baehJs4au2yoz0GH3P5XsP416XX3xj0mR+P9izbNK+1hi05bNw/m
         gYww==
X-Gm-Message-State: AOJu0Yy4+PPsFKalnFml0P2JtBUsl0yTr44JIhnxQ5iWKVx8KzLapfoj
	4C2D9DJuoD+u/oc74/ui/UefUg==
X-Google-Smtp-Source: 
 AGHT+IHAg0Bp/wi4V4DDaV11/b+CpdNwq4NJCdF+2HwL/+gKGTZiazhI7ctuPHYrMgccKJRbjt9Qiw==
X-Received: by 2002:a05:6512:5d6:b0:503:8fa:da22 with SMTP id
 o22-20020a05651205d600b0050308fada22mr7923388lfo.22.1695734734372;
        Tue, 26 Sep 2023 06:25:34 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 eq25-20020a056512489900b0050307bf2bcdsm2221540lfb.247.2023.09.26.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:25:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] GPIO descriptors for TI ASoC codecs
Date: Tue, 26 Sep 2023 15:25:28 +0200
Message-Id: <20230926-descriptors-asoc-ti-v1-0-60cf4f8adbc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjbEmUC/x3MPQqAMAxA4atIZgMaFX+uIg6lTTWLlUREEO9uc
 fyG9x4wVmGDqXhA+RKTtGfUZQF+c/vKKCEbqKKmGokwsHmV40xq6Cx5PAXd0BHH2PYjB8jloRz
 l/q/z8r4fstvD22UAAAA=
To: Tony Lindgren <tony@atomide.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Message-ID-Hash: SGXCIQLWSBNUIT5YX4754FD2KGZ5TMOT
X-Message-ID-Hash: SGXCIQLWSBNUIT5YX4754FD2KGZ5TMOT
X-MailFrom: linus.walleij@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SGXCIQLWSBNUIT5YX4754FD2KGZ5TMOT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This cleans up and rewrites the GPIO usage in the TI
ASoC components to use GPIO descriptors exclusively.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (5):
      ASoC: ti: Convert N810 ASoC to GPIO descriptors
      ASoC: ti: Convert RX51 to use exclusively GPIO descriptors
      ASoC: ti: Convert TWL4030 to use GPIO descriptors
      ASoC: ti: Convert Pandora ASoC to GPIO descriptors
      ASoC: ti: osk5912: Drop unused include

 arch/arm/mach-omap2/board-n8x0.c           | 10 +++++
 arch/arm/mach-omap2/pdata-quirks.c         | 10 +++++
 include/linux/platform_data/omap-twl4030.h |  3 --
 sound/soc/ti/n810.c                        | 31 ++++++++-------
 sound/soc/ti/omap-twl4030.c                | 20 ++++------
 sound/soc/ti/omap3pandora.c                | 63 +++++++++++-------------------
 sound/soc/ti/osk5912.c                     |  1 -
 sound/soc/ti/rx51.c                        | 19 ++-------
 8 files changed, 72 insertions(+), 85 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230922-descriptors-asoc-ti-a852eff479ed

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

