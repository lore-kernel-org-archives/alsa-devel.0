Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776FC35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:59:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A69220679
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A69220679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1AFA170A;
	Mon, 17 Feb 2020 07:58:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1AFA170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581922747;
	bh=Q9gTqyRsJzugKmhoJEKQrEBtU7BbKTC8br4JiE6Gdjc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7TkKE32K0ypVMkKx2hcCj4N0w/LtBE4PWzysiqrwKIOihOW80xwmm8/l8Hy7Lyhu
	 5EhO0NKM+V5V4tpq0pPHoNKRBBl+nhEfxupXUYNwkHhw07YZJDO7sNIV85ISah17eM
	 Tofs4FAw6FmXgFUu30Ok/pfEwIQHUnUo2cmoS9bo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D3BEF80385;
	Mon, 17 Feb 2020 07:44:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66786F80315; Mon, 17 Feb 2020 07:43:40 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C43BF802A9
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 07:43:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C43BF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="InlAs3Bg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="q49izLc4"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 79E9556DB;
 Mon, 17 Feb 2020 01:43:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=I3xw5qy1UxUBp
 B6XTvG7LlHa8i+mx9aC7f7VSVA0AfY=; b=InlAs3BgFzcKKX1N06vsPXFIw/Vye
 WdQxPcHR5PG8oZrDQM7cZ3q2PYozLJPunz9Hjx1QLQnP0qVl7GNVfJ2kuvGCmOjJ
 82+NIMLpd1+vMRSepMggyHfkZL4qo1OUXJowLWvBYgQ81u/EnmP2gEkRAbPG90PL
 cOhtV/EMRdrA9iMq/h4u/ryHg0NC0/WO+a1v7PPlNkqFNmngJvU4y3tAeHEZAeWj
 TN8gn3vs/DaEJ6Jtg0tNXSWQCOq/ESkU7dsNrLTfovY+QeGA0CvE8Zy4b95F77m5
 epMbdWsfhP7rCxuP4mQ0Jh2jAsD3qAfIyS9fPrMLRuqH35YTepIj6qLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=I3xw5qy1UxUBpB6XTvG7LlHa8i+mx9aC7f7VSVA0AfY=; b=q49izLc4
 C5IYmqBQGCMt/iXi4zsD0EsTJ4B//OqI5bq/Q9DOICtFqL0Q32ve6lwW++0vDRrd
 nTw4QTOtZM8ixNghs3lMG4KPjmB9hWI74xnLvh6K61DiXrTXk/afwfA6220EWfB4
 Ah8KjMVLSFvNbR7L3hTKqrAgIvds+TzRocQXWMfsCTtE0+VKOcsmrd7zgVCgF+sq
 O/nkiXq+JVmSpGFt5lh7Um6JS0sHgVQ/ayQhWTCMgMJSAPdiFLLSenssFSzZv7eH
 hyQyLJoshKkil5ebT2tAujsOJ/YkUjTVtU579WGtbBcGSkk7uUqictMoHROn9wZG
 G+XNjNwsprayog==
X-ME-Sender: <xms:_DVKXoj9sAtGFP--G4Q_DcFYVACPHR8JljwnGCTpSoK2xlkp3KTPxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
 rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_DVKXvi35OWWRKvbwKHp06CSpV6mTTxMMWWt4mGjWP8IUNuAWV91Ow>
 <xmx:_DVKXmRdPKSp8domuYjy8M-uNeMp5ciAGnR9vcobjp6jvLmzfWUxmw>
 <xmx:_DVKXuBHEPd2Urvd_uhYhp5Q_JWiJUtmiZeOcCwCP8ElicjHPLD2_g>
 <xmx:_DVKXm0D7I4TRSBrYtf2P51TFthcpsISb8lR68KFrW9mP1GqsWzacw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id BC937328005A;
 Mon, 17 Feb 2020 01:43:07 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Mon, 17 Feb 2020 00:42:44 -0600
Message-Id: <20200217064250.15516-29-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
Subject: [alsa-devel] [RFC PATCH 28/34] ASoC: sun8i-codec: Add AIF loopback
	controls
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This allows controlling the loopback flag for each AIF. This is useful
for developing/testing complicated audio routing scenarios (such as
recording a phone call while using a BT headset for mic/earpiece)
without needing to involve the devices on the other end of the DAI
links.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index fdb9bf346cc2..245145e36357 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -63,6 +63,7 @@
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_SRC		10
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_SRC		8
+#define SUN8I_AIF1_DACDAT_CTRL_AIF1_LOOP_ENA		0
 #define SUN8I_AIF1_MXR_SRC				0x04c
 #define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF1DA0L	15
 #define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF2DACL	14
@@ -82,6 +83,7 @@
 #define SUN8I_AIF2_DACDAT_CTRL_AIF2_DACR_ENA		14
 #define SUN8I_AIF2_DACDAT_CTRL_AIF2_DACL_SRC		10
 #define SUN8I_AIF2_DACDAT_CTRL_AIF2_DACR_SRC		8
