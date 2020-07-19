Return-Path: <SRS0=8d/u=A6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B05C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6DE208DB
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aEKuEBDo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MP6Ox3R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6DE208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 415791682;
	Sun, 19 Jul 2020 07:10:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 415791682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595135498;
	bh=HNZ7SQ/GL1/v5TZI5e3R/i5UD8lqJ/kr3mVAVWCs2vY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aEKuEBDoT8mAOx6svNiIVpfIZS+FNNOxFi8Zt3ikhGey+aMMYwcMCvFhEAYf+U8Ry
	 meJm0SRN7wIbpaCMYp+wS1ZHmtr8VRQMPW1+xHuVhrjaRmua7C65wrJ8+1PGpHMakY
	 RcZCEOhdWf0Ice8O9LE4GZpxHhftQ11dOWsJxrIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA7B4F8015A;
	Sun, 19 Jul 2020 07:10:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0F0EF8015A; Sun, 19 Jul 2020 07:10:45 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7F6DF800C1
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 07:10:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7F6DF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="MP6Ox3R7"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f13d5c10000>; Sat, 18 Jul 2020 22:10:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sat, 18 Jul 2020 22:10:38 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sat, 18 Jul 2020 22:10:38 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:10:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:10:37 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f13d5c80000>; Sat, 18 Jul 2020 22:10:37 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH 00/10] Audio graph card updates and usage with Tegra210 audio
Date: Sun, 19 Jul 2020 10:40:07 +0530
Message-ID: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1595135425; bh=2yR3bYh9gS4d3yeOOjl6Vfl0mVOZ60aB1nO5qNxebQU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=MP6Ox3R7Sgzld54uLLNY0Fdg4C/pv1j2ajpcLwaOJka9fkvpNV16YnlamUhZEBCsZ
 4diTasDOVgf3dNIoiT75ugIrOcRwm3DYL5bT2BOo7wzKGyQcw5MaFP53hBVw8Pmwt4
 +tC0bBJedubBlOy+Pqf9ykWoUZ92W8CIPFfjtkyaVIxxqO1gHTOL6VjFFRJSKsyYAy
 zla6fTZGS2kXbe4MW/EKu2ECTpxBGlxMvl5So+2Ba31lR+6hLKw3N3kb+uA5g8eqHV
 NFCtJEk9ZXo3Bz28YpX7O5RRM85oXtjxUPPdlWyGKtf/kSLBZr9Q4GzwXkbWJsgTDt
 BDy105l+WpEDA==
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 Sameer Pujar <spujar@nvidia.com>, nwartikar@nvidia.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, thierry.reding@gmail.com, atalambedu@nvidia.com,
 linux-tegra@vger.kernel.org, rlokhande@nvidia.com, mkumard@nvidia.com,
 dramesh@nvidia.com
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

This series proposes following enhancements to audio-graph card driver.
 * Support multiple instances of a component.
 * Support Codec port with multiple endpoints.
 * Support open platforms with empty Codec endpoint.
 * Identify no-pcm DPCM DAI links which can be used in BE<->BE connections.
 * Add new compatible to support DPCM based DAI chaining.

This pushes DT support for Tegra210 based platforms which uses audio-graph
card and above enhancements.

The series is based on following references where DPCM usgae for Tegra
Audio and simple-card driver proposal were discussed.
 * https://lkml.org/lkml/2020/4/30/519 (DPCM for Tegra)
 * https://lkml.org/lkml/2020/6/27/4 (simple-card driver)

Sameer Pujar (10):
  ASoC: soc-core: Fix component name_prefix parsing
  ASoC: audio-graph: Use of_node and DAI for DPCM DAI link names
  ASoC: audio-graph: Support Codec with multiple endpoints
  ASoC: audio-graph: Support for empty end point
  ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM
  ASoC: soc-pcm: Get all BEs along DAPM path
  ASoC: dt-bindings: audio-graph-card: Support for component chaining
  ASoC: audio-graph: Add support for component chaining
  arm64: tegra: Audio graph header for Tegra210
  arm64: tegra: Audio graph sound card for Jetson Nano and TX1

 .../devicetree/bindings/sound/audio-graph-card.txt |   1 +
 .../boot/dts/nvidia/tegra210-audio-graph.dtsi      | 120 +++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 196 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 110 ++++++++++++
 include/sound/soc.h                                |   1 +
 sound/soc/generic/audio-graph-card.c               |  85 ++++++---
 sound/soc/soc-core.c                               |   3 +-
 sound/soc/soc-pcm.c                                |   3 +-
 8 files changed, 495 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi

-- 
2.7.4

