Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2ACC3526D
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:46:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08632243F
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08632243F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B9871818;
	Thu,  3 Dec 2020 15:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B9871818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607006286;
	bh=N+dt8QdfkMUoGL2UwI1HMybuVQwwPME441F8ap8dpCg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZOobWiG9n9JUlEZrXwgOsN6aHyOuGS/j6jm7F8thD1qcKroiYrt8gFeUquP4AScN8
	 dUj7q5aPpygNBE3NOrp/VLRdR+HBX1bvynEHe0SdUH/CGTlXxEhr8n5m7UiHookppb
	 aQl6JSJ+CVOpDSqsRQhl0WaVMLWoCsRjYTHUkXFQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0958F80254;
	Thu,  3 Dec 2020 15:37:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A802F80254; Thu,  3 Dec 2020 15:37:13 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AB4EF8012A
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:37:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AB4EF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Lbr6OUW0"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fc8f80f0000>; Thu, 03 Dec 2020 06:37:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 14:37:03 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 14:37:00 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>
Subject: [RESEND PATCH 0/2] Convert Tegra HDA doc to json-schema
Date: Thu, 3 Dec 2020 20:06:40 +0530
Message-ID: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607006223; bh=oBVH1GkkdSd+6h69hwkZ2XZAHlPV4pT2Qs/l/nDYx3U=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=Lbr6OUW0wGesY0teHTXCdQB4XLfzLF45rs1G+FsTO3K4/WHVIoDcITzJJNPAnwMf/
 K9RtU+Y4j5kKW2eKChMWYnRQG2Awgav8ftJWOIuLnObj/9rUGjNM21k8gfhATvG2O3
 3Wbd7Vo0E+3qg+2hud5n421+vK18ju1SayNIN20j3wdW7ebqDuKZ7R/SyAtC52ooK2
 ARiKTR+49EQsu/vQJ0c5IpCo/P0ZlGdlO/JmVJq/zhen5IydbO4459zHxojABLOalq
 QHQ4XbBMFMRwGGcjN32y3AJohqKDkUm3c9LpFIxawOX7qsklGulUNFWpyBywEKmL9h
 TXLvAQP7su81w==
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

Convert Tegra HDA doc to YAML format. Ran binding validation checks to
ensure there are no warnings/errors for HDA.

Patch "arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering" is
already merged and hence not included here.

Sameer Pujar (2):
  dt-bindings: tegra: Convert HDA doc to json-schema
  dt-bindings: tegra: Add missing HDA properties

 .../bindings/sound/nvidia,tegra30-hda.txt          |  35 -------
 .../bindings/sound/nvidia,tegra30-hda.yaml         | 112 +++++++++++++++++++++
 2 files changed, 112 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml

-- 
2.7.4

