Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AACC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 11:25:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA69608FB
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 11:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAA69608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F7341831;
	Fri,  3 Sep 2021 13:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F7341831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630668348;
	bh=PDf4ewXa1BS8Dm+pNigha4faNn5+mlXw7i6TKmnzs5Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QGp+1qAxnsJV/LFIGTaRxAVQ+MsGtU7zJcObQaEsm2L9tQ7uGY8JrX7cr8uWtiGuc
	 vXvRZ8YcI6J/9n5PUAhckWiaXXp4I4ZH4786vCdldh4z4AWfNLFM8E08HZvhYhqXzW
	 Mzzm/sXMTMnI97LeXefEkC9OBog1xX2t8dOp/uJY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE268F80536;
	Fri,  3 Sep 2021 13:21:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD2A1F80519; Fri,  3 Sep 2021 13:21:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBE8FF804FA
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 13:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBE8FF804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="NthLu70j"
Received: by mail-wr1-x433.google.com with SMTP id x6so7704445wrv.13
 for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2021 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZwS0pTLfaYvtmnmGSPY2CWYSjvjRmgOXbJ+a8m+7l0Q=;
 b=NthLu70jVSNa9pEkEcYM0mSh3MxkSlrJqC6QtjhFW7W7pEJdifqWfKPqN/QcZfGydO
 T1IaFTjhOMACUbcQtTUA0WJ6VbDEZCOELmyogwljE6C5NAaj0fKytVnKr9iDU2dMqkx9
 9r4GrNIp8w+XFYPcibSkw99GMh+/RhMVAh8JIRVqRfZknUUN1QifColyynJlKqPbMl4a
 VsFo7uRITU0lDZldkCEQYgMMcKEMMbtb3MO8WcrLDmElwAr2o7Es9b86C500fHH27g9h
 pI73nF1+F6alXZvQJqzHdyjlHh3go3bpGpQT4sg3lgqF/0RZHH32Os96kNpMqDIRg/j3
 wxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwS0pTLfaYvtmnmGSPY2CWYSjvjRmgOXbJ+a8m+7l0Q=;
 b=j15mex9mrbiznz/OpTyPZgzf5gx5lC3Noyn0nBkD0KngSXbvUOrwOKcdmlzH2CCL9H
 6J2bE8vO1KcCAM1zM/Vu32MDSzzP19kwiOPpE+9nTd8GtvRbxo6AqwR0CcMDwTumcvmd
 869xgQGg44KgVyVp7Q16Lbt/A7vCiIXELAJJs4ncaRTVjOc1G7v/vPruTqB0YYaW1EPA
 RkSt4rt3gJXZiDont+BvSKo4cquBxANpIecb0rHccwFQiaZeoSqaaFJZrpcXv+YFH/qU
 Mv/euxltsFJDo2owF0PHeauMEIh2+hniAe2a3RpAhe++rq77FnZb3AuZniXUyvfzM3Fy
 RA9A==
X-Gm-Message-State: AOAM533sarayDK/EnpojJ1TfLEgPFViltS+WUcur3h6gvRnJJe3asQIv
 Pi7UbHIi4TYXZUiGtnIxKaTRHA==
X-Google-Smtp-Source: ABdhPJyRIG1jDC1HovGExZgKxlc97C10bjOuLrdMrf/bDLQQrwOzv5el44PzsJqyiEzbAknPQa4fDQ==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr3569765wrr.164.1630668106206; 
 Fri, 03 Sep 2021 04:21:46 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id f20sm3881877wmb.32.2021.09.03.04.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 04:21:45 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 11/21] ASoC: dt-bindings: q6dsp: add q6apm-lpass-dai
 compatible
Date: Fri,  3 Sep 2021 12:20:22 +0100
Message-Id: <20210903112032.25834-12-srinivas.kandagatla@linaro.org>
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

on AudioReach audio Framework access to LPASS ports is via
Q6APM(Audio Process Manager) service, so add a dedicated compatible
string for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index e6148c17419b..92a641dfe04f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,q6afe-dais
+      - qcom,q6apm-lpass-dais
 
   reg:
     maxItems: 1
@@ -169,6 +170,29 @@ examples:
               #size-cells = <0>;
               #sound-dai-cells = <1>;
 
+              dai@22 {
+                reg = <QUATERNARY_MI2S_RX>;
+                qcom,sd-lines = <0 1 2 3>;
+              };
+            };
+        };
+      };
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gpr-service@1 {
+            reg = <GPR_APM_MODULE_IID>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            q6apmdai@1 {
+              compatible = "qcom,q6apm-lpass-dais";
+              reg = <1>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+              #sound-dai-cells = <1>;
+
               dai@22 {
                 reg = <QUATERNARY_MI2S_RX>;
                 qcom,sd-lines = <0 1 2 3>;
-- 
2.21.0

