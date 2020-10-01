Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE273C4363D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:25:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C6206C3
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jgJoACMr";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="m+EWPEym";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XH5liIg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C6206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA8D11888;
	Thu,  1 Oct 2020 04:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA8D11888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601519115;
	bh=0345PLcCtCz5MHQf7kBOIBry1vwi/BjgA1VhbKGFBkE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgJoACMryOm2JST4coTZcPl+j+RqSPwNg/tGWyKO0EdI4QifeeiCXFFwcLPVQwkmL
	 EMeD49gbhSKg1LxOj7mY5cxEBmVpE72w1b3fqYNSPhFEiInyyZJzeImGI1UuKY9avm
	 8jXQJGTjbZOGv9XKIANLCm2NjzjiwUKtPHElTKVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8F3AF803CB;
	Thu,  1 Oct 2020 04:12:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 515BFF80341; Thu,  1 Oct 2020 04:12:33 +0200 (CEST)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 338ADF802E0
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 04:12:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 338ADF802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="m+EWPEym"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="XH5liIg8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6D87D58039C;
 Wed, 30 Sep 2020 22:11:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=5k3SUOehEkVJQ
 tme0JHjR/CoY8DUxDwQgt0QBEnrJQw=; b=m+EWPEymCYukaw/YH6/fa6Ffs5Gae
 KHLwVePL9K9RBfOcaCUHqiiihvHZ60VhBCrY4oOUct35r7UzL1fONlZT0wziLvfd
 fAVo5jo/TKQB/wwWVOjzlbVFB5/SNiHDrqBIktOEWOWSn6EpmvUfMByAg9fBub93
 nzwgqSDhQjr1ocUWjsxeVKfw5VhBpjsrgzWO8pwmtT1d2Z9ii0fIYtA4Wdt/bZo6
 snywUNuxPKRefRP1QFYpngcACu2hURIyhEzAFPk+D/+vILfjYXFeN2LkjrvLQ4dv
 fkbk9W+UqIkrqnUxyUzrXbp7TmcSAk29SyBAc7csGJhC5vBEk4egamoig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=5k3SUOehEkVJQtme0JHjR/CoY8DUxDwQgt0QBEnrJQw=; b=XH5liIg8
 wIeQWOHVlvXLpxoO7r5jYwLF3XOae/fYZKmpTWKN11y8VlSQlCoRaQATl/9TorjQ
 vps65xqznWuj1FVUU9SJlkU4WLmidTVQ+YEGLlhfzmoYzR7O6SPRPIrTRtnYQIZs
 oKG5/FWqI+ZCI4sSBo0njDG2ztLg180aqBWabOKByV9MQSUUcjoDKpSQCORv776X
 uyDxJsw+EHb/TKMStua3Dpst3htBF2P5h1kOJ0mDDL1JVaH59gZx639redJi8ZLJ
 jwqVxEz2JBQ2FL0bmjxmYptNL9e0Ko4YlND3Sv3zSMjhkHbZIKDZA2SW9+iE+nR4
 MRrhBYBwJxCKWw==
X-ME-Sender: <xms:7zp1XzMa4L1aLGyvrxUpQphKPiBxj0lH1niX5JzZaLwttMdSc_rhgg>
 <xme:7zp1X98V79j-dtjoLabL3XPnDnOQbNv_9p-IaFT-76Yvib-GzboLlIt2de9878upz
 9zFUZzzcl0jCNLsMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedujeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:7zp1XyQCZ64VAgujoTU-4Qh1ZTW77olzed-es9aFIuZfrdQjI3n_GA>
 <xmx:7zp1X3ut20MJjrYkWwZ_PgZ3vNX2WOgEdpWXM9C6Kxo1KI31N29v2g>
 <xmx:7zp1X7cjDRbP-GE58ekSEW4dTvt2qUq8gyZ2cEgEj_WrhoccRRVSUg>
 <xmx:7zp1X6y7KsbUs_0ISYQZCxK7lOuik88RJ1jWlkU6IWoWmSZAWdvfzw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id B93043064682;
 Wed, 30 Sep 2020 22:11:58 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while streams
 are open
Date: Wed, 30 Sep 2020 21:11:43 -0500
Message-Id: <20201001021148.15852-21-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
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

The codec's clock input is shared among all AIFs, and shared with other
audio-related hardware in the SoC, including I2S and SPDIF controllers.
To ensure sample rates selected by userspace or by codec2codec DAI links
are maintained, the clock rate must be protected while it is in use.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 501af64d43a0..86065bee7cd3 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
 	unsigned int div = slots * slot_width;
 
 	if (div < 16 || div > 256)
 		return -EINVAL;
 
 	return order_base_2(div);
 }
 
+static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_rate)
+{
+	return sample_rate % 4000 ? 22579200 : 24576000;
+}
+
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
 	unsigned int sample_rate = params_rate(params);
 	unsigned int slots = aif->slots ?: params_channels(params);
 	unsigned int slot_width = aif->slot_width ?: params_width(params);
-	unsigned int sysclk_rate = clk_get_rate(scodec->clk_module);
-	int lrck_div_order, word_size;
+	unsigned int sysclk_rate = sun8i_codec_get_sysclk_rate(sample_rate);
+	int lrck_div_order, ret, word_size;
 	u8 bclk_div;
 
 	/* word size */
 	switch (params_width(params)) {
 	case 8:
 		word_size = 0x0;
 		break;
 	case 16:
@@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	/* BCLK divider (SYSCLK/BCLK ratio) */
 	bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
-	if (!aif->open_streams) {
+	/* SYSCLK rate */
+	if (aif->open_streams) {
+		ret = clk_set_rate(scodec->clk_module, sysclk_rate);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
+		if (ret == -EBUSY)
+			dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
+				"conflicts with other audio streams.\n",
+				dai->name, sample_rate);
+		if (ret < 0)
+			return ret;
+
 		scodec->sysclk_rate = sysclk_rate;
 		scodec->sysclk_refcnt++;
 	}
 
 	aif->sample_rate = sample_rate;
 	aif->open_streams |= BIT(substream->stream);
 
 	return sun8i_codec_update_sample_rate(scodec);
@@ -487,16 +505,17 @@ static int sun8i_codec_hw_free(struct snd_pcm_substream *substream,
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
 
 	if (aif->open_streams != BIT(substream->stream))
 		goto done;
 
 	scodec->sysclk_refcnt--;
+	clk_rate_exclusive_put(scodec->clk_module);
 
 	aif->sample_rate = 0;
 
 done:
 	aif->open_streams &= ~BIT(substream->stream);
 	return 0;
 }
 
-- 
2.26.2

