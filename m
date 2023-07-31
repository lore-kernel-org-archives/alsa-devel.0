Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE41EC001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:48:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B566DE81;
	Mon, 31 Jul 2023 23:47:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B566DE81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690840088;
	bh=sQGtw6GQ9GXlM3MjpOd1aSFiPgo5LMH/TthGebdxyv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ngCKAEqDMvqsyv274+4uDx1TfmKr9M9OS9QO3+q/bZYQx9OqmEd3qypByxV1dsT3a
	 3wpBi1J3La8sSC5ezAQF2Mi1nN19oaPHiA3ZbLxnnqZnYV98vDtJaNKlrFHsWbtC0y
	 S7X3aAVirxK6kaUXq2e5lMsc7AF8RJQdZQNzdXyI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B173F80610; Mon, 31 Jul 2023 23:44:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 97319F80612;
	Mon, 31 Jul 2023 23:44:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06EEFF805B1; Mon, 31 Jul 2023 23:43:31 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 31717F8057A
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31717F8057A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I2/N7Pj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839802; x=1722375802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQGtw6GQ9GXlM3MjpOd1aSFiPgo5LMH/TthGebdxyv4=;
  b=I2/N7Pj08hFM2UjO6W4o3NJLswvaY04Ds9E/QAMCSOfqTPnx+p6TfdAN
   p9HfG4Ut2WNEowN/X0mlqqpLrZIbaWPo9J8T1361aZCIUvTndGm88giDs
   nvFIym3psJcdi/1PqB4sefmKjAM5brgYnVRP0WhPa9w3BuBvNPLjkJDS8
   XiFzNeI1hN43ad3SdENo2cFpWnjRxJxINlgFZZg3I+a+E3xymHTq707Gw
   TF/iqUxASnG+g23rSuKl6ZYJUOx1vHylQIa51cYsB1JqPoECbCwsQHg4i
   R7awTw/z2rpYlH5F8pkqYWjUKKZ8YD4ywJdvMKGTW8KB/49EFYhJyplKi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449788"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523558"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523558"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:17 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/23] ASoC: intel: sof_sdw: Minor tidy up of mc_probe
Date: Mon, 31 Jul 2023 16:42:49 -0500
Message-Id: <20230731214257.444605-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZQEIW4MEXSPEK7U4DO6KNK7H3KPSFH7O
X-Message-ID-Hash: ZQEIW4MEXSPEK7U4DO6KNK7H3KPSFH7O
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZQEIW4MEXSPEK7U4DO6KNK7H3KPSFH7O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Shuffle things around to group operations a little more, and
consistently use card->dev.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index fc67029b3a64..d4f2711b6f26 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1964,34 +1964,34 @@ static void mc_dailink_exit_loop(struct snd_soc_card *card)
 static int mc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &card_sof_sdw;
-	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
 	struct mc_private *ctx;
 	int amp_num = 0, i;
 	int ret;
 
-	dev_dbg(&pdev->dev, "Entry\n");
+	card->dev = &pdev->dev;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	dev_dbg(card->dev, "Entry\n");
+
+	ctx = devm_kzalloc(card->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
+	snd_soc_card_set_drvdata(card, ctx);
+
 	dmi_check_system(sof_sdw_quirk_table);
 
 	if (quirk_override != -1) {
-		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+		dev_info(card->dev, "Overriding quirk 0x%lx => 0x%x\n",
 			 sof_sdw_quirk, quirk_override);
 		sof_sdw_quirk = quirk_override;
 	}
-	log_quirks(&pdev->dev);
 
-	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+	log_quirks(card->dev);
 
-	card->dev = &pdev->dev;
-	snd_soc_card_set_drvdata(card, ctx);
-
-	mach = pdev->dev.platform_data;
-	ret = sof_card_dai_links_create(&pdev->dev, mach,
-					card);
+	ret = sof_card_dai_links_create(card->dev, mach, card);
 	if (ret < 0)
 		return ret;
 
@@ -2022,7 +2022,7 @@ static int mc_probe(struct platform_device *pdev)
 	card->long_name = sdw_card_long_name;
 
 	/* Register the card */
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	ret = devm_snd_soc_register_card(card->dev, card);
 	if (ret) {
 		dev_err(card->dev, "snd_soc_register_card failed %d\n", ret);
 		mc_dailink_exit_loop(card);
-- 
2.39.2

