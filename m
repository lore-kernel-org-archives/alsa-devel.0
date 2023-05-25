Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A3C7EE29
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 18:34:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E72D209;
	Thu, 25 May 2023 20:34:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E72D209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685039690;
	bh=ff1S6i4jLOfLLDr5CzWF6ooM3A4D2S7c6EccFUBVNa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZThKYb2JS7tFbtSBubDmLmh0NMJZh7ooR9h4lFpmTXvhZIYUknQQI7ChFUeBr02GL
	 bmmfIGdjprm1i4yKDFDoBCNlArudUgAEHlvgjkzLPr92mNAdSm80F/gEZ8Iz8vGotI
	 8ecUjdPcuYXl93Q267P9HW8rAjJWB2e3Y7A32d6k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA588F805AD; Thu, 25 May 2023 20:33:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 190AAF805A9;
	Thu, 25 May 2023 20:33:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2A73F80578; Thu, 25 May 2023 20:33:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FC07F80249
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 20:32:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FC07F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BHN+dRWR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 06E49648A3;
	Thu, 25 May 2023 18:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC15FC433A8;
	Thu, 25 May 2023 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039574;
	bh=ff1S6i4jLOfLLDr5CzWF6ooM3A4D2S7c6EccFUBVNa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHN+dRWRRRm0cEyIPNWccAMqNDy1enoI4obsz8yvVccWEZ6QI+0GJozdpT/zCLW8C
	 S/v6PwSddZyogX6qXf8MXSMIeWfnXwEfnKG6zKaVNf3WM2vtQcuqGDrl+0Pl+gZIaR
	 Wmr4CAgWxhzDa5vdyEBCnbBuS0948f8gby2r1G4zNdGBHVPMPExgU/kyUz4Xbjw2VY
	 Kkl9OyK1quKrnDKozXWykJIMmxDTf7NazM+ESF/jaRlrKu7wJRTED2PnscCYpwK9ew
	 jmnOUNg2tvsER78aOLLHKwTwTMcNHdjwgVI4YUNAtJ7NOXOf7K6j1M4Hl55BJFNanq
	 BZDjTSgZVNK6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	afd@ti.com,
	shifu0704@thundersoft.com,
	shenghao-ding@ti.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 12/67] ASoC: dt-bindings: Adjust #sound-dai-cells
 on TI's single-DAI codecs
Date: Thu, 25 May 2023 14:30:49 -0400
Message-Id: <20230525183144.1717540-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EMEKJ4XQHDPM2YSGDK5OXPYRT6QAVMGN
X-Message-ID-Hash: EMEKJ4XQHDPM2YSGDK5OXPYRT6QAVMGN
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EMEKJ4XQHDPM2YSGDK5OXPYRT6QAVMGN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Martin Povišer <povik+lin@cutebit.org>

[ Upstream commit efb2bfd7b3d210c479b9361c176d7426e5eb8663 ]

A bunch of TI's codecs have binding schemas which force #sound-dai-cells
to one despite those codecs only having a single DAI. Allow for bindings
with zero DAI cells and deprecate the former non-zero value.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org
Link: https://lore.kernel.org/r/20230509153412.62847-1-povik+lin@cutebit.org
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas2770.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas27xx.yaml | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 1085592cefccc..81218c07079a8 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -55,7 +55,9 @@ properties:
     description: TDM TX current sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -72,7 +74,7 @@ examples:
      codec: codec@4c {
        compatible = "ti,tas2562";
        reg = <0x4c>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        shutdown-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 982949ba8a4be..cdb493db47f9b 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -57,7 +57,9 @@ properties:
       - 1 # Falling edge
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -74,7 +76,7 @@ examples:
      codec: codec@41 {
        compatible = "ti,tas2770";
        reg = <0x41>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 0957dd435bb4b..2ef05aacc167a 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -50,7 +50,9 @@ properties:
     description: TDM TX voltage sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -67,7 +69,7 @@ examples:
      codec: codec@38 {
        compatible = "ti,tas2764";
        reg = <0x38>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpios = <&gpio1 15 0>;
-- 
2.39.2

