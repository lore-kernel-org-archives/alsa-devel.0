Return-Path: <SRS0=Oq54=DE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08779C4346E
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:41:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BEE23A32
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G9/Oyscf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZyv2VLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BEE23A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4373112;
	Sun, 27 Sep 2020 21:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4373112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601235670;
	bh=Rb5wXmBrtBKDogUuv7UZhOrx+urFeYY/Tiyvce3YfbA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9/OyscfHoil+KFmOnSWo2vb/5dq7XDe0544lYh+MWoJykTI2fGKjS5RIfuFoR+rx
	 ZfLOVikgYP0FhQdWd+/a8GGP6snHUZUFZNqNGeVLUIHvRaGKxEI0JW/Zn8RNC7gR9y
	 gxUg1wxcOrj6rTplhVPrbLUu1a8j4C0RH0KAG+8o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70DBBF80350;
	Sun, 27 Sep 2020 21:30:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A56E7F80305; Sun, 27 Sep 2020 21:29:58 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DC25F802DF
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 21:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DC25F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iZyv2VLE"
Received: by mail-wm1-x342.google.com with SMTP id v12so4627764wmh.3
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
 b=iZyv2VLEgfXdTf101uh6h3DUe68TxHsCdp8h9PNhz+JBiBd5noYxV5hWSysw3svFrO
 3hzxseVeGw9pxlCAjvA1BEPYcTTNVp8XRSYF73HyhH/NAYotAPrd5ORkSlV3htIziMEV
 bsnAMNkOGupuZWgg++cuyQImqtV6MwB6N9Sd0RWmNtFcYWfqV3VgP2yNKOdZlPy+Nqf0
 nXuHSJBIpvQs/gztfKSdSLSxOO/cWLMnu6a9O+wf3uF8ENpQY+2OSARre3pdmy0RgC0c
 I1gzQj5z6mrTNLZvqlS2y9qNL4XvFDQ+rEawDAYMIWC9K/6G02J3NvyONDaTQlWhN5yB
 QXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
 b=q0sziTjU/RuysKiZz6ty6/laePE0/DDzhCUbfTAZi55N6RRCD43+AWkEjib+ckIhVS
 LmwbdBZMPH9jaA67oIZ3GSj+sOEFyQvjl4BmX7uiMhKRW6Kwn18ONb2olemn8aTPUr/n
 wOPvfK8VjCH/XzcYN88Hgx2gI5MG0hVV8VuBOlrfkW7mQJl3mWP8wS0jByzemENGWQRL
 OgPnDtgvjQS6AD7cci0S9n6113vR9BEVCDtG9ZKNpgPzwUXnuq6WGnahoHhMxF4IjpyT
 I4ukflauAVyVgdKxawP2xqIs4I6vanBfqPTmF9PTzV5PdhoxUKqW4QhT8ctpW7Tq6Dnu
 XXbg==
X-Gm-Message-State: AOAM530R/m8+8qF4knVvQTZNzLziLuFdqLbIFUGsv9JGDuITdqpgacva
 G9SxzrClfQeNCZ3T/OxoZiY=
X-Google-Smtp-Source: ABdhPJyMfhFmZdZRNFIA7hlt5CN0yPE3ZvZ+6BZVp9QyVpTd/nn/PhNL8cZhWvAv4entdLHdnxWazA==
X-Received: by 2002:a7b:c141:: with SMTP id z1mr8285789wmi.79.1601234977829;
 Sun, 27 Sep 2020 12:29:37 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 12:29:37 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 18/20] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date: Sun, 27 Sep 2020 21:29:10 +0200
Message-Id: <20200927192912.46323-19-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
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