+#define SUN8I_AIF2_DACDAT_CTRL_AIF2_LOOP_ENA		0
 #define SUN8I_AIF2_MXR_SRC				0x08c
 #define SUN8I_AIF2_MXR_SRC_ADCL_MXR_SRC_AIF1DA0L	15
 #define SUN8I_AIF2_MXR_SRC_ADCL_MXR_SRC_AIF1DA1L	14
@@ -519,6 +521,21 @@ static struct snd_soc_dai_driver sun8i_codec_dais[] = {
 	},
 };
 
+static const struct snd_kcontrol_new sun8i_aif1_loopback_switch =
+	SOC_DAPM_SINGLE("AIF1 Loopback Switch",
+			SUN8I_AIF1_DACDAT_CTRL,
+			SUN8I_AIF1_DACDAT_CTRL_AIF1_LOOP_ENA, 1, 0);
+
+static const struct snd_kcontrol_new sun8i_aif2_loopback_switch =
+	SOC_DAPM_SINGLE("AIF2 Loopback Switch",
+			SUN8I_AIF2_DACDAT_CTRL,
+			SUN8I_AIF2_DACDAT_CTRL_AIF2_LOOP_ENA, 1, 0);
+
+static const struct snd_kcontrol_new sun8i_aif3_loopback_switch =
+	SOC_DAPM_SINGLE("Switch",
+			SUN8I_AIF3_DACDAT_CTRL,
+			SUN8I_AIF3_DACDAT_CTRL_AIF3_LOOP_ENA, 1, 0);
+
 static const char *const sun8i_aif_stereo_mux_enum_names[] = {
 	"Stereo", "Reverse Stereo", "Sum Mono", "Mix Mono"
 };
@@ -643,6 +660,20 @@ static const struct snd_kcontrol_new sun8i_dac_mixer_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
+	/* AIF Loopback Switches */
+	SND_SOC_DAPM_SWITCH("AIF1 Slot 0 Left Loopback", SND_SOC_NOPM, 0, 0,
+			    &sun8i_aif1_loopback_switch),
+	SND_SOC_DAPM_SWITCH("AIF1 Slot 0 Right Loopback", SND_SOC_NOPM, 0, 0,
+			    &sun8i_aif1_loopback_switch),
+
+	SND_SOC_DAPM_SWITCH("AIF2 Left Loopback", SND_SOC_NOPM, 0, 0,
+			    &sun8i_aif2_loopback_switch),
+	SND_SOC_DAPM_SWITCH("AIF2 Right Loopback", SND_SOC_NOPM, 0, 0,
+			    &sun8i_aif2_loopback_switch),
+
+	SND_SOC_DAPM_SWITCH("AIF3 Loopback", SND_SOC_NOPM, 0, 0,
+			    &sun8i_aif3_loopback_switch),
+
 	/* AIF "ADC" Outputs */
 	SND_SOC_DAPM_AIF_OUT("AIF1 AD0 Left", "AIF1 Capture", 0,
 			     SUN8I_AIF1_ADCDAT_CTRL,
@@ -776,6 +807,15 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
+	/* AIF Loopback Routes */
+	{ "AIF1 Slot 0 Left Loopback", "AIF1 Loopback Switch", "AIF1 AD0 Left" },
+	{ "AIF1 Slot 0 Right Loopback", "AIF1 Loopback Switch", "AIF1 AD0 Right" },
+
+	{ "AIF2 Left Loopback", "AIF2 Loopback Switch", "AIF2 ADC Left" },
+	{ "AIF2 Right Loopback", "AIF2 Loopback Switch", "AIF2 ADC Right" },
+
+	{ "AIF3 Loopback", "Switch", "AIF3 ADC" },
+
 	/* AIF "ADC" Output Routes */
 	{ "AIF1 AD0 Left", NULL, "AIF1 AD0 Left Stereo Mux" },
 	{ "AIF1 AD0 Right", NULL, "AIF1 AD0 Right Stereo Mux" },
@@ -882,12 +922,20 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "AIF2 DAC Right Stereo Mux", "Mix Mono", "AIF2 DAC Right" },
 
 	/* AIF "DAC" Input Routes */
+	{ "AIF1 DA0 Left", NULL, "AIF1 Slot 0 Left Loopback" },
+	{ "AIF1 DA0 Right", NULL, "AIF1 Slot 0 Right Loopback" },
+
 	{ "AIF1 DA0 Left", NULL, "AIF1CLK" },
 	{ "AIF1 DA0 Right", NULL, "AIF1CLK" },
 
+	{ "AIF2 DAC Left", NULL, "AIF2 Left Loopback" },
+	{ "AIF2 DAC Right", NULL, "AIF2 Right Loopback" },
+
 	{ "AIF2 DAC Left", NULL, "AIF2CLK" },
 	{ "AIF2 DAC Right", NULL, "AIF2CLK" },
 
+	{ "AIF3 DAC", NULL, "AIF3 Loopback" },
+
 	/* Main DAC Output Routes */
 	{ "DAC Left", NULL, "DAC Left Mixer" },
 	{ "DAC Right", NULL, "DAC Right Mixer" },
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
