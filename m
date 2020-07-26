Return-Path: <SRS0=gzS/=BF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80380C433E3
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 01:29:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DBD2070C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 01:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GHDMrlVs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="HNNcySqo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXMxsghq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DBD2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E7571684;
	Sun, 26 Jul 2020 03:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E7571684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595726959;
	bh=TTzjO5QDPH/nDuFKl+MIvfK8SjzkGLSviJpqXlDG8Hk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GHDMrlVs0T5ErfxqtzOe6jCPuUYUjNAwJv0JwHw3lMs7wbT0dcBycjzlP9SoMrOOP
	 XEIkU/UVepz7+UM/Naw6Jpr/sH0z8/VJSZTp33Vnf/4/pPTPh3JoITeWRA81C1eEVL
	 npS4QRAE56OTbbO5A3nFwI1VfGzuoDVBrcm47PrU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0361F800C7;
	Sun, 26 Jul 2020 03:26:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3757F802C2; Sun, 26 Jul 2020 03:26:16 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A79BF80274
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2020 03:26:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A79BF80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="HNNcySqo"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PXMxsghq"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id E9F6F580165;
 Sat, 25 Jul 2020 21:26:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=aG4Uj5m5qoBSO
 tcKgLA116HFz/3E9K0FEPpd2GWuX5c=; b=HNNcySqomav8Gad97WESHlVZSKUH5
 J6xf3jMAMw0jDRxd800cI9Ci6Yf06uUmy0lmHu/ofcOw6huOTIjVrwP/jE2XNGEM
 5smIcmsJsYGU6VKLGM/+bvsbzqeGo+ygpuMW4MFSPCoHgaUS8MEOZ40gL+FJCcOb
 PT21KHcEMSPD1sRdURGEgMcFcxXSGRnoElV/SPfwCHDKo8ddlO3jXB1MZwbgYAgS
 4AdU9pKK1nVMcpQmUMNEJ4A3cvUhcuReh2rpwZ6rXj02AQ2w0gb7HeQE7XLV6dyo
 rg3ntI5X7xlspQEijMxtdD7HZWh3CdZtHAPl7wMx2t0wiEapMKy3syoYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=aG4Uj5m5qoBSOtcKgLA116HFz/3E9K0FEPpd2GWuX5c=; b=PXMxsghq
 wmAvc3bCz0iOTsco3wDTShP8wOkTFKQU83g48j+JYOMh49AgOHQA63Uy4j28fIus
 mKxxHV2KZUS0q0BhvX0Y44EBMl7jkDMG9ZqfULpQyGcefq/EN4uHYyVqD+q4IXtF
 zNp4VFQOIAh26oCF4ZHQnlG9sE1Lxi9rmpbt41f/nSUTPB3ugCAWpRAmxeeHlGAx
 kRKh6xZmfgTsimkvL1jR5om1BDB3sNud6ReyGv/3t9Y+sXccJzBywDN+6ua1lTYS
 guEKo6LfmRAaNjiEU/U/4jp6Y/2/Wm3VE98soGpqYAeq5uj5YSI/9dChPT+D5f5e
 Hz3CJhFkP7V0Fg==
X-ME-Sender: <xms:qtscXwDj3heq8KJeWrIdc2-OBJe0QY_58RRsQ5uAk5ODc5tp5csUIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:qtscXyjDzvUlTqZp74XNSHQh44oFKul6XQ_gWRn9k3A_qkPKo-KfzQ>
 <xmx:qtscXzlgn_yjvfDHjztDuk3Gna2bOEDJ9YwFQyqc_1NHvUuDkjxCeQ>
 <xmx:qtscX2yavicdEX7r8if3XtYtiAVQEzpfl_Z2pRuGr16D4wUytrU9sQ>
 <xmx:qtscX1YYqchZ7Lnn6EVo7sRi01wxYKlTDXfe-iYq3uLagLIalgcVrg>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2641A3060067;
 Sat, 25 Jul 2020 21:26:02 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 6/7] arm64: dts: allwinner: a64: Update codec widget names
Date: Sat, 25 Jul 2020 20:25:56 -0500
Message-Id: <20200726012557.38282-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
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

