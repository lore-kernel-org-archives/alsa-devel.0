Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8492C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:39:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D132054F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i/uTbH+U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AzEA73aR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D132054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDCEC1ABC;
	Thu,  1 Oct 2020 19:38:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDCEC1ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601573974;
	bh=9K0MXW/TCJWbLuAW2+qS7ZZMjKBu9HQVYq5b0ZB7Y50=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/uTbH+U+3L3k7lnV4g/e8qP44DSPI5PscBu+ufGO/teecNrebPE2QsjhvpkKS6Jo
	 g0anrMLfowvxg9ab0rjUl5fZ2gsRrYIrZG30lGVoTvE5ootMTPQM0EIY7rxWHJtG59
	 37w/8n4fFLdVsR7/kbgiGs/QPwVhe/fmefwrzOF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2467DF8032A;
	Thu,  1 Oct 2020 19:35:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAA9AF80331; Thu,  1 Oct 2020 19:35:13 +0200 (CEST)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60CD8F80329
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 19:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60CD8F80329
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="AzEA73aR"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7612dd0000>; Thu, 01 Oct 2020 10:33:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 17:34:58 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 1 Oct 2020 17:34:53 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
 <kuninori.morimoto.gx@renesas.com>, <pierre-louis.bossart@linux.intel.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <thierry.reding@gmail.com>,
 <jonathanh@nvidia.com>
Subject: [PATCH v3 09/13] ASoC: dt-bindings: tegra: Add schema for audio graph
 card
Date: Thu, 1 Oct 2020 23:03:03 +0530
Message-ID: <1601573587-15288-10-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601573598; bh=1m9aUvgKZy/iYRzXFgjMHyA/Qza8PoLq3wlioFAv9eA=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=AzEA73aRHr1Q5sWyGpruRHzIMIRr4romEKt/fkyz/dYS3i5X6LQ+IV79Ep4ePtarF
 ORVwnrydL5DcqC6Kr7+WhBnG411R2XlDppdbO1H5LRb19IWLLMaWKVdvKYmuagQMg/
 MimzlGVqKBgBUEfxCk1EgHWKXa4oLOtekyOK0kXsbJRuEryMepQcMsnKOovQfNTed/
 Yfh/jlSiathVhB1JSaFNjDunbQYSgLyEAC43Jq8rMLW6PBdYILDcdVePYsFUjUxIIg
 +VTXndoQyFsCW+GMrBS/k9R7MwSTyudvLKAUdEcHCYiMMnOZHZofnQ576M2WcQPwWD
 uYTW5H0q5sdrw==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, swarren@nvidia.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, atalambedu@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, nwartikar@nvidia.com, linux-tegra@vger.kernel.org,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

Add YAML schema for Tegra audio graph sound card DT bindings. It uses the
same DT bindings provided by generic audio graph driver. Along with this
few standard clock DT bindings are added which are specifically required
for Tegra audio.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../sound/nvidia,tegra-audio-graph-card.yaml       | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
new file mode 100644
index 0000000..b73fbe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-graph-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio Graph based Tegra sound card driver
+
+description: |
+  This is based on generic audio graph card driver along with additional
+  customizations for Tegra platforms. It uses the same bindings with
+  additional standard clock DT bindings required for Tegra.
+
+  See{LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-audio-graph-card
+      - const: nvidia,tegra186-audio-graph-card
+
+  clocks:
+   minItems: 2
+
+  clock-names:
+   minItems: 2
+   items:
+     - const: pll_a
+     - const: plla_out0
+
+  assigned-clocks:
+    minItems: 1
+    maxItems: 3
+
+  assigned-clock-parents:
+    minItems: 1
+    maxItems: 3
+
+  assigned-clock-rates:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
+
+examples:
+  - |
+    #include<dt-bindings/clock/tegra210-car.h>
+
+    tegra_sound {
+        compatible = "nvidia,tegra210-audio-graph-card";
+        clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+                 <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+        clock-names = "pll_a", "plla_out0";
+        assigned-clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+                          <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
+                          <&tegra_car TEGRA210_CLK_EXTERN1>;
+        assigned-clock-parents = <0>, <0>, <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+        assigned-clock-rates = <368640000>, <49152000>, <12288000>;
+    };
+
+...
-- 
2.7.4

