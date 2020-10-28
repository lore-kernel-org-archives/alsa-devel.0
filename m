Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D7C388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:21:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DB624734
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qq0bJFTE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZt+HicB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DB624734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3938E82A;
	Wed, 28 Oct 2020 15:20:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3938E82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603894866;
	bh=4V1qSDzwAqSvMGc1S1mnyS36aiLtZV70QLQiZOXWAEc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qq0bJFTEvHc7EBGAfPLGWZ46Oz/DBv69iPKClZSBLNG7sQNf7TbEk6IFdANi2Lb3O
	 NjNJpMRbOrUFygC4wPETGxwADBijOU7Xj2VZDX4QLvSy5tnzbhJDjMPiAYX0uTJ0jL
	 XkZv2aCTAjqG5pS/ho3s0PP79ryfwrvow4Iod4so=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1835F801D5;
	Wed, 28 Oct 2020 15:20:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A10CF80212; Wed, 28 Oct 2020 15:20:14 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 340B7F800FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 15:20:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 340B7F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="aZt+HicB"
Received: by mail-wr1-x444.google.com with SMTP id n15so5913026wrq.2
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hM0rbzQPb+TSKGempjX+VBzQUrYZY3aGqxwljGgjo5M=;
 b=aZt+HicBEZUhf1884Lhve5iIj5FxIs951qs6/RcYAfsIlyP5AhUCCaZoNeXvkBvEW4
 mNIk49OTpJklyL9GuEQJEykqsB7a9Umm1Q21c+k5o+yhKaVwCaDDvtf9wAR5pF4L6tFY
 otg2wpYl1UIeDi3rjAee3iGsKLIDJ2oaWbTFterLidrD9oe8XiCC1r4QcYRgLjhM3QSc
 llBUCdWDd3GUFisPc33ejIwXT2iZlZQoDBiT7aI02haeudzhYoCSKH/WrAn0aCmasULn
 Vc2F6RkKIpePMAwHeUXoIhKJzeIv8MrPf+GyThYGAa/Xjd6nc5eTQKVBSUyZeHutfF3W
 j+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hM0rbzQPb+TSKGempjX+VBzQUrYZY3aGqxwljGgjo5M=;
 b=dhgzTPOHH2OPRCjTODQZi/83d0PUkqv+urthG65xkQAM6zQqVSm0jVZrKNrzuWoShS
 yV+JEc5ao9P75ziDIMNuBPj4qHhk2L6OReKlvQi8K76DTxbwEX3PSKo/VOaMnlFXU6oe
 yXkIhX3VK5M6W9GkaNB6uoIY911av59mbV2kkpl6cc7V0yMRWStSxobiDqOeS5fluMV4
 dtayidEGo6xnxaX3lEQ/T4VzYEiWKlxkm8jbbtQLU57OjXnr9GwkTYIm9FbpMaexQ/cG
 EUeuKeEipC7TVmpoTDepvWTwLi/nXd7QNXjl1KjLFUWbICZFXWdxndHqtjwXNxLd46nF
 oE6Q==
X-Gm-Message-State: AOAM531iBX8iFWxeXfkhZRNjzLiCwkVozuPLDMK3WGsV5svyPFcTQdBp
 /L/Ml4QA1AltPXLFWlmHGwEAww==
X-Google-Smtp-Source: ABdhPJycIJUox/uaqmQGSJ7pkSXTWDzPXRxyvjjvCUryaByWL3GsvfoL65GxN9I7c103OaLskXKCZw==
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr9206720wrx.248.1603894807270; 
 Wed, 28 Oct 2020 07:20:07 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id o186sm6771380wmb.12.2020.10.28.07.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 07:20:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: qcom: sm8250: Fix array out of bounds access
Date: Wed, 28 Oct 2020 14:20:01 +0000
Message-Id: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Colin Ian King <colin.king@canonical.com>
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

Static analysis Coverity had detected a potential array out-of-bounds
write issue due to the fact that MAX AFE port Id was set to 16 instead
of using AFE_PORT_MAX macro.

Fix this by properly using AFE_PORT_MAX macro.

Fixes: aa2e2785545a ("ASoC: qcom: sm8250: add sound card qrb5165-rb5 support")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 7d43de6d909f..52c40512102f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -13,12 +13,11 @@
 
 #define DRIVER_NAME		"sm8250"
 #define MI2S_BCLK_RATE		1536000
-#define MAX_SDW_STREAMS		16
 
 struct sm8250_snd_data {
-	bool stream_prepared[MAX_SDW_STREAMS];
+	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
-	struct sdw_stream_runtime *sruntime[MAX_SDW_STREAMS];
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.21.0

