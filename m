Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A7C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B20206D7
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OV+OyeJu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9s9oPlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B20206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3484884F;
	Tue, 17 Dec 2019 13:22:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3484884F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576585395;
	bh=Yco2H4Wz/2GZY+uz1xLsCAeKvY60o0BeTAtCvGUlr2U=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OV+OyeJuT1VsEgcLC2B0CR6gKHo5d/g3y1oC0ywefBlasfGkhLBBkPGZevpadIEow
	 8KSMY7MckcbhYu9SonSRcvxAzm/Ebyh0ahY7EcSBN/lgtkhpX6/9LlVlmwNZ0O4qR8
	 1z76EPZnjLyDtdI3u5IpvJY6WRYkrTKi+zG75BgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED8DDF802EB;
	Tue, 17 Dec 2019 13:17:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9493DF802DF; Tue, 17 Dec 2019 13:17:25 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 999E6F80291
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 13:17:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 999E6F80291
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="e9s9oPlq"
Received: by mail-wr1-x441.google.com with SMTP id q10so11035974wrm.11
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
 b=e9s9oPlqXY3bctDM3DAHIJFutY3Ax0XREhVRz8vU2/r0RE5AQiKlprlrrhlwjSUKnU
 I4MNJ6If8bH8sOZ/8V8co/C8+VmqvSH+0TE9JWQjAlvN5D8Hu1cYG72tuFzM72STIrIx
 8Z7L6qC+b+xgUl6hi7VzTgXqyOA/7TE2//DxOL1bg5v6g0P1Iu43cZPvXE4l5EsfOaTz
 381W/UqQI3VECNLJO1D8aX97tm+2wRw2dckwE25xta8py1wh4vBWgJ6TYVG86CLQah5v
 d0CvEauJ67z2iUN9K6EgAvlhrN3ky0wQKeqS4hhetqXQg/RDE0785FOABqsg2WjS5dkh
 dxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
 b=KKXHWNeVdq9ORq3zc4Lt+b7iuBzJYkW7FL5nUPgq/Nx67D/W/P2JpLYwzJZynwAp9N
 W4KSrFl+btyn4G71DDPY5NqT3cyYwOQM7Jwh31J6K/UNd2IepY+J0tcfNX8M2jInJBFs
 R7Ha492kwLLRRVizDeVITIzOw5WjSBg7x+UAKD8pgEYBBdd3R1gppNy5ijB5sPQ55TnS
 Iv1R+7eFL7dEx7xWVSkQKSse6jotMb9K5qOh5/oHfuAeyXO/IwRIoIZ5grvaZGiHxPAL
 w3Uj2hSjET0Irrz6/gY46zvq5/g4IR8sqdDmiCBL2au9KxLQZV6ZLp/XKaE91AD3+a+i
 CCJQ==
X-Gm-Message-State: APjAAAVrAFz+q6wZH2dbClg6JVeKRB4wTJ0eFq5KQkWSeIcT5jeIM+3o
 fK9Dnl29AgTB6RoLk/GCnf3zTQ==
X-Google-Smtp-Source: APXvYqwUd8iYagOOPCAYY210HLyKnjSRxtsp4sXkvd58+blKgW/ZwzPQFg9MOF97O4mj3QOzD6d58Q==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr35902104wrw.165.1576585033342; 
 Tue, 17 Dec 2019 04:17:13 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 04:17:12 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
 linus.walleij@linaro.org
Date: Tue, 17 Dec 2019 12:16:41 +0000
Message-Id: <20191217121642.28534-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, vinod.koul@linaro.org, spapothi@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v5 10/11] ASoC: qcom: dt-bindings: Add
	compatible for DB845c and Lenovo Yoga
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch adds compatible strings for DB845c and Lenovo Yoga C630
soundcard. Based on this compatible strings common machine driver
will be in better position to setup board specific configuration.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,sdm845.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
index 408c4837e6d5..ca8c89e88bfa 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
@@ -5,7 +5,10 @@ This binding describes the SDM845 sound card, which uses qdsp for audio.
 - compatible:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "qcom,sdm845-sndcard"
+	Definition: must be one of this
+			"qcom,sdm845-sndcard"
+			"qcom,db845c-sndcard"
+			"lenovo,yoga-c630-sndcard"
 
 - audio-routing:
 	Usage: Optional
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
