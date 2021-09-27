Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB08C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 13:58:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5618261041
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5618261041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0A8D16C1;
	Mon, 27 Sep 2021 15:57:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0A8D16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632751102;
	bh=6S4MMf0P9KUf4QLmZga52h7TMUJCzxWqw1kXeq7znlo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W5dSBeOJ4mQycE0bzMMXdcH+9xKX6aNTw6ETuAcGS5N9rdOpjuAXTNtcU3JNtVEKx
	 GYh9Too1inPHkbUv/Q9PdBJY7EjTjFuPELAe/h6LcH+FdcQO60jHU6RpMe7RrrwQl/
	 ESRqpGJHIbvJZLeIBkilUYidP6Rd2jV7akp8+kNs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A4A5F804EC;
	Mon, 27 Sep 2021 15:56:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02FD8F804E3; Mon, 27 Sep 2021 15:56:35 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05455F801F7
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 15:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05455F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="FJVHaZ92"
Received: by mail-wr1-x436.google.com with SMTP id k7so234834wrd.13
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JXUzKXqyFK0FF7TuDfDOhSheb5jJRieIFIcaHFlaH0I=;
 b=FJVHaZ92Zy4tdL4mLMnairBsfoQht09siSoxJ/xaKOuD+75nKunNeAx8TWvIP7607T
 CrT6/MdgzbYjA5UZJVnHAAcPkrVHknaAHPa5DUbrm0qaxAZb9ZMe7vj8n2NgRLHhrrLP
 AGXxT8NvcCBY5q9ujiTzb0Kr8ZS4nIsKnwBh+Sa/xjipYHIOBbtItbcBpqP5Kt1Pp3T3
 Y4natP7yDJvp6V75Vx3IXUgqmL91mgLNeoF9LksC0ilienn61TwoCmVdLw4s0zoWvRVG
 y24kL52HfDNEigLDkLUrWCWx7uhEunmOw+NYni7pQxtW3BzwTthjNe2LNJ/2O3eckok2
 0vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JXUzKXqyFK0FF7TuDfDOhSheb5jJRieIFIcaHFlaH0I=;
 b=NRINQ2z9maXnekv236HOBLJM3LHlLOZtsHU1pUlNiU6dppu3+uJ2dGczefNxQOOalW
 ERqnjYyGqoJFiaiSBFmjOGEFA/EeSyf5BKKkWM66GrBAPENLeoDy5oFuMCNC64Lm8O7z
 QIpRRUF28pSt1fQAthCk+ECiCRao7n+FHvo8YgBnvcymmA9ezdwWmF1uxwfeShPjsTXT
 Yw235RetTjbbKrClnSBky3nIbT3HEl2iIyPqv6vRKcA4mb6q72wg+TkWSvboeLBUcj5h
 MBdvKc6Zc4ROZZ9ARf9Rzx7x8S5YjzekoWH9RySfk1S4uquKbF35pugAHCAhax6+3pk2
 rg9A==
X-Gm-Message-State: AOAM533YKJbN2aoW4rufCxCvGZCN7ZuuE1AT1KaAJrvgZKJWXLk3925S
 63Aauof3tMlBzEhgI4mqsKos6A==
X-Google-Smtp-Source: ABdhPJyMnxWD4DFpntZjf1T7Cl+1GxX4bnbqpL4kGzlnlR8WkcIGK7SIgSAUMnOjuPwy990O/t+eDA==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr15407688wrn.291.1632750984966; 
 Mon, 27 Sep 2021 06:56:24 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b7sm20485606wrm.9.2021.09.27.06.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 06:56:24 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v8 02/22] soc: dt-bindings: qcom: apr: deprecate qcom,
 apr-domain property
Date: Mon, 27 Sep 2021 14:55:39 +0100
Message-Id: <20210927135559.738-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
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

