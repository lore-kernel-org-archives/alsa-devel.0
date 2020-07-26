Return-Path: <SRS0=gzS/=BF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D1C433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 02:58:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5A320700
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 02:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="keucrM22";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="NsyBIab5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MX0wUf5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D4BD168E;
	Sun, 26 Jul 2020 04:58:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D4BD168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595732331;
	bh=+XnNjZHrfkSyXf6MOpUvvQMaVYLGs1J0mNvSVfIxUSA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keucrM22oZD7O0lfCIxv5CoP3oGlb11dGKVm5i7cPiKmREidJ1kputjnbO8T/mLOT
	 Vs1QHLPgkuKKS2oK2SWUCSomBrRqnazfdNPdNCokL+CyHdduIRUbsY0gXlm9rZ/UfQ
	 hXpOfq9ZF/A1IJ0iNRLG9F3+3LnOH79VDp48kmZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B2E8F802EA;
	Sun, 26 Jul 2020 04:54:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21143F80227; Sun, 26 Jul 2020 04:53:55 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 765C6F80254
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2020 04:53:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 765C6F80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="NsyBIab5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="MX0wUf5S"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id D9D005804FF;
 Sat, 25 Jul 2020 22:53:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=hMP+XOSq5Dytq
 NXan7fqx8FFoZjdxZgtQttmYrTXXe8=; b=NsyBIab5f8qLG2VJAYMNaoe+y49UG
 jYYhV3mhsYWIDE0Y38JkTQxkECrkyHxXs89feOF/xofBn+ja6mdYpz2EGxDkfXaN
 f6b0JweS3vnwpif1UrdYWWiUKJROxpDzByVyb77QW93i2ClPDqka0bvjKoFL9AZQ
 vS8xziAEbcnToKquEmIV0qASYHc8o6pbeLjG5dtYxYAl3uahrWiMegRQCmBMidiK
 K/Mtl6Rtmzc3bKzlr5mrH3YFZZ6Hy0QtSbxsW1nZMEOoZuo/kJZk4m+Jdv8yq1Rg
 Iglj7qrOCeMXd99rw5FYM086pxlA07FHZCXzSdYJx+5Cih9aBzyFxqqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=hMP+XOSq5DytqNXan7fqx8FFoZjdxZgtQttmYrTXXe8=; b=MX0wUf5S
 IsZvmDTK+zXRsXiOJ2Ehz6nz7Jez8BgdazJ7L+kJPceqvqMf3pSS5/hlI2bcsUfp
 HW0vYblZjUkeKE7C6aAU+gvHf5jcmeB0YWgbJyx7LfjWOEfzdgE6KwWdYHSbfVaT
 bz+0RfvlPiSo+4c2XzWNkOiEj7er6+9u2BKagOBGZiFnM26JlpNDHCMstTuyzpNe
 2q1pIwl6dGLSNsFciqnNn3OAJLAm2JOjd58Zlzahl0z2/AgWWl6w1jA2naA2ExbU
 FPrXPeKAzQTOD4HARbwfCvmhJyHGLrtzkEb9H72+fyjNi8niADmlDw/T5fhgRag/
 P77gwR2gTeNB3g==
X-ME-Sender: <xms:MfAcX4nU-faE9oOPT9bBTkcLPis3U2ChvrZejKKduGz4AF2IiBnwug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:MfAcX32wlKHd6TkMWp0ezDZzOvJ8vbI3wdMfQblC8vURasJddNPmQQ>
 <xmx:MfAcX2rLe3OTb9ELpFGkj7DPyN9FTLNoAd9U4kG66rAf7vneBuyI9w>
 <xmx:MfAcX0lEEht4hZmG5lnMcV8OlKICoYQvV50uW6sl1RfZqXZq_05ORw>
 <xmx:MfAcX_lTL_u7M7wXaVNJ4V-BTHe38UvwZWwGCP3pBJgfRy9rVFAd0Q>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 45015328005D;
 Sat, 25 Jul 2020 22:53:37 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 5/8] ASoC: sun50i-codec-analog: Enable DAPM for headphone
 switch
Date: Sat, 25 Jul 2020 21:53:31 -0500
Message-Id: <20200726025334.59931-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
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

By including the headphone mute switch to the DAPM graph, both the
headphone amplifier and the Mixer/DAC inputs can be powered off when
the headphones are muted.

The mute switch is between the source selection and the amplifier,
as per the diagram in the SoC manual.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index f98851067f97..176d6658d099 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -193,11 +193,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		       SUN50I_ADDA_HP_CTRL_HPVOL, 0x3f, 0,
 		       sun50i_codec_hp_vol_scale),
 
-	SOC_DOUBLE("Headphone Playback Switch",
-		   SUN50I_ADDA_MIX_DAC_CTRL,
-		   SUN50I_ADDA_MIX_DAC_CTRL_LHPPAMUTE,
-		   SUN50I_ADDA_MIX_DAC_CTRL_RHPPAMUTE, 1, 0),
-
 	/* Mixer pre-gain */
 	SOC_SINGLE_TLV("Mic1 Playback Volume", SUN50I_ADDA_MIC1_CTRL,
 		       SUN50I_ADDA_MIC1_CTRL_MIC1G,
@@ -264,6 +259,12 @@ static const struct snd_kcontrol_new sun50i_codec_hp_src[] = {
 		      sun50i_codec_hp_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_hp_switch =
+	SOC_DAPM_DOUBLE("Headphone Playback Switch",
+			SUN50I_ADDA_MIX_DAC_CTRL,
+			SUN50I_ADDA_MIX_DAC_CTRL_LHPPAMUTE,
+			SUN50I_ADDA_MIX_DAC_CTRL_RHPPAMUTE, 1, 0);
+
 static const char * const sun50i_codec_lineout_src_enum_text[] = {
 	"Stereo", "Mono Differential",
 };
@@ -315,6 +316,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_MUX("Right Headphone Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
+	SND_SOC_DAPM_SWITCH("Left Headphone Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_hp_switch),
+	SND_SOC_DAPM_SWITCH("Right Headphone Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_hp_switch),
 	SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
 			     SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
@@ -413,13 +418,15 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	/* Headphone Routes */
 	{ "Left Headphone Source", "DAC", "Left DAC" },
 	{ "Left Headphone Source", "Mixer", "Left Mixer" },
-	{ "Left Headphone Amp", NULL, "Left Headphone Source" },
+	{ "Left Headphone Switch", "Headphone Playback Switch", "Left Headphone Source" },
+	{ "Left Headphone Amp", NULL, "Left Headphone Switch" },
 	{ "Left Headphone Amp", NULL, "Headphone Amp" },
 	{ "HP", NULL, "Left Headphone Amp" },
 
 	{ "Right Headphone Source", "DAC", "Right DAC" },
 	{ "Right Headphone Source", "Mixer", "Right Mixer" },
-	{ "Right Headphone Amp", NULL, "Right Headphone Source" },
+	{ "Right Headphone Switch", "Headphone Playback Switch", "Right Headphone Source" },
+	{ "Right Headphone Amp", NULL, "Right Headphone Switch" },
 	{ "Right Headphone Amp", NULL, "Headphone Amp" },
 	{ "HP", NULL, "Right Headphone Amp" },
 
-- 
2.26.2

