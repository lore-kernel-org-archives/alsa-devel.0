Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C2C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 05:44:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7194122517
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 05:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7194122517
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DED56177A;
	Mon, 18 Jan 2021 06:43:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DED56177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610948658;
	bh=AnHzJPjtBQ5MWsrKAvuFGKy6O/3lWY/FmGU10befUzU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DesdUcWa6ikwufcEDdNyv8/ghwrGPu6ZKWHU3R3Zeqw4L8m+17BxytyAWd2ivpVjc
	 /ZbdgHq+fOydXDun/DC0SvzR+FNg6AE0vuQeZMAAs1tEsutXRgChRxE3l9dkKIjEpY
	 /m0pEPLC77MFWWDWelUclrCT7yXZK4ehy711/ZB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39ABBF80166;
	Mon, 18 Jan 2021 06:43:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6352CF80137; Mon, 18 Jan 2021 06:43:24 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2716F80137
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 06:43:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2716F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Y7fcaI/V"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60051fef0000>; Sun, 17 Jan 2021 21:43:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 05:43:11 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 18 Jan 2021 05:43:08 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <broonie@kernel.org>
Subject: [RESEND PATCH] ASoC: audio-graph-card: Drop remote-endpoint as
 required property
Date: Mon, 18 Jan 2021 11:13:05 +0530
Message-ID: <1610948585-16286-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610948591; bh=z5xavFenRoKMKPK0qwGJtQP0fdSh62QlRJgN6qV4K8w=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=Y7fcaI/VN5m+uJOx/l6EHovzNU+Geqx+7pa7ROXrfbtlnKN9zDaY5iGjMOoJuzdx5
 7lTghFQNTzwPuLbS1jPPX1WCiFI6anNPTI8Eau+6L3opb2+M0EkJUsPZw1UUG//PKC
 +gdyQ0FwNtlxz+oD1W1NYtNH2r/u4oy9LbT3SCDG3Eynhx67/2Sc0FvGxQXeodMv5s
 fC2aIoQkFAheuRdd/39lwAYTxTttkjPuoxRsoqUsivLZhpr9xg+ehOehXq2CmKCuDr
 C0RFmndOnX+Dkc/BBHXUSPQSe2g3INSKCld9pQgMoP0lkJnBJ4LeaZQ972HvdpgtXw
 Vof/9xALgHULQ==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Rob Herring <robh@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com
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

The remote-endpoint may not be available if it is part of some
pluggable module. One such example would be an audio card, the
Codec endpoint will not be available until it is plugged in.
Hence drop 'remote-endpoint' as a required property.

Cc: Rob Herring <robh@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 2005014..766e910 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -71,9 +71,6 @@ properties:
             description: CPU to Codec rate channels.
             $ref: /schemas/types.yaml#/definitions/uint32
 
-        required:
-          - remote-endpoint
-
   ports:
     description: multi OF-Graph subnode
     type: object
-- 
2.7.4

