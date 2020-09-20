Return-Path: <SRS0=okCM=C5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D6BC43463
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:14:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB78207EA
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p8rehAZB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od8msnBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB78207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 042A016A0;
	Sun, 20 Sep 2020 20:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 042A016A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600625639;
	bh=eWiiq5Url4azgTOk6WrrOLGo89ieP4u00auyyK+0BG8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8rehAZBAFDLV4TeyKzcWAOq3W+J/83V0IIEp1x0hIdSMDCuVS4lfZiqhnDA3XmmQ
	 2U0XKv1riMGQ+AUVq40/KWbKDfCZxPPJqeA8euEpvQeKtcds3IRtNYofgrnlBABdiO
	 bM/Fx8z1fw3oSTnphfw/4SgzG0PkwqVT6BwLo/Lw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4AF4F80303;
	Sun, 20 Sep 2020 20:08:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E740F802DC; Sun, 20 Sep 2020 20:08:27 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04F9DF802DC
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2020 20:08:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04F9DF802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="od8msnBt"
Received: by mail-wm1-x344.google.com with SMTP id s13so9957049wmh.4
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2020 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=od8msnBteZldCebjDA0LhBvuf3owGuNVeXNmfc8zL2GnHQS7hZR0U+kvi5obx8Dq8a
 eOOF3U5APL9OcA2gGUxW4wAB7T6ZZkcqxri2nZxq18s+BtaSkBiqPjqedJy6r/spZIUL
 pkAz8YIn13puAv7TpYjMW9xBCk+mN2vHIJ9Yp9qm/3GPKy8rK2RegOH9IpHw7chDX7F/
 agkswXCDJiqfqNfoy8Kf++GcFQElzxzPBltqWl3BBCMzMxknuCPMEED+9mOiYYk/KMWh
 pkH6DaQ88kcjqIUyr88HzCrXykSicoogxw95gXYjNhVi2Jcie/spXWbTBBIE8/bK/6fU
 lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=BiykBeLFthywKObYf+/3IoW/1P5keID54eqcFH2QgmVYjFdU2WRf2Dm23Zspv2vFC0
 6F3TdeEPOHn+u5Bm/WUW4Oy6+HFyjPKwImfaicNGDTQ/ggLVVArlGlbcqUfxZoNt9J4m
 cdgcuIOHJfaNiZ5ZYa0F6UtszOF7Ci0UP9nB+26gTD7Dsa30+Kk9ojArWKvxLz2BOgcH
 JB5uvehZvqQ5P7p1RrttOrIwRqypVxBNDXODwwfKMfoSe1wCn6N0V6fsn3IdciSSZC7q
 9woVE85phduD3AqH7c/vMgGJN8bNftkzKykNJcp5mWgFDhHR/5CSgHfb3jAb+q/4uEHk
 n1qg==
X-Gm-Message-State: AOAM530D8f2hu/0LwqacJofLNMojduJBuTaLjixQYEs62GAd97pPeIh5
 R6b6IB0kK+b69fG5/aOXlbs=
X-Google-Smtp-Source: ABdhPJwcGaD0crtgI3afCNwwoShmAF7R7HzisPHTeGnNrjW67KKPM9CR/iaHPhakzxHB9RZkDcIpYQ==
X-Received: by 2002:a7b:ca4a:: with SMTP id m10mr19858849wml.11.1600625299426; 
 Sun, 20 Sep 2020 11:08:19 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 11:08:18 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 08/19] arm64: dts: allwinner: h6: Enable HDMI sound for
 Beelink GS1
Date: Sun, 20 Sep 2020 20:07:47 +0200
Message-Id: <20200920180758.592217-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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

Now that HDMI sound node is available in the SoC dtsi.
Enable it for this board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..049c21718846 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -118,6 +118,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

