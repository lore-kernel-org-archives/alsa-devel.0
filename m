Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4565C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:53:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581AD20578
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JrYn/a3T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdNk/maS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581AD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EC7E1679;
	Fri, 30 Oct 2020 15:52:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EC7E1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604069586;
	bh=TlaKVXdkaBmec4tXS1T9gPnftMPH3PL+xEeJCkQRjjE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JrYn/a3TW/T9d0QTb8Hzblcis79yUXFIsqE0/Y+VXKQmcLru1/Ztsfh25Rk+IFNbb
	 LQp7ClkPTms4h1xYb4E6/r7t8WiESSN4i4DsEu1MbTQOdeJ/8sgpaeMPrHw1ySp98H
	 in0sqBGnwKqQwbZTpSxPHtkBm2oDOroKx0Y5D+mg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09A13F80534;
	Fri, 30 Oct 2020 15:47:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AE23F80533; Fri, 30 Oct 2020 15:47:41 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D9C5F80516
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 15:47:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D9C5F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WdNk/maS"
Received: by mail-ot1-x344.google.com with SMTP id n11so5771401ota.2
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
 b=WdNk/maSnufv6lQD7+3w9GrNmVH8iqqH5NfjsMjqXFEqtE8foZTWoQarE2o3+RpUXi
 68PwhvvpVuVuQWFelQ2c9UgVyPW5sSX1DZaJQ+ZtnJCAMCHxoX3a01eYd5MQnZ9qOCWX
 Ve+njlu4hPHKuHEY5VCpfTZngbcrTOaalrZDGXq934csEyvbyhFmKeobV0OVLtirgXIY
 WKo2pR9TFOUp64lkAS8fKPbMgtrbXrdeFqBo5rKgH4aAVVmJhhztVZjdwiieCoyoQvko
 BXYdFir0vCRVZmLdKDlc7FLVKMKk1+q8ulkSN/S9Rk4G2YvYB7S5AAfnY0rRvO4OsyMO
 ACSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
 b=kvta0XL6kOqQxWgDtMCy53GdR5uOl5KhQ2tD6wo9qiK3qIpmuHvkIhbTepwNg05q8B
 rhb1zMDosRviN5zMeZ78bzeE1PFZUEP2cUkbKiFuSBCLmXOnPffy1BKo7fGxirSyktqX
 1t33jtoamuqAU5hsCRJrQkP16HxKTjZwvWIU6KG6WetPlwiAZrmNk7Vfy+tBahDVllIr
 /reJ9FGdfZv1AOdidyj991ckYXBPPk9bMeXH5Q0gGmWNAR4feu4oqKiKkA2rPMtqH8PO
 teBoPf0dlVwDqOeMl7uxSVAVfDAVT8kKYszylzRHTVi7W6uBh068Ndt7/M5LC9ZhcvI8
 Fpmg==
X-Gm-Message-State: AOAM532IoYi5YJoxavztFz7d9fW7OmUOUBSLzXVI49uGyO2zDc2LL07Z
 9EplUuqycnvL+9wQEvU71BI=
X-Google-Smtp-Source: ABdhPJwdhY99fmpkW+U8mY6UuxGKLEsNDlligIDXRDSrvMAxcuSKIvAwSX2olqwkokvqL/0Y+3Ns0Q==
X-Received: by 2002:a9d:51d1:: with SMTP id d17mr1949640oth.81.1604069251888; 
 Fri, 30 Oct 2020 07:47:31 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr.
 [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:47:31 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v10 12/15] arm64: dts: allwinner: a64: Add I2S2 node
Date: Fri, 30 Oct 2020 15:46:45 +0100
Message-Id: <20201030144648.397824-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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

