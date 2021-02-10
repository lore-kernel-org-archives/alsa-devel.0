Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E8C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 06:45:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3F564E56
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 06:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3F564E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5891516D4;
	Wed, 10 Feb 2021 07:44:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5891516D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612939549;
	bh=jnYUYcBzXZK/l15+08ZJgRLCGySC4lsQtVEgyqH1CEE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTybf43FIW858VhX6CVE3WQIMv3KTA9yEn2PDFbiTpzYhz/ghR1HFFmCt3tx5hZzx
	 Brw/NLOFn/fzXq8uuiMTn6ZHL1aMleBIqRHN/ZYsiIjw8P8pKgtWMhQnamo8U6Mewh
	 95HgYWthr4iB+uABmb+Lw/0nGGzTO9rqyouNROhY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B75B7F8027C;
	Wed, 10 Feb 2021 07:44:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE14DF8027C; Wed, 10 Feb 2021 07:44:11 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09877F80165
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 07:44:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09877F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Po03+tEk"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602380b20001>; Tue, 09 Feb 2021 22:44:02 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:44:01 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 06:43:58 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <thierry.reding@gmail.com>
Subject: [PATCH 2/3] Revert "ASoC: audio-graph-card: Add clocks property to
 endpoint node"
Date: Wed, 10 Feb 2021 12:13:40 +0530
Message-ID: <1612939421-19900-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
References: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612939442; bh=tzAzf8RJ+CVI9/B1xW0MIz+DLI3Y9TUl532PL8g/3LU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=Po03+tEk+TumFL6jxcGAjjy1sD6AXOtgREaHlkD9iQzMcCYL3olEStVFzBj2ZBLZA
 nukvzyeIRn8iye9BPjTzOOBWnAEOyBoLQJl4xJ1UsymRmXRMP/tARasbViCkZN1fcw
 Qdha9xGj3zQW9UTsUtWzoZIzL5Usl2UUtJDB4LXXGaAP14lp6adUA19BZB2Gx+3kth
 WgJZ0Q12VIHfU53NEL+wIGS7rq/pHqCFjRGwp2JDnbr/8otyLt7JVXj8MgwPgYMVmn
 7AXUFJyzlSoKk9QuePjA3xvSdsVFsf2K1qWgDgN3Nw8WsT2LeBdGgBjCrLeQCbzOkf
 I1txY1/K+BV6Q==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org
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

An endpoint is not a device and it is recommended to use clocks property
in the device node. Hence reverting the original change.

Fixes: 531e5b7abbde ("ASoC: audio-graph-card: Add clocks property to endpoint node")
Suggested-by: Rob Herring <robh@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 08ed8f5..766e910 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -33,9 +33,6 @@ properties:
         properties:
           remote-endpoint:
             maxItems: 1
-          clocks:
-            maxItems: 1
-            description: Describes the clock used by audio component.
           mclk-fs:
             description: |
               Multiplication factor between stream rate and codec mclk.
-- 
2.7.4

