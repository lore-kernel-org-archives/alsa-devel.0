Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F4C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:24:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBB120716
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vf1mp6Ke";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tX7eVcCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBB120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 540BF1671;
	Tue, 17 Dec 2019 13:23:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 540BF1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576585487;
	bh=E/QQSbezSiqAcXWzCtjeGViHO6zehff4xIfVlRfchKk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vf1mp6KeD6TLz5UlV8k38c2euEMDh1pLx0APkCIACCJs6RK/aqvmASqf4cYpeigWM
	 bpq6OEJ16eMmpYiVeGXlA4Li0l1zaIFg01mM+h5uQeWRypfazz2+IAjRsI8G9bN5kl
	 5LGayz/k7eOET91HlHUS15NIfT1FzDGVyVwmiZ34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD793F80307;
	Tue, 17 Dec 2019 13:17:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F786F802E8; Tue, 17 Dec 2019 13:17:29 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CA96F80278
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 13:17:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CA96F80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tX7eVcCe"
Received: by mail-wm1-x341.google.com with SMTP id m24so2707453wmc.3
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bP6qV0Ge4OMghuS4pDxfRI185IDu6wuYLbRLvgY6Moc=;
 b=tX7eVcCe82xuhNC4PtRdC4o19ggzlkpXXKC3ofHdPnMGoIBdtJ+n9h63ySJTmqXnfX
 XcmWluL3sri/Ms32jGrFx3Hhlqwc/BblRQbRgxlHZtxx+jMd58YB+/Nq7GKl99YaXLi9
 xof6rXshHUY34q8W9fYqqHVRUuJfD2mkcs6XshUdzC3lYXhSArJEHUDhht9Ly3Wja5IJ
 hK5Ioh1AoZiPz7q1f+dwc1Mq/aZNn+TTrfW/SoYMcR6vnLvHjAesK5r8xG1SJ82V/Ur9
 223ZaJK29Xg1SvhHeHjgC4hyzjJcr5yNigxGHDIgKaXrxMPBIWvsoOoGppDTKebbwV3E
 SsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bP6qV0Ge4OMghuS4pDxfRI185IDu6wuYLbRLvgY6Moc=;
 b=SVhihqiZ5rrpQPz9As7/Z+Uw6dJmz0FMYufwtN+CkXsfkqnfRGhIr9yooW4zVnXP1P
 bFqTE3O9Hwsgj8j/pmvmgK19sZTogEqyLzLkUjMhWgC/UT9KMa6iOhtkDYzFfSR0ZcDX
 F5hDL4f6oSrn0EFhU2/IZUvvV1TSr8kiF+xfPp5E85uDl4tRBKrdbp7JL1OFrfmGQVjk
 T7FOE8wfm1s/GD1CQGVGZuHF8c8m/PWKwLrTaTocIrs/DPlWf+G15I/IgjKx6Mq/MuQS
 61asq6B2rs0vPRSViqFGkCKJjCL0nNck9f13G1p1yP/rmQPkTMowb+uus1tF3QG3+jJ+
 oCEQ==
X-Gm-Message-State: APjAAAWGrSNxJwd299WplePFnqvB6r5WRVVikSJogbplSY4zozF5iUBA
 Q6/1669AxqAe07ZoGesdB4d+Rg==
X-Google-Smtp-Source: APXvYqyhNFRYqA8YEwQyb3kfdFZYXIoOjrycvy9xsHJmwlK1lktGn3t816k2UYMqif/8XJ0kUp+qMQ==
X-Received: by 2002:a05:600c:141:: with SMTP id
 w1mr5056232wmm.61.1576585030660; 
 Tue, 17 Dec 2019 04:17:10 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 04:17:10 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
 linus.walleij@linaro.org
Date: Tue, 17 Dec 2019 12:16:39 +0000
Message-Id: <20191217121642.28534-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, vinod.koul@linaro.org, spapothi@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v5 08/11] dt-bindings: gpio: wcd934x: Add
	bindings for gpio
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
gpio controller to control 5 gpios on the chip. This patch adds
required device tree bindings for it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpio/qcom,wcd934x-gpio.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
new file mode 100644
index 000000000000..32a566ec3558
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/qcom,wcd934x-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WCD9340/WCD9341 GPIO controller
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
+  gpio controller to control 5 gpios on the chip.
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcd9340-gpio
+      - qcom,wcd9341-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    wcdgpio: gpio@42 {
+        compatible = "qcom,wcd9340-gpio";
+        reg = <0x042 0x2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+...
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
