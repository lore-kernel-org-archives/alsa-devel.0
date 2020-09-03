Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005DC2D0A7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:45:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8B32071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jlXq027+";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="unymFlAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8B32071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 801CD1AD4;
	Thu,  3 Sep 2020 22:44:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 801CD1AD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165916;
	bh=jQf1YvOOi6qqOrdkJa0hlJPeE/VEjcP4wOVbLqeX3js=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jlXq027+xDAWQjvUIw+ASkP23nAicj5Uw8QHanCWiqR1Wvv9/AKiaCOjgY7e2WQHh
	 9nQmWgkOpY/59Re1/k4C+GtOmMtFl5HTl8NNbMDdC1j5/N6frthR9Lm2UAJA1rrYsZ
	 9RBGBelj8BweKcuhmTDB+XVF436eJfFw14dl71mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63605F80385;
	Thu,  3 Sep 2020 22:33:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4909CF802E1; Thu,  3 Sep 2020 22:33:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03055F802D2
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03055F802D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="unymFlAv"
Received: from localhost.localdomain (unknown [194.230.155.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 845F120684;
 Thu,  3 Sep 2020 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599165189;
 bh=jQf1YvOOi6qqOrdkJa0hlJPeE/VEjcP4wOVbLqeX3js=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=unymFlAvsxJBHZVuoj7ah2m390fM5UKAcnYHWW0rts3GWScaOIKpbm2URLteZPJUJ
 WRns507l8M+gsoxxfUDPPoUvtH2rv/h8ExKajWoGGjthpBUZ8FzcXz68IZs86uDZs+
 z1Cbyp/c1zl3H9L9ySoci4NKJTxtpnBjlWigdCGE=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] ASoC: samsung-i2s: Add missing properties
Date: Thu,  3 Sep 2020 22:32:48 +0200
Message-Id: <20200903203250.19830-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903203250.19830-1-krzk@kernel.org>
References: <20200903203250.19830-1-krzk@kernel.org>
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

Usage of "unevaluatedProperties: false" is not correct as it suppresses
warnings about all undocumented properties.  Instead, add all missing
properties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fixup for:
https://lore.kernel.org/linux-samsung-soc/20200829142501.31478-6-krzk@kernel.org/T/#m7476a34a33a443d05d2f05988e43d6a34c6fb227
---
 .../devicetree/bindings/sound/samsung-i2s.yaml  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 16dc81288115..2e3628ef48df 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -41,6 +41,12 @@ properties:
       - samsung,exynos7-i2s
       - samsung,exynos7-i2s1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -58,6 +64,9 @@ properties:
           - const: rx
           - const: tx-sec
 
+  assigned-clock-parents: true
+  assigned-clocks: true
+
   clocks:
     minItems: 1
     maxItems: 3
@@ -92,6 +101,9 @@ properties:
           - const: i2s_cdclk2
     description: Names of the CDCLK I2S output clocks.
 
+  interrupts:
+    maxItems: 1
+
   samsung,idma-addr:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -104,6 +116,9 @@ properties:
   pinctrl-names:
     const: default
 
+  power-domains:
+    maxItems: 1
+
   "#sound-dai-cells":
     const: 1
 
@@ -115,7 +130,7 @@ required:
   - clocks
   - clock-names
 
-unevaluatedProperties: false
+additionalProperties: false
 
 examples:
   - |
-- 
2.17.1

