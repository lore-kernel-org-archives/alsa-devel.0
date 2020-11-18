Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281AC63697
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 08:08:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBB121D7A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 08:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TVQpSLM+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jz8pZt0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBB121D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3216416BF;
	Wed, 18 Nov 2020 09:07:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3216416BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605686924;
	bh=2SgWWwDvv44DiI6rNvGMwIqmxgDg0cOwSZP17jgBE1M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVQpSLM+SIqooqdS+/gYAx0d0kIAK1vKHah/HfO3cATU2Gxcbkx7TuBLyh/27bLl4
	 Fw78VqRM3Eb4ZRnd/TJotG8zpBUi8COLFnknXKpBWhRJqjTpQSSvq78i0yH1JfKZm0
	 /oof7wQe60cQwnJrf+Aici5o5sZMer/j4/nvCGLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1793BF804B1;
	Wed, 18 Nov 2020 09:07:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E03EF804BC; Wed, 18 Nov 2020 09:07:00 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06920F80158
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 09:06:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06920F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="jz8pZt0U"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fb4d6120000>; Wed, 18 Nov 2020 00:06:42 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 08:06:37 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 08:06:34 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>
Subject: [PATCH 1/3] arm64: tegra: Fix Tegra194 HDA {clock,
 reset}-names ordering
Date: Wed, 18 Nov 2020 13:36:20 +0530
Message-ID: <1605686782-29469-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
References: <1605686782-29469-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605686802; bh=5+i2Us2XoqokmBo59PMW/PDmxf9BY2baahXD2ObGdOo=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=jz8pZt0UlfYGjujrBtGkxBbEEcPt2tA0RLOS2IHsfP/36DUM6itDIISeaDpiIzZsh
 iu/cO1UCMBYgPXkdaTeE8kAzSLDa27GzJ9irjBiifR+l4F+JDE7BZx+PysUkEuUb6V
 D3IuoCnrKUdTjYQVQVSeT+haQRs1DZ/8goBTHAXESWt1Ah4fftSIESeGWA/zd523Gt
 wYno5mAUsUSavI1nT4XCHDp94INKCLXNx6wePDJsfvYdD4k6MCmUU3n9O2ZfAXUqCq
 KWoIz0BZ7m5T+59uJJMn34UVST/JrcTSCYCRQUTdUha53kKOftv26annTWuPp5xhqN
 7RNwPa6LtAS0A==
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

As per the HDA binding doc reorder {clock,reset}-names entries for
Tegra194. This also serves as a preparation for converting existing
binding doc to json-schema.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6946fb2..e3cab26 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -782,13 +782,13 @@
 			reg = <0x3510000 0x10000>;
 			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_HDA>,
-				 <&bpmp TEGRA194_CLK_HDA2CODEC_2X>,
-				 <&bpmp TEGRA194_CLK_HDA2HDMICODEC>;
-			clock-names = "hda", "hda2codec_2x", "hda2hdmi";
+				 <&bpmp TEGRA194_CLK_HDA2HDMICODEC>,
+				 <&bpmp TEGRA194_CLK_HDA2CODEC_2X>;
+			clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 			resets = <&bpmp TEGRA194_RESET_HDA>,
-				 <&bpmp TEGRA194_RESET_HDA2CODEC_2X>,
-				 <&bpmp TEGRA194_RESET_HDA2HDMICODEC>;
-			reset-names = "hda", "hda2codec_2x", "hda2hdmi";
+				 <&bpmp TEGRA194_RESET_HDA2HDMICODEC>,
+				 <&bpmp TEGRA194_RESET_HDA2CODEC_2X>;
+			reset-names = "hda", "hda2hdmi", "hda2codec_2x";
 			power-domains = <&bpmp TEGRA194_POWER_DOMAIN_DISP>;
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_HDAR &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_HDAW &emc>;
-- 
2.7.4

