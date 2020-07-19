Return-Path: <SRS0=8d/u=A6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421DC433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:08:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA86207EA
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MXTKyLFo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nda5lJUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA86207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD39816A3;
	Sun, 19 Jul 2020 07:08:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD39816A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595135336;
	bh=nIMGpqXXWKV9TkR+/FLfVnvqgbRTDEIh/3MRcAtPFqg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXTKyLFouWrbWmjWShgMkec/oogA/K5kdAcAzuBjuseyraeWSucpzp9+jOUMlpaZH
	 vB8T6FhxETVKyjXq+fjCu1QZcEdnACTgk00TwBcOG0+wxzWgtYT2roWP12Z8uwHqf7
	 oAPty0TClLVP5HczKHglKjidt9AT49WdSHez9DDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C89FF80341;
	Sun, 19 Jul 2020 07:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07DEEF80328; Sun, 19 Jul 2020 07:02:34 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A7C2F80328
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 07:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A7C2F80328
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="nda5lJUh"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f13d3a90000>; Sat, 18 Jul 2020 22:01:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 18 Jul 2020 22:02:29 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:02:29 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:02:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:02:29 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f13d3e00000>; Sat, 18 Jul 2020 22:02:29 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH v5 09/11] arm64: defconfig: Build ADMA and ACONNECT driver
Date: Sun, 19 Jul 2020 10:31:28 +0530
Message-ID: <1595134890-16470-10-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1595134889; bh=ib3U7Vm7ufz0JpNg27la6nszO6b1ud/ZdmXtMNpwaT8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=nda5lJUhcb0XM4EQwtgUbuzVqjAZ1YrrPogJheDGfpUyw7jC5+ie7KegDewf8xFoD
 XnnzsvV8Qp4VuvBB65VzF7m/Esd4S8fFM6YPjgrI0qM7I3JtD7Gqozp4fW1fehD+RA
 vF+qYwbuApWyB21JYSxiBFAXmv3CFIhccEukOsAGn+xyQqL22A7ZXbCFvyWDSTbgHs
 yAzBT9OwvZUZzaz/N7AveMdiJgSuc2F7RDq6T1ex89kVJfOutGGTBWs/1zS8bBZVax
 NHAoS8bQjYfdESi1g8SpJp5uB4yJNQ/ylc3UU6omwOoK/dgfkZNURzJYhjJIX4ukPq
 Ys7D7tXCVUg4g==
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 Sameer Pujar <spujar@nvidia.com>, nwartikar@nvidia.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, thierry.reding@gmail.com, atalambedu@nvidia.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
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

This commit builds ADMA and ACONNECT drivers which can be used on
Tegra210 and later platforms to transfer audio data to/from AHUB
(Audio Hub).

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4976e1a..7bc093a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -219,6 +219,7 @@ CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_FSL_MC_BUS=y
+CONFIG_TEGRA_ACONNECT=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -788,6 +789,7 @@ CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-- 
2.7.4

