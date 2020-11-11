Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5942EC5517A
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:29:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383C320809
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CQ4bWCZi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O4Qz5W7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383C320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C4C116D3;
	Wed, 11 Nov 2020 13:28:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C4C116D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605097749;
	bh=DJmguHJxfToV/kdC7rj60yOyIoypj4dbeiz1UKvtjI4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CQ4bWCZiVUnDy1sletG91Jv1pNnIQlufXUc91PZfyJ4sYukcZbL0WPUJrlQFY7qY3
	 Pa/l/eFRYaA3HWv3QjA0Pa5MUg7Nfv5hBc7njL+zrLRW5rpnczFtBiV4wVON7I7MaH
	 BFCsJpZYjV9doCWoZjR/dlfk6dvFJPzSohCTSscs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF514F80290;
	Wed, 11 Nov 2020 13:27:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53785F80290; Wed, 11 Nov 2020 13:27:25 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0851BF801F5
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 13:27:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0851BF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="O4Qz5W7D"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fabd89d0001>; Wed, 11 Nov 2020 04:27:09 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:27:14 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:27:11 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: renesas,rsnd: Update audio graph references
Date: Wed, 11 Nov 2020 17:56:53 +0530
Message-ID: <1605097613-25301-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605097629; bh=eVDvBYPuDeWHrQDKtdmXcW5F5gglOSR4F/k9ksEl7j0=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=O4Qz5W7DhbuSZVZy+sTYm1ktW8XicISRp2huyTrfApNfq+i2f59tn6eKE7aEX9kvO
 gdzH+FJKLIiHSD9QHJIXKkmH2fayOkyGtsBwfhUeTo/zIwOjJhsq7NSxZlEnB8sdzU
 l1Gx+NranvrEn+hGlIewfnWjg8QTUrdwXwz+OQORS/cyHj0qr/JAtcY5753j9rKiVM
 45NsRLcSb4DgfcvQrfSAfeIOmgFODz6HetQh1AdCKrwUwJAZwY13mRlxFDvlfDQgd4
 5p7XUQbG6GZKCVFI7G7F29cOsN7mdDiJJDJcYqHUQe9nik9QLXqEDA0KOPupmR/8dm
 jaayB/XkRlgnw==
Cc: Sameer Pujar <spujar@nvidia.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kuninori.morimoto.gx@renesas.com
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

Since audio graph schema is refactored now update the related
references here.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 51f4dca..fc2ae22 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -112,12 +112,10 @@ properties:
         - pattern: '^clk_(a|b|c|i)$'
 
   port:
-    description: OF-Graph subnode
-    $ref: "audio-graph-card.yaml#/properties/port"
+    $ref: /schemas/sound/audio-graph.yaml#/properties/port
 
   ports:
-    description: multi OF-Graph subnode
-    $ref: "audio-graph-card.yaml#/properties/ports"
+    $ref: /schemas/graph.yaml#/properties/ports
 
 # use patternProperties to avoid naming "xxx,yyy" issue
 patternProperties:
-- 
2.7.4

