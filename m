Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5708C83F01
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Aug 2023 02:34:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4B34A4D;
	Sun, 27 Aug 2023 04:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4B34A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693103645;
	bh=mlCIGyNtd+1jW4y7BtLv/AGrAgPDY4P5R3A2Z2JVywQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IrJDAh79eIJ0lTitXS637jZijerXc8T2jV7UAAP9aZ74KXHSbrxBUviX1WTu3E0Un
	 KO/a2jJUUZt5CENV5ZmUfAZGhb/VQz/SEo14oxibA1zMdruWz6aOi7MdnwUQUVeGHO
	 tWaAdybMr3vGIU5JMt65Z5aA+2OuhM5lyJMvJGbo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12CE9F804F3; Sun, 27 Aug 2023 04:32:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5138FF80536;
	Sun, 27 Aug 2023 04:32:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA131F800D1; Sun, 27 Aug 2023 04:32:19 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 124D6F80158
	for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2023 04:32:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 124D6F80158
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=XuMQgGVJ
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso7543075ab.3
        for <alsa-devel@alsa-project.org>;
 Sat, 26 Aug 2023 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103530; x=1693708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D/qWo3eeniEHWUOvOQr5eDGJa7jMw5uJueo9l6EPmM=;
        b=XuMQgGVJ1bqauAc29S++ga38hDlTJkjWGKU5uK0vFROrjXgvz9scsjtDUwpHBBMQ6a
         MuGOdH8THZn5bnzaMKPan1vSCIruCZbbZl9OWsJlQWAP1DrLad7YplPuLKgaOI8bVKwq
         wchpegxIqKyH6hgv4nG4kuPstffzGut0tC7Jrgj0U2sRjA9EvNz0azn6J6iQ80HS3KdH
         MK3SIZUxYkJnYjOLsxDj93yVZ4mN1PmneXbG2H5STLZ8sIHN3+gY0l48qpZJxwbVAaFp
         iEa6sO8BWmmbkark8C+NOVzSYTdIgvprZLaN3HC7GkFXHhcGGKOYrHFJB83pJumLMU3F
         KZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103530; x=1693708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D/qWo3eeniEHWUOvOQr5eDGJa7jMw5uJueo9l6EPmM=;
        b=I2UiURWrfqK/mC8AldN+E4L0v+sO9YWGg4WGjvdqF3G4qnys7d59QZ4jXLxsu6Dw9p
         mq0m2Qs43oXgYWQkGtXEYdulrHmjdamIzmxU94TZfFgVCPfdqs9xNqL6kp3t5+N8m/vD
         w+OGzmj9lnUGkWakPlvzkJrNduHNK490jRdOQlah8yP2HRsIsASBSBNlOYqgqezgmkFE
         GTIW7D6Mxz6D81sCmYXlpJIn6LuAi8bxDf40Qqci7KCsdVdTWqxM8p9Wg6QYGEekwoTM
         X88ULrjcvUfCpf0W1hqMIO2x4mLj/6hzb8lghw3mADrorRzkCldWsMudWG7pudL2Tpug
         SIag==
X-Gm-Message-State: AOJu0YxYcV5lriNPj5TqWz3aB+ozRXx2ulRh0H84VhgxOPV49ADTANcQ
	BijtH1TV31ULAxHtg+eloi8=
X-Google-Smtp-Source: 
 AGHT+IEpnvztJJ7HO3LB7tD86lnw5g8Py4biZ+7rJUaPiHU4q1Ub+9TbQ2YansqORcIItaDYEv3juw==
X-Received: by 2002:a92:505:0:b0:34c:cee5:4bf5 with SMTP id
 q5-20020a920505000000b0034ccee54bf5mr10148093ile.5.1693103529979;
        Sat, 26 Aug 2023 19:32:09 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:80ee:1859:87ec:6d31])
        by smtp.gmail.com with ESMTPSA id
 n18-20020a056e0208f200b0034202d05fadsm1581533ilt.72.2023.08.26.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:32:09 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] arm64: dts: imx8mp: Add micfil node
Date: Sat, 26 Aug 2023 21:31:55 -0500
Message-Id: <20230827023155.467807-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
References: <20230827023155.467807-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EGRV5HJVVZRXIHUE4J6F7HGPF7RYUTIE
X-Message-ID-Hash: EGRV5HJVVZRXIHUE4J6F7HGPF7RYUTIE
X-MailFrom: aford173@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EGRV5HJVVZRXIHUE4J6F7HGPF7RYUTIE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The i.MX8MP has a micfil controller which is used for interfacing
with a pulse density microphone. Add the node and mark it as
disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 79cdd4c066c8..b44851a2f579 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1473,6 +1473,27 @@ easrc: easrc@30c90000 {
 					fsl,asrc-format = <2>;
 					status = "disabled";
 				};
+
+				micfil: audio-controller@30ca0000 {
+					compatible = "fsl,imx8mp-micfil";
+					reg = <0x30ca0000 0x10000>;
+					#sound-dai-cells = <0>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_ROOT>,
+						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MP_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.39.2

