Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A5C3DA7D
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Dec 2022 15:43:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E12E4B9AA;
	Sat, 24 Dec 2022 16:42:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E12E4B9AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671896588;
	bh=3nT3DeZF5i9pQFxuFaL0flQ2ATEb6zWrvMChjlr1LPw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=TTPQCP1+9hNqu1qZ9ou92RENQaX/dGBmISTgCQEod/r8mKQaIYUA3xgaFxkTbLca3
	 Br1LpKRBA164GdlQrSriE4w1M5H9ZS0yUJ+iUtHZSEDRYqFA0AcbLIL+EJrpMu/3mx
	 R8KDkqUKp2Lpe/JUAZX8eecDEVP7zrPd+fSJpQEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 912B8F802E0;
	Sat, 24 Dec 2022 16:42:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BFF6F8032B; Sat, 24 Dec 2022 16:42:17 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41955F8027C
 for <alsa-devel@alsa-project.org>; Sat, 24 Dec 2022 16:42:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41955F8027C
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZISpF/bQ
Received: by mail-lf1-x12f.google.com with SMTP id z26so10703774lfu.8
 for <alsa-devel@alsa-project.org>; Sat, 24 Dec 2022 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqWUzbhnIAOTNuauAVvGliUcjdZQPn3jI6LrgXIAOOE=;
 b=ZISpF/bQ1vT7Hdz9XwEiNw5O4wSPD9NIaG8Bj72o+0OysHCmbuLWznK+t2xd2SnkEt
 BT7j6S1TVu4r1W/QIC8p9wm4HRyTSqIRwUdWImryZfcSyGPRlkKb6XqQygsyvl1yPwLw
 oPukVD1Axb0QmACySyS6pw7mbZzuklsOLAXYKpsW7MjOvGahSBl/p4kk1MjY6bv2WV8n
 s3xE15aHGpFJ3O+egsbP9YIWeu8LiLIV8aOT5OjYsm+5apC8TJJCch1eK+mE9n9C8+p1
 gSVn93lJIiGSOosrvAGEFh8BTPWE5IemOHksSeNE30ZPH3BHt4cj1JS5hZ14w/4H5tio
 xWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VqWUzbhnIAOTNuauAVvGliUcjdZQPn3jI6LrgXIAOOE=;
 b=tJcSvIjGBOcFjoORcXenT+71kimkAtOs7XtTFCLHoJMHNLm/za7q4jk4snMUERny6T
 30FuKowV93pUY3rCBAL2asxHZ0kBtqEX+f3ljM9Arny9Jg1zkhg5Hhzz58zjUSckIBbc
 RAIVrqp0sew4tiEqsuynie6889sNEb+Vt+Xp8J8TKl0sFow0XBDSgu8DRiashZhzjStW
 CAf2uxnXcD7SE4cveFKDqstdllA/bYW1pfikj67pmNsI+Q/rFJWgdx3U8OQXOFZ2WYpY
 DuJRAT4zYRoqcORAY87fY9NsjnMS4m+s1AT9SMDvgEqsudaHKtcFue+VuJI4NjSuK0sf
 Hh5w==
X-Gm-Message-State: AFqh2krmXofm+f31gbjXy/tLeo+9dVaBxqQ4xPtiv+gJRv++/J2J58mE
 FpvRQh5J0/3HdhddfgotorCQOA==
X-Google-Smtp-Source: AMrXdXtE4roLvHWHaTa2XWArg6aS1kUMpuXXyPvEmgNO0tkVjIjWdQkVTIyMDwCHiss/5ix5ynBINg==
X-Received: by 2002:a05:6512:3294:b0:4bd:de32:b789 with SMTP id
 p20-20020a056512329400b004bdde32b789mr4633400lfe.52.1671896533122; 
 Sat, 24 Dec 2022 07:42:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 c14-20020ac25f6e000000b004b5821219fbsm987035lfc.60.2022.12.24.07.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Dec 2022 07:42:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: cirrus,cs35l41: add interrupts
Date: Sat, 24 Dec 2022 16:42:09 +0100
Message-Id: <20221224154210.43356-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Both DTS (SM8250 and SM8350 based Sony Xperia boards) and Linux driver
mention interrupt, so allow it to fix:

  sm8350-sony-xperia-sagami-pdx215.dtb: cs35l41@41: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 82062d80d700..919d7f16f24c 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -22,6 +22,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   '#sound-dai-cells':
     description:
       The first cell indicating the audio interface.
-- 
2.34.1

