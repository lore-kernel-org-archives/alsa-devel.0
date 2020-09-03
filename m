Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE5C2D0E3
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:35:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E1520639
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uU6a9uEw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q65xxxeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E1520639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 657311A9A;
	Thu,  3 Sep 2020 22:35:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 657311A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165352;
	bh=boSYUpAFaV1HcTVn+7H652mrbdplQWGEROHV+TLKk8U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uU6a9uEwzY7QfCQfS49pREIunX/Di9prnpsbS/mpbr+46n3lEgr93CXyFUDvHdQmD
	 Orwqv9AcvC/SAt02PoafkMggjD3RvL3kc/iITAfF4b20N717qbu2gx+WOTexefM1NT
	 l3472Xzu5HnxiaqK45olbThWDdPGcx/Psxd+qraM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0A6BF80331;
	Thu,  3 Sep 2020 22:31:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFE75F80331; Thu,  3 Sep 2020 22:31:08 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB99FF802DB
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB99FF802DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="q65xxxeb"
Received: by mail-wm1-x341.google.com with SMTP id o21so4156060wmc.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
 b=q65xxxebQ5o0CGBL7V0pXVWRuuEQJXqkTJ4fvQTtbbZtdVPp1+1K1jDEF74acvpUba
 AQ5Hx9JAdLnM4rGo9B0DlcNSdUdUk4BaleSAIK190wD+JRW2XEpzGjoSr4VeKBJ/8GLw
 3vDbrFNbL/AVczZaL/iB4NeNmxme+z5ET5q+bakPEvtFAROuvh5NrdwbxTX/0sI8wRSm
 KRxOWPsMz4qfLu8dnCp5oN9MZqqt2/AsJWiS4SKXWfyzqYSDkIbj+h2rcYNJHAzFvSn1
 KurPOpAP+ArNQAlvPJlol6XH6TK7Omo608AD8RXHRcgUC2BzZ1YMJliWNK5BKECnHJuR
 UdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
 b=M0nmIjSqDgpS57Lk8QrEH6AW/6FrG9+I5WPFJkDYGuGRkquj+n1arZ6VZCo9We7ZZD
 wGqEVJEZB1sW9kcUlEr3971bJC+hz19IQjwEqWnHWHc+HvmS5l2VZ7iIbwT+Mka0REDn
 BQhQB0X59Yh79r8JFc+5RaoxLVlAVDTemq/Unlj/axWFvVxRiNNpB68gJNl7tz6HkeK1
 WJq2nbD6ZfUnYGZlox6uFKqXMFsTj4lOmc2fefFtt9gP9Yi6qVMePcxqqxr6OUpYBqpR
 ZhKBJHHd3uiBzgjkFGJdoFqBd6nugVSXS+a9grbWCmMaXFOBfjIAPjgLInv0Fo7pp/mI
 CT0A==
X-Gm-Message-State: AOAM532CC8nx7VzGWSaUocHSU+wu9MuChe7/YPExFbcdheg1C39piaSA
 B9fiUm0mtaiv3J0zloBQ28M=
X-Google-Smtp-Source: ABdhPJxkFH2OLYuxAHxFrqCP+1QlNdTrnstdo4sIsV5Hxm1M+fvSoQbG7ckceLE1d4Lijogw88crTw==
X-Received: by 2002:a05:600c:414e:: with SMTP id
 h14mr4115503wmm.2.1599165055122; 
 Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 10/20] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date: Thu,  3 Sep 2020 22:30:24 +0200
Message-Id: <20200903203034.1057334-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
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

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..3dca6d89cab9 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -662,6 +662,19 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>, <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

