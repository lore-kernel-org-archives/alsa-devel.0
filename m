Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B4C2D0A8
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:44:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466CC2071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UIwvBrwU";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhMk/jlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466CC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C808B1AC1;
	Thu,  3 Sep 2020 22:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C808B1AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165850;
	bh=92uFz6sFhAh1pp3KzCm8GS1+pP7l6jA8SS2d+ieytR8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UIwvBrwU5qrvHqy1ZUrf82nxgqh8Vjn8RrY9DQkL31xPRECV8z6Zrn4hb4eKb4ZiY
	 K3d/nbPcEWTsie3BVqd3MrTKrLHQohPnj5aQJBQkcfnC19XMcvcoy3ksyITPJdetCe
	 pPnMBCNgNO0jkQy6B3a0L5oMhfg91vuwP2p1sez8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A723F802DD;
	Thu,  3 Sep 2020 22:33:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96E8DF802D2; Thu,  3 Sep 2020 22:33:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30D83F801DA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30D83F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RhMk/jlN"
Received: from localhost.localdomain (unknown [194.230.155.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80B7620658;
 Thu,  3 Sep 2020 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599165185;
 bh=92uFz6sFhAh1pp3KzCm8GS1+pP7l6jA8SS2d+ieytR8=;
 h=From:To:Subject:Date:From;
 b=RhMk/jlN1GrSCCHWwfyBk8c6vjdyZL4trcZAoUtR2Pj6c+zkByMAfdIYCwyCTNzct
 tQ8iIiltGL5PChRum0BZyNoiFKGrh5cKwjW7wcfYwm8sMwdEZS36+j83CgtJ5m5TFg
 KJpc9Qof6PAk/hkh1Om+q3zoY7MMzk+rW4BcQpK0=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/4] ASoC: odroid: Add missing properties
Date: Thu,  3 Sep 2020 22:32:47 +0200
Message-Id: <20200903203250.19830-1-krzk@kernel.org>
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

Usage of "unevaluatedProperties: false" is not correct as it suppresses
warnings about all undocumented properties.  Instead, add all missing
properties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fixup for:
https://lore.kernel.org/lkml/30b8ea43-c2d0-5ddf-dc16-a8fe80d47c38@samsung.com/
---
 .../devicetree/bindings/sound/samsung,odroid.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index de1be3d6d1e9..e8122bc87362 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -28,6 +28,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: The user-visible name of this sound complex.
 
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+  clocks: true
+
   cpu:
     type: object
     properties:
@@ -69,7 +74,7 @@ required:
   - cpu
   - codec
 
-unevaluatedProperties: false
+additionalProperties: false
 
 examples:
   - |
-- 
2.17.1

