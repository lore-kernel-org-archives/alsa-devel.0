Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93FC4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF6260F01
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BF6260F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA9701763;
	Tue,  3 Aug 2021 14:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA9701763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627995568;
	bh=/MEgtQBQ0ZOeLjeS+yziXFYJcP2p7/PeZzyDmyS7W/Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tn3SUfNSPOc9WDsJvxrlVRqj1C4TihdUjE5Bag8DsTa/oyiUt9ih2xjJXkhXKphuK
	 37xjQXMwe03W3Z/CFYDcvCTzqbdRX21mjpHN2d8x3dfHadoMjm3G/RNb4mgZE6pPk3
	 PmJiAn9HwQqPUtjS6ZRBoELe8/iB70pyd508gAlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD461F8053A;
	Tue,  3 Aug 2021 14:54:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE1D4F8051D; Tue,  3 Aug 2021 14:54:43 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEF8DF804F1
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 14:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEF8DF804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="oMdPQTqY"
Received: by mail-wr1-x42b.google.com with SMTP id k4so14390198wrc.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2021 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=28lNrxGL6jA0sHRoGitHZoiKhTcNCqvnm+1QFtFW9QA=;
 b=oMdPQTqYbS0n7nNTAc6RUgeTUJfRUAgxS9yeER6PWv/htrRkc7boe3tOVDL9OKK06U
 tnRGmueii8x8eIUASxX+dEl1D4UrHAhAZdWYoIVsubKdVaF/aPnvQnIKZksawDN3DA8h
 uf00k/yDQ/n4nifh1m7f/bgpok65g69jvw9pLHhsegNRXCXy74nSwVSoqyXuN02tLR+J
 paJycM+Qawia8H1X6ZSrWFyaQUZ9FhvXesa6kSWy+TofW4sZqANszjmH3dDfMqf8kwiy
 d9x0zGBAMWI/R4mcSlcNoah4+eLbxRaOL7g/yV+LAsyOB+03ctnQrrBvHqmm+nsNrNgc
 2sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=28lNrxGL6jA0sHRoGitHZoiKhTcNCqvnm+1QFtFW9QA=;
 b=MOo2/C2TV7qyanQV1eKrEpwyRa3LFKa9M9KiYVqZSQp2KjiAU89/3dggW+fGKhiqb0
 2sy4q27JzItrWmZjpguamJrzncXVKUnDuKUznsT62gi1AUoQGU66DazePSa7XOSRaf9W
 hpC1y3nE8rZD3RtKYDXWOK7qzivaisPaaGrkxIJ5R00ssyW/relIO3I7nS5qwgk51Ud2
 c4qsHfU7pPUvxuUKLnF+kIdrKqz2wfgMUAfd969ZEPfRr6/Iy6xb07eVxfv3B/aDgwMX
 5DAzOYwMTaFs91x8amsJfkVmbcmkGp20lLRI564hOHrm7yrXbfWht8cktKSbOpPvRWW1
 xLuw==
X-Gm-Message-State: AOAM530XkZY2X7Xvkj64orDYB7cjcnCK+RIDXvU6pSQn0aGJx5Qkj7XL
 CABO0uwciXvTCO0WCcMa5QqkfA==
X-Google-Smtp-Source: ABdhPJwSV90qUIMwimZIMbPTkUyxXqCNgtBEJRQx9Izi4W3JJxga8ow9xr+OhU3p76VGtvY0fb4QpQ==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr22850871wrv.151.1627995275295; 
 Tue, 03 Aug 2021 05:54:35 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h14sm14695574wrp.55.2021.08.03.05.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 05:54:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v3 11/20] ASoC: dt-bindings: q6dsp: add q6apm-bedai compatible
Date: Tue,  3 Aug 2021 13:54:02 +0100
Message-Id: <20210803125411.28066-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../sound/qcom,q6dsp-audio-ports.yaml         | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-ports.yaml
index 6990295803a8..521256339909 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-ports.yaml
@@ -14,7 +14,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,q6afe-dais
+    enum:
+      - qcom,q6afe-dais
+      - qcom,q6apm-bedais
 
   reg:
     maxItems: 1
@@ -168,6 +170,29 @@ examples:
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
+              compatible = "qcom,q6apm-bedais";
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

