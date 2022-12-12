Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A4C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Dec 2022 13:11:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98A1C190E;
	Mon, 12 Dec 2022 14:10:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98A1C190E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670850701;
	bh=kcrzmGTR7C7wlxWvy8O11JGORcZwZVBintZtJZ2LbuE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fGDT9oqvwTrUxU7BchegAHUsCFhBdHvArVut3mKEiEjX+b3X0QRiuSVKUrdi4xCvB
	 XqX/lFIYncbLPWmd+Hzy5nlHUuouKSD+mPNFa7xasK9TBvqC5MDJgvGMTQgHUxbyBd
	 RzGBzTAmRFNQkIKDyoozlhHViSVE2T6P8Pe63E68=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CA2CF80508;
	Mon, 12 Dec 2022 14:10:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A7ABF804D7; Mon, 12 Dec 2022 14:10:27 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BCF1F800F8
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2022 14:10:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BCF1F800F8
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=uNz1F1QV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1670850627; x=1702386627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kcrzmGTR7C7wlxWvy8O11JGORcZwZVBintZtJZ2LbuE=;
 b=uNz1F1QVgseJkzYkHSEGnfbpiP7RCVr0GpLhN/Z74rCczXN+01Ip5aRc
 tD351DnpyDMwO6Rv5ISZ2Kq0NWutK5hmrVs5qqay3yuO2CgUT1q3WLZAr
 cwsS4gZm7Z+SQ23wjNp5FCyTDc5G/Xe6WK4jXEuIXCVoaooL39AL3WDGo
 Wxe27y6FPRrP4LH94Ogkr0+mvhvPuoLwCeC7IbjPRdGH7X+Bu6HCmnAff
 Pxedrb/e0EP6XWlxQU35IC9AKKENikD4C7m93v24vrGFsrCc+bDZFVtn7
 +I++X2NToxYguA3AwjyEgKmFU0iEg57p9PWDzOhblmdJFwOZG3yBhQlfA Q==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; d="scan'208";a="187716852"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 12 Dec 2022 06:10:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:10:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 06:10:15 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] ASoC: dt-bindings: microchip: use proper naming syntax
Date: Mon, 12 Dec 2022 15:15:32 +0200
Message-ID: <20221212131535.76111-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221212131535.76111-1-claudiu.beznea@microchip.com>
References: <20221212131535.76111-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Use the following syntax for Microchip ASoC YAML files:
vendor,device.yaml

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2s-mcc.yaml}   | 0
 .../sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml}    | 0
 .../sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml}   | 0
 .../sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml}   | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2s-mcc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2s-mcc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-i2s-mcc.yaml
diff --git a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
-- 
2.34.1

