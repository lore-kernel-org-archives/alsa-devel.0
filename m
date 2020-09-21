Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054BC43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:33:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F80B20EDD
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f9BAUj1x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvDq5ACJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F80B20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3C8E16EA;
	Mon, 21 Sep 2020 12:32:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3C8E16EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600684419;
	bh=pOUDdxF+ORCxoCN1LCBGXRN4UlT3CfIWSSGkMvcrhLc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9BAUj1xvG17Am9z72u4EoE2ger9LPFC2F1g1Ug/QKnnaQSBPbSaEr9K5KyahxhU2
	 P3Urqg5Nc+Ln82SMHaGHMNDXf+twMUB3jbhgD52ggAWHsagMOCoUEWYGL/suyzvYF0
	 OFOUzBxtobaV+EbpwL6zOZjAJMHw6qtFgska5itE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55BF2F802EC;
	Mon, 21 Sep 2020 12:28:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53C9FF800B2; Mon, 21 Sep 2020 12:28:07 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5CA3F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 12:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5CA3F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RvDq5ACJ"
Received: by mail-wr1-x442.google.com with SMTP id j2so12147834wrx.7
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
 b=RvDq5ACJPtcSlqQgNrS9a3nOGhIsFdBgxLfrl9P56YbGTStq55a6p52GECOAedqyy6
 gMzeOiMhfAAkyD/nxfsATltAVGFWBJgowmuHCg55dvJZsRffi2zdA12KmUko1g3Qp1SX
 ldXtluqJWmnRhJxX2W8IcIGn1tuSgwXJEYuta/HXu6wbAceQagBGidUQzmkWqMPnjg8t
 xPRcG6WBUZmwtL+ER3Ktd7IOHQol7NXZ85ztiwPCoWpMmkzu7f+dszG5Os71mmvDQXb4
 l4b+H3lTLectvTOx+hp/GkJzxBSwV9fkONw3EcPMvqpw2EeR4znqu+WZcC7qRhGMvT40
 sbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
 b=YhQuC6p7Ak38vNEyhU9BpGtQA+jxBYHQRHwu1t1KxbIs+0JPFkjIgepjUQLg0+JN4w
 Q2+1+zzvi44iZp6RgTmKkHITfVaKpFDQ9Vsb3dCeU2WkK2IPdjzIAEX1As6xQpq3bpO7
 IKY3NYfcwkwZosc+5unxZiZ9EWUHyZKrmGgpv18ZAEJd0p+oEMNdUD24/Ri7Lg1qj7I0
 5GAQibpG0VONoL40KFDx4CK3ujSLkCwfb+9jye5NuWNroP2RLPxz1WHutLY5lpCu3Q/S
 au6B8hbJQdZmwTdvJXH0HleLK7ULI6vkSGarQCzwHFPi1HCc8+BpscpyvfTdPltj6KR4
 C2fQ==
X-Gm-Message-State: AOAM532mpoY2rZBnlqH8Zz/T77YfbDmPnY69+woDGZtBAzQG5UyFOok8
 PqgYyX+HOxFucI2TddwF/VI=
X-Google-Smtp-Source: ABdhPJzWiop5gOEboJyVl9N3SYa7aUJaakgTHf38lUDH0hociHufJWzfPObOk+9i3qTV7iU2vHQmKg==
X-Received: by 2002:adf:e385:: with SMTP id e5mr50763021wrm.129.1600684066825; 
 Mon, 21 Sep 2020 03:27:46 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 03:27:45 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
Date: Mon, 21 Sep 2020 12:27:18 +0200
Message-Id: <20200921102731.747736-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 28c77d6872f6..a8853ee7885a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -67,6 +67,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-h6-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -609,6 +628,19 @@ mdio: mdio {
 			};
 		};
 
+		i2s1: i2s@5091000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-i2s";
+			reg = <0x05091000 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spdif: spdif@5093000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-spdif";
@@ -739,6 +771,7 @@ ohci3: usb@5311400 {
 		};
 
 		hdmi: hdmi@6000000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-dw-hdmi";
 			reg = <0x06000000 0x10000>;
 			reg-io-width = <1>;
-- 
2.25.1

