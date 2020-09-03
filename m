Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9368C32773
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:37:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A79A20678
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tk/3GOVR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUUWA/3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A79A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E62D61A94;
	Thu,  3 Sep 2020 22:36:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E62D61A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165450;
	bh=bIfAyfAcZcUVTXQ4FfhLsy9dzL8NoeVWz6/UjK/5A+w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tk/3GOVRtW+6V9Qa7ZOko7vnQgZhgN8o/UkmQAk4UwnHc4grkp0CWfhOzBPq2B6sA
	 Mj/ZMlUkt2DeDHvb+Yo9cDYgnvBZa4Us97BCdqYJDS025pc9VPL2382QJjSYXGPq22
	 WI/OuC2J+qxxjAoF4Gl2T5ISXxqiyXNtT6SdJV0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30085F802FD;
	Thu,  3 Sep 2020 22:31:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C06F9F8033F; Thu,  3 Sep 2020 22:31:16 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAE25F802E9
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAE25F802E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="PUUWA/3D"
Received: by mail-wm1-x341.google.com with SMTP id a65so4094745wme.5
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Kzc7c8z/8BLZLzO00zFvlw0RIRscqiIQLsTxrgpdlY=;
 b=PUUWA/3DwOR0XZKrhD7f6l68tbk5P/o5FOQQmpRTCPHsPuDmBxR1cfmiCkIh4pRRkG
 ApgMa0YPGTXrqN27iHak3drv+otCQfhpzAKkRZCYFBMd53wBJf7hxZq1Llwj8GclQeVq
 jF7vB53l1KsMwSapXwKhrUa3rUAvhoH/j76DtlI3dWZnBKSCQGjzQ/oqM9rgQ8ouOtku
 rc31+b1AEwnwbvC5rQOvfV6CmsW+QT65UPHdOG6pOiIePlIyvHyVpJTZP0vq70aH85SE
 tXj7tUgKAcpnYhadrY5cppTrTw55hIZBpjLMcdyozMryAYrZFDFiEUrnEz3IQd+C1Pbu
 ao2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Kzc7c8z/8BLZLzO00zFvlw0RIRscqiIQLsTxrgpdlY=;
 b=dihQaubASYXBIof2dlRXMnr3Mp7KF2IERqdeZy0USwmewGVnSQjePnE9mfnLmjrs9Q
 2FoiLNGORw15TV1yzjlGEgX0KqTsmsbRzIunIDjsltvQhF944WH9G4CCZuFgVU4ZPlQH
 2n0O0WzOGGg7fTQY54VuXk99eTsOQJApznPC5p+BEDJlL3kfhsH3PS/rKP8GguzA0B3k
 mHgqnut1d23slKNxHCiSJavTB8USFlcjJ4Mwl58cZHns+PqwNOHw12AmsOiAG9zOLvfe
 yCLcpcslTiCIS/OgcmRJTTXfhbcLuKvDScaiRt5CFyCxUKgmK80T+5xbPeLcAYK2i0yL
 zXwQ==
X-Gm-Message-State: AOAM532FUHtyZlGUv+PeWulhUW7Ktn9n24FFMsBkvVVOvze14PQBpY9Q
 kgs3puTb6trXXQDNbRlBZJ0=
X-Google-Smtp-Source: ABdhPJw+tb3+WnIk1ktQolOHCtjM7VlSRebZKfzrpihaMF2DlFCRTa3VjYI21Dgt/yP0CFcatKXo0g==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4198374wmc.35.1599165058374;
 Thu, 03 Sep 2020 13:30:58 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 13/20] arm64: dts: allwinner: a64: Add HDMI audio
Date: Thu,  3 Sep 2020 22:30:27 +0200
Message-Id: <20200903203034.1057334-14-peron.clem@gmail.com>
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

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index bcf808459edf..8c540f4f64b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,24 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
+		simple-audio-card,mclk-fs = <128>;
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
@@ -1155,6 +1173,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

