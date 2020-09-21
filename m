Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3AAC43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:35:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05B620EDD
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CQmRTBFD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4aevM37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05B620EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 640DA16FB;
	Mon, 21 Sep 2020 12:34:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 640DA16FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600684542;
	bh=Ffu0p009uCbD0lcNfaK6xKfJNWxF0SG5XCL5X9Lp6GY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CQmRTBFDz1tn/ayWTuVR352mIDAhXjIEaTVsQQwm3m1uMbZgGi8EmOlyJa63Ro04U
	 ZyuAW7e2y+O/qddNnOeUPqmv03ZEp7n5Fm3QqB/pgukIjMowj8NVutYn2ip4It8dld
	 +4yAnWsGJCZZfTEoFRB5t2u+Ik+4ZcvSKvaMCuuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1507DF80344;
	Mon, 21 Sep 2020 12:28:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1C18F80308; Mon, 21 Sep 2020 12:28:15 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52CAEF80171
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 12:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52CAEF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="a4aevM37"
Received: by mail-wr1-x442.google.com with SMTP id t10so12156170wrv.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
 b=a4aevM37+SprF1bLM94DNefZwrVfG7PKjwoGEHWOWnCkjx1KIJclErcP52rGECmy2u
 0NEE9ml8OGLWkm/3AMJ7grlyWFa/vsQq3OsnjazTLMkSJgnLJrXOPst9Wu4m8u4HdNj/
 whepRegy+FZ3ni/+MFUwgnhQB1AFtwcMKNueTTkcEUfFOjjnRGjq+Td49w9ZwQ/ZQgbn
 WKEZ07BSLGds6GmulIw24MmMvQFUIIn1SfOHralDmXO3duE1dKrfOSTgbAiC1i3GRdK1
 agG1yrHxpyBfkg1+NfkVM2qNag6DuILrjoR2wVFUl09XeYSrbcPYovrD974+SaBj+udQ
 FOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
 b=rtllXWidh9ihoFOiA74JK/7aKbuVQBlXCX4+ZCEx0l5A2CKnfbChkRa/iyXEn72TU3
 A5bO7f4hSELFMzpmgbU9K0Q5c+l1veuxRnmgU71OpL8vcKWprCrhFVYCVYb3wIX3ok3B
 pGMTLg+T+YQFuDxISGpxWE364rCeduKK9jjI6X3MW4YSJ+laaCyHFUckYJWIe/6iocMe
 pwq2Z3yutuAWoFDsYZlkXt9LG9CpI0s27qkxjVii82/Mq5wK2EsIcnDD4TTXoHmmSlUf
 jkRmK0NkpAEyFTpNK+e/ulZ7N1eHluUcM4/m9VtI8LZOpVr2xUVTGhNPZJuqwvEyxDW0
 VX9w==
X-Gm-Message-State: AOAM5337UxleFP07NnYB9Pqa/oY1gQ2RlYSZg9sa4F0OV88SpU3O5DHX
 gvkmPu3OCFC9vpXayqnujWQ=
X-Google-Smtp-Source: ABdhPJxbA7uANPJzxa10IXud9ItkTWxz6vNBdSRqG1AtDH9W7d1HGj2bTsIlcisE/sk+/ZBjoTqN5Q==
X-Received: by 2002:adf:f586:: with SMTP id f6mr51529912wro.299.1600684075307; 
 Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 03:27:54 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v4 16/22] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date: Mon, 21 Sep 2020 12:27:25 +0200
Message-Id: <20200921102731.747736-17-peron.clem@gmail.com>
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

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on the Beelink X2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 45a24441ff18..f9bec6935120 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -142,6 +142,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	linux,rc-map-name = "rc-tanix-tx3mini";
 	pinctrl-names = "default";
-- 
2.25.1

