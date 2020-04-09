Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0183C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:09:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4863A2082D
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SGoHebdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4863A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5E4416C0;
	Thu,  9 Apr 2020 22:08:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5E4416C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586462985;
	bh=wic3/XjG+pGc4Gdr9tFqw/9PwY9js2EG3QT6PAYBGy0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SGoHebdmpt7/ybwzn95aajKYUJWKtYaHLmnzqGm5PsDgBds2DUfqpujLxTwqqRB7M
	 s9+l9v5r15PZ1vQKNwuVqTNjGiC62dBTbfELexZbm0d1TcEYQ2swipRYu43HycfYur
	 odh67MW1QWuAAv1M3FUBHZYRxQDbNu3G56x9a3aU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B1CCF80341;
	Thu,  9 Apr 2020 21:59:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26E14F80334; Thu,  9 Apr 2020 21:59:39 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AA71F80331
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 21:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AA71F80331
IronPort-SDR: s5mfrch23mgjMGCQh4m9T2lKUq8d5YUhBOrnH+H6XgI2eklK27k37mM392A/dcOg+ebnUED3/M
 CBsGbIr74jow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 12:59:31 -0700
IronPort-SDR: G2/Ajg69GcgfbXqhZHW6iacCWEtQftjM4PBIf8MySIWVELQOsp14yx595KU0tR47zClAZh4eKG
 dUqCnwa2wunQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="242745426"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2020 12:59:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 16/16] ASoC: dt-bindings: add document for Hifiberry DAC+
 PRO clock
Date: Thu,  9 Apr 2020 14:58:41 -0500
Message-Id: <20200409195841.18901-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Matthias Reichl <hias@horus.com>,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
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

The Hifiberry DAC+ PRO relies on two local audio oscillators exposed
with the clock framework.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../bindings/sound/hifiberry-dacpro.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hifiberry-dacpro.yaml

diff --git a/Documentation/devicetree/bindings/sound/hifiberry-dacpro.yaml b/Documentation/devicetree/bindings/sound/hifiberry-dacpro.yaml
new file mode 100644
index 000000000000..9305a1a0ccd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hifiberry-dacpro.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/hifiberry-dacpro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hifiberry DAC+ Pro clock driver
+
+maintainers:
+  - Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+description: |
+  The Hifiberry DAC+ PRO provides two oscillators for enhanced audio
+  quality. The clk driver allow for select and configuration of the
+  clock source.
+
+properties:
+  "#clock-cells":
+    const: 0
+
+  compatible:
+    items:
+      - const: hifiberry,dacpro-clk
+  reg:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+
+examples:
+  - |
+    dacpro_osc: dacpro_osc {
+        compatible = "hifiberry,dacpro-clk";
+        #clock-cells = <0>;
+    };
+
+...
-- 
2.20.1

