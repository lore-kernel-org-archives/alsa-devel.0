Return-Path: <SRS0=1gO0=P5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30EC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 03:47:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93A160EE9
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 03:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C93A160EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E49D41676;
	Wed, 10 Nov 2021 04:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E49D41676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636516049;
	bh=9Mbphwktmz5hh6jYqELFouDQ8YWpwk5Jgc8AGUp8dgY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otiVUQCUNQUY7OMBUgO4JBvLSSMfJPBj0lP3otESqzlx9UkQ2ROPJjacN504Ool8b
	 trdhabhMRSgAgI9LIOiAfYZ2L7IsbMaeeosm44zUZ6qeuieKcpHWm9NapJ7HLAirO6
	 HQGrrc3Cl27DVA8Wl6lH1td4z/8liN477F3jBodU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4AF8F804E2;
	Wed, 10 Nov 2021 04:45:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D6ECF804E0; Wed, 10 Nov 2021 04:45:46 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E8B2F80054
 for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2021 04:45:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E8B2F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="IuHX1kyi"
Received: by mail-pj1-x1031.google.com with SMTP id np3so429290pjb.4
 for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2021 19:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wBoAGbVhgj1EGgLNyNq5oP4OsB/aYBvxLMmAQPjrD6M=;
 b=IuHX1kyiNtczzfyUF64wMUY5b45f+Uv3BDp2qXlpngL5oedAtDCZGO5tFmyJI3/WjI
 GiDhdtJu48qpDkXqdXoy5wXkZmCH4b7ySeE13HFymZUvhbHCIEz68uczRWWQsLvUzjJ7
 a9x4YFN0gWFYI1/kP9KLhF2Cql1VZRSz0U6CWQv0Zp6AD6KU05i9VuRm6E/MbKkCmKsy
 E3/j254QBwXOp2RSzxjlAvy30Peh0009pHdv6a1YmNHR9x2BGigdsyQ36oj+QVx0eNzj
 efh5pxV1hl3U6PpK+B0Nm7Gb/ZwCK8sFo7Kia7889DDCJzqLCJ7UydrPLYQo6StrwN5f
 JS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wBoAGbVhgj1EGgLNyNq5oP4OsB/aYBvxLMmAQPjrD6M=;
 b=Mhr6mX0PfFP9wlshXF9LAbrbX0q4yimvgYHQv2TyvRZ8YXqgLAmzA7p+sGjK3TW1rY
 cLQb1q2ObczkVZZkJgWmHJZq9B7RCDj2qjdPMSjhy1ECw1Bc32YhYIkQ/shz6po7HqD0
 cEtsxNZ3P6wYnVjMVxje3719kmbxt6BRZhHrjv9xeTFnY8kER9bWQ55/slb0DaDV6bVX
 SDlQg8iSCy7v6pArFjMLk5qHGLHVwns1qIGJxgCYS34A3HKkM+M7eFOqP/q73nY/gVE3
 yp1sVCEJxmAtUZFvcM6orEZY/Kg5yvxHN9Lst8sMcRIjX4jQJcBRPAnru42tVpD3qtkG
 mr2Q==
X-Gm-Message-State: AOAM5301J1MVBo2cbj7w4R7X3tz4SS3200byvfwaZSI25BgvYhqv7AKR
 WhG1m3bDy+BF3gRE7gPrcA0taxZhTDk=
X-Google-Smtp-Source: ABdhPJy7PzFemz2RPZj8gYWqRuzwe1u8zA+Czwnk1/u1ku5Jkqhm/bZUTDDjSZedB9HZTrg9UHVOpA==
X-Received: by 2002:a17:90a:be10:: with SMTP id
 a16mr13050233pjs.133.1636515935214; 
 Tue, 09 Nov 2021 19:45:35 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:46a:f117:d5ee:c3e5:104f:c135])
 by smtp.gmail.com with ESMTPSA id q6sm5995293pgn.42.2021.11.09.19.45.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Nov 2021 19:45:34 -0800 (PST)
From: cy_huang <u0084500@gmail.com>
To: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v2 2/3] ASoC: rt9120: Fix clock auto sync issue when fs is the
 multiple of 48
Date: Wed, 10 Nov 2021 11:45:20 +0800
Message-Id: <1636515921-31694-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, cy_huang@richtek.com, allen_lin@richtek.com
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

From: ChiYuan Huang <cy_huang@richtek.com>

If fs is divided by 48, to make audio clock sync rate correct, internal
sync function have be disabled.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index 032c520..981aead 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -26,6 +26,7 @@
 #define RT9120_REG_INTERNAL0	0x65
 #define RT9120_REG_INTERNAL1	0x69
 #define RT9120_REG_UVPOPT	0x6C
+#define RT9120_REG_DIGCFG	0xF8
 
 #define RT9120_VID_MASK		GENMASK(15, 8)
 #define RT9120_SWRST_MASK	BIT(7)
@@ -46,6 +47,7 @@
 #define RT9120_CFG_WORDLEN_24	24
 #define RT9120_CFG_WORDLEN_32	32
 #define RT9120_DVDD_UVSEL_MASK	GENMASK(5, 4)
+#define RT9120_AUTOSYNC_MASK	BIT(6)
 
 #define RT9120_VENDOR_ID	0x4200
 #define RT9120_RESET_WAITMS	20
@@ -200,8 +202,8 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *comp = dai->component;
-	unsigned int param_width, param_slot_width;
-	int width;
+	unsigned int param_width, param_slot_width, auto_sync;
+	int width, fs;
 
 	switch (width = params_width(param)) {
 	case 16:
@@ -239,6 +241,16 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_component_update_bits(comp, RT9120_REG_I2SWL,
 				      RT9120_AUDWL_MASK, param_slot_width);
+
+	fs = width * params_channels(param);
+	/* If fs is divided by 48, disable auto sync */
+	if (fs % 48 == 0)
+		auto_sync = 0;
+	else
+		auto_sync = RT9120_AUTOSYNC_MASK;
+
+	snd_soc_component_update_bits(comp, RT9120_REG_DIGCFG,
+				      RT9120_AUTOSYNC_MASK, auto_sync);
 	return 0;
 }
 
@@ -280,7 +292,8 @@ static const struct regmap_range rt9120_rd_yes_ranges[] = {
 	regmap_reg_range(0x3A, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_rd_table = {
@@ -298,7 +311,8 @@ static const struct regmap_range rt9120_wr_yes_ranges[] = {
 	regmap_reg_range(0x40, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_wr_table = {
@@ -369,7 +383,7 @@ static int rt9120_reg_write(void *context, unsigned int reg, unsigned int val)
 static const struct regmap_config rt9120_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 32,
-	.max_register = RT9120_REG_UVPOPT,
+	.max_register = RT9120_REG_DIGCFG,
 
 	.reg_read = rt9120_reg_read,
 	.reg_write = rt9120_reg_write,
-- 
2.7.4

