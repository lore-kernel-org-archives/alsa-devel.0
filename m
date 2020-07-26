Return-Path: <SRS0=gzS/=BF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D9C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 01:30:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DA6206D8
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 01:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OBSqHg4W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="truARi95";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCUBBvrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DA6206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9BA016A9;
	Sun, 26 Jul 2020 03:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9BA016A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595727028;
	bh=Bzld3renOutKYfvOmofpFeC4iBndJmNs3LtPTjokYdc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OBSqHg4WIJDNkOC3Ql2bdhLVLNjIgjFB7tGUcYArWEyWY9m20Q7GSyyxwZ9yfQD8Z
	 R/W88Y0hNNB6GE6vz8nPSLDy6gGpZKiqc6/PmsMJIwsbyq8yGkSXlhEDo8PAY+Cw9x
	 +KNBtB0DCXqhtZRJe2cqR6U3ydDaSApePIlxecEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 626E8F802E8;
	Sun, 26 Jul 2020 03:26:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EA86F8028D; Sun, 26 Jul 2020 03:26:22 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96BB5F80212
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2020 03:26:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96BB5F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="truARi95"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kCUBBvrP"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 82165580161;
 Sat, 25 Jul 2020 21:26:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=92seWwiwyDFZb
 JFzQ9d3eHcie01wHXdtRt1sWd8bW4k=; b=truARi95xImcb2fRj1hjIyQrtpHZ3
 QKo8JEn5Cqwa6NnKOpf9QykGuRdWK9FvyMQHmgQDNui2PsinxXWnJbSubrQfmXbA
 VIW3Ug+OXmzHaaUDiK9/njsUSNWkSWcxGrNsyFY8H5S1de4rtyRoMqPCdXsjw1+S
 nQBvYFqVRMvkM4z6VMSJMW5f49oWxMNu+JemvgKGDhM3jro1rWu/rMJ8oQ6kZBn4
 Q2ggHplJ0nx2qSHB/mWbOafa7iR9pDIA48IV9R4o37xLuFZ6UAyrtbu9wtyhvGgv
 YaDXKzUbcntgpS7DkozmAqezMgK8nU3yHTheUK2+54PrTv30CL+COWuMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=92seWwiwyDFZbJFzQ9d3eHcie01wHXdtRt1sWd8bW4k=; b=kCUBBvrP
 QhlFnHL7qHPuSqsolAPjsgtU3XCNlst41eUmH9Y4hZRjodPS8i9n1Q4rcnOUq9h8
 pXZjPIwzVqQvwza0YZCauy6ABnqXV6Q67anCA2spT2dIlO7MUkHJDZjkLc2o6XIK
 HvdOqeYRMv4H8wl/E7ihYoLFAggph4WDFlP/e/SfLJ8lj9iEt56K3CmfPOL+laJ7
 19J8rn5Btz/FZxwAvuVvOV2llVMFjM5CZrl1qT+FQhbjVX4cEga7EIH946CU428a
 vfYgLyn9CyeaAXWejp1I5wne7bA5e2wD3qDFE4J+x+ywme9+4LIxXA2vBvacPgQF
 Q/h5iK6svL+obg==
X-ME-Sender: <xms:qdscX_RGSd0Bz5REcB0aynj5T25jXIrvgEsv9e57H56NKetIMONI2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:qdscXwyK2FYqLC728I9A31l-fcx0SvbDFgydDfGDzGhuJR2gX7fb-w>
 <xmx:qdscX03nqSjE-tG8K6ZphOnY5-A0k-HdDMpn6-klUmPABi4X_jTFcA>
 <xmx:qdscX_AVBjwSIo_TAmQSddIfRntZ7wvwu_tXu1_mlzuMZOcyeNxXDQ>
 <xmx:qdscX3p6dP340suJaeFCkfc0ZIuK_oIBhoRYN2WzQF1qtxiJNz6dMQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id B65AC3060067;
 Sat, 25 Jul 2020 21:26:00 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 4/7] ASoC: sun8i-codec: Add a quirk for LRCK inversion
Date: Sat, 25 Jul 2020 20:25:54 -0500
Message-Id: <20200726012557.38282-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
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

On the A64, as tested using the PinePhone, the current code causes the
left/right channels to be swapped during I2S playback from the CPU on
AIF1, and breaks DSP_A communication with the modem on AIF2. Both of
these are fixed when LRCK is no longer inverted.

Trusting that the comment in the code is correct, the existing behavior
is kept for the A33.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index a75be9e82d22..304683a71acd 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -88,6 +88,7 @@
 
 struct sun8i_codec_quirks {
 	bool legacy_widgets	: 1;
+	bool lrck_inversion	: 1;
 };
 
 struct sun8i_codec {
@@ -215,18 +216,19 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
 
 	/*
-	 * It appears that the DAI and the codec don't share the same
-	 * polarity for the LRCK signal when they mean 'normal' and
-	 * 'inverted' in the datasheet.
+	 * It appears that the DAI and the codec in the A33 SoC don't
+	 * share the same polarity for the LRCK signal when they mean
+	 * 'normal' and 'inverted' in the datasheet.
 	 *
 	 * Since the DAI here is our regular i2s driver that have been
 	 * tested with way more codecs than just this one, it means
 	 * that the codec probably gets it backward, and we have to
 	 * invert the value here.
 	 */
+	value ^= scodec->quirks->lrck_inversion;
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
-			   !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
+			   value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
 
 	/* DAI format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -673,6 +675,7 @@ static int sun8i_codec_remove(struct platform_device *pdev)
 
 static const struct sun8i_codec_quirks sun8i_a33_quirks = {
 	.legacy_widgets	= true,
+	.lrck_inversion	= true,
 };
 
 static const struct sun8i_codec_quirks sun50i_a64_quirks = {
-- 
2.26.2

