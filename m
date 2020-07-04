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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B2C433DF
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:46:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881BB20890
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tf2v8XXR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knZfke3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881BB20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FE18168A;
	Sat,  4 Jul 2020 13:45:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FE18168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593863175;
	bh=eWiiq5Url4azgTOk6WrrOLGo89ieP4u00auyyK+0BG8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tf2v8XXRr4GebbdAyxJCAIWqWAFzSQQTIGhUDh02w4fcoOQ+KCSGN8HIhzmX7fvjJ
	 zJLqlxDalOxlCCvKQFVc7K5N9h9dFHUSYFDrnYcsOA4FOBn83FiQHJtv1V9JoAQqV2
	 o+YF2DBewikFt8EFJ8sTfRN5P46Ran5q2SS36P1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F89FF80328;
	Sat,  4 Jul 2020 13:39:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 726B7F802E8; Sat,  4 Jul 2020 13:39:24 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD7E5F8011B
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2020 13:39:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD7E5F8011B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="knZfke3s"
Received: by mail-wr1-x441.google.com with SMTP id k6so35448490wrn.3
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2020 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=knZfke3sKYc0DXJM2t47oa2ovnx/dBeypmgCmiy3LPvRXi8c8/HnzAF1ftA44DIpVM
 u17jA8jPwwoWp/t8Ya47Jcbhd1CqcMj0+Mw+mt/E2zm25zjxG84IszIewvufsi+WlbuP
 nlHtCuAbGywK1wiTFYj3mfmErCdtgBOSfv1DqpGJrC+dJIN++ap5vun2+TcaV4voxohS
 hgd41PtZ2U4+cMgGmx9yo1mismQjgSIksxzaIeqXxIzj63hzYwX49+Uxc1Kb1gBh7KqG
 HYxa6jrxNS2qIRh4fQmekm32pi06pwsMtZeECEmDCkKrFlwVFtBb+OywLFbzEMrcNuVU
 yC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
 b=dlnpbLqOzksB5eiB3UTKTbq/NQpRQ7ab2rmWQja9tqUvv6xDthVy2A3LWola3oFqqR
 MBeNl4fg+neMWn7eoifjl4wqK41fOZ8Q2H8hdYeNiq2HvYr9LxWACX0aoerFzl4/1ltR
 a2dnrZ6LkcD7w2Kw5K5XJ/GxF4VsSnO4+8Njt/A3WXWXKbeAq8Lg2yHj50EScFWbl1kM
 O8pP4v1yJ60IUZTHWpAjWp/zI3sDn9Un/FqCjzhNiV2vWMQWsLKf+14flgDgSpXjPVQu
 yM+GbP0qKYWUuc7AOZCQvPHRPqtUPr9zLihkY60cz1qzRwAozuXGbsaHINwxTKLa1u7r
 Fv/w==
X-Gm-Message-State: AOAM531120+xc3/A1c06mSTRloppbspEufi70MEiMukWqXOTBYQnI5ue
 uEGIysEdNRB3+a6Ehueq5sw=
X-Google-Smtp-Source: ABdhPJxuTS7kWmB4UbzVJyIM3G9fZFmSLmupexqyp35pR8yUKDd6X4+414YmhPgrPW1m9h4bEjT62A==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr39543136wrt.49.1593862756426; 
 Sat, 04 Jul 2020 04:39:16 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 04:39:15 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 09/16] arm64: dts: allwinner: h6: Enable HDMI sound for
 Beelink GS1
Date: Sat,  4 Jul 2020 13:38:55 +0200
Message-Id: <20200704113902.336911-10-peron.clem@gmail.com>
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

