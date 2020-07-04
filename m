Return-Path: <SRS0=zuuw=AP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C0C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:46:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE972084C
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c2f9NmLE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXEFrhsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE972084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D35116AA;
	Sat,  4 Jul 2020 13:45:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D35116AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593863208;
	bh=VNFAJqEyVyy0XlnR0W+J5IGO8xzOMW1TS3N4PEBvea8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c2f9NmLE6EEV1CllM5cavxN4yrIw12CxwrB9xof0G80DP5D7qsfK8PlPVajP7RJpU
	 9qPM+rWaomqyLmXJs6VgpGdedCTh10okAxHQWZJA8PPDKCzOevzUeNhBx0VSoI2Q5F
	 lK2NZT0PkG8OqQaRzk57WoyWbLrAcMFQXMf0NwtU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A603CF80334;
	Sat,  4 Jul 2020 13:39:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20161F802EC; Sat,  4 Jul 2020 13:39:26 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69AD0F802E0
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2020 13:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69AD0F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CXEFrhsc"
Received: by mail-wr1-x441.google.com with SMTP id f18so27368203wrs.0
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2020 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fTGEWk45ndJLT2NY/8Es0iz5Nm0crZjCJORIXqLrPak=;
 b=CXEFrhscCk+j5TdunLyNHrZJrFTXYvNBQ5sAs4RwVo03mfiM+PtGWDpxafKr37ac0U
 w3EJeeD7fJHyI7NtFCa7hADR+v4sUNvZ8nVPHGJtiXAViVyRJ1oW7eTqlj1J8jyS6XCN
 mPfkZXS/SPAUWuo8crj9VojAf7Jq0apgMdlqZMAopvh2jH4reQIzeqgDR4FGEqrBp7SW
 bSokSJgr9mjXdsuhpWD+BWB0sb9sCtDcveDqNWTVbeXn+AGxd64K4jDMwQ6zRDdqJ85d
 1SKKSrScwedcGXGymdH5NehlKUFxb9PvGFfKOx8rdhkbHi8gneO9o/AC4I/6rsjWZYCO
 HMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fTGEWk45ndJLT2NY/8Es0iz5Nm0crZjCJORIXqLrPak=;
 b=AIyTqZoVqbx+h/z4aENTkb+jDenUHCCxSSSdW8UEnF9jHChIlcoSSfRBWOt2qZz/nG
 f5kmcFjEklG/J6RYNtxGrf1tw6eX7u7y76xlId6lh+a64y5iQLLwsCRj2KMHbsYAnJnU
 WNrgoOeaQpI+CQS6AsoBCqQp88qL7yBLKXT8y6GkwA2P7V3mPmbwnsDuP5wXD5ZV7waE
 9IjTwnGo61+sPUcoEoHhRcwpdFNxB5IOjmzf8uTI0C35OBxTvyhpu8h/yaowIyfpFxRq
 zgnEYHHm6h21JEWZKYrD1XxmTvO4cEWd4hWWkZlBCjlq5UUun6HBaeEU20pBcqdZEyIV
 SUYQ==
X-Gm-Message-State: AOAM533+tl/PlYiKmqVgzHBLsDyKKkK8W30o9b5Hj2F3Jlyimz01uota
 IK8w83kfyoJ4y2y3K28jX+0=
X-Google-Smtp-Source: ABdhPJzjNETgLRXE5zmLJIHF5Od05otTh5j/Sb/JD3W7Unyc0STwxcF2Y/1iz8u6zDLiGCgzVeKx3w==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr42411528wrm.92.1593862758810; 
 Sat, 04 Jul 2020 04:39:18 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 04:39:18 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 11/16] arm: dts: sunxi: h3/h5: Add HDMI audio
Date: Sat,  4 Jul 2020 13:38:57 +0200
Message-Id: <20200704113902.336911-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Marcus Cooper <codekipper@gmail.com>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 9be13378d4df..91d8c2690feb 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -806,6 +825,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

