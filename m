Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:41:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A75260F50
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A75260F50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4E79167A;
	Tue, 21 Sep 2021 15:40:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4E79167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632231674;
	bh=6S4MMf0P9KUf4QLmZga52h7TMUJCzxWqw1kXeq7znlo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qn57TInxd5wGzkSE55uc+kJibRDvrGGdOQq6wqpfAUNparWjLYyYayLMfyyYqb3qv
	 egVpqRLzp/axfBYEvngKMgPoKyiGdilXVzgL8jk7VAb4bENL5LbLaO9aqpYDfYYyzs
	 zqxztkf7+yD+Ev4P679r2NmnYocBfeZnAiuTf1V0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F9B9F804EC;
	Tue, 21 Sep 2021 15:38:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B889AF8050F; Tue, 21 Sep 2021 15:38:57 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1349BF804EC
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 15:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1349BF804EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="J5KYw5/J"
Received: by mail-ed1-x52e.google.com with SMTP id co2so28030227edb.8
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JXUzKXqyFK0FF7TuDfDOhSheb5jJRieIFIcaHFlaH0I=;
 b=J5KYw5/JHY3SHsYK5xunLWBHiyNjKDGJmh26R0nD5SXMSzMzRszw7/jYFBUI3oMjBd
 Hv0eQNrj3VXxdR8p+9FlEqmRci3tjUCzv/7uF6npiknFzmdtSITr2nuAS4CxOXCDjJ7q
 h2BcHFbfCJFezSKXwaQb6kUUOce2QHxJF0v7x0SVEMicJnOlH++3vcsNhlvuPgflJGKu
 Z8k+511YeuMjyMwRR/RyEhQ6q0fxhCXSnCJAvbCNcDZDXZE1vLEekD4fTAORXuDqMoxM
 x4j4AJg2qjbyHKXWlb4JJC54wDGXY9f2v8CdkL0a06Ow/YuBo3CJU8YiYvtPbW15ZEMG
 HFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JXUzKXqyFK0FF7TuDfDOhSheb5jJRieIFIcaHFlaH0I=;
 b=BXybbcPzoJWm3H/CHQouP1RoGIPnQPfEPtCT01KtmaNHcIYMY8GYtzzEsg7f/7MwGB
 owIa/RVm/jjCaQ7y1MT2RCGufvwjQnoCtsP2Ga5Gw8cBqTO7oRBGaotE9WJLmTq7SGMS
 MxbHI++YD/gXQwkWCvaj8eRKMvH1/OpqjRzu2crbRJ9UDuF3iQbyJx7IxZodkg4ee1Rc
 fI6S3G+RELnHv2Qz9ItVwuKj3V473UZPjP0i08dLPPJEb3CBPSS5zbPRRFze+HMreDa+
 rU9w1ml+nFhDgkCdo9uiXQek0jr1MvWnbn12vlnazmimu/QmP79WEHT8WE9/rN/G34uQ
 0vJw==
X-Gm-Message-State: AOAM533t83hVXjgjwUdYDdU9mK5tpC3oXqu02U7e8q4pMmWIewWYloQN
 lg0JaqXn8j44rfQVg7C8eW8/QQ==
X-Google-Smtp-Source: ABdhPJxtEV/r1kUQl09tKJkIr/Lk3YzeGcoAz7qrFNky6Uuzy9MibbGzeXxennhqj5pAGCSZfjuiBA==
X-Received: by 2002:a50:9dcd:: with SMTP id l13mr11954771edk.90.1632231446434; 
 Tue, 21 Sep 2021 06:37:26 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b3sm7915799edx.55.2021.09.21.06.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 06:37:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v7 02/22] soc: dt-bindings: qcom: apr: deprecate qcom,
 apr-domain property
Date: Tue, 21 Sep 2021 14:36:49 +0100
Message-Id: <20210921133709.4973-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210921133709.4973-1-srinivas.kandagatla@linaro.org>
References: <20210921133709.4973-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
 plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
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

replace usage of qcom,apr-domain property with qcom,domain property so
that bindings and driver can be reused.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index a52b955b8b39..bfe04fca8aa3 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -31,6 +31,21 @@ properties:
         5 = Application processor Domain
         6 = Modem2 Domain
         7 = Application Processor2 Domain
+    deprecated: true
+
+  qcom,domain:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 7
+    description:
+      Selects the processor domain for apr
+        1 = APR simulator
+        2 = PC Domain
+        3 = Modem Domain
+        4 = ADSP Domain
+        5 = Application processor Domain
+        6 = Modem2 Domain
+        7 = Application Processor2 Domain
 
   '#address-cells':
     const: 1
@@ -96,7 +111,7 @@ patternProperties:
 
 required:
   - compatible
-  - qcom,apr-domain
+  - qcom,domain
 
 additionalProperties: false
 
@@ -105,7 +120,7 @@ examples:
     #include <dt-bindings/soc/qcom,apr.h>
     apr {
         compatible = "qcom,apr-v2";
-        qcom,apr-domain = <APR_DOMAIN_ADSP>;
+        qcom,domain = <APR_DOMAIN_ADSP>;
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.21.0

