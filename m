Return-Path: <SRS0=uq2S=3A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D97C282DD
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:45:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F71E2087F
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YZVh6Sz5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="hBQ1uSQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F71E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C354F1698;
	Sat, 11 Jan 2020 17:44:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C354F1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578761102;
	bh=2QHzc3s0m4aJMtS0YAnzwqld8hfjDzGiIInz+4sEETo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YZVh6Sz5sVJAyBIHc7P9VXat54M11/cWdqtVTqLP4OwpPB7jsls1makxeTS5gXQSg
	 2Iuk08Px88EKIFrTu+GiHmpbV0ygq5X0RCzkzBeY/La8tnRNQ2RDG1/gvPkyNis4lm
	 R0+XhHRP7MH76kYMCDhyAz6X2cLI/i0XUYuVlcoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4BCFF8028A;
	Sat, 11 Jan 2020 17:41:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69F7FF801F4; Sat, 11 Jan 2020 17:40:59 +0100 (CET)
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 809FFF800B9
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 17:40:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 809FFF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="hBQ1uSQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578760852;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=5jjHfnxrRJDesj6I56ZBVBKDQExEgqr2NC9/ksJgp3I=;
 b=hBQ1uSQjfm70sPk7mcUB0NHneewBEtHohwtjq/kPNRxKOkEGsrAJp3newcOeYglsQV
 1rGupRYWrEK9qEWTRoq5NSxBnYyz9VvaQLGn5gy8X5lTDM8oOR7ISqkx2kbNEo2MRLP6
 Sh+bD2fJBm/dli5O9IHiXgpb9KQl/jFaqoEfsoyLgQaS/zNNmnwCDDLkI5zSzJrkLev5
 s2GPneN0fhZQCDKQxRwXWRzwKEMLONDUyj9z/m8Gzet+akNfB20cNmbPkpiBaIZRaoaP
 Lsc435vC2IplGbGRaVQN+ahhaHjFML+CAyRvbGipjLfRYr3lg/xk63aG1DAOdNOQNekF
 ce4w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMv5qxJRCe0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.1.4 AUTH)
 with ESMTPSA id h048a6w0BGeoFqA
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 11 Jan 2020 17:40:50 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Date: Sat, 11 Jan 2020 17:40:05 +0100
Message-Id: <20200111164006.43074-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111164006.43074-1-stephan@gerhold.net>
References: <20200111164006.43074-1-stephan@gerhold.net>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Nikita Travkin <nikitos.tr@gmail.com>
Subject: [alsa-devel] [PATCH 3/4] ASoC: msm8916-wcd-analog: Simplify MIC
	BIAS Internal
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

At the moment, MIC BIAS Internal* and MIC BIAS External* both reference
the same register, and have a part of their initialization sequence
duplicated.

In general, the sequence for enabling MIC BIAS InternalX seems to be:
  1. Enable MIC BIAS ExternalX
  2. Enable internal RBIAS resistor

This means that we can simplify the code by modelling MIC BIAS InternalX
as supply connected to MIC BIAS ExternalX. MIC BIAS InternalX is only
responsible for enabling the internal RBIAS resistor (2). The DAPM enable
sequence will automatically enable MIC BIAS ExternalX (1).

This makes it much easier to add support for MIC BIAS Internal3
as a next step.

Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # longcheer-l8150
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 57 ++++++---------------------
 1 file changed, 13 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 1f7964beb20c..930baae6eff5 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -389,23 +389,17 @@ static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_component
 	return 0;
 }
 
-static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_component
-						 *component, int event,
-						 int reg, u32 cap_mode)
+static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_dapm_widget *w,
+						struct snd_kcontrol *kcontrol,
+						int event)
 {
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
 		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_1_60UA);
-
-		break;
-	case SND_SOC_DAPM_POST_PMU:
-		pm8916_wcd_analog_micbias_enable(component);
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
-				    MICB_1_EN_BYP_CAP_MASK, cap_mode);
 		break;
 	}
 
@@ -437,26 +431,6 @@ static int pm8916_wcd_analog_enable_micbias_ext2(struct
 
 }
 
-static int pm8916_wcd_analog_enable_micbias_int1(struct
-						  snd_soc_dapm_widget
-						  *w, struct snd_kcontrol
-						  *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
-				    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
-				    MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE);
-		break;
-	}
-
-	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
-						     wcd->micbias1_cap_mode);
-}
-
 static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 				      bool micbias2_enabled)
 {
@@ -564,9 +538,8 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
+		snd_soc_component_update_bits(component, CDC_A_MICB_2_EN,
+					      CDC_A_MICB_2_PULL_DOWN_EN_MASK, 0);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		pm8916_mbhc_configure_bias(wcd, true);
@@ -576,8 +549,7 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 		break;
 	}
 
-	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
-						     wcd->micbias2_cap_mode);
+	return pm8916_wcd_analog_enable_micbias_int(w, kcontrol, event);
 }
 
 static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
@@ -878,12 +850,10 @@ static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
 	{"SPK PA", NULL, "SPK DAC"},
 	{"SPK DAC", "Switch", "PDM_RX3"},
 
-	{"MIC BIAS Internal1", NULL, "INT_LDO_H"},
-	{"MIC BIAS Internal2", NULL, "INT_LDO_H"},
+	{"MIC BIAS Internal1", NULL, "MIC BIAS External1"},
+	{"MIC BIAS Internal2", NULL, "MIC BIAS External2"},
 	{"MIC BIAS External1", NULL, "INT_LDO_H"},
 	{"MIC BIAS External2", NULL, "INT_LDO_H"},
-	{"MIC BIAS Internal1", NULL, "vdd-micbias"},
-	{"MIC BIAS Internal2", NULL, "vdd-micbias"},
 	{"MIC BIAS External1", NULL, "vdd-micbias"},
 	{"MIC BIAS External2", NULL, "vdd-micbias"},
 };
@@ -937,11 +907,10 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("RX_BIAS", CDC_A_RX_COM_BIAS_DAC, 7, 0, NULL, 0),
 
 	/* TX */
-	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_EN, 7, 0,
-			    pm8916_wcd_analog_enable_micbias_int1,
-			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			    SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2", CDC_A_MICB_2_EN, 7, 0,
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_INT_RBIAS, 7, 0,
+			    pm8916_wcd_analog_enable_micbias_int,
+			    SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2", CDC_A_MICB_1_INT_RBIAS, 4, 0,
 			    pm8916_wcd_analog_enable_micbias_int2,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
