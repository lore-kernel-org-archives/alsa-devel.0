Return-Path: <SRS0=Oq54=DE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCE8C4346E
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:38:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BF32311C
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vGXe8xZq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKfMWekh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BF32311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCF311AD7;
	Sun, 27 Sep 2020 21:37:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCF311AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601235516;
	bh=D/YVt5lbsY1L8tB5Rw2FqLgcE37Fu1cKZ7jw3rmRlyY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vGXe8xZqxCKkCTi+Zi7LV1m7FzzmoxabPSGrfbkyMIJbNmKqfkJ4fd71XbF07vZKY
	 rAQghY2TmDLXWTiArBRDvoCJk6wPDvbqNDYciTDr/ePRNz5SLxXqb4Ct47V1FjkjX6
	 nrPxbvsKR4QT9r9hdSpIAEswJFDb4vJC3mOMZYhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43137F80341;
	Sun, 27 Sep 2020 21:30:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B5C8F802EC; Sun, 27 Sep 2020 21:29:50 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6975CF801F5
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 21:29:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6975CF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rKfMWekh"
Received: by mail-wr1-x441.google.com with SMTP id w5so9524527wrp.8
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9TQWIqgvaw89lJDj44ur6CfXLBdvHwh5oAFQqUb8yKI=;
 b=rKfMWekhk7Ns8FICmbviit95Pt+WpU7TuXkoPXKkf/DGkKAG3sWtM2kxCDfM58R6fx
 iVEiO1d6KYmkiz7thtuGvxuwOSXzNXG9eql/5LS4M5wiO8ysiFXpKONZ/TlmKAEQQr8j
 fHVqVk7/lOlOXEbzw6z80vG6C/quZb7hMDfffn2WuK9FHEjWsAVhi0ClxuKduKBqakRE
 SUhEkcSa2y5pLO7vsJ1CIcBXpNL41i72YlDSFiuBUtXNq+4vHRsECc9+b587v5PhByPS
 F3PARu87zvOHatIjf788LXYpRCGbGFQPpLcxSxgiNjnGKgJ9833xFZxPWxecLIPUcYY8
 5TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9TQWIqgvaw89lJDj44ur6CfXLBdvHwh5oAFQqUb8yKI=;
 b=jF4Wv/vWDoQ+uu39I+vRPgqxiDOJ1KNyxvkU03XXw4mankee/n35mDo2ilfjdxBYo8
 H7M4rsehyzpwRIIhfCa+CiQKdeEbvxG24QT9JE2bKZYmVIz8+F7znE6Y3E6VGZV+QDOP
 HK7/FqcvmkeuNbLzFnOI5cJkezWiWgWnW25RpVniVKlcmN+M8N4Lizaxpcyiwjy1x0kY
 oF3C324jqqTIazIm1xZZVPLG6rR1/pfj/fFuOnrW66EvIwe6yhVHqeycUNlGrVUQAv9Z
 sDl8JIHYByyeQV+hmyYDrHsBBHi8Kl4WO7XNowzBNJZTnQVq38V8rIgzMhM4cclKr60T
 Lmdg==
X-Gm-Message-State: AOAM533t3fyrUcsiYPXZ72q3lUlbKcpfwLR98orUwPNoSRM4q3Xpr6FZ
 cD0WBBBWG7XpNIEfrCHN8Go=
X-Google-Smtp-Source: ABdhPJzBvHHOuka+qYBTkGrJbTxh9J56urhJS3nHGtKfbwHU33hQ2wR1ys5AololhKsYuJSIYeYALg==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr14893492wrt.162.1601234971305; 
 Sun, 27 Sep 2020 12:29:31 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 12:29:30 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 12/20] arm64: dts: allwinner: a64: Add DAI node and
 soundcard for HDMI
Date: Sun, 27 Sep 2020 21:29:04 +0200
Message-Id: <20200927192912.46323-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

Add the new DAI block for I2S2 which is used for HDMI audio
and a simple-soundcard to link audio between HDMI and I2S.

Note that the HDMI codec requires an inverted frame clock and
a fixed I2S width. As there is no such option for I2S we use
TDM property of the simple-soundcard to do that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..ba8a84e6e993 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
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
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -846,6 +865,20 @@ i2s1: i2s@1c22400 {
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
@@ -1143,6 +1176,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

