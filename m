Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F8C63777
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 08:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3956F241A5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WE6JGHez";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="paq+oABr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3956F241A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39D6C16C8;
	Wed, 18 Nov 2020 09:07:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39D6C16C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605686919;
	bh=oFeCnU/wfsLM6687U+3lFcAAKGIuxLokldVjD/G9blw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WE6JGHezzBr6xWgNdTgHRjTlPYL6j1BKEBeT1SIHA8JsmmIk2a9ullH+OmmWKpC96
	 h8GqkKxP/lrf7iARMyYkuiuSgeTxuWjMbR8XGXITHYp+0ckaokFl0uL2zJ1suJl1Ro
	 HIUSvQwG3rrf+5Xbc92aIFNv/P03tRwQSDmSUFFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F39FF80276;
	Wed, 18 Nov 2020 09:06:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC55DF8016D; Wed, 18 Nov 2020 09:06:53 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C07ABF80168
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 09:06:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C07ABF80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="paq+oABr"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fb4d6010000>; Wed, 18 Nov 2020 00:06:25 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 08:06:34 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 08:06:31 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>
Subject: [PATCH 0/3] Convert Tegra HDA doc to json-schema
Date: Wed, 18 Nov 2020 13:36:19 +0530
Message-ID: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605686785; bh=+mKNcXPQxwCx+awvh3qmVh6msTm6zFNTg3ytvlVwQDs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=paq+oABr9TMcUz423TCs8j7XyC4Yt9wlv5Ti7x1lBF0yhDlBk6Kn/eiD/ztpuP69U
 ptNWxtVU55d8Msza0rQXrTEkjVLO/69atPL84sIUWRbommBnxLAlTlZSIj7tKeNCVe
 eNm+JBPIgxFYy8aM709yiVo8YzfNSOid06rwOEW1GPH+M6Rl36eAfDb7vTDrrnCXjt
 jl22wL3gcz/SWaeXDALvrNEkd3PoSHNEURjmz2ZOHgOchI9FQaRvnUto1xFbJ5E6rN
 8KOImO8rQ0ajuz5f86KX2PUDQ1rrp1sC4pYRVMiTHRBUxnlc86O+We6w06cds0XkN0
 8uvn/uWpmE/9w==
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

Fix Tegra194 DT and convert Tegra HDA doc to YAML format. Ran binding
validation checks to ensure there are no warnings/errors for HDA.

Sameer Pujar (3):
  arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering
  dt-bindings: tegra: Convert HDA doc to json-schema
  dt-bindings: tegra: Add missing HDA properties

 .../bindings/sound/nvidia,tegra30-hda.txt          |  35 -------
 .../bindings/sound/nvidia,tegra30-hda.yaml         | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  12 +--
 3 files changed, 118 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml

-- 
2.7.4

