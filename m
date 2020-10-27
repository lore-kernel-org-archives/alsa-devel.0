Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF7C4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:38:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8196920760
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gho12I5r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9Flst7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8196920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E644616AA;
	Tue, 27 Oct 2020 19:37:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E644616AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603823906;
	bh=jByL7wceUKemAIpsigGbzjkZTh11zuZWY1O+VcfPAy4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gho12I5r+fwYvcoqVAkNwNllNOFu+SwdKyuGjTub7MYkdsZRjCvTJYYCzunV0U+yR
	 7cL0XubAwvQd/lm76dIxCqKXF0dhp9ZbB5noqABaMdmdgaQozdt+ndHSso/xbqSzem
	 pTrEKqw1v+kzvqs828sKvv9qSFNaSyivs0tBMxEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39FF7F80526;
	Tue, 27 Oct 2020 19:32:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 018A2F804F3; Tue, 27 Oct 2020 19:32:24 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AB1BF804B4
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 19:32:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AB1BF804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="k9Flst7t"
Received: by mail-wr1-x442.google.com with SMTP id n6so2997092wrm.13
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
 b=k9Flst7tFAAjG9ubHEoElAgNXZSrbI98UQtantRFcTAA3sl83J1YqJaS455+rKDUdz
 OFUrdcShLvdVTrTYjjCp5hgaZQCBj5jW9D/v53Nj2gkOe8KQx5ZYs+tTO8cxov4FpCbP
 oLKCYMpaLD/PYF2103hjp6CzKjKn/mPncKNOkqS/i9oeN48eGXotxwgyHFVGS4TDKq+d
 8hNAKg7sYzJZ/9WJArhfx9wYLXIvR/XA/swpPKFqkSOMGmh4MTkH2dyyG0GZ++zP8VPG
 3k/XdlAF1esngVbZEYrcYA1JqwHYrTKjgU4i15uziev6iA7wRhgMgdVP7VsyQs34PNrh
 H2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
 b=USWISMM5AbNrBOCfuGAOnUGHv+5Uxh3Df0EmGHXorLhExwQhBAlw+DdmRqrHHr6wj+
 5FR4Ru+D9efKSLQPKA0CSo/uloSbRTl4x4F8WLFEIjfWot/lKKIJjbxnEmTiitbAnVVo
 uJ4+YfWr+y6iEBMRNJOEv5zees0McpebboHIamilE8GjXuK7tFXAIRynGqL2JewTS4fW
 4GU0IXeath4K6fW7Czf6TgSznKTkkpTIx3vLplp0sw4DfXCDKAtrQET9CJyPomeIZpsU
 iGUv9vp/rzBNA3UPCCTogZ3BbzW2il9B+a/JzsUusB8OG9ILNYrlwqc0wbtqMw7sBiT5
 FMUQ==
X-Gm-Message-State: AOAM530vwZ9kbMXn7FoWv1wQY8n2jxggM7bcn3T+pxWSd4qyCRFLLgYU
 IEkf4kwTBltcxsSRpdDU/JM=
X-Google-Smtp-Source: ABdhPJyXTU2eBEU1X7yNh+0GRV2R4fs016UXcklgs1IGMsryGK5lYkJlyJsQU30Om0dELzxdpENPgw==
X-Received: by 2002:adf:8362:: with SMTP id 89mr4535667wrd.280.1603823523303; 
 Tue, 27 Oct 2020 11:32:03 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 11:32:02 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v9 10/14] arm64: dts: allwinner: h6: Add I2S1 node
Date: Tue, 27 Oct 2020 19:31:45 +0100
Message-Id: <20201027183149.145165-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

Add Allwinner H6 I2S1 node connected to HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 28c77d6872f6..d915aeb13297 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -609,6 +609,19 @@ mdio: mdio {
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
-- 
2.25.1

