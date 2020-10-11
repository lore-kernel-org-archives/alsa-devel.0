Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0E7C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:27:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060762145D
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ax+baWg4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDKH1w+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060762145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FAFC168C;
	Sun, 11 Oct 2020 22:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FAFC168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602448030;
	bh=B492S0gbzMVEt7zK+0CeVGTw6bnlEScnnoe5BJP0QfA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ax+baWg4pArmc98AaYhTOGD9Qg2MABogHwJ15h2fmvQXJKnpEBr7u/dcUUTRJNUcM
	 s1OPdOtPRflroIPSRR1aQC983uk0kpsP4LBZASm67NL2nVoJe3uxXPBwc5xpUVzkQ3
	 SC7PAAO1kCTzqlcQ1ADJh1ZHoYVwY8GBOylx9PL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B083F802B0;
	Sun, 11 Oct 2020 22:23:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46CFFF80297; Sun, 11 Oct 2020 22:22:59 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7245F8028F
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 22:22:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7245F8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="EDKH1w+P"
Received: by mail-qk1-x742.google.com with SMTP id z6so16077724qkz.4
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pwVmd8q6/xF4Z/iHMmW565olMdZiqSSZzSQVJZEvMNY=;
 b=EDKH1w+PS9wgUBgnG0c+as4kzQfgC0b2YG2vs2aDcGRzieVlYK7mytge/Y3MduSU26
 3Su8uO457kYU1XSQUHt5UWkmV5p8TS2YHH/4o78R4oSNJXO5YDKoIH0TbqRuFvpD1yys
 kTvGH41n0Fp1mqMSwIoUyPS+u1AtJ0VfgT9d0JU29RZ/D6RdFs6PfzOCAwlhxMx2/Ip8
 tEUHdgWlSGncnaQxR/fcDlMwHr1MISd2TGniZnLY6wVDwCCUEVVRXytjcMfIG/4kfQdQ
 YWXmwG/Q9/5u2/yTRDHKhcaNFjpz9jlkRozeS8Pd4xyFlsjlFmXIq+Ld+S/0mVOVRhBH
 f1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pwVmd8q6/xF4Z/iHMmW565olMdZiqSSZzSQVJZEvMNY=;
 b=H3Q5J49C6DfkiHBWxPnJA5hLrTa7njhc7nYcW3XtrvgGFs5DeCX88vgK8AxsUG1X++
 32GgM8UWVSiGRhxUEsSd60IE+dh0ZO4me31+zLmymzq51KZBWfe5TXaSOquCElYa4fvA
 cEXh/A6jMDgmkTtsSYKonedn7LvpuqzlVl6JuYk8+rAzUsxaST2d+FxvoBUjFe4JRgxu
 lgor30Uo/3QtI6B5UQXB1BeJnDCSZi8RCp8sgFpMHBIc6gO2fVpaP1RJUHM3BozdDXpA
 Q1mcEAICROg3PzMv9cmlbFoflkM2wYCrMwAbC4P5WGOYpu9HpIifom56Y+JJW5nenPLQ
 F6PQ==
X-Gm-Message-State: AOAM530Kkat15If5766S8ktm8CNr0xrT6XcvYdGu3PPipBFPuWZP3Hfs
 u9fjth0QOmbKvgE0ixJkdyo=
X-Google-Smtp-Source: ABdhPJwma7ATFj/LYHPNUv+5n9rjXATsJjvZSlxf7Dw7uRa+RqRYE9uSqoaU1C2eBCR3dxYMZttPuw==
X-Received: by 2002:a37:6285:: with SMTP id w127mr7282847qkb.454.1602447775138; 
 Sun, 11 Oct 2020 13:22:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 13:22:54 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v7 08/14] ASoC: sun4i-i2s: fix coding-style for callback
 definition
Date: Sun, 11 Oct 2020 22:22:18 +0200
Message-Id: <20201011202224.47544-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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

Checkpatch script produces warning:
WARNING: function definition argument 'const struct sun4i_i2s *'
should also have an identifier name.

Let's fix this by adding identifier name to get_bclk_parent_rate()
and set_fmt() callback definition.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e7b9dcbf82db..b2923d4c03af 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,13 +180,13 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1

