Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF286E7C4F5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Oct 2023 07:59:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10BC7F12;
	Thu,  5 Oct 2023 09:58:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10BC7F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696492755;
	bh=ZRDZ0z4Gdtpd4t9mKPBGCyZbF9Ut6G4aFJF0Fb/EtUs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NnJD9wQI1cE+T/64VUgh1KGQCMv6mt4xG46LaOiofSC97ncevSwMoy+zO9aBtVjlQ
	 kEcKP06wt1cpJiLDRUOqVXq1wZ4V4gYcamMqkZfv95d1V12zZcOZI1vwmrLNSEDDZ3
	 NxGR4Xm4Ig8CpA+BqKo4W7OraP8gx7DcFgSyNt80=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0ED9F80699; Thu,  5 Oct 2023 09:53:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BAC1F8069C;
	Thu,  5 Oct 2023 09:53:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58DFDF80552; Thu,  5 Oct 2023 09:53:05 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87B47F8065A
	for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2023 09:52:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87B47F8065A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vV/mSCoP
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso120901266b.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Oct 2023 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696492373; x=1697097173;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VPo73+NISdMnqKKa8YLMLwOayu51kTHaFGUFFnTf0g=;
        b=vV/mSCoPCRL5vnIEJVkEQHfCTZSRDQrbNdePo/hreMhzK36P+rr+4gaI7nakrUivxX
         G0mKWXopeILqUwOfNZ0z4VgNI/XfrzGiHxf0QBVYA9ppmWyhBGxVasuIOCNhQcni8JaE
         LcQDtlHwJUJp1Nyb9ksJKFowI7Vd3GkG8TwOam4Zsy0YITm63bej01niVfDs2AEI6aZO
         MaNZFeT30H9FUpQIDaqr9ScUxhl2/GjtHr3xxqrNQH/pV5R1jcQewfvAgqBZ7rkTH+P6
         EbtZY5gu3bs7rEU4KV7ShqjrT+F1AubaxqMhaqrfLROc9XkV7CnF2064jnxith80LuKS
         2tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492373; x=1697097173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VPo73+NISdMnqKKa8YLMLwOayu51kTHaFGUFFnTf0g=;
        b=YIc1nh5AjDdQ5TfaeWDTRFIYYjBPmW/J3kmQYA5LhEF2vtVU0164czzRr2Xy7kXFKM
         4+G5W18sI3ohA7Nm0R1aYGbD+Y74oF4URoo0NOQL6eGY7DPEzSSAO6SoQMjDl4KIleiM
         3aSyFLbDhTvBdUSJppSU1ptLnPdrXVRUoSw2V6sT2F3g77362Mt+vZkRm9O+iF7KzDDN
         XWd3FjUFXxdLPMdwipMKzS8WzpymaYnlkr+JL6AttWLTiq8vxUq1gh0GNGjkDmTMNVsU
         h4W4VHqnVeE/m0JxCzM0lZiHS0EZHhN98FUcCVwStVvPIaGMvvxXjuC8smrxs+XqVgc/
         lJCg==
X-Gm-Message-State: AOJu0Ywj+LZzM1uS3ZoMoDmub4dipa1sQ4d0dpdC54vtwMiQT8+cBjZo
	kh7ylS6j+diuxFbK4uRcdJeuGQ==
X-Google-Smtp-Source: 
 AGHT+IET4gtql0BEhc/DH8ss0kuES1cJOacsuqdH2Pa/FBh564Eq+POI0e557ksJTlua6yohWy5Dcw==
X-Received: by 2002:a17:906:95:b0:9b2:7b89:8199 with SMTP id
 21-20020a170906009500b009b27b898199mr3889937ejc.53.1696492373610;
        Thu, 05 Oct 2023 00:52:53 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id
 l12-20020a170906078c00b009b94fe3fc47sm722051ejc.159.2023.10.05.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:52:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] ASoC: qcom: explicitly include binding headers when
 used
Date: Thu,  5 Oct 2023 09:52:49 +0200
Message-Id: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4SZNBPDIX7ASEFTM3KNQMEMCZ6SLFL3L
X-Message-ID-Hash: 4SZNBPDIX7ASEFTM3KNQMEMCZ6SLFL3L
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Few units use qcom,lpass.h binding headers but they rely on them being
included through a different header.  Make the usage explicit which
allows easier to find the users of a header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 sound/soc/qcom/lpass-cdc-dma.c  | 1 +
 sound/soc/qcom/lpass-cpu.c      | 1 +
 sound/soc/qcom/lpass-platform.c | 1 +
 sound/soc/qcom/sc7280.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 8221e2cbe35c..586f23049447 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -5,6 +5,7 @@
  * lpass-cdc-dma.c -- ALSA SoC CDC DMA CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 39571fed4001..d15039bb7f82 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -5,6 +5,7 @@
  * lpass-cpu.c -- ALSA SoC CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 73e3d39bd24c..5b99b41956ed 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -5,6 +5,7 @@
  * lpass-platform.c -- ALSA SoC platform driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index c23df4c8f341..095756883050 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -4,6 +4,7 @@
 //
 // ALSA SoC Machine driver for sc7280
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.34.1

