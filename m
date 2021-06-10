Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F9BC47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 15:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9663613DD
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9663613DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A82E17B8;
	Thu, 10 Jun 2021 17:01:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A82E17B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623337364;
	bh=8uKiJUbDLO2OHYYJrCmbZOx/bGF+9PGRLeM3yGzn1gI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gYtsBrwW/Fp0SgXBu9mG5TPGrFKY7ijYdg62zYrZd2oDwO4voPG+AFetDB78dKhXz
	 t9X7xnB2gwj2gVEbR9LkVlVzoPru/eCY0R+oVTr4h7q4f70snbvL8UGndDI7z4ijC2
	 qaTKGjCUigDEyrmakP7W8shupTqHlkV5RVKjEw0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4460F8020D;
	Thu, 10 Jun 2021 17:01:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 443D0F80218; Thu, 10 Jun 2021 17:01:52 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B026F80149
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 17:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B026F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="Wt3D6iMS"
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5657582CBE;
 Thu, 10 Jun 2021 17:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1623337300;
 bh=z8vyksDbi1Tg8yhCTQ0kxHad7PfZiGsU5cOSq5Q8QN4=;
 h=From:To:Cc:Subject:Date:From;
 b=Wt3D6iMSxdyRtQPHvQCGWMjf23s67ho2KTKl2ZjQlwJ7Itrrv6T5eNUe1hfzmgHcU
 58d4DZQsdwLa2dZC+S6/r+UjuiYxZNj8twV3EVu5Z4yil3y38LqNxHGLIIvBQWU9iE
 yFo4YOIbBRJKZryVd0NwYLWl2Lo2o51jchavbBcMN2fyk4X0grDUcno23NKhem6PDd
 GYIw46O9dTH7qRacvcyeG1tAd6jrBe//R+FY9LaYj17A8ZHf1GFUPxWBnVwPB5aKxd
 +p/5HtVdxVH8KJLYfYpIf77tOSP6WPrUL3+HIBg8ZU0uWfvevBIMkfjP4dQIyBjc7y
 5KD3NjbZf7HqA==
From: Marek Vasut <marex@denx.de>
To: devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: ASoC: sgtl5000: Add audio-graph-card port
Date: Thu, 10 Jun 2021 17:01:35 +0200
Message-Id: <20210610150135.29905-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 kernel@dh-electronics.com, Fabio Estevam <festevam@gmail.com>
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

The SGTL5000 codec can be connected via audio-graph-card,
add the missing port: entry into the bindings.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: kernel@dh-electronics.com
Cc: alsa-devel@alsa-project.org
To: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/sound/sgtl5000.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
index 70b4a8831073..e762c320b574 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -75,6 +75,10 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/uint32"
     enum: [ 0, 1, 2, 3 ]
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
-- 
2.30.2

