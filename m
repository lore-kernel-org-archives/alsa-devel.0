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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAB9C2D0A7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:42:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0B82083B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nWJIYrKC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z299lBM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0B82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C79F1AC1;
	Thu,  3 Sep 2020 22:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C79F1AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165753;
	bh=XNKZr4YxG207frcRssV+j0jdDFGgQG6cjZ75MkXhYns=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWJIYrKC2DpS7rPY7bF6YllahSFxeMe1eJg4fHziMhlsWcEplGjrnHfB1RHAb03oP
	 RSc2UpriPRuJ6uONuMWdFTbQDW8txBaH7VpHKp6y16dCRzXkJRgekJWi6/YWMQPmaA
	 ATkuNXopKrorIVRX6yYTALti5qPpGAulLBJOMAyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 670D7F8036E;
	Thu,  3 Sep 2020 22:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89ECEF800F0; Thu,  3 Sep 2020 22:31:39 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 140F0F80217
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 140F0F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Z299lBM+"
Received: by mail-wm1-x341.google.com with SMTP id c19so6098723wmd.1
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EGc0yXuTiDFTGIiyB8RKG2RROl6pKeDEVLqeD/qlySQ=;
 b=Z299lBM+zeS6T63IlyOyPftevP++hmKvFRve7cd4JLiV0g+AYfED1OpJPoqyClpKLQ
 U4Cof/TLllguqcQpEBBuN6xdrbHUMJfRX5bVgum+js04Lk9ImuC12dH6jB8dWDn51kQ9
 pMApAk3W8s+0AByLZH9G+/sNsUIgWp/aMqi+WwnmNN0c5NYb0FfPWqQ5tmh8tqbICh+4
 qc6zFWPKemXHt5jCTYvkFOaFXVf5vs7GnI4hVF5Wj+UM+EfxqqgpSMtyiaT+EPgTrl3F
 8tuR95Hr4GboBN39VxpdIDhNwRrFXju/NDQ2HEAKgOUNeeVu4G1kgms0U1qKOjy32U7C
 c0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EGc0yXuTiDFTGIiyB8RKG2RROl6pKeDEVLqeD/qlySQ=;
 b=eLyDOQiRMGuJ6zx/HZMcHNTwGlsIZnXWaalMkXox8gE2bT9PNuxe/ija6d57SuQK/C
 5KGQwX5yhhoqefVqtNV0HFTHpm2dWr3RgbnT56y+4d+uEHAH8DYWe64zqGRNOVa4KlkM
 IHqODVq7Xpy0mo23hWAEVlkN92jWVbgjx0v54FwHfP3/Sd7h6K3a6R/KDqf04MLVoFvC
 NSz+yDSGx1Hgp0x4OarrFCwm5CyEmeCgisRYbrw9p9cNCiYvVnxtNW15R5Ks7MTGkoc6
 WimA7OLc360BYX1rcdfTxDDgJWn3n03UE5/3SSystN4EcCpsVqQhEwv8/62vkukIJh2s
 1rZg==
X-Gm-Message-State: AOAM530VDAb0QDIdpSTbS2FtIwzRIffDq1qzWfaGRxFlIPeiMOPrUCM0
 fhyrZ7SFyHuyAdDJCt+7TdY=
X-Google-Smtp-Source: ABdhPJxQ7DZ6I7oOzap9bBKEMFXCm/suuPFfs+wc6lgap5FkPRR1GPgiwQFHEnBKqx2fZHFh/ybsYw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr4186180wme.8.1599165047136; 
 Thu, 03 Sep 2020 13:30:47 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:46 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 03/20] ASoC: sun4i-i2s: Adjust LRCLK width
Date: Thu,  3 Sep 2020 22:30:17 +0200
Message-Id: <20200903203034.1057334-4-peron.clem@gmail.com>
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
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

Some codecs such as i2s based HDMI audio and the Pine64 DAC require
a different amount of bit clocks per frame than what is calculated
by the sample width. Use the values obtained by the tdm slot bindings
to adjust the LRCLK width accordingly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index acf24f512f2c..1b4482b0f4af 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -478,6 +478,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		return -EINVAL;
 	}
 
+	if (i2s->slot_width)
+		lrck_period = i2s->slot_width;
+
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
-- 
2.25.1

