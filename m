Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:43:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286CC64E06
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286CC64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 916BF16C0;
	Fri, 29 Jan 2021 12:42:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 916BF16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611920619;
	bh=klxT2hmc/eg8LavDlqrmh3FQWw+ug2p3vjdHa9EbHnw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BrGTLCaTwXO5IKQQ/qpNZShVHcjk9ztVQnBLC7rSSIxaCXB6hlwzjl1/g4eOFiDBb
	 KoBZNZpv91yCNGIAM/xgEM+Q3IddwwCbwz2LRqTaCtj0UohKxlnYA56kRDHAB6xzn0
	 uyp16TiIv2fWtoW+Q4IyAD6z6tIKy3MgF17kma6w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AA41F804CC;
	Fri, 29 Jan 2021 12:41:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D54C4F804C2; Fri, 29 Jan 2021 12:41:54 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B56AF80259
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 12:41:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B56AF80259
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="XjCbFejC"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6013f4790000>; Fri, 29 Jan 2021 03:41:45 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Jan
 2021 11:41:44 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 29 Jan 2021 11:41:41 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <thierry.reding@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH 2/8] ASoC: dt-bindings: tegra: Add iommus property to Tegra
 graph card
Date: Fri, 29 Jan 2021 17:11:04 +0530
Message-ID: <1611920470-24225-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611920505; bh=SLGxbjmqkghCiCzoXbOehlvqpU26zswcFn4UUR9CvHU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=XjCbFejCoKNC+3EUGaTx97S2uj3zDrtG3cSuwdR4k0hFpYOW1cHrim2oyMdEsBPpi
 abRxQPkIH+knebAGHOcuc3786svuWY32DSB7KRaNFdmT9hbq7pGMYcs0uZ4bXpTYfd
 1yiUwFPljoV6O8tzZbKY7Yg5XoRvqC04XjHnVqIpySXs5iqxsWlk3rD5YvOg5C8RF5
 eakdFwr/EdAF2zyZnpbSStGEk6y089etCbaJIn0sVSw9y/Y5U11eRopvAIdf9HGDcC
 8Ot8n/c8GsyQWCWHN6flx4bEHGZlD+MEhJqPFkqexbAvPQ4G7F2bpJEWpIhWS19EqL
 K8EogrmD8rggQ==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Sameer Pujar <spujar@nvidia.com>,
 jonathanh@nvidia.com, sharadg@nvidia.com, linux-tegra@vger.kernel.org
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

Document 'iommus' property for APE (Audio Processing Engine) sound
card.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
index fc271f6..2499709 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
@@ -45,6 +45,9 @@ properties:
     minItems: 1
     maxItems: 3
 
+  iommus:
+    maxItems: 1
+
 required:
   - clocks
   - clock-names
-- 
2.7.4

