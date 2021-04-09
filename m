Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89CC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949C610CF
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949C610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D9A01681;
	Sat, 10 Apr 2021 00:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D9A01681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618005892;
	bh=5YDSdjSqFjV/5k4IUgoKxkZ0WuQ4XpHiX1Lna2hiq8E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MnIeu9X4KrwifZiY5qIrc+rW1/eayB2mXmH/wmR7Exv5CxM/TH5n/QW6MyUYHpSZm
	 tJrZkNd2Q3GYR7DtzHAqyTShGjcdlYcz6ABcN10vP4oUpxOuvqoYDdTkIpv11mDyqH
	 cksOBHb6eJvNjvP/0ZynIgdtCjKHVOXE7ssxW4Nk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C819EF804AC;
	Sat, 10 Apr 2021 00:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B29C7F80245; Sat, 10 Apr 2021 00:01:52 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01588F802C9
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01588F802C9
IronPort-SDR: iEuSDxj8eORvyDpS6qjOUEtFeYvUp1I/zVg2P4qC+JlMTJMhRe9yo2ajsCFqhwrOq1IwVfuqdw
 Z8dRt4xlwhKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214284737"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="214284737"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:41 -0700
IronPort-SDR: 3STFujXkU87WWze1gUnrsZQj5YF2sLZVOcSv3ximKGIKy/hEHBcxLMVpgNbDD8kvT6fqodFfG1
 lkFCvJeJ9yyA==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599290648"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:39 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/6] ASOC: SOF: simplify nocodec mode
Date: Fri,  9 Apr 2021 15:01:21 -0700
Message-Id: <20210409220121.1542362-7-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
References: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Replace ugly #if (!IS_ENABLED) by if (!IS_ENABLED), remove
cross-module dependencies and use classic mechanism to pass
information to the machine driver.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/sof.h       |  3 ---
 sound/soc/sof/nocodec.c   | 39 +++++++++++++++++++++------------------
 sound/soc/sof/sof-audio.c | 32 ++++++++++++++------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index b93bb8038080..502ed9b8d6a1 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -100,9 +100,6 @@ struct sof_dev_desc {
 	const struct snd_sof_dsp_ops *ops;
 };
 
-int sof_nocodec_setup(struct device *dev, const struct snd_sof_dsp_ops *ops,
-		      int (*pcm_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
-						struct snd_pcm_hw_params *params));
 int sof_dai_get_mclk(struct snd_soc_pcm_runtime *rtd);
 
 #endif
diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index 3b9bb2e83a86..356497fe4f4c 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -20,16 +20,14 @@ static struct snd_soc_card sof_nocodec_card = {
 };
 
 static int sof_nocodec_bes_setup(struct device *dev,
-				 const struct snd_sof_dsp_ops *ops,
+				 struct snd_soc_dai_driver *drv,
 				 struct snd_soc_dai_link *links,
-				 int link_num, struct snd_soc_card *card,
-				 int (*pcm_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
-							   struct snd_pcm_hw_params *params))
+				 int link_num, struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link_component *dlc;
 	int i;
 
-	if (!ops || !links || !card)
+	if (!drv || !links || !card)
 		return -EINVAL;
 
 	/* set up BE dai_links */
@@ -55,16 +53,16 @@ static int sof_nocodec_bes_setup(struct device *dev,
 
 		links[i].id = i;
 		links[i].no_pcm = 1;
-		links[i].cpus->dai_name = ops->drv[i].name;
-		links[i].platforms->name = dev_name(dev);
+		links[i].cpus->dai_name = drv[i].name;
+		links[i].platforms->name = dev_name(dev->parent);
 		links[i].codecs->dai_name = "snd-soc-dummy-dai";
 		links[i].codecs->name = "snd-soc-dummy";
-		if (ops->drv[i].playback.channels_min)
+		if (drv[i].playback.channels_min)
 			links[i].dpcm_playback = 1;
-		if (ops->drv[i].capture.channels_min)
+		if (drv[i].capture.channels_min)
 			links[i].dpcm_capture = 1;
 
-		links[i].be_hw_params_fixup = pcm_dai_link_fixup;
+		links[i].be_hw_params_fixup = sof_pcm_dai_link_fixup;
 	}
 
 	card->dai_link = links;
@@ -73,29 +71,34 @@ static int sof_nocodec_bes_setup(struct device *dev,
 	return 0;
 }
 
-int sof_nocodec_setup(struct device *dev, const struct snd_sof_dsp_ops *ops,
-		      int (*pcm_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
-						struct snd_pcm_hw_params *params))
+static int sof_nocodec_setup(struct device *dev,
+			     u32 num_dai_drivers,
+			     struct snd_soc_dai_driver *dai_drivers)
 {
 	struct snd_soc_dai_link *links;
 
 	/* create dummy BE dai_links */
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
-			     ops->num_drv, GFP_KERNEL);
+	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_dai_drivers, GFP_KERNEL);
 	if (!links)
 		return -ENOMEM;
 
-	return sof_nocodec_bes_setup(dev, ops, links, ops->num_drv,
-				     &sof_nocodec_card, pcm_dai_link_fixup);
+	return sof_nocodec_bes_setup(dev, dai_drivers, links, num_dai_drivers, &sof_nocodec_card);
 }
-EXPORT_SYMBOL(sof_nocodec_setup);
 
 static int sof_nocodec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &sof_nocodec_card;
+	struct snd_soc_acpi_mach *mach;
+	int ret;
 
 	card->dev = &pdev->dev;
 	card->topology_shortname_created = true;
+	mach = pdev->dev.platform_data;
+
+	ret = sof_nocodec_setup(card->dev, mach->mach_params.num_dai_drivers,
+				mach->mach_params.dai_drivers);
+	if (ret < 0)
+		return ret;
 
 	return devm_snd_soc_register_card(&pdev->dev, card);
 }
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 5d13bafd4736..0d0d47dc0246 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -468,24 +468,24 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 	struct snd_sof_pdata *sof_pdata = sdev->pdata;
 	const struct sof_dev_desc *desc = sof_pdata->desc;
 	struct snd_soc_acpi_mach *mach;
-	int ret;
 
-#if !IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)
+	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)) {
 
-	/* find machine */
-	snd_sof_machine_select(sdev);
-	if (sof_pdata->machine) {
-		snd_sof_set_mach_params(sof_pdata->machine, sdev);
-		return 0;
+		/* find machine */
+		snd_sof_machine_select(sdev);
+		if (sof_pdata->machine) {
+			snd_sof_set_mach_params(sof_pdata->machine, sdev);
+			return 0;
+		}
+
+		if (!IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)) {
+			dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
+			return -ENODEV;
+		}
+	} else {
+		dev_warn(sdev->dev, "Force to use nocodec mode\n");
 	}
 
-#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
-	dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
-	return -ENODEV;
-#endif
-#else
-	dev_warn(sdev->dev, "Force to use nocodec mode\n");
-#endif
 	/* select nocodec mode */
 	dev_warn(sdev->dev, "Using nocodec machine driver\n");
 	mach = devm_kzalloc(sdev->dev, sizeof(*mach), GFP_KERNEL);
@@ -495,10 +495,6 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 	mach->drv_name = "sof-nocodec";
 	sof_pdata->tplg_filename = desc->nocodec_tplg_filename;
 
-	ret = sof_nocodec_setup(sdev->dev, desc->ops, sof_pcm_dai_link_fixup);
-	if (ret < 0)
-		return ret;
-
 	sof_pdata->machine = mach;
 	snd_sof_set_mach_params(sof_pdata->machine, sdev);
 
-- 
2.25.1

