Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD1CC4363D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:14:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FB623444
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ny8FxSy7";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="jLOp6W3A";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJ0VAapR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FB623444
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12C8017D1;
	Thu,  1 Oct 2020 04:12:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12C8017D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601518427;
	bh=IgnxbzBX4sPbwU9Yc21SkuF9daJHhHnZEdF3YUpKOEo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ny8FxSy7E+LC2gR4+5I37CbkjVide0al2UNS+pM5o/QbWhFKOAvCyPVD2gDEJQPsP
	 1EBBinX2v5kC+w588R3V9Qy4SyE0MtHAE3702ZO7UO7yvwUz+0K3qTNNkpwyUQxVSF
	 V+xUQURNOrHVnq4ZMsn0P8B0Cn+k/9vq/fPRoJAA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4FD1F802FB;
	Thu,  1 Oct 2020 04:12:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 459F0F802F7; Thu,  1 Oct 2020 04:12:02 +0200 (CEST)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 164DFF8022B
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 04:11:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 164DFF8022B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="jLOp6W3A"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="XJ0VAapR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 44B1B5800F2;
 Wed, 30 Sep 2020 22:11:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=bCadA2k97gYBC
 JYu+Nk68aMYO410w1muYxzc/ljxcyM=; b=jLOp6W3A4k/+ZNCuhFbclf9fiKDHM
 BHtQt+meatamHVlBn8APwQq6usjAH9Mv9UH/vdAHmehmF9QS2Ve/C+ZDEE58luFI
 62aQ5kog/72FeYoC+KrZoWtJ+2Q1fM4N06l/tl5/RuYV+AkD/aICAK7KL0OKXQ5p
 SmviUfUk7MUVgwSy4tuTT17joVOHTlzXikSlq7bupZHibRk8H4QijoMWAZUywhg6
 fhV2i8hgtlDNFAa4Ne6bOvjqncpj7fGg6vqUJTnf8/Gf0zYUK50bShBA0JaGygxu
 o7SIR0CNMSd8hR24NGxAKy0fJoV6TK6Vk3VbjwiinrafM9sAtsJf/f2vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=bCadA2k97gYBCJYu+Nk68aMYO410w1muYxzc/ljxcyM=; b=XJ0VAapR
 NQ7zdRh24olSi8zmvYMS5c5+8LD0Y9lcFF4D8CMddo39UGLOf+W411haXID03IqN
 ciYgR2SOe5azcH6nh2wuw4ibzgrNTQB04DY8oSBg7fcyJShcF6a0GjM01QJBwnhF
 9LY/stj3k8cS0znkHVUuLd1xyeGm6QS0LpMdMzX/2lpsugDHPqFxylJ7kvPCqjRu
 p97PiJME4sbnytzi3PaQZD6/iOzJiUSD6/qMm1Argg31gTDfNjJ3FOK1dw7+99uc
 pUCKxFIVUEMZLkq45Celf70B4p9DFa5Bkrz4vbiTM/xu8q+X1pRuLt2721HtVSpj
 dweWmdwbkBll0Q==
X-ME-Sender: <xms:5zp1X8oSov-Gc7aGVg3vxnRoPdPM5bYsSKu1P6qH4vHJLaHlnE1Y0g>
 <xme:5zp1XyqYETupMdZYg9JvQ2kSC8AyGWbSxuAf7y4UZC0qZz1NJ3cqRQikMxxdXvW3m
 khYx5zuwM2c0kiMsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:5zp1XxPeS5-HUu9Rm9BzJitHxccbsUjR331AOwi7ggQfBoPx4whNSg>
 <xmx:5zp1Xz4MOnVMUloYwo4dMEA4kTIbpH2-gCLRd9BWD0zc1_c5BrqiIA>
 <xmx:5zp1X76uIloCLxvHKPCA_Q3iDNGgYdJtgZUGBvW-eIwWBo8_w0MpEg>
 <xmx:6Dp1X1txSgI1iyfO7IODyxblmvwfnoNPv0zJ6LnH3AqYE-JFvNfIOw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 39BC23064686;
 Wed, 30 Sep 2020 22:11:51 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 04/25] ASoC: sun8i-codec: Consistently name DAPM widgets and
 routes
Date: Wed, 30 Sep 2020 21:11:27 -0500
Message-Id: <20201001021148.15852-5-samuel@sholland.org>
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

