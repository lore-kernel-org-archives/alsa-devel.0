Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F11C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 11:26:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F4E6056C
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 11:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30F4E6056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFABD181F;
	Fri,  3 Sep 2021 13:25:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFABD181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630668382;
	bh=M75VjAePp5xxN6vkI3+ydrgQkMRpP9j42m6a3+3YrME=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEVDGbGwnyrLBUqQnQkN3eM/eT7FPTl1nRXb4RU5cnYso5H3w3zajKdo3GYXPbSoo
	 RvhZ2tI3q5kB7Sx1/a2IYHoaiK3yS9yAI750/iOdgUoL6rOry6fTMn2mp51N0FhUPB
	 zhejQZVUCHkHi7qGPKQwJoxNah7YffjVz0jLIbX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D4FBF80542;
	Fri,  3 Sep 2021 13:22:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D90CF8051A; Fri,  3 Sep 2021 13:21:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86C8DF804EB
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 13:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86C8DF804EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="m3dU1nsk"
Received: by mail-wr1-x42e.google.com with SMTP id v10so7727722wrd.4
 for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2021 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XrcdWigOrJBOqNH3/v+b+R+GIipVI1XmPMk0yejMbMo=;
 b=m3dU1nskU148xorso3M3e8tJyMoaA5cHdIzy7AL+czkLGPv7oLPA5e7oVDBKgfySp6
 NzaK41cabEW4S3hpjdQHiOyuVtyfaP4+2EM+JFWxbRAn8VFJEiKI4bDMgFkH6Q3i9rCX
 0de9CDTHSVkVTXIVZnpdIibdLfUKSjFPnCPCc4LoWaQvs0hDXnBTUF0xA5tSprctigvW
 Sj1iRKkQRrutNlSRfRgic/lZR379VY9Eka8nmn2z1EQzlDKQZFErCpHOgOw5+4txL4yR
 aUw1vzmFa8QB0WAjRrKFD2fAqPO5jqIrMLUsl0tPuf0GxybFXu4exEErL0OXa8QKEM3b
 T7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XrcdWigOrJBOqNH3/v+b+R+GIipVI1XmPMk0yejMbMo=;
 b=qHosRyVE9yGDcI4bsC632Q39FWeoLhrXLQX3BU+LJnSrXKB+ZHLNZ3SOnFOoEwVUx4
 GWtZrhZWugX6/zpQ1rgKvwyxvvRMyTcHXXxM8uSeYzpkVZ3j5hV1MMf14NgCdBYshfnk
 b7jS/SkilbAMQpaN1MQwGxuYzWaCTRqUC8KI9pKGeBNsVhhlJrk68zkpXHh8ldKZ//GC
 GaneiePw0eiqcI8/dGNXAQ++D83rJEbRSmWfTzOQrQ1B62Iu1Ki3WfGL8MJ1ARGn0ipx
 rorVbfgA/LyOjoMMGBPnP1O8e2+sHeyWJnHpTma/F7GNYgIku4DuI2M86cXE/JlsMF7b
 bc4g==
X-Gm-Message-State: AOAM532fNMsVmnVxeOtkpFony+nX8raeRUf41+JZdthjGUKFKYIykA86
 uAN2jq3o3e+FU47/jue8l4rWQw==
X-Google-Smtp-Source: ABdhPJx/laJ0dPo3VhAp35pton8lIaiXEa8k4R19JM9JV80XiAkhPelcOx2o0e0ANCWxX77k4D+xsA==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr2888686wrw.134.1630668107423; 
 Fri, 03 Sep 2021 04:21:47 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id f20sm3881877wmb.32.2021.09.03.04.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 04:21:46 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 12/21] ASoC: dt-bindings: lpass-clocks: add q6prm clocks
 compatible
Date: Fri,  3 Sep 2021 12:20:23 +0100
Message-Id: <20210903112032.25834-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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
---
 .../sound/qcom,q6dsp-lpass-clocks.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index 589c3f1e2008..9f3de2307d1c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,q6afe-clocks
+      - qcom,q6prm-lpass-clocks
 
   reg:
     maxItems: 1
@@ -54,3 +55,20 @@ examples:
             };
         };
       };
+
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gpr-service@2 {
+            reg = <GPR_PRM_MODULE_IID>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            q6prmcc@2 {
+              compatible = "qcom,q6prm-lpass-clocks";
+              reg = <2>;
+              #clock-cells = <2>;
+            };
+        };
+      };
-- 
2.21.0

