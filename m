Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05B1C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 13:19:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5751561283
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 13:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5751561283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 036B4185F;
	Wed, 15 Sep 2021 15:19:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 036B4185F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631711995;
	bh=RrS/YC9yrka5UPSznR9amblm2X0hN9a4tClp4dX1oN4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQ2MYwf2bDZV5zvnXa0RcjyldMIYYzmc5XHnf0P0BVMwRCzmb39VLu9Qc8oSh/tH7
	 mFYq4AhJd8EUjRDl5vALKP1oxZ+89uSckOSVoZplvQrz6A1w8znjg16bDlj+WkHiSe
	 Ki2yQRJnBe4uqfOMj4Im0uLiCydsHnsn2ECwcbEc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F3CBF80559;
	Wed, 15 Sep 2021 15:15:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69AC3F80538; Wed, 15 Sep 2021 15:15:10 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5303F804FA
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 15:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5303F804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mdCjM/Xg"
Received: by mail-wm1-x334.google.com with SMTP id
 u19-20020a7bc053000000b002f8d045b2caso2011354wmc.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dEl9+MXeU9ILc1heZjgbaev2CRPnvoQ4/YvbAvAmQM=;
 b=mdCjM/Xg0joHWVCrO9CS5+RUsTFAWiE3a6o+eVHyeEwMYz1jZhVOisr9On7Ox8pnXa
 gasEtmdQuD0Jf15rI294eXVRpx5fOE10afqQCxDeqso0K9aQ2R7r0pAGEarHMllBvHH+
 +GmzkMFp4nF6BE5USZ44tsOxzCF9UYpbR50W4JhOVIBR+loD8nFctSMjcsK1wyt3Us0J
 Wzm8QhSDm5pX+QHhQA5f/TtB4Fue5EJXyKxyuTvHjbyi7e6+UpQbzTeBI7f86I/rsRh5
 4xPjk6k4SLU/SmZKoqP6Hw+MsjKXmlcddBsI10PCSFcpzfO7ZiYc0ArBWQZKdENQUFY1
 kuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dEl9+MXeU9ILc1heZjgbaev2CRPnvoQ4/YvbAvAmQM=;
 b=Furewr52VCsKZmS9h/lGec4LbysmAelyLnoWLd27hq6m2iNHUiRGhZaPtIZ7SBo84Y
 qkOyPyKTl5STET4HzJ2WId4Fe6ThHwrHyQwU/SW6nKQMe+PwC3nSuvws2S8ZKO+MqWNL
 b5kVY+Tw1N0MkQo+3Dmr/KvuKYHJ6lbJgZ64OSs+otdmExkyqK1EGh/aLSbkpk/HJ3qi
 WKZ5wAjpIYrT9Z0LG7QTvUmGsYG8OdvgJK25ZSRdpLrPxe0/tkLzpwf3BvzqXJtg+QqT
 b8ZxDHLazM966wcWhY2zvlj+D6vjEDMZsfmny3TkoHY0OgKpM/VTWo69PyjBIvYX0QTe
 14Yg==
X-Gm-Message-State: AOAM531mD5xOhB7eO5SqC8X8cOb1Jwbw3Kcd727NtW8i7b2XBY8R9kO0
 mSkyWNLFWZD6vBpn24BKlClvbg==
X-Google-Smtp-Source: ABdhPJwCqH29R2WC5jfAJQojFqo8UXLLjHJDfHuKzQAhbiRAyUY97HVVuL5ILxehDthcuD4055DT1Q==
X-Received: by 2002:a05:600c:3392:: with SMTP id
 o18mr4454389wmp.92.1631711695734; 
 Wed, 15 Sep 2021 06:14:55 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m29sm14501717wrb.89.2021.09.15.06.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 06:14:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v6 12/22] ASoC: dt-bindings: lpass-clocks: add q6prm clocks
 compatible
Date: Wed, 15 Sep 2021 14:13:23 +0100
Message-Id: <20210915131333.19047-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
References: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
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

On AudioReach audio Framework access to LPASS ports is via Q6PRM
(Proxy Resource Manager) service, so add a dedicated lpass-clock compatible
string for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index c686164732aa..f83f00737a2f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,q6afe-clocks
+      - qcom,q6prm-lpass-clocks
 
   reg:
     maxItems: 1
@@ -54,3 +55,23 @@ examples:
             };
         };
       };
+
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        service@2 {
+            reg = <GPR_PRM_MODULE_IID>;
+            compatible = "qcom,q6prm";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clock-controller@2 {
+              compatible = "qcom,q6prm-lpass-clocks";
+              reg = <2>;
+              #clock-cells = <2>;
+            };
+        };
+      };
-- 
2.21.0

