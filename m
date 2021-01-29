Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD3C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:45:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D1664E7C
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D1664E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4C9716B8;
	Fri, 29 Jan 2021 12:44:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4C9716B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611920702;
	bh=9yNvczujMbAHZ+LztQHdstL/bOaWoRxaZttkKyG/moc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJg4q8f2cjYxGcqkm5qQWxfIlQtW7rh1noTJZrjQTqkaXIUDDXQ7FjJkdhOFau5Ul
	 FL54+cufGrarXJ2uJEOfrBDPCzFMv3Ey4t1CVjplnGdExabHlR9H/m0nqj51rMfpwo
	 L0WcpRSWvznKJk9f9JIlwYZdFHGrizcbip9jFjNw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 257F0F804D6;
	Fri, 29 Jan 2021 12:42:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 930BEF804E3; Fri, 29 Jan 2021 12:42:02 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 258D7F804D6
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 12:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 258D7F804D6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="H+oksgcK"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6013f4850002>; Fri, 29 Jan 2021 03:41:57 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Jan
 2021 11:41:56 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 29 Jan 2021 11:41:53 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <thierry.reding@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH 5/8] arm64: tegra: Add RT5658 device entry
Date: Fri, 29 Jan 2021 17:11:07 +0530
Message-ID: <1611920470-24225-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611920517; bh=kUDuAR+PUTUVvEzciIgYIxo2Rqb7F6D5EW+M6G9chIs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=H+oksgcKtd7uFGJjsUm0af5bre33QJBrYdi5TLzpsg4JVtmEfOqjMgs6ilSOV1wE7
 zMzH49kdrfzgEEXURXyQa4Qmiqoh5UbHpxzdtL9COj6Zx4YDik18Lza/ozQfvRoU9G
 IMo+4NZc9yFwfiQO84V6ffkmoeUgWAwcuF2LR1JLhZCNJ8lUgYoXprb99b6IRFGQTc
 UK0KNM6awEPcklRqQRwBi635YE32421XgApmt/crOZvgD2LA/ixdVSGXonKtjCiRKA
 q3Gno73xzmUnW6zH/YbKsmaednJlAMswKjVDb61e8sHbnfORKW9gipqs1F4z+aJaxT
 d/kbgx+iTdVUQ==
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

Jetson AGX Xavier has an on-board audio codec whicn is connected to
Tegra I2S1 interface. Hence add corresponding device node for the
audio codec.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 8697927..36f19c9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -41,6 +41,21 @@
 			status = "okay";
 		};
 
+		i2c@c250000 {
+			status = "okay";
+
+			rt5658: audio-codec@1a {
+				status = "okay";
+
+				compatible = "realtek,rt5658";
+				reg = <0x1a>;
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA194_MAIN_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
+				realtek,jd-src = <2>;
+				sound-name-prefix = "CVB-RT";
+			};
+		};
+
 		/* SDMMC1 (SD/MMC) */
 		mmc@3400000 {
 			status = "okay";
-- 
2.7.4

