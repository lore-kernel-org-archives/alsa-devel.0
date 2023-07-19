Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86223EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 12:50:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64C36846;
	Wed, 19 Jul 2023 14:49:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64C36846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689770999;
	bh=VbGtW8BX8Fyh51DZc7NkTwd1J6fgwswDPGXxDSa1p8Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZX66K6q77Tw+KME2EiHimG3IoB1Vo8W2tyqoTRroUAOfmDtbt6iZ8AEtS7UFw1pgp
	 hVzxmfPj16xYjk8Z6UXbEp3Fjgem1uKF2kTRH2OU2QK7yzJ8PeOpDR++mBANkP4Nmz
	 6Cent8QPgp16VLtimdIs73XGx6mGj0RDKu/4UeA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C944FF805A8; Wed, 19 Jul 2023 14:48:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 105F5F805AA;
	Wed, 19 Jul 2023 14:48:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04C50F8055C; Wed, 19 Jul 2023 14:48:07 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08280F8055A
	for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2023 14:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08280F8055A
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BE405206BC;
	Wed, 19 Jul 2023 14:47:56 +0200 (CEST)
From: Francesco Dolcini <francesco@dolcini.it>
To: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	CTLIN0@nuvoton.com
Subject: [PATCH v1 0/2] ASoC: dt-bindings: nau8822: minor updates
Date: Wed, 19 Jul 2023 14:47:50 +0200
Message-Id: <20230719124752.248898-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LEUBMSVN3RYLGUYCDFFU2LW6ZKCIE7ER
X-Message-ID-Hash: LEUBMSVN3RYLGUYCDFFU2LW6ZKCIE7ER
X-MailFrom: francesco@dolcini.it
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LEUBMSVN3RYLGUYCDFFU2LW6ZKCIE7ER/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Minor updates to NAU8822 DT bindings:
 - Add #sound-dai-cells
 - Add MCLK

Francesco Dolcini (2):
  ASoC: dt-bindings: nau8822: Add #sound-dai-cells
  ASoC: dt-bindings: nau8822: Add MCLK clock

 .../devicetree/bindings/sound/nuvoton,nau8822.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.25.1

