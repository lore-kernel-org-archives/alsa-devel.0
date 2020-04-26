Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C6C55191
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:08:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A992071C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G6SffBxS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIyo/Bmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A992071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3928D1679;
	Sun, 26 Apr 2020 14:07:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3928D1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587902904;
	bh=FgWiHJIhcBIXm8IifzFtJXPaLmPJ+wXIbIo9qnNWWfU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G6SffBxSV30yDv0F3jMwbPApH9wKB89SB4ORZNYFgn+pbMyauhwONpOr7cnWCtgPZ
	 XesqZopn1fumt53uHvh2q0pfxciat37lb44iuhPITSnheNh7nnzF0eAB8BxHE2QYyg
	 brgoKiXlST7XZradKjvt+5F2iaARGSLoapDc8N1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A7CDF802A7;
	Sun, 26 Apr 2020 14:05:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79B53F802A2; Sun, 26 Apr 2020 14:05:00 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84751F80229
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 14:04:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84751F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nIyo/Bmb"
Received: by mail-wm1-x344.google.com with SMTP id 188so16355486wmc.2
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6FIu0CKz6K8bw/qZHzUU/qulO7p9niPo12Ocs6dso3A=;
 b=nIyo/Bmb96CC41r6Cn6/hrDqIswZRgvihoA+YRaXmQpSvcBkYcnyPwLW2/6T5WF8io
 cXrL4Rm4RhQh3end54PK+wBCPqD5dSt3wcuYZy66eNomHHqXU+j4bTqcRRyJZsjAxy2Y
 9ooxBEr9GdYVuHV5/MFH/p5LnjRA8cb5ujnTdYt+JfpxuwX+qo1YxKZoxOD3aWnAzGnL
 yyRD4lmWbx2EL+XvU+IhUtRQve3Rlwc52e6PE23EGibGfmAd9IJdEcW/7KAldSYOE3zE
 FPxYcXB6fwitkkAFGF2T1ltqCuMQrqN6fUeFmF9UKzFnxEbN2gp4YF3PtoYNjOMOJ0d3
 DqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6FIu0CKz6K8bw/qZHzUU/qulO7p9niPo12Ocs6dso3A=;
 b=C0A85dC+OFuFHNyPFILL6IpAOntdiklEbwlOfP/Z1L1jpn8s/X9VoLjQ8+E5enHfos
 mekupcY+Q/9usAMRMr9T1DMZKBL7a5GmYAjOB+4ToAk3CzFVK6dKMHcN/oZGa7v3aB0A
 o4EusWK9+z8PCzCrdl7uTwETgpP+w11HuJlcOeako+7nb2i0Ck1QWezA4N4cMy0PCjRa
 rYun+Xn6Oo8aMjs+imi0aHldqnTYI6R0pS6nsbAntr2HIDFKvc3Yfa7wt+iJDj1I7W39
 JBdgZ5ebVswm9Q3l0Ok9fCi/5/WsXmqrpQQWlIGAiI1cm7PEn3QX45I+CVioJ79Beiwr
 kQRQ==
X-Gm-Message-State: AGi0PuZf8JSFqzQ83hGXScWFc+BGCLhtlYoPonbcoCo2voDJBcrsrz/j
 beFa/hFAqrvKbJ6vh1uhiIA5NGwgY+x8zQ==
X-Google-Smtp-Source: APiQypKbb8aW5E+I7IyMgkie3hkD0SZYHTn0fzk6KclUGwkr2OlHTf3t7+jC+BpE8W2ywJWC9lgZ7w==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr20743750wmc.123.1587902692186; 
 Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
 by smtp.gmail.com with ESMTPSA id
 s24sm11120026wmj.28.2020.04.26.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2020 05:04:51 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 5/7] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date: Sun, 26 Apr 2020 14:04:40 +0200
Message-Id: <20200426120442.11560-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
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
@@ -144,6 +144,14 @@
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
2.20.1