The sun8i-codec driver introduced a new set of DAPM widgets that more
accurately describe the hardware topology. Update the various device
trees to use the new widget names.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts     | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi   | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts      | 8 ++++----
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts      | 8 ++++----
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             | 8 ++++----
 9 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 883f217efb81..3ea5182ca489 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -331,10 +331,10 @@ &sound {
 				    "Microphone", "Microphone Jack",
 				    "Microphone", "Onboard Microphone";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Headphone Jack", "HP",
 			"MIC2", "Microphone Jack",
 			"Onboard Microphone", "MBIAS",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index fde9c7a99b17..d894ec5fa8a1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -330,10 +330,10 @@ &sound {
 				    "Microphone", "Microphone Jack",
 				    "Microphone", "Onboard Microphone";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Headphone Jack", "HP",
 			"MIC2", "Microphone Jack",
 			"Onboard Microphone", "MBIAS",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..329cf276561e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -261,11 +261,11 @@ &sound {
 	simple-audio-card,widgets = "Microphone", "Microphone Jack",
 				    "Headphone", "Headphone Jack";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
 			"Headphone Jack", "HP",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"MIC2", "Microphone Jack";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 64b1c54f87c0..896f34fd9fc3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -374,15 +374,15 @@ &sound {
 				    "Headphone", "Headphone Jack",
 				    "Speaker", "Internal Speaker";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
 			"Speaker Amp INL", "LINEOUT",
 			"Speaker Amp INR", "LINEOUT",
 			"Internal Speaker", "Speaker Amp OUTL",
 			"Internal Speaker", "Speaker Amp OUTR",
 			"Headphone Jack", "HP",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Internal Microphone Left", "MBIAS",
 			"MIC1", "Internal Microphone Left",
 			"Internal Microphone Right", "HBIAS",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index cefda145c3c9..93b091313323 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -342,10 +342,10 @@ &sound {
 			"Internal Speaker", "Speaker Amp OUTR",
 			"Speaker Amp INL", "LINEOUT",
 			"Speaker Amp INR", "LINEOUT",
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Internal Microphone", "MBIAS",
 			"MIC1", "Internal Microphone",
 			"Headset Microphone", "HBIAS",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index dc4ab6b434f9..3ab0f0347bc9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -421,15 +421,15 @@ &sound {
 				    "Headphone", "Headphone Jack",
 				    "Speaker", "Internal Speaker";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
 			"Speaker Amp INL", "LINEOUT",
 			"Speaker Amp INR", "LINEOUT",
 			"Internal Speaker", "Speaker Amp OUTL",
 			"Internal Speaker", "Speaker Amp OUTR",
 			"Headphone Jack", "HP",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Internal Microphone Left", "MBIAS",
 			"MIC1", "Internal Microphone Left",
 			"Internal Microphone Right", "HBIAS",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 2f6ea9f3f6a2..9ebb9e07fae3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -159,11 +159,11 @@ &sound {
 	simple-audio-card,widgets = "Microphone", "Microphone Jack",
 				    "Headphone", "Headphone Jack";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
 			"Headphone Jack", "HP",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"MIC2", "Microphone Jack";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f5df5f705b72..a1864a89fb89 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -340,10 +340,10 @@ &sound {
 				    "Microphone", "Internal Microphone",
 				    "Speaker", "Internal Speaker";
 	simple-audio-card,routing =
-			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right",
-			"AIF1 Slot 0 Left ADC", "Left ADC",
-			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
 			"Headphone Jack", "HP",
 			"Speaker Amp INL", "LINEOUT",
 			"Speaker Amp INR", "LINEOUT",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8dfbcd144072..73ae7656e0f3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -139,10 +139,10 @@ sound: sound {
 		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
-				"Left DAC", "AIF1 Slot 0 Left",
-				"Right DAC", "AIF1 Slot 0 Right",
-				"AIF1 Slot 0 Left ADC", "Left ADC",
-				"AIF1 Slot 0 Right ADC", "Right ADC";
+				"Left DAC", "DACL",
+				"Right DAC", "DACR",
+				"ADCL", "Left ADC",
+				"ADCR", "Right ADC";
 		status = "disabled";
 
 		cpudai: simple-audio-card,cpu {
-- 
2.26.2

