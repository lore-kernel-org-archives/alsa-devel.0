Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807DDC43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C35C20737
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bpaMAbp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C35C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5334D1679;
	Wed, 25 Mar 2020 22:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5334D1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585173038;
	bh=BAJ8cLUlfqRckus8LZ2OnkvffiGr12PvSBa4/6097Ug=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bpaMAbp7m40vwoEXxs1Rns1ttZuEKdDy5UMqJWnj8kF1vFmeu7geff01UOa8bzFLg
	 Y7W6y05oqJr2RzGLEz3ueFnPeT5guEh4t7QqKlL01jQirEAK4CcRf6LBCPqKE1HHyC
	 4vc+doRIzplpITZpUq2O70AjOROdNjjgfnhs7QnE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0DC0F802A0;
	Wed, 25 Mar 2020 22:47:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C18DEF80147; Wed, 25 Mar 2020 22:44:59 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1925AF801DA
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:33:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1925AF801DA
IronPort-SDR: fy67IctSGDj5nMztz6d1sqcrj2rBYLmeDBWmP/cIKifndiJNttxxknxoNNwfTqYyJiPQpr9act
 xeuwswCzgJng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 14:32:52 -0700
IronPort-SDR: LLSauTTSEaok7OkLFDTV6o0E05kfhCBKx6ckdIeriDZ7LwWiiJ03Ro442X/uq0WBAy4Po7y260
 DDunSkTwhwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="420455882"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by orsmga005.jf.intel.com with ESMTP; 25 Mar 2020 14:32:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: intel: sof_da7219_max98373: Add speaker switch
Date: Wed, 25 Mar 2020 16:32:43 -0500
Message-Id: <20200325213245.28247-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325213245.28247-1-pierre-louis.bossart@linux.intel.com>
References: <20200325213245.28247-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Bhat@alsa-project.org, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Uday M <uday.m.bhat@intel.com>,
 Yong Zhi <yong.zhi@intel.com>
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

From: Yong Zhi <yong.zhi@intel.com>

Add "Spk Switch" and associated widget, route to max98360a
speaker amp for power saving, also remove the speaker_amp_init()
callback with complete separated tables for max98373 and max98360a.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Bhat, Uday M <uday.m.bhat@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 67 +++++++++++---------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 6d210ba06d19..239d8ffdbccd 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -72,11 +72,17 @@ static const struct snd_kcontrol_new controls[] = {
 static const struct snd_kcontrol_new m98360a_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Spk"),
 };
 
+/* For MAX98373 amp */
 static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			    platform_clock_control, SND_SOC_DAPM_POST_PMD |
 			    SND_SOC_DAPM_PRE_PMU),
@@ -90,17 +96,33 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+
+	{ "Left Spk", NULL, "Left BE_OUT" },
+	{ "Right Spk", NULL, "Right BE_OUT" },
 };
 
-/* For MAX98373 amp */
-static const struct snd_soc_dapm_widget max98373_widgets[] = {
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
+/* For MAX98360A amp */
+static const struct snd_soc_dapm_widget max98360a_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+
+	SND_SOC_DAPM_SPK("Spk", NULL),
+
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			    platform_clock_control, SND_SOC_DAPM_POST_PMD |
+			    SND_SOC_DAPM_PRE_PMU),
 };
 
-static const struct snd_soc_dapm_route max98373_map[] = {
-	{ "Left Spk", NULL, "Left BE_OUT" },
-	{ "Right Spk", NULL, "Right BE_OUT" },
+static const struct snd_soc_dapm_route max98360a_map[] = {
+	{ "Headphone Jack", NULL, "HPL" },
+	{ "Headphone Jack", NULL, "HPR" },
+
+	{ "MIC", NULL, "Headset Mic" },
+
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+
+	{"Spk", NULL, "Speaker"},
 };
 
 static struct snd_soc_jack headset;
@@ -144,21 +166,6 @@ static int da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int speaker_amp_init(struct snd_soc_pcm_runtime *rtd)
-{
-	int ret;
-
-	/* Add widgets */
-	ret = snd_soc_dapm_new_controls(&rtd->card->dapm, max98373_widgets,
-					ARRAY_SIZE(max98373_widgets));
-	if (ret)
-		return ret;
-
-	/* Add routes */
-	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98373_map,
-				       ARRAY_SIZE(max98373_map));
-}
-
 static int ssp1_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
@@ -249,8 +256,9 @@ SND_SOC_DAILINK_DEF(ssp1_amps,
 	DAILINK_COMP_ARRAY(
 	/* Left */	COMP_CODEC(MAXIM_DEV0_NAME, MAX98373_CODEC_DAI),
 	/* Right */	COMP_CODEC(MAXIM_DEV1_NAME, MAX98373_CODEC_DAI)));
-/* For the driver-less spk amp */
-SND_SOC_DAILINK_DEF(dummy, DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
+SND_SOC_DAILINK_DEF(ssp1_m98360a,
+	DAILINK_COMP_ARRAY(COMP_CODEC("MX98360A:00", "HiFi")));
 
 SND_SOC_DAILINK_DEF(dmic_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
@@ -282,7 +290,6 @@ static struct snd_soc_dai_link dais[] = {
 		.id = 0,
 		.ignore_pmdown_time = 1,
 		.no_pcm = 1,
-		.init = speaker_amp_init,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1, /* IV feedback */
 		.ops = &ssp1_ops,
@@ -356,10 +363,10 @@ static struct snd_soc_card card_da7219_m98360a = {
 	.num_links = ARRAY_SIZE(dais),
 	.controls = m98360a_controls,
 	.num_controls = ARRAY_SIZE(m98360a_controls),
-	.dapm_widgets = widgets,
-	.num_dapm_widgets = ARRAY_SIZE(widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.dapm_widgets = max98360a_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max98360a_widgets),
+	.dapm_routes = max98360a_map,
+	.num_dapm_routes = ARRAY_SIZE(max98360a_map),
 	.fully_routed = true,
 	.late_probe = card_late_probe,
 };
@@ -383,7 +390,7 @@ static int audio_probe(struct platform_device *pdev)
 			.no_pcm = 1,
 			.dpcm_playback = 1,
 			.ignore_pmdown_time = 1,
-			SND_SOC_DAILINK_REG(ssp1_pin, dummy, platform) };
+			SND_SOC_DAILINK_REG(ssp1_pin, ssp1_m98360a, platform) };
 	}
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
-- 
2.20.1

