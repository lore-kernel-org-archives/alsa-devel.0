Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CAC433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:29:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860C422203
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vyy4H6ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860C422203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0827684D;
	Tue, 14 Jul 2020 15:29:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0827684D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594733395;
	bh=aW13u1pdqoALeJvtDk9C4ZMYesP9R4hRtwCs0dliT0g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vyy4H6ZIk/Uewv7GVKx+c8EBT3+T8rnDDo3enUgSGMWq7jQQNSmxKIWcblMwFIxSW
	 OGPGGcg54LkZGWRIB+eqDOStWPbWHCCZNjiY1T7SlyqSxUd9YcjrrFh4/xeWIXlXnu
	 On84NpAkuiGR2xdUpVNZPaXhKwAoFtcLPC7bNxo0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A006F80113;
	Tue, 14 Jul 2020 15:29:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8EDFF8019B; Tue, 14 Jul 2020 15:29:00 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F369F80113
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 15:28:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F369F80113
IronPort-SDR: i0MNH0Mi8BFe8TBdBhUMprVciqNbbL//gsyzyypUm3rAyxQR44eAxSGnR7MxMR5gDdnNf9ksCR
 aFEQ+L5LnG4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="137026696"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="137026696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 06:28:48 -0700
IronPort-SDR: O0Nm5uyrfx+b+M1QYvgmLf8Foyqu4ylHR32SUDnvEzCIWGJsplwGiekGFzElk2ktDaL1qJZihJ
 PIHTQWjev5kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="459689688"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 14 Jul 2020 06:28:46 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: intel/skl/hda - fix probe regression on systems without
 i915
Date: Tue, 14 Jul 2020 16:28:04 +0300
Message-Id: <20200714132804.3638221-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, kuninori.morimoto.gx@renesas.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Rander Wang <rander.wang@linux.intel.com>
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

Starting in commit cbc7a6b5a87a ("ASoC: soc-card: add
snd_soc_card_add_dai_link()"), error value from ASoc add_dai_link() is
no longer ignored.

The generic HDA machine driver relied on the old semantics to disable
i915 HDMI/DP audio codec at runtime. If no display codec was present,
add_dai_link() returned an error, but this was ignored and rest of the
card was successfully probed.

Fix the problem by changing the machine driver add_dai_link() to not
return an error in this case.

Fixes: cbc7a6b5a87a ("ASoC: soc-card: add snd_soc_card_add_dai_link()")
BugLink: https://github.com/thesofproject/linux/issues/2261
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---

Notes:
    base broonie/for-5.8 at commit 12eb3ad0638c ("ASoC: rt286: fix unexpected interrupt happens")

 sound/soc/intel/boards/skl_hda_dsp_common.h  |  1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
index 507750ef67f3..4b0b3959182e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -33,6 +33,7 @@ struct skl_hda_private {
 	int dai_index;
 	const char *platform_name;
 	bool common_hdmi_codec_drv;
+	bool idisp_codec;
 };
 
 extern struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS];
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 79c8947f840b..ca4900036ead 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -79,6 +79,9 @@ skl_hda_add_dai_link(struct snd_soc_card *card, struct snd_soc_dai_link *link)
 	link->platforms->name = ctx->platform_name;
 	link->nonatomic = 1;
 
+	if (!ctx->idisp_codec)
+		return 0;
+
 	if (strstr(link->name, "HDMI")) {
 		ret = skl_hda_hdmi_add_pcm(card, ctx->pcm_count);
 
@@ -118,19 +121,20 @@ static char hda_soc_components[30];
 static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params *mach_params)
 {
 	struct snd_soc_card *card = &hda_soc_card;
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai_link *dai_link;
-	u32 codec_count, codec_mask, idisp_mask;
+	u32 codec_count, codec_mask;
 	int i, num_links, num_route;
 
 	codec_mask = mach_params->codec_mask;
 	codec_count = hweight_long(codec_mask);
-	idisp_mask = codec_mask & IDISP_CODEC_MASK;
+	ctx->idisp_codec = !!(codec_mask & IDISP_CODEC_MASK);
 
 	if (!codec_count || codec_count > 2 ||
-	    (codec_count == 2 && !idisp_mask))
+	    (codec_count == 2 && !ctx->idisp_codec))
 		return -EINVAL;
 
-	if (codec_mask == idisp_mask) {
+	if (codec_mask == IDISP_CODEC_MASK) {
 		/* topology with iDisp as the only HDA codec */
 		num_links = IDISP_DAI_COUNT + DMIC_DAI_COUNT;
 		num_route = IDISP_ROUTE_COUNT;
@@ -152,7 +156,7 @@ static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params *mach_params)
 		num_route = ARRAY_SIZE(skl_hda_map);
 		card->dapm_widgets = skl_hda_widgets;
 		card->num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets);
-		if (!idisp_mask) {
+		if (!ctx->idisp_codec) {
 			for (i = 0; i < IDISP_DAI_COUNT; i++) {
 				skl_hda_be_dai_links[i].codecs = dummy_codec;
 				skl_hda_be_dai_links[i].num_codecs =
@@ -211,6 +215,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	if (!mach)
 		return -EINVAL;
 
+	snd_soc_card_set_drvdata(&hda_soc_card, ctx);
+
 	ret = skl_hda_fill_card_info(&mach->mach_params);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unsupported HDAudio/iDisp configuration found\n");
@@ -223,7 +229,6 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&hda_soc_card, ctx);
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
-- 
2.27.0

