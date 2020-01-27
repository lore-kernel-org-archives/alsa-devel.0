Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB9C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:12:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DBB21739
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A46NPWRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DBB21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06D7A14E;
	Mon, 27 Jan 2020 19:11:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06D7A14E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580148737;
	bh=/XgvFhbBB/AudquzeptN4a+W3UXD3YE5ykqUvxWxwug=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=A46NPWRDJDIvLFp9DkJragEV8+he8O6VcEyDXp5+RLX++AytXe4g+sM/esNy09LvS
	 EutjFIzYuKGyj+lKuBXHyzjyBnEhNGDrkQXdtr3uAvdpwxvH4sboQvg/Eidgn/BRFR
	 MzHrWHy8pfMW3z1oPEC8f7cgMmRjmuhj63Zhu5UI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B62BF80234;
	Mon, 27 Jan 2020 19:11:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 097C9F8021E; Mon, 27 Jan 2020 19:11:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id BF3FCF80082
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 19:11:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF3FCF80082
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5A630E;
 Mon, 27 Jan 2020 10:11:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8AFB3F67D;
 Mon, 27 Jan 2020 10:11:17 -0800 (PST)
Date: Mon, 27 Jan 2020 18:11:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <20200124213625.30186-8-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200124213625.30186-8-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: Intel: consistent HDMI codec probing
	code" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: Intel: consistent HDMI codec probing code

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 98ff5c262f27aafee077a4c096f71a8566e9e948 Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Date: Fri, 24 Jan 2020 15:36:25 -0600
Subject: [PATCH] ASoC: Intel: consistent HDMI codec probing code

Multiple Intel ASoC machine drivers repeat the same pattern in their
.late_probe() methods: they first check whether the common HDMI codec
driver is used, if not, they proceed by linking the legacy HDMI
driver to each HDMI port. While doing that they use some
inconsistent code:

1. after the loop they check, whether the list contained at least one
   element and if not, they return an error. However, the earlier
   code to use the common HDMI driver uses the first element of the
   same list without checking. To fix this we move the check to the
   top of the function.

2. some of those .late_probe() implementations execute code, only
   needed for the common HDMI driver, before checking, whether the
   driver is used. Move the code to after the check.

3. Some of those functions also perform a redundant initialisation of
   the "err" variable.

This patch fixes those issues.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200124213625.30186-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 +++++++-------
 sound/soc/intel/boards/bxt_rt298.c            | 14 +++++++-------
 sound/soc/intel/boards/cml_rt1011_rt5682.c    | 13 +++++++------
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 16 ++++++++--------
 sound/soc/intel/boards/sof_rt5682.c           | 15 ++++++++-------
 5 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 33b13f3ca152..9177401c37a5 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -617,12 +617,15 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, broxton_map,
 					ARRAY_SIZE(broxton_map));
 
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct bxt_hdmi_pcm,
-			       head);
-	component = pcm->codec_dai->component;
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
 
-	if (ctx->common_hdmi_codec_drv)
+	if (ctx->common_hdmi_codec_drv) {
+		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct bxt_hdmi_pcm,
+				       head);
+		component = pcm->codec_dai->component;
 		return hda_dsp_hdmi_build_controls(card, component);
+	}
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
@@ -643,9 +646,6 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	if (!component)
-		return -EINVAL;
-
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 067a97e7e6a8..4b67f261377c 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -529,12 +529,15 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct bxt_hdmi_pcm,
-			       head);
-	component = pcm->codec_dai->component;
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
 
-	if (ctx->common_hdmi_codec_drv)
+	if (ctx->common_hdmi_codec_drv) {
+		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct bxt_hdmi_pcm,
+				       head);
+		component = pcm->codec_dai->component;
 		return hda_dsp_hdmi_build_controls(card, component);
+	}
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
@@ -555,9 +558,6 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	if (!component)
-		return -EINVAL;
-
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index d6efc554898c..dd80d0186a6c 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -241,12 +241,15 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 	struct hdmi_pcm *pcm;
 	int ret, i = 0;
 
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct hdmi_pcm,
-			       head);
-	component = pcm->codec_dai->component;
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
 
-	if (ctx->common_hdmi_codec_drv)
+	if (ctx->common_hdmi_codec_drv) {
+		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct hdmi_pcm,
+				       head);
+		component = pcm->codec_dai->component;
 		return hda_dsp_hdmi_build_controls(card, component);
+	}
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
@@ -265,8 +268,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 
 		i++;
 	}
-	if (!component)
-		return -EINVAL;
 
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 4a6d117ea7af..8e947bad143c 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -534,15 +534,18 @@ static int glk_card_late_probe(struct snd_soc_card *card)
 	struct snd_soc_component *component = NULL;
 	char jack_name[NAME_SIZE];
 	struct glk_hdmi_pcm *pcm;
-	int err = 0;
+	int err;
 	int i = 0;
 
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct glk_hdmi_pcm,
-			       head);
-	component = pcm->codec_dai->component;
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
 
-	if (ctx->common_hdmi_codec_drv)
+	if (ctx->common_hdmi_codec_drv) {
+		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct glk_hdmi_pcm,
+				       head);
+		component = pcm->codec_dai->component;
 		return hda_dsp_hdmi_build_controls(card, component);
+	}
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
@@ -563,9 +566,6 @@ static int glk_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	if (!component)
-		return -EINVAL;
-
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 8a13231dee15..5d878873a8e0 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -273,19 +273,22 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 	struct snd_soc_component *component = NULL;
 	char jack_name[NAME_SIZE];
 	struct sof_hdmi_pcm *pcm;
-	int err = 0;
+	int err;
 	int i = 0;
 
 	/* HDMI is not supported by SOF on Baytrail/CherryTrail */
 	if (is_legacy_cpu)
 		return 0;
 
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm,
-			       head);
-	component = pcm->codec_dai->component;
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
 
-	if (ctx->common_hdmi_codec_drv)
+	if (ctx->common_hdmi_codec_drv) {
+		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm,
+				       head);
+		component = pcm->codec_dai->component;
 		return hda_dsp_hdmi_build_controls(card, component);
+	}
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
@@ -305,8 +308,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 
 		i++;
 	}
-	if (!component)
-		return -EINVAL;
 
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
