Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444DC41604
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:27:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE8520759
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gZeaTy2L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb+99JrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E5441ABF;
	Sat,  3 Oct 2020 16:26:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E5441ABF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601735259;
	bh=TlaKVXdkaBmec4tXS1T9gPnftMPH3PL+xEeJCkQRjjE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZeaTy2L8pFGtux+EuCBqAvTTAPywregRjXINZDx6CZrCi9ESOVe9GHP1AlrtjDhX
	 8t+xHZHcK1CdTK2TNA244J9MQ2rsuZTLxAinQobFlJAvKc0lKc8RgeHE6Jw2fMezcn
	 2JLvTEhSxDrW9oRC68SbGtm3bUG8G9AxeiRFFFgE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AE6BF8033E;
	Sat,  3 Oct 2020 16:20:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73217F80338; Sat,  3 Oct 2020 16:20:28 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F872F80328
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 16:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F872F80328
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eb+99JrH"
Received: by mail-wr1-x441.google.com with SMTP id w5so4845628wrp.8
 for <alsa-devel@alsa-project.org>; Sat, 03 Oct 2020 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
 b=eb+99JrHGu7CStzvPmgJqEYGTTZr65cO4Rme1m1HQrkX3eP6OtamKbnFjU+KfRPHJY
 Pvfj3aCfPq6q5B+/Tuo8Qapq+fBT63gBHs53Apw2QTf5MCSE2nVCI2jYbNlbBeEUqUNY
 7HaUW/fi23P1cY8u+VjlhE639i4pnXPXN3RRi2Kt1E/luZpQTMQ/sYLlBsSi/bxmSFTZ
 AxquGIS9jRNjME0IW5jsGuNfCAlre8OTLCkRidbu7qqacligrG0Ra46NLSwuoBC8eUkv
 a7HdaK8uXNhzdBUm2pZ4cCs19AeKizkdrXkpkhNJaPGBaqWldUu98JC4EKATsUAhdNrR
 hZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
 b=FVyxLI9bk6h3os/ZikEvU6vVY5F3XyTAGjKJ20he/C3Q9yAD9GobqQ7dRnlGPQWbTu
 wpFKBhrTgRsigxSreKMOGIko9XTYmK/6lV52WDnodw/u/DIP/nGZUrwIWCpSpbWvDRCi
 eJ5JWvW9uE5ifgH6J2U8Mo4jRsKAEK/GRjWmVL0zrG33qjkaWGnQq8Ru3IfIdXN4X7n/
 URp3RRjourbtLWuXYhbwG/c/jU6e1JRA5tAAY1ePGEOWrom8v/jTJHy5Zb1AXOWhOwDy
 6v11e2truV2nqqV6tKHxoVYu4PIJk8AEnW0s1VmDknTxp6AckoTooWfFKHF99w/vm8Jd
 l+aw==
X-Gm-Message-State: AOAM533aMyIFaEm58LBD510R8Oh3M3hVxZdokH9fAv5FlV/SSw5LwifT
 zgnBX200BeZ+J1bqfHGfUa4=
X-Google-Smtp-Source: ABdhPJxkOEi3rerfibud96xE0Nh1JET90gjU8tEtkYMpwM1s02F5+a8gjfBtZ2G9gGt1rIZhLWL8tw==
X-Received: by 2002:a05:6000:12cf:: with SMTP id
 l15mr8237746wrx.312.1601734817786; 
 Sat, 03 Oct 2020 07:20:17 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 07:20:16 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 11/14] arm64: dts: allwinner: a64: Add I2S2 node
Date: Sat,  3 Oct 2020 16:19:47 +0200
Message-Id: <20201003141950.455829-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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

Add the I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..51cc30e84e26 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -846,6 +846,20 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			dmas = <&dma 27>, <&dma 27>;
+			status = "disabled";
+		};
+
 		dai: dai@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-codec-i2s";
-- 
2.25.1

