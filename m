Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A7C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:24:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E3D22265
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xrakkb1S";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="mCFBuHL2";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6HfyKo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E3D22265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AD2016F1;
	Wed, 14 Oct 2020 08:21:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AD2016F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602656554;
	bh=zP7eKtIGVAId2sWrkMbCbZzlvjKt9T+etE8r7gftY8I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xrakkb1SpFz7qSS51GTWs3p3ifaHDuTViYt23vHfw0AiWdz2lTriJQOX4BDHbCft6
	 COFFr9QIy8G17kcj5+7uVJIdvCfL5F1+wagKZ0Q7nTZgTv9tUl3lW9eefBE2Sv6qEG
	 lAC/dD+OZBiB3OfqFxpllmLYrdR66ccZZnY6mYwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBA68F8029A;
	Wed, 14 Oct 2020 08:20:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3D50F80274; Wed, 14 Oct 2020 08:20:02 +0200 (CEST)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEC44F80225
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 08:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC44F80225
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="mCFBuHL2"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="K6HfyKo0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id C6C53250;
 Wed, 14 Oct 2020 02:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=dsTqx9fih4qel
 tXgxFFCvDgkr4kxr99tOm8ZaqRJzWc=; b=mCFBuHL278LSXO6A/i6hUVHQSKYiV
 FxOko4paSAlNY5koWEDynyCPPDya3xmctHBNonlMn7cGv8xPSDlQjl1pechlbRyn
 /1V8GK/+kk7f33nD1rcVmNBIJxb12PovXyvEZhFc/iiiQg6Zg13A1bH8GghagMsM
 9bAiXGvQjoDRgKTHHjf7AXz0uR2Anr86gMKbLQhE65Q+5NqU+5QhP/gccHh/xkFm
 oAyz6N+aOh+BG58mI1Q1b0T3g3+IRKH1CAfRxF5kQsCeXaPyM/Qua0vCMk5aRV26
 zjxlyGy3QcMnKapANr9sYAgQcH4GD4uSm5CnLKWc8CTCqyue0S4ic0CCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=dsTqx9fih4qeltXgxFFCvDgkr4kxr99tOm8ZaqRJzWc=; b=K6HfyKo0
 THYsGFONlE8rWh/c0WxceKK2xBA8qZlMRY6QDuiFz8+AgUatZYx++PyfUkwEP0hJ
 pFJpBqI3+5YclgkSjJfCCuIM5O1cNTEOnEWpDYUtVE5V2sygtBhZ4MAM1yJf24dS
 u+nJzaVKpg493hsv0WibHty5t4Wk2TVbdYwkyYBX61lELwqR+G16yqzJuPpxWU9a
 0/Amyxx6I++qi+UZjL6+nXh3hKdBZTV35/E3zGeeQ1mHu61RrL1Wa+OloLfbnfcs
 finy4WVpq6x+9zQC3iUR97TrfTgdi6iOv52SmJ8DmPKSeMTavlDjOxGASsCgLIUd
 CvSLenkNFFaHGg==
X-ME-Sender: <xms:gZiGXyzwYYjpPOcTo5VzpOgYkXlWGgU89XHMSittPl_hzdchBC3n-g>
 <xme:gZiGX-TmAOgO8lKY5E71dFxXR-u2KnmYgAjg1LLAnSd2GzffCQz8ooRh3mqMDs0eV
 P57m428CEC7ioHIOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:gZiGX0V_YyGErE94WOhp7H_TAhL1O5hLjqdGQCT6EwVAhNzorC_fkw>
 <xmx:gZiGX4iaNAoCTAJzeTVB3gJ3DOBh1wRWw3FB6D-Vt7vYwgg2K7wUOQ>
 <xmx:gZiGX0DA3zxiQsJTBESeBV0uu14wnPCRBSLQR_oU2TngSEj2SuyCcw>
 <xmx:gZiGXw3DNAR14v1TqlO3ZU6hRR-8ddugs5MJlBHBMl7BQnV_tyATVjDcnzE>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id ACAFB3280067;
 Wed, 14 Oct 2020 02:19:44 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 06/17] ASoC: sun8i-codec: Correct the BCLK divisor
 calculation
Date: Wed, 14 Oct 2020 01:19:30 -0500
Message-Id: <20201014061941.4306-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014061941.4306-1-samuel@sholland.org>
References: <20201014061941.4306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
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

Previously, the BCLK divisor calculation assumed zero padding and
exactly two slots. In order to support the TDM slot binding and
20/24-bit word sizes, those assumptions must be removed.

Due to hardware limitations, the BCLK/LRCK ratio is not as simple as
"slot_width * slots". However, the correct value is already calculated
elsewhere in this function, since it must also be programmed into the
hardware. Reuse that value to calculate the correct SYSCLK/BCLK divisor.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 92fcef45097d..ae885774c877 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -279,21 +279,21 @@ static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
 	{ .div = 48,	.val = 9 },
 	{ .div = 64,	.val = 10 },
 	{ .div = 96,	.val = 11 },
 	{ .div = 128,	.val = 12 },
 	{ .div = 192,	.val = 13 },
 };
 
 static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
-				   unsigned int rate,
-				   unsigned int word_size)
+				   unsigned int lrck_div_order,
+				   unsigned int sample_rate)
 {
 	unsigned long clk_rate = clk_get_rate(scodec->clk_module);
-	unsigned int div = clk_rate / rate / word_size / 2;
+	unsigned int div = clk_rate / sample_rate >> lrck_div_order;
 	unsigned int best_val = 0, best_diff = ~0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun8i_codec_bclk_div); i++) {
 		const struct sun8i_codec_clk_div *bdiv = &sun8i_codec_bclk_div[i];
 		unsigned int diff = abs(bdiv->div - div);
 
 		if (diff < best_diff) {
@@ -343,30 +343,31 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
 			   word_size << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
 
-	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params), 16);
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
-			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
-
 	/* LRCK divider (BCLK/LRCK ratio) */
 	lrck_div_order = sun8i_codec_get_lrck_div_order(slots, slot_width);
 	if (lrck_div_order < 0)
 		return lrck_div_order;
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
 			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
+	/* BCLK divider (SYSCLK/BCLK ratio) */
+	bclk_div = sun8i_codec_get_bclk_div(scodec, lrck_div_order, params_rate(params));
+	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
+			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
+			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
+
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
 		return sample_rate;
 
 	regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
 			   SUN8I_SYS_SR_CTRL_AIF1_FS_MASK,
 			   sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
 
-- 
2.26.2

