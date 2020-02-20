Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C888C34031
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:43:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D869E24654
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DJJHpdhZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RgF3bCcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869E24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45A8B169E;
	Thu, 20 Feb 2020 07:42:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45A8B169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582180982;
	bh=9cg57s8X4yNuqG9C1HAdd9kbpsiosZQMRWaYsmmoE6E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DJJHpdhZ40VF2ptqYJwSD9W3v/olflpL6S33XliDMTJ6BkN06lE7GXpoidlet5LXj
	 bYAbdRAg2n1igq+7bJob38Z094zFEAi1d144lARc9x8Ezv3jtf3/aFNmnN/NFHKaWk
	 Fy89VoFJvxMH3SqzbpH/pfUhlO3lJvItmPpCCtr0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61290F80323;
	Thu, 20 Feb 2020 07:36:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E526BF80321; Thu, 20 Feb 2020 07:36:19 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5992F80317
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 07:36:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5992F80317
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="RgF3bCcX"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4e28ce0001>; Wed, 19 Feb 2020 22:35:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 19 Feb 2020 22:36:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 19 Feb 2020 22:36:12 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 06:36:12 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Thu, 20 Feb 2020 06:36:11 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by
 rnnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5e4e28d60000>; Wed, 19 Feb 2020 22:36:11 -0800
From: Sameer Pujar <spujar@nvidia.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
Subject: [PATCH v3 10/10] arm64: defconfig: enable AHUB components for
 Tegra210 and later
Date: Thu, 20 Feb 2020 12:04:52 +0530
Message-ID: <1582180492-25297-11-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582180558; bh=E9DzQMAbRg2eoGCLKlLTo06DuBeRfwIPGwm49Ly8E/E=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type;
 b=RgF3bCcXcKViuMmb6BnQPvotg3IIGX2wNZTXNmg0ChGHs0O3iPy1MsUOd8VP6YCqV
 Gfxj3l1jya3EvB05CFY3UA44x7pKpbiZASuJ1NHySG3GwCUwasuI5/DQU0tQkxSufm
 xmA+We/Hx7CnBFhwtztm6GbqxQR4p8BrTN1//DSXdr+w7cK44pBXmOU/bdm8oafpIh
 je1P0IyrSXbC393U+quiAp+yRow0nemE+T8VO7DwfFPRnmIJlM85gYjAuxYWhPdzD5
 di8+ARNGuHs3VLUFcrNYBIqVPAQptdQ5AaYLz2FoAfkvRHvwvHHFJddls0/5Aynled
 qyvr8lh3vydlA==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
 Sameer Pujar <spujar@nvidia.com>, lgirdwood@gmail.com, jonathanh@nvidia.com,
 viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

This patch enables following configs:
 +CONFIG_TEGRA_ACONNECT=m
 +CONFIG_SND_SOC_TEGRA=m
 +CONFIG_SND_SOC_TEGRA210_AHUB=m
 +CONFIG_SND_SOC_TEGRA210_DMIC=m
 +CONFIG_SND_SOC_TEGRA210_I2S=m
 +CONFIG_SND_SOC_TEGRA186_DSPK=m
 +CONFIG_SND_SOC_TEGRA210_ADMAIF=m

This patch helps to register AHUB and its clients (I2S, DMIC, DSPK, ADMAIF)
with ASoC core. Since AHUB is child of ACONNECT, config TEGRA_ACONNECT is
enabled as well.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8801be..784ca4f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -207,6 +207,7 @@ CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_TEGRA_ACONNECT=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_RAW_NAND=y
@@ -590,6 +591,12 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SUN4I_SPDIF=m
+CONFIG_SND_SOC_TEGRA=m
+CONFIG_SND_SOC_TEGRA210_AHUB=m
+CONFIG_SND_SOC_TEGRA210_DMIC=m
+CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA186_DSPK=m
+CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.7.4

