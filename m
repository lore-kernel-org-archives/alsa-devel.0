Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B08C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:41:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F7D60E09
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18F7D60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D03C16F2;
	Tue, 26 Oct 2021 12:40:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D03C16F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635244887;
	bh=FTNshx8mgD/4dsjBE7iHgoCsCH/9Xhlk/9MW2GTlrRw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QIGpBPZor0R7ww/UEhXBTFlIlqY3ltlKvgovGdI5fLlgpIJyl88y8FKgqkzuZPSuE
	 CHNEReKO0/YqqMReMemlVCUYMpDR9BlLn8EWmDO0+7bm8NrIJAHFMxkTVoHNAghnnU
	 HZBQkmijJpXnvQIv8xlXIv0JCKQlfEBzvPRCXmYU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB781F80519;
	Tue, 26 Oct 2021 12:38:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6CC9F8050F; Tue, 26 Oct 2021 12:38:50 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 570E1F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 12:38:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 570E1F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="C84q1Uig"
Received: by mail-wr1-x42c.google.com with SMTP id o14so1084299wra.12
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0TebeQ0TXJpETl5yyZtrFs6HbXMx9cchKOW5rtUhE/g=;
 b=C84q1UigSHqEDprWlNbKiRxo7t/t8Gxf8Acv8pOd6wifnplgThGMajnUPPppcuwtfR
 u87CJJYdPWL1djvQw9qXKtv7BVZYEQ84qmsBT2pKkrjCXFVOBkO7pintT+4EvqeWQ5BH
 1sKmSBFWXIRa1H2Ei41TCx7g5gAAspzK6OudUaClvDhjJUsje7lsEmrPfi+DQSGdmXx6
 LrGRCLgplhDPCyBYSQw3fmESmH82S80avTxwk7+owHH+N4lcrdhGxs0JY1lkrOVH156H
 IpoZWP1U6BfvywFDAa3SlOUZE89MTCfZU/eTHEIKO6VUd6TalsAZxLR9gWYoul4uvaLq
 TNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0TebeQ0TXJpETl5yyZtrFs6HbXMx9cchKOW5rtUhE/g=;
 b=bFnxPT/fmbfXZCCodfE4MJlnFUiO5JCDex3+p4cVRt6kNnwAszN3gzKvNpfcNdLhep
 pl1jWWOu6fXRTJiYxTst8z/NBz/TOsaUKydsvENL138tmjyQCCuRmub/7DlgIh19eVih
 x311Lek9nUg4FjDyLlLDLvAoWMr02ZjQo67TfG+CW9YVJsqrxfhdBPI3n6QBA47k/9DS
 cD4DbqPOC7iBMcALvTy9hHL3mL4kQ9wHNLBX8mNztSvdPvrhzRHOQmu959+O4Ehij9i+
 DP1I3CW5o3ku6z0LHLobp5QFAqiNMCobsGK8Q9Tgg96j+vqidmTaazG/tAxIUuWtQXND
 KgPA==
X-Gm-Message-State: AOAM531h5lbbrf1jdw61cKb9cdTtQkOE/spy1ivsrVFiWyQQMw85iSDr
 CChd1SC7bA2W0eLI3X5I7aWAZA==
X-Google-Smtp-Source: ABdhPJyTjcWajc7F1RRtxUcBM2062zvAhL9RZb2WBYS/U1l8dwdKEntzdWfiCQYcZ+jyHP7zyy0cew==
X-Received: by 2002:a5d:47c8:: with SMTP id o8mr12287858wrc.374.1635244716500; 
 Tue, 26 Oct 2021 03:38:36 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x21sm221397wmc.14.2021.10.26.03.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 03:38:36 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [RESEND PATCH v10 06/17] ASoC: dt-bindings: q6dsp: add
 q6apm-lpass-dai compatible
Date: Tue, 26 Oct 2021 11:38:04 +0100
Message-Id: <20211026103815.19468-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211026103815.19468-1-srinivas.kandagatla@linaro.org>
References: <20211026103815.19468-1-srinivas.kandagatla@linaro.org>
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

on AudioReach audio Framework access to LPASS ports is via
Q6APM(Audio Process Manager) service, so add a dedicated compatible
string for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index e6148c17419b..dc7fba7b92d5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,q6afe-dais
+      - qcom,q6apm-lpass-dais
 
   reg:
     maxItems: 1
@@ -169,6 +170,32 @@ examples:
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
+        compatible = "qcom,gpr";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        service@1 {
+            compatible = "qcom,q6apm";
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

