Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BCC04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:09:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A053061151
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A053061151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CECC165D;
	Mon, 24 May 2021 13:08:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CECC165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621854541;
	bh=Hrq9CX8i7g/jt6Q3lUHRdBdOYs5Kqjj62yJ/CJUd6uE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W2KBxMaJriNsON+QbGqQiferWwuMTmX4wQTdMv503DD2F2JfB0qjr9Lg1Tul/M7fd
	 1kqJbwXQL9lLLZqgcT3EQEcTt3FDZDSPiJyTIgO7Is1p59UFESaWKFf063oORcTh5d
	 vjRYaNzNibosPokHkIxHHXFyDg+EgxF41+eHQ/ws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD047F80260;
	Mon, 24 May 2021 13:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DCBEF80260; Mon, 24 May 2021 13:07:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 868FAF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 13:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 868FAF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tKvdQ/FR"
Received: by mail-wm1-x331.google.com with SMTP id
 y184-20020a1ce1c10000b02901769b409001so10774177wmg.3
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c8u1uKiF4cwNsy2YewN8Mgn0CBiEVyeAerYkNkO3g7c=;
 b=tKvdQ/FR4p6VLgPqIWJrvCMpOywStOt1QnT/nHDbjnQBQXqYdOglN7uVbeLK5mvL2I
 OlhFjD22TsWDv5ISaoct0RTAfOGVMxb1RSuxwEueoZSN2269MPtiXU85EZ5AFYTAQ0K6
 j2FULpjZ5tdwU427vCvOqAvRuob7dD4XPtu8HqZQGfhk7XY5VNkyao4AnRC+O9qZl9T9
 7SeOs6uHd+979UGzhfCq3Kkt2XErJuTsHfEwmCXUjC5aFH4EXuL/53CBOj6trqIqxein
 6EpzSgkMebSQN51fhyD9+qb+sMBGnlhaE0APPpMSTqzYGF4PBtnOhsLHZVOfCVbSxi6T
 UX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c8u1uKiF4cwNsy2YewN8Mgn0CBiEVyeAerYkNkO3g7c=;
 b=cUIkBjcGtmgAQ75SSxN885l90fClsynAdjpC2hKgAq/WRMQ9Kzxjn1bNYm7fD8QqUU
 mxh9qHreEEokpc1sj2El9vG8OIEGW0Y3IrEaZ+YW70wL84uHTeZOSA9Z7DST3dCd+naj
 hP1UOFgyx0OX7zzyBdRI0tY0fFc5j17L52SAOP7choJ9KbB8dA8DPr6oh1ZFtCwDJxQZ
 i3RR/XMCPpwuGKZKDHqjdhRzL9jAFAZ3mQUsy6VJxVyzG7LqIX6hT4L73OR0f2ylAFDj
 Sjw/SohSc2T/IqLDboPpL9H1+/xlxF4/oZzLDdx6sug5eiCsz0oXr2iAm4fczdN97JUn
 VFiA==
X-Gm-Message-State: AOAM531uTbm5cvv9u5AQFa+05yuji2pmOZbMT/tkMuhX7BwY2VcBo7NK
 6HovLEVna551UR5ZfX5qG+JcQw==
X-Google-Smtp-Source: ABdhPJxONpq3vILFH55Qst67QptNQS+miFFkQcuJIrCsQwnMmLgBvTSo9iPfbxxsfqJax9KGx591Wg==
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr19331110wmr.155.1621854433853; 
 Mon, 24 May 2021 04:07:13 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x4sm7590978wmj.17.2021.05.24.04.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 04:07:13 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset
 Button detection
Date: Mon, 24 May 2021 12:06:57 +0100
Message-Id: <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

Add bindings required for Multi Button Headset detection.
WCD934x support Headsets with upto 8 buttons including, impedance measurement
on both L/R Headset speakers and cross connection detection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd934x.yaml          | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index e8f716b5f875..9b225dbf8b79 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -77,6 +77,31 @@ properties:
     minimum: 1800000
     maximum: 2850000
 
+  qcom,hphl-jack-type-normally-closed:
+    description: Indicates that HPHL jack switch type is normally closed
+    type: boolean
+
+  qcom,ground-jack-type-normally-closed:
+    description: Indicates that Headset Ground switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-headset-vthreshold-microvolt:
+    description: Voltage threshold value for headset detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-headphone-vthreshold-microvolt:
+    description: Voltage threshold value for headphone detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-buttons-vthreshold-microvolt:
+    description:
+      Array of 8 Voltage threshold values corresponding to headset
+      button0 - button7
+    minItems: 8
+    maxItems: 8
+
   clock-output-names:
     const: mclk
 
@@ -159,6 +184,11 @@ examples:
         qcom,micbias2-microvolt = <1800000>;
         qcom,micbias3-microvolt = <1800000>;
         qcom,micbias4-microvolt = <1800000>;
+        qcom,hphl-jack-type-normally-closed;
+        qcom,ground-jack-type-normally-closed;
+        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+        qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
         clock-names = "extclk";
         clocks = <&rpmhcc 2>;
 
-- 
2.21.0

