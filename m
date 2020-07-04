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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1801C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:48:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7014220890
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U6P9mu0s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI4QP/0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7014220890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09A1A16D4;
	Sat,  4 Jul 2020 13:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09A1A16D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593863307;
	bh=K4dmeNGtrcbmftZRBPeJGLx+M++AXOW7aIu4gnDm/Kk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6P9mu0sLRf6AcFgeTXudm8mG3cQ1WJ9HTmuYOmZ7sJTQDObb2AOVAh2ga2Lx2mof
	 U1c2U+tD4vzMnpPF4ZSD7538QWJgiroPsjLB1Brl83BRqPDK29/w+chhGz0q0ERy6y
	 n+uqfEuSFhL2OC9YXxESLjLDOomk+mheAiUcz8UQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A97CF80340;
	Sat,  4 Jul 2020 13:39:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 545ECF802E1; Sat,  4 Jul 2020 13:39:29 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30EE0F802E8
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2020 13:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30EE0F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RI4QP/0X"
Received: by mail-wr1-x444.google.com with SMTP id q5so35410637wru.6
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2020 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
 b=RI4QP/0XowcZZZEDfaP14OZ79HPFwfYVqgUSVRFlOnoryDvXSQafpUzHdc2WU6Kw4t
 XVuI6DZmX7EW4EM3aG01vz5tdAdgmTZqrZSfO6KNeGEZX21l7HNbqjtqvZ4ecB5AGe9s
 bUzUX9U0y67YXncfQGuqiJ7Nmut7udl6JMkIMDF1cYPDQdHnauXv7wUf6bC3VTytZrEz
 Lxwp/KCUKCW+I518HMSD+qxajA+fHvvdawHodcY4Ug6s1IQ3tCuVrAVqxUP2+PozffUr
 fSL2k5nS6N9tCRmTcTvVP09+EgrXSSaB76cSXcyBHBcRHPWQ1oYGTJhhYXyER/CMkkL1
 vmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
 b=JYTAy9iuNtXOCM56iOM/Mx29J6QbSUxzxdzalV3xptN8pF1rbRRkYUuAIhMjF17CnC
 yblR5NobiOC0eTjQ6+CUWzP6z+fqa0KcJILVYTyauxhpP+FiCXzmuDM6NyU2sGohWoKC
 b1TJ5MmXg7n43LKhaQNyjaNYzSD/FCP+3rr1TwTXsBOkESAC/KqCtXlSKa+DslmEfCpC
 aOOgJvxmWQku5lSdLA6Ng9qwt4EMFOPpSMHmm8Rszh9/o5MxqkQ/yVhWU9GHhGtXXPO7
 C8JFt5URFc2Xn9kgJL7FZ9gV2H0gzglB3mPhH6ET15lRfSjZXKFAbGsVrJw6S8/007yO
 zGQQ==
X-Gm-Message-State: AOAM530vsNmJMDd2cnUSxI2oCSpqQas0aZwUHSvlGBGYjYZLgogwnWLM
 UN5iPMbMciJ9tuT23xj3ASo=
X-Google-Smtp-Source: ABdhPJymBfXZFsmvWSHG5QSNMx02/m8Q0qDAvFCTHckrezx23s/7LON5l3N2fWHpcKtWyxY8Kl7msQ==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr39545017wrt.119.1593862762417; 
 Sat, 04 Jul 2020 04:39:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 04:39:21 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 14/16] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date: Sat,  4 Jul 2020 13:39:00 +0200
Message-Id: <20200704113902.336911-15-peron.clem@gmail.com>
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

Enable HDMI audio on the Orange Pi 2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 597c425d08ec..64e8e2829f27 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
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
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

