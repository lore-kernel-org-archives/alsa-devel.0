Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2105C63697
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C6E2068D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hf8OnJDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C6E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31FCF187E;
	Thu, 12 Nov 2020 23:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31FCF187E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605221083;
	bh=pxMUTdqtMEtD/8B2tfxp/5oxii+tNOOotW8Wsd8TiJo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hf8OnJDm4ZDp+MtSQZoM0O/2v3qtbfYl7018KqgwGF1tUt35ljeD1WUplm073jo13
	 cdowAGuLYN0aql+D1ftJrVAepusaGJQeNohCPpPyU3O9Iiamn00W4e7Ni12KLv2pcQ
	 TUMbpcIFHZnfnIC1EEvECQhpjWKFmOg51mPFu5O8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 028C3F8051C;
	Thu, 12 Nov 2020 23:39:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF077F804F2; Thu, 12 Nov 2020 23:39:16 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97AAFF804C3
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 23:39:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97AAFF804C3
IronPort-SDR: 4bQ/YnzetklxFynX/H4EtV286+ZSj5gllJM2oWAe7ooyzvANm3laCKiCTZlANGYAaHGFJOqcAB
 ip/zI65wFjWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166885015"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="166885015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:59 -0800
IronPort-SDR: QAF6mFyANA+ICog0xEhlRH7tJog6COJrxRbyZ0VHf7q+5rinRVauCkmSUstIfZSDjfUjt5j/SM
 MgNXBq4ksxMA==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="323797499"
Received: from gjshield-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.180.118])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:59 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 11/14] ASoC: Intel: broadwell: set card and driver name
 dynamically
Date: Thu, 12 Nov 2020 16:38:22 -0600
Message-Id: <20201112223825.39765-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
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

Remove last hard-coded build-time dependency

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 17 ++++++++++++-----
 sound/soc/intel/boards/bdw-rt5677.c | 17 ++++++++++++-----
 sound/soc/intel/boards/broadwell.c  | 19 ++++++++++++-------
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index aa420b201848..c5122d3b0e6c 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -262,14 +262,12 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 	},
 };
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 /* use space before codec name to simplify card ID, and simplify driver name */
-#define CARD_NAME "bdw rt5650" /* card name will be 'sof-bdw rt5650' */
-#define DRIVER_NAME "SOF"
-#else
+#define SOF_CARD_NAME "bdw rt5650" /* card name will be 'sof-bdw rt5650' */
+#define SOF_DRIVER_NAME "SOF"
+
 #define CARD_NAME "bdw-rt5650"
 #define DRIVER_NAME NULL /* card name will be used for driver name */
-#endif
 
 /* ASoC machine driver for Broadwell DSP + RT5650 */
 static struct snd_soc_card bdw_rt5650_card = {
@@ -309,6 +307,15 @@ static int bdw_rt5650_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* set card and driver name */
+	if (snd_soc_acpi_sof_parent(&pdev->dev)) {
+		bdw_rt5650_card.name = SOF_CARD_NAME;
+		bdw_rt5650_card.driver_name = SOF_DRIVER_NAME;
+	} else {
+		bdw_rt5650_card.name = CARD_NAME;
+		bdw_rt5650_card.driver_name = DRIVER_NAME;
+	}
+
 	snd_soc_card_set_drvdata(&bdw_rt5650_card, bdw_rt5650);
 
 	return devm_snd_soc_register_card(&pdev->dev, &bdw_rt5650_card);
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 9cdd4164e1fb..021bc59aac80 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -387,14 +387,12 @@ static int bdw_rt5677_resume_post(struct snd_soc_card *card)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 /* use space before codec name to simplify card ID, and simplify driver name */
-#define CARD_NAME "bdw rt5677" /* card name will be 'sof-bdw rt5677' */
-#define DRIVER_NAME "SOF"
-#else
+#define SOF_CARD_NAME "bdw rt5677" /* card name will be 'sof-bdw rt5677' */
+#define SOF_DRIVER_NAME "SOF"
+
 #define CARD_NAME "bdw-rt5677"
 #define DRIVER_NAME NULL /* card name will be used for driver name */
-#endif
 
 /* ASoC machine driver for Broadwell DSP + RT5677 */
 static struct snd_soc_card bdw_rt5677_card = {
@@ -437,6 +435,15 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* set card and driver name */
+	if (snd_soc_acpi_sof_parent(&pdev->dev)) {
+		bdw_rt5677_card.name = SOF_CARD_NAME;
+		bdw_rt5677_card.driver_name = SOF_DRIVER_NAME;
+	} else {
+		bdw_rt5677_card.name = CARD_NAME;
+		bdw_rt5677_card.driver_name = DRIVER_NAME;
+	}
+
 	snd_soc_card_set_drvdata(&bdw_rt5677_card, bdw_rt5677);
 
 	return devm_snd_soc_register_card(&pdev->dev, &bdw_rt5677_card);
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 69e0b13b47f4..3c3aff9c61cc 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -262,19 +262,15 @@ static int broadwell_resume(struct snd_soc_card *card){
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 /* use space before codec name to simplify card ID, and simplify driver name */
-#define CARD_NAME "bdw rt286" /* card name will be 'sof-bdw rt286' */
-#define DRIVER_NAME "SOF"
-#else
+#define SOF_CARD_NAME "bdw rt286" /* card name will be 'sof-bdw rt286' */
+#define SOF_DRIVER_NAME "SOF"
+
 #define CARD_NAME "broadwell-rt286"
 #define DRIVER_NAME NULL /* card name will be used for driver name */
-#endif
 
 /* broadwell audio machine driver for WPT + RT286S */
 static struct snd_soc_card broadwell_rt286 = {
-	.name = CARD_NAME,
-	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = broadwell_rt286_dais,
 	.num_links = ARRAY_SIZE(broadwell_rt286_dais),
@@ -303,6 +299,15 @@ static int broadwell_audio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* set card and driver name */
+	if (snd_soc_acpi_sof_parent(&pdev->dev)) {
+		broadwell_rt286.name = SOF_CARD_NAME;
+		broadwell_rt286.driver_name = SOF_DRIVER_NAME;
+	} else {
+		broadwell_rt286.name = CARD_NAME;
+		broadwell_rt286.driver_name = DRIVER_NAME;
+	}
+
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
-- 
2.25.1

