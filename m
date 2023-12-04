Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11D4C4167B
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Dec 2023 10:03:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC214DF2;
	Mon,  4 Dec 2023 11:02:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC214DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701684186;
	bh=MhrFc+kvsBuTtxshCGIkg454doACjG7V41KTy1PIApQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AeROclXI+0tn9BaK8q4Zc/ko0TYDf7eCnN6K81l9uFVajypkUtERUCTqvJIWETYpP
	 s4C+RDdvsx9gtVmZYElch+uQDYJ4EXyq4tqstdCd0FT0oKPJRQt6A2xsnedOfmg+wO
	 At+unBeicKGc2aJC+Yiem3sCkO3w9z4Tsqlf3raM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96A83F80588; Mon,  4 Dec 2023 11:02:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26C78F805A8;
	Mon,  4 Dec 2023 11:02:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 097CFF8024E; Mon,  4 Dec 2023 11:01:30 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFDDBF800E4
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2023 11:01:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFDDBF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xlOL86nR
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a06e59384b6so583812566b.1
        for <alsa-devel@alsa-project.org>;
 Mon, 04 Dec 2023 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684084; x=1702288884;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gcpWgbYxTJM4cDAhuGusGlvYgR0Ejalgkc6iMWP0mY=;
        b=xlOL86nRGIlNNE9Qsc8haOiJetyejG1B1UAXr9GOO0PCHsOas3eoPFEsZLErcVq9eh
         YL2DRCm9YCvjJP5hAxScRWvDH2qMtcEPMANR2p2pm+tSfbGkNU3unVCtlDRVv9wZTplr
         L1djO9eA/2PcydVTooAaEBgv2YU9lJfmyaJ+P3lP6uaPeohvB3rnVfbQbhNlz/dLg1L5
         FbLX+R3GqGlkG8MA2SdQfeutY7Ae7ELhPQn1v7i7UdwKA9oRGUoj7wnLPCPt/vwoeLtv
         vX5k4bGduH4RkfVb3Ecuh2AVG7A6vYd2X/ps+7YI+ljlEK3rUbT1VRCfhTu3bOAZ+hlo
         kwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684084; x=1702288884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gcpWgbYxTJM4cDAhuGusGlvYgR0Ejalgkc6iMWP0mY=;
        b=n232qwbJa4V8pdzsrrA9pB4Hj4DCXzPX9wfVskxSq953mb1ZNn+lb4K1E7nKJSYsnP
         Jb8tBWN0eblZqjCHDC7PI2hyx9iFIu8RbzpdOftSlnb4dKqrg4UFdVS+AYygMZKhGmTi
         t+3l+HzkfOQQ96DsbRmTtHpfUh5dcsX3FZxARJwnh15kl5jjTjI3fo8EqH1w/shbpxkM
         7FOSCp9nJ+TRtE3g4frtyfZ7oVc1IZOK3Il+npZ0zjwfnN5ncAa73XobjDWLj9L8upX5
         bgiszsvsJ7p8eMvVqxfBhwoPLlecGm7ZKWDNt393XXifyl7VJjWGyfn/Jsvo7rF0un43
         LlVQ==
X-Gm-Message-State: AOJu0YzjqT68kKXUY2Sgu8YIR86vU2D74WHFipYoVOY1pSKrYleeCxeB
	YmOPlniVjdXh4fFSq/DP/8HesA==
X-Google-Smtp-Source: 
 AGHT+IGIU3jORR6B0x3FGVJgT+5hu64J0FQmCPUvyJ3aNFTkxr8CSXX7InvfFNXJYlFuqoPmGBKcKQ==
X-Received: by 2002:a17:906:3f57:b0:a1b:7313:504f with SMTP id
 f23-20020a1709063f5700b00a1b7313504fmr701721ejj.101.1701684084486;
        Mon, 04 Dec 2023 02:01:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id
 pj21-20020a170906d79500b00a188fe9563esm5065572ejb.131.2023.12.04.02.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:01:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound card
Date: Mon,  4 Dec 2023 11:01:16 +0100
Message-Id: <20231204100116.211898-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
References: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4MBJXLZAIV46NRRHKDESVKL3ZAQB4BGM
X-Message-ID-Hash: 4MBJXLZAIV46NRRHKDESVKL3ZAQB4BGM
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4MBJXLZAIV46NRRHKDESVKL3ZAQB4BGM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Document bindings for the Qualcomm X1E80100 SoC sound card.  The
bindings are the same as for other newer Qualcomm ADSP sound cards, thus
keep them in existing qcom,sm8250.yaml file, even though Linux driver is
separate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index ec641fa2cd4b..4673fdffe312 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sdm845-sndcard
           - qcom,sm8250-sndcard
           - qcom,sm8450-sndcard
+          - qcom,x1e80100-sndcard
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.34.1

