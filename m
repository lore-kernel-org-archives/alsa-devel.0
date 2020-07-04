Return-Path: <SRS0=zuuw=AP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB95FC433DF
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:47:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562BA2084C
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="frRLz4la";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vd95Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562BA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED329167E;
	Sat,  4 Jul 2020 13:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED329167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593863247;
	bh=MFKVMWUPrhlI6G6oprRvcbj9c9ehm344gEKMbV+VDm8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=frRLz4laHpdy5MwsnauDfYLF7zb0SUxQbJHUqgnOx5l1hVJx0rocSQvEKggeS/AI4
	 ydaOUFZ/tHPRXvmlZamxCDElRGxsf7TZvVvyLccoSevDjiuXix29CfzDBq5fmNssjv
	 7KeXWH4BHfufUlyshXGu9w7ChAADMtJ99X9eBnB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75135F80335;
	Sat,  4 Jul 2020 13:39:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B52CAF802FD; Sat,  4 Jul 2020 13:39:28 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88FC8F8022B
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2020 13:39:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88FC8F8022B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="W0vd95Qb"
Received: by mail-wr1-x443.google.com with SMTP id z15so24151387wrl.8
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2020 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vVjW7FiC+qSaQ3KBioDqK1mV2GwG3KhiYxWo2WY1YG8=;
 b=W0vd95QbcYPxywbQ8+RJ8ztu8DvaIkr0ZKZitkNzpk1C9WB8xdrZhvB/JHiMxOaX6w
 tG55l5DSxI/MHd92V/oAFfN31k91tu7G3CuqVPR9EAYe+/LWLF69wUhr1wHIXKjXZWFF
 ps6F4O98jUYhoh6t/XTfLPOjfb0g8dOlfcXi+Ls7rzXpN0Y+/Y+IPlMPO0sVJKtESqnO
 jo++bS18e4d3QnhkVNi2d+n4FJtQJWSr2yZC/0H533V7Or0YyVRns5b+gpgqn9IJEji1
 hw9NsWkziOWm4S3+KrFAQpj6iZ2g97dgkRjWrm5L+4dS0Ej6rygfY2qkHyAae9/nXkpj
 RI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vVjW7FiC+qSaQ3KBioDqK1mV2GwG3KhiYxWo2WY1YG8=;
 b=JIv6tYEW1WixABnXqomZY8ewjj1FBgFUpoovGGwUFao0ohxh5pSX+YB6ytjEGD7VOc
 9ckLbtS6JwWsBWnc+GRei0N3AZyD8lWiipEZVdP3wzlfFVLsB3VFYUZxyDzbTbgIA/TF
 YNDe4VW3M1JeF1TIID9QNJXJjn7Mnl5V+yR3tHLcmVxHl67dtNVKbN+wUvMkf5MdH2hp
 l3CEZHLq+M5IU4tQWl7LuvER/qgQmgEszZWNHUC6pGhcYL67dJs2h9CKY7CXwJlp1CHv
 m0mNl2PlS8JWK8zdIbez6he5y4k8Fd3XNHC4YNfLBpn7XMRRwkvuQO94pK43RbJ8//sU
 PMCg==
X-Gm-Message-State: AOAM532ya+k2TpVSmr9Rmk3ELqvPsFLX+twaSf6l2iQj4PMzmIrYFPD7
 cbLlAibsrNb0horX0B9+Wig=
X-Google-Smtp-Source: ABdhPJwerxoQFv4zEnNu+Da57+LRJoLW49iAkIp8U0yBpTUxgLCXgzWvx3YJVjiOUOqQbUJjIMeB6A==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr40337474wrs.365.1593862760024; 
 Sat, 04 Jul 2020 04:39:20 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 04:39:19 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 12/16] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date: Sat,  4 Jul 2020 13:38:58 +0200
Message-Id: <20200704113902.336911-13-peron.clem@gmail.com>
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

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8dfbcd144072..c662f6a170ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -845,6 +845,20 @@ i2s1: i2s@1c22400 {
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
+			dma-names = "tx";
+			dmas = <&dma 27>;
+			status = "disabled";
+		};
+
 		dai: dai@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-codec-i2s";
-- 
2.25.1

