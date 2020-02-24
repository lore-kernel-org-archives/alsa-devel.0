Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38AC11D30
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:02:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675572072D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NlYnlGCg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iYSdXnfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675572072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C98E816A3;
	Mon, 24 Feb 2020 16:01:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C98E816A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582556562;
	bh=eqc3Zf0ltqqq1vV2tUJb9rDdmtf+EK0IjkGB/IsCNSk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NlYnlGCgt7iE90IKMpsEaJo+iF7/qs2DAziQga5jaI4ECxqNYgGyo1pxTrA1zxrv0
	 KvsZhla/MLKIsWbYhOdW0y4Wj8C7Ydko/TojZf2kB2mRrJuSgld44/y5xYPOtoet/c
	 HfylvA8gtxf2GboO2WC31ArrMaDl6bnWGBXwL7Wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BEE7F802A9;
	Mon, 24 Feb 2020 15:58:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74278F8028A; Mon, 24 Feb 2020 15:58:37 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB477F80213
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 15:58:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB477F80213
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="iYSdXnfZ"
Received: by mail-wr1-x441.google.com with SMTP id z3so10748535wru.3
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1GUC3r+7+XLZ1MnTHNeVxioo8UtC8ynUGXhqoFIr38o=;
 b=iYSdXnfZfenDrSM3NrHSdFp0SkkGQ0EccB/BQ6ZL6qmgu1dkYPK+tOaU2sT339KqsG
 AklFU6MyF1IJfG3DYEn9+EsQePg0FixjiwvyXbJVsxGvadzoaewawwkcNOdKV9Htmq01
 TnyNvXNFEyH4WnFmR7tKa/ERovodprH84TOZ/iyUhSFb7drHqh6xxDjxZPQ+SQhW33sQ
 b5il+GsUvtIgc5pnDtpvac6aKM+VTUdylOgaxtY5fRdymhmEZAheP/2PVKJgCJeyEHj2
 64IQUvwcer7G9rwk0n3uKlFdDT22B2wXpTl37fVmOMT+/5Y+itZDiUkdNVDbEocEIE9e
 MWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1GUC3r+7+XLZ1MnTHNeVxioo8UtC8ynUGXhqoFIr38o=;
 b=JRrvtWQttoZPgKXxtSrZ3cyBm31xz6oBXXY31vPF+fJitx/FDDG4aVO6SIFP2LrkrB
 ciL6jEWW8t7uLF0oPAZX5Wbvw3e2VSZ5XTuQo2J6ySFOEWfeMsldWov7PzEHbR3eSkzd
 ydO1rXB4Lln6ZK/goSlTskXIWrS3aGJJ/UBwiq3gz1QHdK7uuyRK7csqCO1LlLzHZ+qG
 xXfdTZYYgxGh3zj84TBlj+UeQO1v5aX6e2H95uwujH75eqV00BrMQc1TKemwsZaZr0u7
 ibBpci0lUQILrvh58slMt+2GykD6eCItkEQg4kGE9VaUNUVSsKSScYusY2mLaK3+eksS
 xXOA==
X-Gm-Message-State: APjAAAX52pDONyDmNTkjS6Vaj77jEK6PU1Tr90YxnbYx2yTxz5v1W5fC
 /ERJzUfO+cZ7quQN2pDrv9qZwg==
X-Google-Smtp-Source: APXvYqzvG6wN9QHqbYKHMBdBwFlan6RiQm6wsilDz1UiJ8oMW9F8w7g4WBpGnn3CxfgONsTL+fNtLQ==
X-Received: by 2002:a05:6000:1206:: with SMTP id
 e6mr41194382wrx.410.1582556311811; 
 Mon, 24 Feb 2020 06:58:31 -0800 (PST)
Received: from starbuck.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 06:58:31 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 6/9] ASoC: meson: convert axg spdif input to schema
Date: Mon, 24 Feb 2020 15:58:18 +0100
Message-Id: <20200224145821.262873-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224145821.262873-1-jbrunet@baylibre.com>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg spdif input to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 27 ------
 .../bindings/sound/amlogic,axg-spdifin.yaml   | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
deleted file mode 100644
index df92a4ecf288..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Amlogic Audio SPDIF Input
-
-Required properties:
-- compatible: 'amlogic,axg-spdifin' or
-	      'amlogic,g12a-spdifin' or
-	      'amlogic,sm1-spdifin'
-- interrupts: interrupt specifier for the spdif input.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk" : peripheral clock.
-  * "refclk" : spdif input reference clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the spdif input.
-
-Example on the A113 SoC:
-
-spdifin: audio-controller@400 {
-	compatible = "amlogic,axg-spdifin";
-	reg = <0x0 0x400 0x0 0x30>;
-	#sound-dai-cells = <0>;
-	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
-		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
-	clock-names = "pclk", "refclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
new file mode 100644
index 000000000000..b9b0863c5723
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG SPDIF Input
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    oneOf:
+      - items:
+        - const:
+            amlogic,axg-spdifin
+      - items:
+        - enum:
+          - amlogic,g12a-spdifin
+          - amlogic,sm1-spdifin
+        - const:
+            amlogic,axg-spdifin
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: SPDIF input reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-spdifin
+          - amlogic,sm1-spdifin
+then:
+  required:
+    - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdifin: audio-controller@400 {
+    	compatible = "amlogic,axg-spdifin";
+        reg = <0x0 0x400 0x0 0x30>;
+        #sound-dai-cells = <0>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+                 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+        clock-names = "pclk", "refclk";
+    };
+
-- 
2.24.1

