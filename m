Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C58C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAB460462
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BAB460462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E09B316D6;
	Wed,  1 Sep 2021 11:19:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E09B316D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630488046;
	bh=sHuh4AL1QBeZ30fBOJuW1AmBWRscSHQ+lsB59r/BoNU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BvR6YkbYXCMFgYqFiFmoa8uqyFGZ+AiCmQvlpbIzRHlearDAdm5Cz6G5sMzJcNMZQ
	 P1mdv0dGMro7dHXQN/O69U3V2Qv1Vcu97MuN4iv7okYviItz3nbb1BPYyMkftz9pBm
	 CtPUIMiMasJyra+Rcj27WZm1mJSE4hJ+3kHW6sTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C660FF804C2;
	Wed,  1 Sep 2021 11:19:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4006F802E0; Wed,  1 Sep 2021 11:19:10 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DFB9F80171
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 11:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DFB9F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="ks1Q1D3J"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="hLXLNayg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id D26FC5802FE;
 Wed,  1 Sep 2021 05:18:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 01 Sep 2021 05:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=3yomxpkPFm1FI
 Eaqfzf/NNqj5DtvmQUrtwAFUvBRgfU=; b=ks1Q1D3JFJGOMUbGhsZGsQ96c8PBI
 yhK+O5XegEkxvb/EfcmLyU7jARub+k1kq49OF9nX3G2/2GJxPLwK/OLRwmJilt1b
 1pArqIX5V4n4lOiqS+CTbZDGxJ5fQrtbgusdoUsqLt7Wzs3AH3SIiEpYlUgokVmX
 tRHszmghQcibF3I1ZOiQ6D7BqhMwy4Miqn6rXK1RSJsMBZmTPMv9K3QgQuCD0HdA
 y/KVVuN8Fq4SPJ4UqlQO8pkedoZGvXXa5o9Mqcpr+ktHc1L68wPKZf0piaQCz6SD
 2oextD8yY3A2b/qOPU66Ap8ytGREOTX+/GUwvy5qMNqKapS5xwr9FclGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=3yomxpkPFm1FIEaqfzf/NNqj5DtvmQUrtwAFUvBRgfU=; b=hLXLNayg
 7QPYuWiS3me/eqc92sGRUwE8O/7RGIlUpqMo3Wh+ugx4WrnrloSpxATfnqWzjCfP
 sLXyJuuFx3FjOPCgi9VilrVvzoBpF87AzI8uQsan+27nShJ/xycXzP7YesfUuO2h
 l8ZiyMcD+/QVmw8gj2iyjwUHJfyx6dDS5Ecglx4gnNQQooAoG1hdGaoNZKpwv3dt
 nVnurPo56M4QWlNmCB35WUTsg35i8WQ0b0tmB/JK0rNftjl0Zgt/d/UXFRGvCoQg
 jRK33YIMH3Dspi1jxsWZ3THiTYD1wn8YRZ8jXusoIIOpKBUP6AGXaWi68soR1fCQ
 5MsTIczdILD06A==
X-ME-Sender: <xms:gEUvYXCO8UPiHJ1cHWnKhkPJKszRT5I37O92DivU5gciVa0fQuHLOw>
 <xme:gEUvYdhhCKsLlkgv9w9c0XmLa5PwBhSpZ-39Ie-2CLT1CyId7ik4AtEN1YWDYUdjw
 fNkd663i17FwoBRMD8>
X-ME-Received: <xmr:gEUvYSkR-tTSqwmuA18gYv0Jh1bWlZACQ6LiicW5xf7Wds3vRFfCL5hu4X1MPNqkNUZnDqzFO0JrsZWQiKTp7i-MQ0xU7lyJ9Y8W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 govehorghsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgj
 fhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrg
 igihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeevjeeijedtvefg
 fffgjeeugffguedtleetkeegteeufedtuddttdfgfffhgfeuffenucffohhmrghinhepug
 gvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:gEUvYZyQk_7uNVx-OPJgJTwzFNF9O_dZUkcsydMLVJDHfQewFEK5Tg>
 <xmx:gEUvYcR-1MxvYIV5BSh5mXxWdR4_-sf4n-G86-Uk313OC0_g-gBgTA>
 <xmx:gEUvYcat9HULakMthbU_K-otYYIfop_Bm5ULGqllkFT0UykpMuPgkg>
 <xmx:gUUvYQa-yRj42RyBEFC1NtGawmtZqau02xALyEt73O2DkeXHuir77w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 05:18:55 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime@cerno.tech>,
 =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH v2 01/52] ASoC: dt-bindings: Add WM8978 Binding
Date: Wed,  1 Sep 2021 11:18:01 +0200
Message-Id: <20210901091852.479202-2-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901091852.479202-1-maxime@cerno.tech>
References: <20210901091852.479202-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Even though we had the wm8978 driver for some time and a number of
boards using it already, we never had a binding for it. Let's add it
based on what the driver expects and the boards are providing.

Cc: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v1:
  - Changed the maintainers of the bindings
---
 .../devicetree/bindings/sound/wlf,wm8978.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8978.yaml

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8978.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8978.yaml
new file mode 100644
index 000000000000..944e5859c962
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8978.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8978.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8978 Codec Device Tree Bindings
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  '#sound-dai-cells':
+    const: 0
+
+  compatible:
+    const: wlf,wm8978
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 526000
+
+required:
+  - '#sound-dai-cells'
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@0 {
+            #sound-dai-cells = <0>;
+            compatible = "wlf,wm8978";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+        };
+    };
+
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@0 {
+            #sound-dai-cells = <0>;
+            compatible = "wlf,wm8978";
+            reg = <0>;
+        };
+    };
+
+...
-- 
2.31.1

