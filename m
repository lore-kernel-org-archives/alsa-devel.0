Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC806C10F1B
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Dec 2022 08:29:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 749157097;
	Tue, 27 Dec 2022 09:28:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 749157097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672129776;
	bh=g8i31QJOt7maRA42zoQ1xufh5/MjSgMZd+De23wm6Vg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RejxdDWfPYRgTN6Ek8+FO1RSTR8RhhcolYrqcuw5uucUhg/b2DEG4uU8TGRjoi/6Y
	 Cic7mPFtx3uy3AVfy4BtChEz1zV+6u5TyQiLjG6K6+DCdyXFMoCJHB64BAZkCacGL5
	 oJbYmurZ8+i+w+ldbiRaWua68YzDPr3xPLQXYMJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F10B8F80534;
	Tue, 27 Dec 2022 09:27:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 965A5F804B4; Tue, 27 Dec 2022 09:27:52 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C4A3F800F0
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2022 09:27:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C4A3F800F0
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=rRrb+mfa
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BR8Rmti017638;
 Tue, 27 Dec 2022 02:27:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1672129668;
 bh=oMJ4FPeMkZnO6YuQT5Qyr7UmQmMUx1pUdxiAyBoQDfQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rRrb+mfafPGIxrDgux44h1sRO+J/KluWspMM+xkOGt+16E6nia87GfNVcdIZvJ5U3
 wZcaFvB9svy9vgwK+/rQn1YNZqrpiRDbN+/hplaytS+7HSPanb2QgiFl/aWnlU8+Sj
 thhcSUjp4V1A307m7M7vvqedSnRBNdFXELwt2cmA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BR8RlM5049793
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Dec 2022 02:27:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 02:27:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 02:27:47 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BR8RkUA037782;
 Tue, 27 Dec 2022 02:27:47 -0600
From: Jai Luthra <j-luthra@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: sound: tlv320aic3x: Add optional clock
 and port properties
Date: Tue, 27 Dec 2022 13:57:17 +0530
Message-ID: <20221227082717.29561-3-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221227082717.29561-1-j-luthra@ti.com>
References: <20221227082717.29561-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jai Luthra <j-luthra@ti.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Describe optional properties for clocks and ports that were missing in
the original txt binding, to fix warnings like:

aic33@18: 'assigned-clock-parents', 'assigned-clock-rates',
	'assigned-clocks' do not match any of the regexes:
	'pinctrl-[0-9]+'
	arch/arm/boot/dts/omap2420-n810.dtb

tlv320aic3106@1b: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-sl50.dtb

codec@18: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
index f0375bbf4c40..2f9fc76bba55 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
@@ -110,6 +110,12 @@ properties:
   '#sound-dai-cells':
     const: 0
 
+  clocks: true
+
+  port:
+    description: For DAI connection when the codec is used via graph card
+    type: object
+
 required:
   - compatible
   - reg
-- 
2.17.1

