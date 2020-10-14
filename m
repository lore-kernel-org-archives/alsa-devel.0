Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF9C43457
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:24:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9978222260
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S0d+/sAi";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="VwJtsJh+";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/YTfX6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9978222260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E597516E6;
	Wed, 14 Oct 2020 08:22:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E597516E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602656605;
	bh=46xfCZvxx26zGEoRvg1vdBsZm0QMicgD1Hbl7W6+ZpM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0d+/sAi13CcZK9TvkDlRdedzNLRfnzdDgnDSGpkXHCHwChtvKXYDgxUKJBYwgRvj
	 7LkG04uKC0Lfzxb5O/pXxlcAgFupYqPimLMu192if34DRDbQLC2qz+5vkKVo2mf3HL
	 M8Jnj0Gubc+q6uAC/bY953rFtG3HO8NcE2R0vHC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5DB6F802C3;
	Wed, 14 Oct 2020 08:20:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD818F802B2; Wed, 14 Oct 2020 08:20:09 +0200 (CEST)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEC77F80226
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 08:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC77F80226
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="VwJtsJh+"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="N/YTfX6M"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id 5CEA8D1A;
 Wed, 14 Oct 2020 02:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=8KOUPydzBFIsE
 SxaN7/phco2Yu8yymSNmR8YZ4EHypo=; b=VwJtsJh+ZnZArCy0Vr5VXu7Hhh8eE
 iqD4VAPCy/tWOSmzRRfJOx+nGf2/pr80VHGwVyWwwH1fIU08vC+1G05Z0q6Z3k7T
 iNhfDLn8t1KCll1zH1+KRL+fhIezSkzsl3Dz2IJCZ/qemJzUq/X4zt6W1QUDDnEl
 DR2urdGNk8HiF9ZJnYxKXK1sQQd1NqPE7VTiU/euMu2pfii9Wg63r22FlLZ27qhg
 eJlcjtVi7OOp7mWd71JLDej8tpfxqL0MJp05gAcFHkclsZqEBePAijVb4wuFQMvx
 vUvTKMRuBok+la6UXQgov8O+GefGZb25gn/TYJCQJqg0OEEgM+7itH+wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=8KOUPydzBFIsESxaN7/phco2Yu8yymSNmR8YZ4EHypo=; b=N/YTfX6M
 fr9Ije3OjwN0dhfmFNpNzMHdl+LA01iuQxi+cHZbfCN9fEhyzqi4BAu8/yFmell5
 idc6w2CuAgdVylp/XEwlXlt+lFOVJkdMOfICqyJi2DvAFHZ9KXi8VJsapzlB8TiG
 WBFTSFfohyNKqtF2yaMYorwHdMql+NTCLqEzC8gHigfNc8et2kkWgBx1q5xjb4Nx
 5OJRDqm6wFbgtchHyJEE+sWPDb1w6Yqmj/ME5I5lr184XFOz/f407wiGMEr0xIEM
 CSEKt2PSVGNG1N1QxDbHty6qQ0PErkYGAzHzANUCVpf34st+Df+de6XysJB/rmE4
 tQZid2SKLDOa3A==
X-ME-Sender: <xms:gJiGXxh52X1ZrQ6aPMXCTjvLJeXHOy7TFSeG1Ct-UOyHMfuy3f6kYQ>
 <xme:gJiGX2A7erJCGjbdr9iNqSyVH31sE7JAtxArUZQGd_iSJ94wt3WkplooRrl-3gY-u
 7adOzSEKFxsI3olrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:gJiGXxHgQ8MqtIh3l3gf-u7wH9x-EpIdWXx8KfcZrFLZl2JDO6w9Sg>
 <xmx:gJiGX2QZxbH2d7nOK5dRETD9hiQ_VFZjzPZT55cGUdWnWykC13EOVA>
 <xmx:gJiGX-xrLyIp9PrnD_WEaOn5uj7Gdvay2QsmqM7gj_mkBgUZOOc4fQ>
 <xmx:gJiGX9nuXjs-JdWIVmgUgyDorMaUcZ7WRIFO5ddLfBPSYukcWc2Z38f5bkY>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 39A74328005D;
 Wed, 14 Oct 2020 02:19:44 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 05/17] ASoC: sun8i-codec: Round up the LRCK divisor
Date: Wed, 14 Oct 2020 01:19:29 -0500
Message-Id: <20201014061941.4306-6-samuel@sholland.org>
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

The codec supports only power-of-two BCLK/LRCK divisors. If either the
slot width or the number of slots is not a power of two, the LRCK
divisor must be rounded up to provide enough space. To do that, use
order_base_2 (instead of ilog2, which rounds down).

Since the rounded divisor is also needed for setting the SYSCLK/BCLK
divisor, return the order base 2 instead of fully calculating the
hardware register encoding.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 82576066c249..92fcef45097d 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -300,33 +300,35 @@ static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
 			best_diff = diff;
 			best_val = bdiv->val;
 		}
 	}
 
 	return best_val;
 }
 
-static int sun8i_codec_get_lrck_div(unsigned int channels,
-				    unsigned int word_size)
+static int sun8i_codec_get_lrck_div_order(unsigned int slots,
+					  unsigned int slot_width)
 {
-	unsigned int div = word_size * channels;
+	unsigned int div = slots * slot_width;
 
 	if (div < 16 || div > 256)
 		return -EINVAL;
 
-	return ilog2(div) - 4;
+	return order_base_2(div);
 }
 
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
-	int lrck_div, sample_rate, word_size;
+	unsigned int slots = params_channels(params);
+	unsigned int slot_width = params_width(params);
+	int lrck_div_order, sample_rate, word_size;
 	u8 bclk_div;
 
 	/* word size */
 	switch (params_width(params)) {
 	case 8:
 		word_size = 0x0;
 		break;
 	case 16:
@@ -346,24 +348,24 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
 			   word_size << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
 
 	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params), 16);
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
-	lrck_div = sun8i_codec_get_lrck_div(params_channels(params),
-					    params_physical_width(params));
-	if (lrck_div < 0)
-		return lrck_div;
+	/* LRCK divider (BCLK/LRCK ratio) */
+	lrck_div_order = sun8i_codec_get_lrck_div_order(slots, slot_width);
+	if (lrck_div_order < 0)
+		return lrck_div_order;
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
-			   lrck_div << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
+			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
 		return sample_rate;
 
 	regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
 			   SUN8I_SYS_SR_CTRL_AIF1_FS_MASK,
 			   sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
-- 
2.26.2

