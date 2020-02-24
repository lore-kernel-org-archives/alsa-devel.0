Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81CC11D32
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:01:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AF720836
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fvyPCEri";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HFA4ICVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AF720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A94AE1690;
	Mon, 24 Feb 2020 16:00:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A94AE1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582556461;
	bh=hGq9jOY/xwlnNI97adB9tXaqe7mrZqNn9IwLrJcPftY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvyPCEriRjDONW/grVE+e8/AvdTkYm8BP8pMpIGjMiH0W6crTc/OOYc62RWC68u61
	 Yq5D8ZpBPU2HzoTSg7hjbg304Mg4XwLXuebgpVoJWbrEFZkkQkplGQVjjjLyt3NYuj
	 5kL0LJgA/t6Jad91um71wjzFfk0GmWP9qnVZ57eE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11DACF8028C;
	Mon, 24 Feb 2020 15:58:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A6F1F8027D; Mon, 24 Feb 2020 15:58:33 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF5D7F8014E
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 15:58:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF5D7F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="HFA4ICVw"
Received: by mail-wr1-x442.google.com with SMTP id w12so10746011wrt.2
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QbPDnJvMb3x4DYL4TCdJnWqdiB62oTXrzN6fiKtZb+M=;
 b=HFA4ICVw6V3LfO9qsOscd8/53GDOJ3feJ6Ji0HTsOjTTuAfuXMA0hsAdQkCSU+bL1q
 qhfqsEkCP2czU4Xjmkmw+EEm6CZaDVFNLQIiAg+kUooHrcLk+Opg29JGVI7CWnl4biTJ
 Juwq/Os17E9C9puNGBVtGWkN4iKkMLauBzjpW6A0K6hfC2sAB+hy9SgW9Sexlmlgs/7B
 W+JJ1c3ikKSjCl0izRj2FzutJE98f+IzxhtqGCxOzFm7enLHKcK2BweferHjmXshlRAR
 qay7/kngc50egqFvqA6+AOFo/Qe+IPVz8uXpFDz5wYPax0ITcqQ0eQQzank8PArcR/Fk
 2+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QbPDnJvMb3x4DYL4TCdJnWqdiB62oTXrzN6fiKtZb+M=;
 b=qj3PDv6RUnuA5D0fPXP9TjwXJRg9fyXJeh5TOUhLgVP+WRrazg/9RHMruiWc+Gxm3m
 JK8R4VmmFKyP934HAPyAON/7QURbICQqeuMf0YdJCcH0FHR4V7KWvOwg3RlpSmTOFcBG
 /wPpQ7P9XaJq7JTGCl5+WvF2LPWZOkOn5g+9ETztf1dG18rAR9EMDhA1HXLQsrlcrLAb
 ilY8zf8bytdFqW5YJR+j2+T1rcmaN3Ug3ksKV+utd9O+ILA898GPdLXWa1QIe6SXPrCa
 TZHlYOCpyheYo3edyLcJ52l/fA0IEt8HweVzZbZxmyvvjha6tWQuDLQi9iw/JG1t3dP2
 y6JA==
X-Gm-Message-State: APjAAAWkQCZcuFqfZDJFLfuqnEjp1fuuQItyBSB4JruzV5OicE87swTq
 AWK1sfbo+jsLbagHx70b69uGVA==
X-Google-Smtp-Source: APXvYqwPxiP3e2VegzNZkK0egE5/QUcECBQ7ji696G0f6DJy+KFTKe13E3vEe4wS2WyJefgjBE6iMQ==
X-Received: by 2002:a05:6000:118d:: with SMTP id
 g13mr64415099wrx.141.1582556307308; 
 Mon, 24 Feb 2020 06:58:27 -0800 (PST)
Received: from starbuck.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 06:58:25 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/9] ASoC: meson: convert axg tdm interface to schema
Date: Mon, 24 Feb 2020 15:58:14 +0100
Message-Id: <20200224145821.262873-3-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic tdm interface to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
 .../bindings/sound/amlogic,axg-tdm-iface.yaml | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
deleted file mode 100644
index cabfb26a5f22..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic Audio TDM Interfaces
-
-Required properties:
-- compatible: 'amlogic,axg-tdm-iface'
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "sclk" : bit clock.
-  * "lrclk": sample clock
-  * "mclk" : master clock
-	     -> optional if the interface is in clock slave mode.
-- #sound-dai-cells: must be 0.
-
-Example of TDM_A on the A113 SoC:
-
-tdmif_a: audio-controller@0 {
-	compatible = "amlogic,axg-tdm-iface";
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
-	clock-names = "mclk", "sclk", "lrclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
new file mode 100644
index 000000000000..5f04f9cf30a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio TDM Interfaces
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller-.*"
+
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    items:
+      - const: 'amlogic,axg-tdm-iface'
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: Bit clock
+      - description: Sample clock
+      - description: Master clock #optional
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      - const: sclk
+      - const: lrclk
+      - const: mclk
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    tdmif_a: audio-controller-0 {
+        compatible = "amlogic,axg-tdm-iface";
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+        clock-names = "sclk", "lrclk", "mclk";
+    };
+
-- 
2.24.1

