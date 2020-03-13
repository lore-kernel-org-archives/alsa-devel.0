Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5FC2BB1D
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:22:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E804B206B7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ll50zrfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E804B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 293F61837;
	Fri, 13 Mar 2020 17:21:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 293F61837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116555;
	bh=nwLhNbizDF7W7x3n64YT4ZoOvNfDchn5pKX/07yRlJQ=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ll50zrfbfybl0F71iS4ZzXcIAu6FZ1x0xRSQnBI8bOXC+QL3v3jJp4xZlgwVANiuA
	 AC1CA7qEleANUe+e4PDsy2/KmRXD4AevKVqxyWG6eSXrv9yfOZX9vcEcTWRORzqlDC
	 wmxGXc4MJ+S5eKzCmG060EYYJbTV6/wmUB2IKur4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1CFAF802DD;
	Fri, 13 Mar 2020 17:17:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA1F3F802C3; Fri, 13 Mar 2020 17:17:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 45212F80290
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45212F80290
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 804481045;
 Fri, 13 Mar 2020 09:17:39 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01F713F6CF;
 Fri, 13 Mar 2020 09:17:38 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:17:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Applied "ASoC: Intel: (cosmetic) simplify structure member access" to
 the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Message-ID: <20200313161737.uXmhCo3QhOeI0DR2L4Dom2vgU0SmANN04xNzzpVoEKE@z>

The patch

   ASoC: Intel: (cosmetic) simplify structure member access

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 42432196cfb01500ec058e8acc8dcfcf27eb76c9 Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Date: Thu, 12 Mar 2020 14:48:56 -0500
Subject: [PATCH] ASoC: Intel: (cosmetic) simplify structure member access

Fix a clumsy structure member dereference in all machine drivers.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200312194859.4051-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5650.c                 | 2 +-
 sound/soc/intel/boards/bdw-rt5677.c                 | 2 +-
 sound/soc/intel/boards/broadwell.c                  | 2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/bxt_rt298.c                  | 2 +-
 sound/soc/intel/boards/bytcht_da7213.c              | 2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c        | 2 +-
 sound/soc/intel/boards/cht_bsw_nau8824.c            | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c             | 2 +-
 sound/soc/intel/boards/cml_rt1011_rt5682.c          | 2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c       | 2 +-
 sound/soc/intel/boards/haswell.c                    | 2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 +-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c        | 2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       | 2 +-
 sound/soc/intel/boards/sof_da7219_max98373.c        | 2 +-
 sound/soc/intel/boards/sof_rt5682.c                 | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index 1a302436d450..058abf3eec50 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -298,7 +298,7 @@ static int bdw_rt5650_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	ret = snd_soc_fixup_dai_links_platform_name(&bdw_rt5650_card,
 						    mach->mach_params.platform);
 
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index bb643c99069d..a94f498388e1 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -412,7 +412,7 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 	}
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	ret = snd_soc_fixup_dai_links_platform_name(&bdw_rt5677_card,
 						    mach->mach_params.platform);
 	if (ret)
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index b9c12e24c70b..25178000c6a5 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -283,7 +283,7 @@ static int broadwell_audio_probe(struct platform_device *pdev)
 	broadwell_rt286.dev = &pdev->dev;
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	ret = snd_soc_fixup_dai_links_platform_name(&broadwell_rt286,
 						    mach->mach_params.platform);
 	if (ret)
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 9177401c37a5..061462248bce 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -721,7 +721,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	}
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret = snd_soc_fixup_dai_links_platform_name(&broxton_audio_card,
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 4b67f261377c..4b5e7f6dbdf1 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -627,7 +627,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, ctx);
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card,
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index eda7a500cad6..d6b912c013fc 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -231,7 +231,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	int ret_val = 0;
 	int i;
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	card = &bytcht_da7213_card;
 	card->dev = &pdev->dev;
 
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 70bb86f3342f..ea119d523926 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -553,7 +553,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* override plaform name, if required */
 	snd_soc_card_cht.dev = &pdev->dev;
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 501bad3976fb..34d4e17e3295 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -259,7 +259,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* override plaform name, if required */
 	snd_soc_card_cht.dev = &pdev->dev;
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b5b016d493f1..452691db12cc 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -539,7 +539,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (!drv)
 		return -ENOMEM;
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
 		if (acpi_dev_found(snd_soc_cards[i].codec_id) &&
diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index 2a6e5b124099..30de502b4fbb 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -451,7 +451,7 @@ static int snd_cml_rt1011_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	snd_soc_card_cml.dev = &pdev->dev;
 	platform_name = mach->mach_params.platform;
 
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 8e947bad143c..ea1de8b3f3cd 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -604,7 +604,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, ctx);
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card, platform_name);
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 3dadf9bff796..6589fa56873f 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -193,7 +193,7 @@ static int haswell_audio_probe(struct platform_device *pdev)
 	haswell_rt5640.dev = &pdev->dev;
 
 	/* override plaform name, if required */
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	ret = snd_soc_fixup_dai_links_platform_name(&haswell_rt5640,
 						    mach->mach_params.platform);
 	if (ret)
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index f65feee1c166..20d566e9dd9d 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -962,7 +962,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 341bb47311a6..6493ede89300 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -772,7 +772,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&kabylake_audio_card, ctx);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index fe2d3a23a4ef..3be764299ab0 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -182,7 +182,7 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	if (!mach)
 		return -EINVAL;
 
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index e6de3b28d840..8216c15fc8da 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -660,7 +660,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index c99c8b23e509..6f68712ffce9 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -703,7 +703,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 8f44f13d2848..8c657da5fcf0 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -335,7 +335,7 @@ static int audio_probe(struct platform_device *pdev)
 	card = (struct snd_soc_card *)pdev->id_entry->driver_data;
 	card->dev = &pdev->dev;
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 	ret = snd_soc_fixup_dai_links_platform_name(card,
 						    mach->mach_params.platform);
 	if (ret)
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 5d878873a8e0..99b5a5e01e38 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -604,7 +604,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
-	mach = (&pdev->dev)->platform_data;
+	mach = pdev->dev.platform_data;
 
 	/* A speaker amp might not be present when the quirk claims one is.
 	 * Detect this via whether the machine driver match includes quirk_data.
-- 
2.20.1

