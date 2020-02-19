Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB0FC34047
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:18:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC0F2067D
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OJsUTdhd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uc0tsC47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC0F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BECC1698;
	Wed, 19 Feb 2020 17:17:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BECC1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582129102;
	bh=GLA8XQhKkwhXaQmXQlyLvv/TIokS4AMSUAxBeZsIcXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJsUTdhdcHkKtLq3+8xw/xIrn55K9Q8SYhOBHwNf085hPyHpJa+JlP3nETI9m49hS
	 HYTtuK0KLDVfCZXh+P4dvKqZl6VpPK3ldrAL3/BOofUDIjoFO/uSfs2QvKwSPXkcB3
	 XtqjoO06h1v4f2Dm1A/S7Sp7/AtVfJeCwSeT2m88=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95C61F80279;
	Wed, 19 Feb 2020 17:16:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 239B4F80279; Wed, 19 Feb 2020 17:16:38 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 528D3F80114
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 17:16:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 528D3F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uc0tsC47"
Received: by mail-wm1-x342.google.com with SMTP id s144so719825wme.1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
 b=Uc0tsC47BaJeKfd4KzNsQc2dQXTzEw8wn8WAQTvg9GaYhQ+XL4GRBQy6qoOqYrWTsI
 Xhq1W4SawLW4FeBhdv3QBtpMRf+VHCyuFqybW0T00Y8dj4c/BNQQqnku4zpu1b37qODQ
 fEJD/cJ4M9Ad17f4GnDIJO1GCnfV91kyVB6iFsPQlFfFTUWMEMgSTobfXqu1u7o0LaN6
 KYuUUk7B3O8SLIiuJ13yplhm74KbwSNDcWDEMG+TeQDQAc34laenw0KmksTAatngio3N
 7ZyacehueKO5IMc8NfA4nMBZwX6Vj2Btv0XZV6XSvw3KPKn/hGabu+4pNpO7CLWPg7Fn
 v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
 b=bvoBqPJgcFSUhiH3owA/CXMhd1s0aVzjPuiJlFe8be0/E8tHFND6W3ei/qBc1A7Pfr
 tGuXocsl2hN+ReDUEGmHuGBKoc53aRXHnta26mxAaL+DwHT7NKtTKTH/BnIYtt/frCpz
 0Cp623pFam1TJG7D++VYZt2AX4aSrcgIBfsae3zQ1jiVd9yZ0tBh2EV8Bts0KNf9Ym84
 FCya5AeiQQR7iMuN7RhnkcYrnR53vBwLthcxKhu68BXQ60QbVx+hxUIR3FiZUZqHZHuL
 iqOibT0XyRZAZVV5INGTywdRFKtMO0ZcL+Hr+rCg9wJVqxaWDG/SGC/qNh8LSymRuPcL
 zgXw==
X-Gm-Message-State: APjAAAWAgy9gMCmnevT6vsi1m0Q7Ck+bZdRsFQ/RYK9TtyavuhakX0UO
 PIrJLbup/lZZ5eYg4yu2o/uneA==
X-Google-Smtp-Source: APXvYqyxsijU5d9Vs4rJZhP2IlvQTVINyfHLXZAjIwR5PKz7AyNYQdmxrleEMtbffmdy05IniAkW0Q==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr10662910wmj.96.1582128993481; 
 Wed, 19 Feb 2020 08:16:33 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id a22sm437140wmd.20.2020.02.19.08.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:16:32 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 1/2] ASoC: meson: add t9015 internal codec binding
 documentation
Date: Wed, 19 Feb 2020 17:16:24 +0100
Message-Id: <20200219161625.1078051-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219161625.1078051-1-jbrunet@baylibre.com>
References: <20200219161625.1078051-1-jbrunet@baylibre.com>
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

Add the DT binding documention of the internal DAC found in the Amlogic
gxl, g12a and sm1 SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,t9015.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
new file mode 100644
index 000000000000..b7c38c2b5b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,t9015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic T9015 Internal Audio DAC
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
+    items:
+      - const: amlogic,t9015
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: pclk
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
+  - clocks
+  - clock-names
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/g12a-clkc.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+
+    acodec: audio-controller@32000 {
+        compatible = "amlogic,t9015";
+        reg = <0x0 0x32000 0x0 0x14>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc CLKID_AUDIO_CODEC>;
+        clock-names = "pclk";
+        resets = <&reset RESET_AUDIO_CODEC>;
+    };
+
-- 
2.24.1

