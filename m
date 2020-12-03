Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B1C4743B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:46:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA28A22588
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA28A22588
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1553C183C;
	Thu,  3 Dec 2020 15:38:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1553C183C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607006350;
	bh=T8Caerc1UfqfbAAoh0bZBJsJ1dpxHPluarQEr0v6mSo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXZX1n+IfrpYabgietWxZF5RP1B655JLtMIyI0SfFOljwK37cDfF8H8l8Zih3sBa9
	 aCQQN86iE53ukk/eDzn41jTO7AvNKgi6RfueFgZwxcZYrrQ7UFfcBbVGMQ7UocIOnI
	 qCUUtESTOwj+p7F1KWl+KRSJkr9JalzrABgFQE78=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27467F804CB;
	Thu,  3 Dec 2020 15:37:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59830F8049C; Thu,  3 Dec 2020 15:37:20 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CD4CF80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:37:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CD4CF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Tfos+hhJ"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fc8f8180000>; Thu, 03 Dec 2020 06:37:12 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 14:37:12 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 14:37:09 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>
Subject: [RESEND PATCH 2/2] dt-bindings: tegra: Add missing HDA properties
Date: Thu, 3 Dec 2020 20:06:42 +0530
Message-ID: <1607006202-4078-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
References: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607006233; bh=g6WzfzkxGm1Rrc/PS9d7uqmNnF/hATJUD1WCAcXHzoM=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=Tfos+hhJHgh0rYjVrV1rICsz26cXfcJkUaYsainhd0eKTUusozVeab44byRra9Gye
 0saLefVWfVzpUXL52/xeuQEutL/PL84MU3YjAhIod+/DgHYgJqZsIwBvO/6VnqTM3o
 +EFtgD2Gp2ZujFXFGJ/F3Q272D1z6QG0ews1sGWWTawzVEPfRicgZsGvCiNdCfJUL2
 7IoNuKNvzix+re22XyuFc7f2sMfOGh1XIlwt+qSuwtEeH1sXCt7iVoenD7UUfFyUGE
 E1YI+BVNxCPKG2kxq1pVflES3c7A34vagADJLqvxJr3YBq9v8KXEcovuK/KU34dZJ+
 9YZyX1G9Qkfkg==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, sharadg@nvidia.com
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

Document the missing properties which are currently required for
Tegra186/Tegra194 DT files.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
index 3059bc3..e543a61 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
@@ -60,6 +60,20 @@ properties:
       - const: hda2hdmi
       - const: hda2codec_2x
 
+  power-domains:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  iommus:
+    maxItems: 1
+
   nvidia,model:
     $ref: /schemas/types.yaml#/definitions/string
     description: |
-- 
2.7.4

