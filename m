Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB5DC2D0A7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA5B2071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Egc4PQKc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5vk9jAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA5B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D452E18F8;
	Thu,  3 Sep 2020 22:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D452E18F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165650;
	bh=Rb5wXmBrtBKDogUuv7UZhOrx+urFeYY/Tiyvce3YfbA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Egc4PQKcJCV3lHWmUP6C9Q5H10enhb5Un+e8GPrpkKum0V7389Jw18C/zQlkshgy+
	 nob4tyhXVXHgdagH4ugT4N3kT3pXQ0EdMjX90yADnuPUQW4LSTw3G3Gxh5k9GKVRoC
	 Sev9W/JtBkoBiwFkwuzRNpmdZI2T92wW/DtvgFlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 328F9F80362;
	Thu,  3 Sep 2020 22:31:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86163F80361; Thu,  3 Sep 2020 22:31:30 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD407F80323
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD407F80323
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="K5vk9jAu"
Received: by mail-wm1-x344.google.com with SMTP id b79so4119724wmb.4
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
 b=K5vk9jAuMg+7u4ZOKCzRhzqDjr3f7Qc8HprHbYh4Y+5TVknoECOVpj0q2LEw4rSYUw
 NFp9jVoFOx/WNltsI3+i5YlWvLBV5wYXhf9KTrXPITe4lMKTvJRHCEoXF2NPPlEbF/LN
 RNK3E3jc5Tcqp5tp7CrGybxG7OuPpGXQXBB1pkmzjHGxrsDQuFSMAXn61NxGqKLHdWIv
 TU46VFL1X19Tg4phIRMZIDRBn6jO5c5QrlSuLDcFt5wH7GEBcVHIGEXO1rKRMTht4F39
 16CfA5wDD3fdRhnmckByJn3bRx2LocdtnnVDmxB68FD2p/VVXhAFZnolcAZuqngmEziB
 pcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
 b=nyZmZorAeWsEEvzgn6MUvoagEDdTc+GP6tAEWH9MPjzN9o/6EEYxMtiLZjN/goQW8f
 2i4Vn/Padq6IKu7Fkbt//b+aqEZC2t66wAUTbTbWvuKKBun60i3vsZOE2l0ySygM3VCW
 NtUk+RZ/pN+5FOSWZwl96To3bdUmR5TLEwcHktY65IK+J6sAYywipqBu6QWtbKVPRpFx
 0McycUTAKKx0hsrtixk8IgO/kEmL6a7ClWFbW8lddD4bYVB8Vjzc7cuiaMybkVcF8vlz
 ya32x10Pbr6Iaj/Q7j2eXuIIoXSqc6b9ZJCACbw5q/B6ZzDC1605oUm1uX+P7wZk/yFJ
 Vr0A==
X-Gm-Message-State: AOAM531c50JMUZ6+SAR/QHAGQB6syqAFvNSqGw2j8zgIYSCBveE/6LdI
 cP7CODfrr9JJsTOEkpE3/tU=
X-Google-Smtp-Source: ABdhPJxs+lMWm9287ep2HEvwgo5E2HLax3EG19m3cXREGOmgBv7K/F0wW+lCpLavoAx8uLTvvIBc2g==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr4202979wmf.75.1599165065932; 
 Thu, 03 Sep 2020 13:31:05 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:31:05 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 19/20] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date: Thu,  3 Sep 2020 22:30:33 +0200
Message-Id: <20200903203034.1057334-20-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
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

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..193587e78031 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -128,6 +128,14 @@ hdmi_out_con: endpoint {
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
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.25.1

