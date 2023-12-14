Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626DAC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Dec 2023 13:17:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 499B6DED;
	Thu, 14 Dec 2023 14:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 499B6DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702559833;
	bh=xk0Ta/r6eE2cZCI9alTTnyvzmABQ8gDwXlQDMgyAt+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fo5PgKNWIDk8goGXu7I+rNiYNAG9WEImzk/BU7g80xtpGEBbhujgqmWSYdbw56dqP
	 o6eM3euc/MfRLCITwnb9l9kzKSX+y1lRDrFs4BtTQsnNHOEe6+UIlZIf4bs12BuDg6
	 tc3B1PbbrMSao6cS4+5jQaOQuvL6eRCxPukVtlTM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6F4BF80615; Thu, 14 Dec 2023 14:16:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0A2BF80605;
	Thu, 14 Dec 2023 14:16:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2FBAF805D2; Thu, 14 Dec 2023 14:16:04 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 65850F8016E
	for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2023 14:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65850F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XVmO1QOR
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9f572c4c5so121042581fa.2
        for <alsa-devel@alsa-project.org>;
 Thu, 14 Dec 2023 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559745; x=1703164545;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl/2P+gDfIp0TQYPTG0vKiGyNkTIQEmbjw6ExQX0Pf0=;
        b=XVmO1QORDVYQ3m14HZOqWIIRCqgjgWKvFzQDmnOx8wlMFGnvELmZVsXGVT3HHpJG9X
         5TGFTteendFuBDd3B96+3zXf+ktg5a0D3WBeojObpFU47ZJshx9fMy9J0Aoh+4Fdy5/m
         BAWbkBs7YGYOAOJymTFwxf4gcvEm2gygicHsm0OaV2mtV8kPiXDI8DsW29/7w+fHX9Da
         oDpjCbx4pSNp2CFiRkhFj1svJyr4h1fb0XX76E1QNH+8rLASyF/NvIDtU5zz2KXfhPJ/
         95dIXEDa1HqzEkD+TtVWSBw2DAK91V9Xi4MdbFvT4Gx+j+ZwiQ2ELptWWmr5d1ZGttZH
         21dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559745; x=1703164545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl/2P+gDfIp0TQYPTG0vKiGyNkTIQEmbjw6ExQX0Pf0=;
        b=lzmqCoT4rd9UjE7jf4v1upxJjTncC4oiGpXdS1dCoojSbVcWclTm9H4WxLDYVo4s8q
         GjrCJ65EXB95/UAL45dIWBQhyrmYVZkDlKqymW5eMuhbpFMTw/8CMGsgvqRcvY/RGuRA
         pZSfJyP23mylcBU4PIwjHiz/48gnQgZ2nMQGeaeNrDZjfkIMPVL0sXyKVcNnVcoD1YIQ
         kBleqkajxgQo3ciz+LMIoH09UGaJyi5t2aI+8Az7vrsby4xUvkEe3GW9nKF3hWtsklQx
         uC9xrRMgbSW3sFvtJ5fEPtlaDynj8V2z7d2PAlPq+Vd94SAkGq4DYBzgtYA/V5G7SNlY
         FL7Q==
X-Gm-Message-State: AOJu0Yx7mkb9XlalJzG2/QvLm7lrrDBPMae2npVf/d0heehUIniPNN26
	WH/6y/hlqIJX/qTML90YM2p4Hw==
X-Google-Smtp-Source: 
 AGHT+IGLIizoYzjhcP0yvk0sz4u3yPAe8upgnxL+cRqGZY/tUMOhZBAjkVQRfIg1sZ28AJa+AoI7CQ==
X-Received: by 2002:a05:651c:110:b0:2ca:f17:dd69 with SMTP id
 a16-20020a05651c011000b002ca0f17dd69mr4501498ljb.43.1702559745303;
        Thu, 14 Dec 2023 05:15:45 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 p23-20020a2e93d7000000b002ca02ceae84sm2080478ljh.83.2023.12.14.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:15:44 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Dec 2023 14:15:43 +0100
Subject: [PATCH 2/4] ASoC: qcom: sc7180: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20231214-gpio-descriptors-sound-misc-v1-2-e3004176bd8b@linaro.org>
References: 
 <20231214-gpio-descriptors-sound-misc-v1-0-e3004176bd8b@linaro.org>
In-Reply-To: 
 <20231214-gpio-descriptors-sound-misc-v1-0-e3004176bd8b@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Message-ID-Hash: ZJRUWQYVAWLQDBINVXB7D2GIMYESMFK2
X-Message-ID-Hash: ZJRUWQYVAWLQDBINVXB7D2GIMYESMFK2
X-MailFrom: linus.walleij@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZJRUWQYVAWLQDBINVXB7D2GIMYESMFK2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This driver is including the legacy GPIO header <linux/gpio.h>
but not using any symbols from it. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/qcom/sc7180.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index b0320a74d508..4ab34a8842ce 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/sound/sc7180-lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>

-- 
2.34.1

