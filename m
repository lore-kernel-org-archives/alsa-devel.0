Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA34C43461
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CB220684
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZqIemSYO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AofMPUlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CB220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF6A21A9A;
	Thu,  3 Sep 2020 22:33:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF6A21A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165261;
	bh=eWiiq5Url4azgTOk6WrrOLGo89ieP4u00auyyK+0BG8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqIemSYOLi96UnI+lut4QcZB5j0eN8IDy7xlyJDOiBjLKCZ2VloygmejGfKO6Vfx3
	 hOCHi9UL1nxIwPuCZOhIrUMm6TCoxG2Fj5pYkpX/AYxGakin3IPQi9+Ddk06ylmy/J
	 o16YJa8mxwUTvgcL2uM5Ijo5NlU+5juqE209JcXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC94DF802FE;
	Thu,  3 Sep 2020 22:31:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87938F80304; Thu,  3 Sep 2020 22:31:03 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B97A8F802C4
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B97A8F802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AofMPUlq"
Received: by mail-wr1-x443.google.com with SMTP id e16so4598770wrm.2
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=AofMPUlqcs0dd76rChwiMRdo55Jcj6y71Rgpbc1aNwUqPS7DJdK51GnxB3YwpAb3NG
 XtTZ5r4ef8N99rsLokQQfNWhGMHgv1hPPsvOKTAjMhGYLZFjBpS8pyEFV/Go+VCyZh2N
 XriN57ox1KygKYA7FmKA6+iR/Yd6Jcp5WL0f1h5lPc1uFbng6IRcCtbOkiH9tUbnt0os
 ZJcUA6vMaY2lWQnz443ZTh3jmJTIy2+s9VKV6ZojBHp04MTpQo1ypxsAvA4r3WcX+JIL
 9/QLQsAdGvaLC1VdhzQ7PeDD20Uewfys34XP3q3m1Gw8oY3P68FB0TCMsztZSGAFEEVZ
 1mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=HlPbTSHog8lXNaQbSJwgmZ5cOxtpEDs2M4LFlYLC4MGC3g6ShFJl5bmDlAsy3EUGS7
 Bh+cY+UsFcG8KYd/2owLsbdzLzYNh3r2ZK5lXt/rF1v2zcCJlSGbRK78Hd3gMX2d4MDO
 gVMalhUEY32k0TF3AWRul2uQVC4v3IpxSYsRiwjWcrRbDwnq0l5nNFCxxm2a0CWSlnIQ
 2dncahFbtU+exVHj72nRyWFJKmmKlmGviE0pWOJ+8zFMWTtolaygh5NNDxIlI9RqB2Yk
 HXvvRjTPqBwxT4GNNKYTlgXlB0xL2qqnJp0r5KwCEWcBqo/MalN8jIkxtmZtYjCfKkuW
 3O7A==
X-Gm-Message-State: AOAM530YgXcOeYqByT5Bsq0axYgiBJ/ad4lDenrhioieAcQDGDtYxWo6
 opjXCxn5272995v2ZuaK/QY=
X-Google-Smtp-Source: ABdhPJxM+s4BW/s05DxzE1Osvppd5Q7WAI8huiPFbLd4i9SxR7Berw2c2tV53IyuNTsJi9Q8xKfLAA==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr4577028wri.292.1599165054048; 
 Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:53 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 09/20] arm64: dts: allwinner: h6: Enable HDMI sound for
 Beelink GS1
Date: Thu,  3 Sep 2020 22:30:23 +0200
Message-Id: <20200903203034.1057334-10-peron.clem@gmail.com>
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

