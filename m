Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD46C4363D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:22:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFB5206C3
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GxGz6TYF";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="LZiDmrdd";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jUeJZah8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFB5206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C19F17E0;
	Thu,  1 Oct 2020 04:21:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C19F17E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601518942;
	bh=mXGaDkd5MXrUh73GY04cBBleA5S+ZccFrRlwz+TskPc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxGz6TYFUL7C8kjvxh4C0iffD2eJgm7rr6TQ67kqgRdp+3Paga5R31N46AUUwpfeG
	 DEom5jKRNgp5x+a1S2pZehKxfFb0VFxE6Bx4LVNUGCFznc8QtwWw+5hkndyGjfBUgB
	 zErj/Dmol86seJCmDykcGYpg+ykJGqmGby0gPbUM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9BE1F8036D;
	Thu,  1 Oct 2020 04:12:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C02AF8033F; Thu,  1 Oct 2020 04:12:28 +0200 (CEST)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C456F802E2
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 04:12:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C456F802E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="LZiDmrdd"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jUeJZah8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 21F8D580374;
 Wed, 30 Sep 2020 22:11:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=ILYuHKalHReJx
 sb9rn5Spi0BEtY3rG8Pgijtrm0Qi1k=; b=LZiDmrddHkoJBUsygf6Ro0e1i03Ip
 INwzVQMa3vKY56Zo/ymadMfZIx/OnT8SrOZwNTC2KCLkBnW2cCAcE+dap2JynWC1
 Dw/qxzQ5OToXjmx0n5KO14QkMA6napaGSw/EOyu/0S8mQNmCQnlGlKZyGGoZEgtF
 H8loDT9hvtv/36ZSrXK9Io2wBJ9ui2719ipNKPmRoJc/58WgMh2RmrwD9klNvhuD
 Q2GYVqxRIJnHYKJQd+nbLIymR9oGJoriMdfwEgl+zRZ8ksPnF3c3NUfVsqe2lG2y
 35RaNQHJRFVossj4CGo9brp41gjux+TIWwsEA/0qUSd+UaP9hF03l8m5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=ILYuHKalHReJxsb9rn5Spi0BEtY3rG8Pgijtrm0Qi1k=; b=jUeJZah8
 qovoWPODjrG4BlAk4ARcysRx7exaC7TCfvpWKBr03+UgLzAXe8ak9AW/R3whe7p9
 7pr/e3aK1sa6b7kiN3A6CfAT4Q15maaup2RY9sos5f9HYT5RY8dWP7TLX07F9YGV
 +p1sRXSwjeGqDaVm+PwCZikKtxuWJV4djRhDOjfwcRShZ/eGcxPrG1aeFU2TXQqJ
 ZDDfKwFUCcWvPGqLojWWlHUXdOSPR64afuzJoffzeaWTmac5zkNDDXdIs4ScRvpr
 PvIBDipeOyOtQmoNUT5q0z2gWcHnbEW0j1DW9OH99pkqPZkDei19QXTNy0oinWLb
 tM2U7QEfYoOrng==
X-ME-Sender: <xms:7Dp1X_M1pP0WUaGp8M55I_QZmaoYy7FVMdLy39x_ufk7YW4MboaohA>
 <xme:7Dp1X59mXUWVlwfAxQ3c97qwIsvcmzRypB5hvCYj0rp_FqwbtBv9Mo8en-eqkz0nP
 a-w4IqdDDAt-aSLEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:7Dp1X-Tj6-YMH0DxEPpS6xs5qhfqAEK4T-V09bI2jmQo46cyH6FnPg>
 <xmx:7Dp1XztMQlRIj1w4r2Nr-NuGon4kG56txAv8I3KEa2aL3ej2-JvA0g>
 <xmx:7Dp1X3c7Xx0IIzzUBAjGfPZidsFTDzLMXa5R3Wan6Hv-7bCzfCjufA>
 <xmx:7Tp1X2yNq3TlOV0WtksKyEeFvCxJfCBGQ9_4x2LXZs4yxnluLHUscQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 65A82306467E;
 Wed, 30 Sep 2020 22:11:56 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 15/25] ASoC: sun8i-codec: Support the TDM slot binding
Date: Wed, 30 Sep 2020 21:11:38 -0500
Message-Id: <20201001021148.15852-16-samuel@sholland.org>
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

Now that BCLK and LRCK rate calculations can handle any
hardware-supported slot width and number of slots, enable
support for overriding these parameters from the device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 78feed37aa42..0a53dc0c34d0 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -94,25 +94,31 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 
 enum {
 	AIF1,
 	NAIFS
 };
 
+struct sun8i_codec_aif {
+	unsigned int	slots;
+	unsigned int	slot_width;
+};
+
 struct sun8i_codec_quirks {
 	bool legacy_widgets	: 1;
 	bool lrck_inversion	: 1;
 };
 
 struct sun8i_codec {
 	struct regmap			*regmap;
 	struct clk			*clk_module;
 	const struct sun8i_codec_quirks	*quirks;
+	struct sun8i_codec_aif		aifs[NAIFS];
 };
 
 static int sun8i_codec_runtime_resume(struct device *dev)
 {
 	struct sun8i_codec *scodec = dev_get_drvdata(dev);
 	int ret;
 
 	regcache_cache_only(scodec->regmap, false);
@@ -256,16 +262,32 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK,
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV);
 
 	return 0;
 }
 
+static int sun8i_codec_set_tdm_slot(struct snd_soc_dai *dai,
+				    unsigned int tx_mask, unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
+	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
+
+	if (slot_width && !is_power_of_2(slot_width))
+		return -EINVAL;
+
+	aif->slots = slots;
+	aif->slot_width = slot_width;
+
+	return 0;
+}
+
 struct sun8i_codec_clk_div {
 	u8	div;
 	u8	val;
 };
 
 static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
 	{ .div = 1,	.val = 0 },
 	{ .div = 2,	.val = 1 },
@@ -316,18 +338,19 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
 	return order_base_2(div);
 }
 
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
-	unsigned int slots = params_channels(params);
-	unsigned int slot_width = params_width(params);
+	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
+	unsigned int slots = aif->slots ?: params_channels(params);
+	unsigned int slot_width = aif->slot_width ?: params_width(params);
 	int lrck_div_order, sample_rate, word_size;
 	u8 bclk_div;
 
 	/* word size */
 	switch (params_width(params)) {
 	case 8:
 		word_size = 0x0;
 		break;
@@ -371,16 +394,17 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_SYS_SR_CTRL_AIF1_FS_MASK,
 			   sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
 
 	return 0;
 }
 
 static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
 	.set_fmt	= sun8i_codec_set_fmt,
+	.set_tdm_slot	= sun8i_codec_set_tdm_slot,
 	.hw_params	= sun8i_codec_hw_params,
 };
 
 static struct snd_soc_dai_driver sun8i_codec_dais[] = {
 	{
 		.name	= "sun8i-codec-aif1",
 		.id	= AIF1,
 		.ops	= &sun8i_codec_dai_ops,
-- 
2.26.2

