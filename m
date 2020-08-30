Return-Path: <SRS0=QqOT=CI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D46C433E6
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:07:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7160820720
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="arS/YU+I";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lniyAStp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7160820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAEB718F2;
	Sun, 30 Aug 2020 17:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAEB718F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598800044;
	bh=yMnFhXHlxippItZdgfHLbRUuY7UCY/HWezFEFtyBv5w=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=arS/YU+IchkhXUugdPLXsqO/lraUacSz7iw8fV3tX/uWoWlW2Fht3pidUfV1Fd1I+
	 ONEQfNw6y/u0ZE5QzMjDvsrfdKrdmpwr51Xhj3mF4fq0YNTtezqNR3B4aLlNXibccT
	 voD9u3u18MQL+mIgytva8pqok0gGs7tATRz33Bbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A26BF80278;
	Sun, 30 Aug 2020 17:05:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A663F802C3; Sun, 30 Aug 2020 17:05:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6F04F8028C
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2020 17:05:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6F04F8028C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lniyAStp"
Received: from localhost.localdomain (unknown [194.230.155.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 85C0D20714;
 Sun, 30 Aug 2020 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598786799;
 bh=yMnFhXHlxippItZdgfHLbRUuY7UCY/HWezFEFtyBv5w=;
 h=From:To:Subject:Date:From;
 b=lniyAStplYVHoTNln5UL2w9VIlSX2osOegi9pZOhk+UV7Kgu3WPGvFsdHJLNY9bqW
 7539o/8ImcjHRET4t+KRWbHWtVL6RS1vzgFMk5aN8M2xCC191Z/GADFg82HFmf4PDq
 8f8Z71I6b7kalIeqaQmXedkusxCzxoy3eifDrgbk=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Date: Sun, 30 Aug 2020 13:26:32 +0200
Message-Id: <20200830112633.6732-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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

The "sound-dai" property has cells therefore phandle-array should be
used, even if it is just one phandle.  This fixes dtbs_check warnings
like:

  arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0:1: missing phandle tag in 0
  arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0: [158, 0] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/sound/samsung,midas-audio.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 1c755de686f7..578928e67e5c 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -21,7 +21,8 @@ properties:
     type: object
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        maxItems: 1
         description: phandle to the I2S controller
     required:
       - sound-dai
@@ -30,7 +31,8 @@ properties:
     type: object
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        maxItems: 1
         description: phandle to the WM1811 CODEC
     required:
       - sound-dai
-- 
2.17.1

