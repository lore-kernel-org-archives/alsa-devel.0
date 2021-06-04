Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D3C07E94
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 11:54:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8869661418
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 11:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8869661418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB11E1727;
	Fri,  4 Jun 2021 13:53:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB11E1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622807668;
	bh=HoWPLydPlOeV4dLxzQtam8f5Gv9kVNyfAIN6io25kXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7tdadxiRv9KeXWBjsO03ja/Mmp+rmKvHHYYGoqax9mflOwXfAyoWDQ06mHuylO6F
	 kMGmvn/nb+rcLRJTcbOmhqBV0MKwh24YF2IlF+uiOET3LDmYTsj93B/uQxektnwE6C
	 xRTLjQGQnlTrHTSlJeTZZkq6ouNZx3wgAG6yq/xI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57233F80430;
	Fri,  4 Jun 2021 13:52:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACF5DF802C4; Fri,  4 Jun 2021 13:52:46 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA371F80103
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 13:52:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA371F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="J1Ee5tPz"
Received: by mail-ed1-x52e.google.com with SMTP id r11so10755987edt.13
 for <alsa-devel@alsa-project.org>; Fri, 04 Jun 2021 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5j5rgBC9lX13jha0n88LekB5zZqgucGPLSnMQ3bIh4o=;
 b=J1Ee5tPz44E+NWe276Ludx6VS/UmQV+jX0PZA9EUalZ6leSqTpMNFdLfYH9tfl15pp
 zdoC6/GY9VwOqLvYk2fbrleNvXwVcMrzaJJ2JQP9r8Bl+dcHCz33d2kROHkJ9mkXhGpA
 Y7y5EV+iQYVkLiJMkJ/VWVI+20eUK0TWgF0ZWLNhswi8EF4U+wlrJMtzNyZ+k03lvtXq
 3N+Asj0K0AEefwndf0XskBVsKKGICxKl5cg3FjqyaYSwfb5HbdeDR4qtfVft5ixUBx8y
 Tow9s+mChO5ORadFP6ZpE1vAvLmziJR4ZaMOGlcHh4oIqoYv9TOxJdkG8F5nkoBMtgrm
 1CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5j5rgBC9lX13jha0n88LekB5zZqgucGPLSnMQ3bIh4o=;
 b=YR/2uU+/YaiMR5kN2oD3zqciwxgUkr3dkUDEN5ESdJUDUqaGme57/RdxMnEiqgcZgM
 +FL23VNxZnt1AeqgFkEFsMRm9WPfbsjhEmmwQN9AZUjbBtBwDzR2OKzN5MiBiYhUYwdw
 qa/IjhqZWBoWVUpprMhGkheHtfihmwp/qafaZUVRME4mZngzrisah+xBKsXf32oMlcH3
 yPaJL+UxSdSiFr7ynAy6nlGRftkPr3yn3kjrQml+93eT/YfjwSC4FWQKdAR2Vdlfo2E5
 O1ffex0KuoukbyZg1m9sHXIX1C3wq4HxYKkEaa5eqUWCW5TbePxT211Yi4jic8JWhOJ8
 oH3Q==
X-Gm-Message-State: AOAM532GNGYGHsC5gODxMuvkfMariHm3tuQVN7YOD3J3Gynd8BBUr/mi
 +ksjpmHfqzRoG35/oslOLheGjQ==
X-Google-Smtp-Source: ABdhPJwVY3yFv1D6F4g4S+Uhs6HitOYun/5vjW0DqJ3yxHeUU6wMQTm8aRFnuO0cLCFwbbW7S6daPw==
X-Received: by 2002:a05:6402:424c:: with SMTP id
 g12mr4224119edb.145.1622807557673; 
 Fri, 04 Jun 2021 04:52:37 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x9sm2805527eje.64.2021.06.04.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 04:52:37 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v3 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset
 Button detection
Date: Fri,  4 Jun 2021 12:52:27 +0100
Message-Id: <20210604115230.23259-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

