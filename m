Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD69CD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:31:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5F98601D2;
	Mon,  8 Jun 2026 13:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5F98601D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918258;
	bh=eNkE9fThA+Yddd79uMmDbx3+986LsI7yJiUpq9sLT8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UQSbPtmDTwHUA2gk8fr7JzKdg14Xxah1hu/P0mv1Nvd0qx3VuYYRjFHJM3ZrEN8ZY
	 lStYOlWRCFUr6bOjsVkStKAB/oqNlZrc6vo+kBV3n2uLPSsu3P2406sTIw1g3cbKGT
	 jN83L0af00P2sf98urbIM0Y9X7WDn5TK+s9Cxx5A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CDD8F8063C; Mon,  8 Jun 2026 13:30:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E874BF80637;
	Mon,  8 Jun 2026 13:30:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D23E1F804F3; Mon,  8 Jun 2026 10:35:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.212
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907750;
	b=UlujrmXu2GVKxaGP/3bSfOGdIsI+OskgVukEtiT95UaiLv45S13u11PZoRkAE5epny4z
	 0weh0AikKGltJ85YpDbWsSliSqlvrJ8XMtzVGKzS8Ghis+IifnJSHdrTn4dAItgAdUzYN
	 tRgsJc/IVG7ZmqI9NwuyayFiDN0ZlAW2ECUo38WVUpCidHoMTiIOtd3oUioDryDVx88f8
	 EMg+4VAbLUVlQqRsl5spxR5fcL6yTYgK13oYTEoaiwD/o1/7hFKJbzR9nBzJngcg1oHrd
	 g4HRZHXe4k/DFfSZH0aYADK06jGf8daTWoRHSwB1aln5Veq62bDq8+AxQep5DXBtaFA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907750;
	h=From:To:Subject:Date:Message-Id;
	bh=eNkE9fThA+Yddd79uMmDbx3+986LsI7yJiUpq9sLT8g=;
	b=K1VkR0Jkg1Ds/O82HDnx2PReS0MzvX6M47O6iCZQEuiJr0XgNwG0evxlxPAtxbI4nfm1
	 t39rVFhMKYavcP8apeV73PTVKZS8VImk/H1S2qXixhz9BQJdRyEaNf/WBHYP25w/L/HA9
	 TzzqFj+dmYk48pda5jETv6FwfuoasPX8llqf00JFB0LtmQkYkss14NRRs8n1TUPJi2D1v
	 T01LOJaeoXHfqGCtlaBdmt1y/zhc3PfB9Jpfw0pKgbsQgmnwrzw/hhzTvMqTL+uNowRJZ
	 lE+oNrwt3bWP6x1cajOw4QU5uWsKPWzzO+g/lCOe4psf/h3znywQ2/MoiZ83oFliatg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.212
Received: from r3-212.sinamail.sina.com.cn (r3-212.sinamail.sina.com.cn
 [202.108.3.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4521EF80301
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4521EF80301
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:46 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 8E193D818EC3496CA065561154769EE9
X-SMAIL-UIID: 8E193D818EC3496CA065561154769EE9-20260608-163546
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 2/7] ASoC: codecs: ES8389: Fix the issue about mclk_src
Date: Mon,  8 Jun 2026 16:35:35 +0800
Message-Id: <20260608083540.12581-3-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XL5HSZALMDK6V6CE7TOJPRACL7KUWBEN
X-Message-ID-Hash: XL5HSZALMDK6V6CE7TOJPRACL7KUWBEN
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XL5HSZALMDK6V6CE7TOJPRACL7KUWBEN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Fix the issue with incorrect modifications to mclk_src

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 2 +-
 sound/soc/codecs/es8389.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 9c816491648c..638eb1f0462e 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -609,7 +609,7 @@ static int es8389_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	if (es8389->mclk_src == ES8389_SCLK_PIN) {
 		regmap_update_bits(es8389->regmap, ES8389_MASTER_CLK,
-					ES8389_MCLK_SOURCE, es8389->mclk_src);
+					ES8389_MCLK_MASK, es8389->mclk_src);
 		es8389->sysclk = params_channels(params) * params_width(params) * params_rate(params);
 	}
 
diff --git a/sound/soc/codecs/es8389.h b/sound/soc/codecs/es8389.h
index d21e72f876a6..13ce241774dc 100644
--- a/sound/soc/codecs/es8389.h
+++ b/sound/soc/codecs/es8389.h
@@ -116,9 +116,10 @@
 #define ES8389_TDM_SLOT               (0x70 << 0)
 #define ES8389_TDM_SHIFT              4
 
-#define ES8389_MCLK_SOURCE            (1 << 6)
-#define ES8389_MCLK_PIN               (1 << 6)
-#define ES8389_SCLK_PIN               (0 << 6)
+#define ES8389_MCLK_MASK              (3 << 6)
+#define ES8389_MCLK_SOURCE            (0 << 6)
+#define ES8389_MCLK_PIN               (0 << 6)
+#define ES8389_SCLK_PIN               (1 << 6)
 
 /* ES8389_FMT */
 #define ES8389_S24_LE                 (0 << 5)
-- 
2.54.0.windows.1

