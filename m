Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F7BC43334
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 21:52:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDEF716CF;
	Tue, 19 Jul 2022 23:51:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDEF716CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658267556;
	bh=5HSQimwsodDXNvvIhMF+he4ScLqhqXDbtWbxZgAa7nI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KroFfP5MtgITEno7RHCzF/880KSR10P8wpjXNr1fmmusc3iTAFIKlV7Uv1GP14nVK
	 tfo7Twx8wlzq/B2OImp1o1TpK9lnol5p7c05OA90rrPP803Er+gcjKOIaAztp//dVY
	 BLbDoYgZTNFCEIsve2xE5zWoGRrs/G3lXLo8xomA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76C87F80118;
	Tue, 19 Jul 2022 23:51:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B2E5F801EC; Tue, 19 Jul 2022 23:51:45 +0200 (CEST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 008E0F80118
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 23:51:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 008E0F80118
Received: by mail-io1-f52.google.com with SMTP id n7so12939869ioo.7
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 14:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=85HkroyRT6/KmmJdqn8bN9eBoKQ4n7OLsG/Ln9C62EQ=;
 b=EVkkH2Bjy3B7UH3TRL15ogBO3U5TQNmBxm6iJ8hVc5EfIvWCwS7HcdVs/Wi+k0LDmf
 eMGwKBxYAg2DBli23H4ER+cuj2of3E70Lek+TFVLek48hl6AiaI0LMuOSPfMqeN/QOP1
 QZeuesTfA45WE6gOEFvM4f5CV0gIX9zjETbAKHg9Bt0qS/zEi4k1XZN0AeuNUaNNtkOZ
 aeOVG0Mwqx5s5zQ/4iVBEYdq6PckR9v5wznDjM/+B7Y0JVRmWfIuAKdIXEmeN+Tc3k8g
 ZgfWOmucPogIy4+iswBP4l1oI1wquId5ghzQuRjh4e5tn98DIO0lFYXpf4V/LdiajMcd
 45Pw==
X-Gm-Message-State: AJIora8GD4axo1JOavwetdGljivqH/n5IbPTpbVxRlzgam1leFov39hG
 9MBNpXFS+CahVYXlWUCpuA==
X-Google-Smtp-Source: AGRyM1t2dFQzXrBsVPjnPKradNvoFPjaxAi4wE8hmllsMsGhgSvVg8wcKu0IgDqaWk3GBLDOiO9c3A==
X-Received: by 2002:a05:6602:160a:b0:67c:28b:7627 with SMTP id
 x10-20020a056602160a00b0067c028b7627mr6695610iow.207.1658267500740; 
 Tue, 19 Jul 2022 14:51:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
 by smtp.googlemail.com with ESMTPSA id
 q128-20020a6b8e86000000b00678ea668a39sm7786798iod.36.2022.07.19.14.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 14:51:40 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: sgtl5000: Add missing type to
 'micbias-voltage-m-volts'
Date: Tue, 19 Jul 2022 15:51:34 -0600
Message-Id: <20220719215134.1877363-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

'micbias-voltage-m-volts' is missing a type definition. '-m-volts' is
not a standard unit (should be '-microvolt'). As the property is already
in use, add a type reference.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
index e762c320b574..2bc7f00ce4a2 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -47,6 +47,7 @@ properties:
     description: The bias voltage to be used in mVolts. The voltage can take
       values from 1.25V to 3V by 250mV steps. If this node is not mentioned
       or the value is unknown, then the value is set to 1.25V.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
     enum: [ 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000 ]
 
   lrclk-strength:
-- 
2.34.1