This cleans up the mixer widget names. The AIF1 AD0 Mixer names were
previously wrong -- they do not control the digital side of the ADC. The
DAC mixer widgets were not wrong, but they were verbose and did not
match the naming scheme of the other widgets.

The mixer controls are not renamed because they are exposed to
userspace.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index d14243c434f9..30fe27648254 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -413,19 +413,19 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("AIF1 AD0L", "Capture", 0,
 			    SUN8I_AIF1_ADCDAT_CTRL,
 			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA, 0),
 	SND_SOC_DAPM_AIF_IN("AIF1 AD0R", "Capture", 0,
 			    SUN8I_AIF1_ADCDAT_CTRL,
 			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA, 0),
 
 	/* AIF "ADC" Mixers */
-	SOC_MIXER_ARRAY("Left Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
+	SOC_MIXER_ARRAY("AIF1 AD0L Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_aif1_ad0_mixer_controls),
-	SOC_MIXER_ARRAY("Right Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
+	SOC_MIXER_ARRAY("AIF1 AD0R Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_aif1_ad0_mixer_controls),
 
 	/* AIF "DAC" Inputs */
 	SND_SOC_DAPM_AIF_IN("AIF1 DA0L", "Playback", 0,
 			    SUN8I_AIF1_DACDAT_CTRL,
 			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
 	SND_SOC_DAPM_AIF_IN("AIF1 DA0R", "Playback", 0,
 			    SUN8I_AIF1_DACDAT_CTRL,
@@ -435,19 +435,19 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* DAC Outputs (connected to analog codec DAPM context) */
 	SND_SOC_DAPM_DAC("DACL", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DACR", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* DAC Mixers */
-	SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+	SOC_MIXER_ARRAY("DACL Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_dac_mixer_controls),
-	SOC_MIXER_ARRAY("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+	SOC_MIXER_ARRAY("DACR Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_dac_mixer_controls),
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	/* Clock Routes */
 	{ "AIF1CLK", NULL, "mod" },
 
 	{ "SYSCLK", NULL, "AIF1CLK" },
@@ -468,36 +468,36 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 
 	{ "CLK DAC", NULL, "SYSCLK" },
 	{ "RST DAC", NULL, "CLK DAC" },
 	{ "DAC", NULL, "RST DAC" },
 	{ "DACL", NULL, "DAC" },
 	{ "DACR", NULL, "DAC" },
 
 	/* AIF "ADC" Output Routes */
-	{ "AIF1 AD0L", NULL, "Left Digital ADC Mixer" },
-	{ "AIF1 AD0R", NULL, "Right Digital ADC Mixer" },
+	{ "AIF1 AD0L", NULL, "AIF1 AD0L Mixer" },
+	{ "AIF1 AD0R", NULL, "AIF1 AD0R Mixer" },
 
 	/* AIF "ADC" Mixer Routes */
-	{ "Left Digital ADC Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0L" },
-	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCL" },
+	{ "AIF1 AD0L Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0L" },
+	{ "AIF1 AD0L Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCL" },
 
-	{ "Right Digital ADC Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0R" },
-	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCR" },
+	{ "AIF1 AD0R Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0R" },
+	{ "AIF1 AD0R Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCR" },
 
 	/* DAC Output Routes */
-	{ "DACL", NULL, "Left Digital DAC Mixer" },
-	{ "DACR", NULL, "Right Digital DAC Mixer" },
+	{ "DACL", NULL, "DACL Mixer" },
+	{ "DACR", NULL, "DACR Mixer" },
 
 	/* DAC Mixer Routes */
-	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0L" },
-	{ "Left Digital DAC Mixer", "ADC Digital DAC Playback Switch", "ADCL" },
+	{ "DACL Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0L" },
+	{ "DACL Mixer", "ADC Digital DAC Playback Switch", "ADCL" },
 
-	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0R" },
-	{ "Right Digital DAC Mixer", "ADC Digital DAC Playback Switch", "ADCR" },
+	{ "DACR Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0R" },
+	{ "DACR Mixer", "ADC Digital DAC Playback Switch", "ADCR" },
 };
 
 static const struct snd_soc_dapm_widget sun8i_codec_legacy_widgets[] = {
 	/* Legacy ADC Inputs (connected to analog codec DAPM context) */
 	SND_SOC_DAPM_ADC("AIF1 Slot 0 Left ADC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("AIF1 Slot 0 Right ADC", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* Legacy DAC Outputs (connected to analog codec DAPM context) */
-- 
2.26.2

