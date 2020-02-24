Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EAEC11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:05:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E7520838
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="steRqO/1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MoDtdy/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E7520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 699D216AC;
	Mon, 24 Feb 2020 16:04:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 699D216AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582556708;
	bh=WhpW5MaCFQ6nb7s2Ivh0uYUp+ifb7kVQHmYnkQ/AUTI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=steRqO/10U6VoNlxy4c9LKi4CBupH1j3JyS2UZ8euyCcHOkZMs4PGy89bLZrsCE8A
	 0ZRxo14gatFIe54BZyKPgKG8qQhoVvo31nJnaEBvRfypdYx4AovHImduvVzhjsLHLX
	 cuo2CAHsqD1YG36uFjq9Pf+9EsXbSh0FXqUS7+uo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9CB2F802E9;
	Mon, 24 Feb 2020 15:58:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13629F80216; Mon, 24 Feb 2020 15:58:50 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9B99F801F2
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 15:58:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9B99F801F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="MoDtdy/A"
Received: by mail-wm1-x341.google.com with SMTP id t14so9726512wmi.5
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+z+TEx8bhDzFW34QmPiBogPbKoWFxma+x2ar/YNcjJU=;
 b=MoDtdy/ASSE81XvhIDEr7qmy2sjAw1QAcaXSfyHMIBU04We9KpnwK0vGNTV5THR7wI
 iVrviVzuGIaxmeRIqHTm5G9vm8qv/iRnkeZW6BnvPh+KilhC6Nz8INKir9eu8dRr7g3Q
 MUW3kTRWdIXPYXJ5QtrFpXYcB7p+rKRO/Br69oOguNbaY04mYnQo7vdovSnY+arRB0Tj
 z0s1SIr9jh8NAEsJFKg3JcSdExn3BDdPia5en5m1NALv2z+Q9gcSL8z0jkMO5b507ltA
 dDT3psslEf3pa2f9eamk92vx50VkK2vsnmmJTnAfYjK89mBYqCWA/TCBXIS7UXLL8xnI
 C9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+z+TEx8bhDzFW34QmPiBogPbKoWFxma+x2ar/YNcjJU=;
 b=CjfWgPLKBo1Ctblho14K0kYgoeykYSUjVCYCcBiLh+1licZakl34S04rYFO2g67a/C
 YVCZWaIeMiXFordt3aE/l6xCGqo97wKaniL1B79F3n0WlxqKPuLPAtde35KkxS8JTna/
 n+elXe832o0GT5fzLX+d5/IdoY8zCO+d9GlJo2vswbsWCBcL2sVmohl5o9vrFiR8VF+n
 s2HN6ac/X0MhNdU8lgDP8So7VJg+/MKElmAQC3sC5c/drdWv54YNO0HUrTUs1o/Zf1Cp
 UUYwwEEybxzmpMQxitOhFvnK7uDaMbhXjdj6n6R6UuOO/+vDqZver0+ZX/D19EkKeuK3
 lVDw==
X-Gm-Message-State: APjAAAVD7T6R0cLePwFsLGD5vEJU9FrXhUwsY+6OILwNHMHqHWZCGdRE
 7JzN9tUd4lbeltA3vk8Rges4Kw==
X-Google-Smtp-Source: APXvYqxzdyMGHGJFlXqXOA3msq5jgOwUeemvvhttni/cYjCD+O7dBZXHWX3MEa6se4j6NPP37csdjA==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr22245016wmc.162.1582556308456; 
 Mon, 24 Feb 2020 06:58:28 -0800 (PST)
Received: from starbuck.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 06:58:27 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/9] ASoC: meson: convert axg tdm formatters to schema
Date: Mon, 24 Feb 2020 15:58:15 +0100
Message-Id: <20200224145821.262873-4-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic tdm formatters to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../sound/amlogic,axg-tdm-formatters.txt      | 36 --------
 .../sound/amlogic,axg-tdm-formatters.yaml     | 92 +++++++++++++++++++
 2 files changed, 92 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
deleted file mode 100644
index 5996c0cd89c2..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Amlogic Audio TDM formatters
-
-Required properties:
-- compatible: 'amlogic,axg-tdmin' or
-	      'amlogic,axg-tdmout' or
-	      'amlogic,g12a-tdmin' or
-	      'amlogic,g12a-tdmout' or
-	      'amlogic,sm1-tdmin' or
-	      'amlogic,sm1-tdmout
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk"     : peripheral clock.
-  * "sclk"     : bit clock.
-  * "sclk_sel" : bit clock input multiplexer.
-  * "lrclk"    : sample clock
-  * "lrclk_sel": sample clock input multiplexer
-
-Optional property:
-- resets: phandle to the dedicated reset line of the tdm formatter.
-
-Example of TDMOUT_A on the S905X2 SoC:
-
-tdmout_a: audio-controller@500 {
-	compatible = "amlogic,axg-tdmout";
-	reg = <0x0 0x500 0x0 0x40>;
-	resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
-	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
-		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
-		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
-		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
-		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
-	clock-names = "pclk", "sclk", "sclk_sel",
-		      "lrclk", "lrclk_sel";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
new file mode 100644
index 000000000000..f6f3bfb546f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG TDM formatters
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - amlogic,g12a-tdmout
+          - amlogic,sm1-tdmout
+          - amlogic,axg-tdmout
+      - items:
+        - enum:
+          - amlogic,g12a-tdmin
+          - amlogic,sm1-tdmin
+        - const:
+            amlogic,axg-tdmin
+      - items:
+        - const:
+            amlogic,axg-tdmin
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: Bit clock
+      - description: Bit clock input multiplexer
+      - description: Sample clock
+      - description: Sample clock input multiplexer
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: sclk
+      - const: sclk_sel
+      - const: lrclk
+      - const: lrclk_sel
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-tdmin
+          - amlogic,sm1-tdmin
+          - amlogic,g12a-tdmout
+          - amlogic,sm1-tdmout
+then:
+  required:
+    - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    tdmout_a: audio-controller@500 {
+        compatible = "amlogic,g12a-tdmout",
+                     "amlogic,axg-tdmout";
+        reg = <0x0 0x500 0x0 0x40>;
+        resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
+        clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+                 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+                 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+                 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+                 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+        clock-names = "pclk", "sclk", "sclk_sel",
+                      "lrclk", "lrclk_sel";
+    };
+
-- 
2.24.1

