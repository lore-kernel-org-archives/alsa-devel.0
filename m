Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED7C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 15:40:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB0FDDF1;
	Mon, 27 Nov 2023 16:40:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB0FDDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701099610;
	bh=IiyIs7ufyJ5e1diaY+K62Q+KzSHkBJml6pbO+iEgS1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VCsuX5vPtYZ5o1k01CaPwOV03YcYhx57Tda0yZm7ymg3e4nmzABevNV7OOY/O2k2m
	 oTELgBZp/Ufc64mrOEfL3LyEUVP5U8NcI1btMh+dOmn68rE8CobABacbwczyg0K2B7
	 7TnRqn/dBZQ0Jk6L8Xl/Rs3vrfostnZ9BGoD+Wl8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DE29F80C70; Mon, 27 Nov 2023 16:36:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5707F80C7F;
	Mon, 27 Nov 2023 16:36:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D306F80743; Mon, 27 Nov 2023 16:35:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7AF2F805FE
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 16:35:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7AF2F805FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U9ZoIBBJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701099340; x=1732635340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IiyIs7ufyJ5e1diaY+K62Q+KzSHkBJml6pbO+iEgS1g=;
  b=U9ZoIBBJWh2f+7iKah18EDEbXzhcKNaHZdAoNzwq4PiqOWME/h0trbaV
   8SnfdNU/LwQfFkaqvQ2pyGAdVoyuL/a6nohILayRmpq/f8SPXHtHQF6tE
   4h1Gk6yDqe5XvUYI/si2pG3ACD0H6OMPri+8QtwkiXrcY2LUSJciccVyW
   SUSg32Aqi2mcHf8isSm1W2vptxnaqzhStW5cS1qI0XQI4wPjQZz4aNr9x
   WWOSTszjAZSaInCSahYxM6iRwBDef0FgG9tFXBJQTwZVbBONOtNX6nGKP
   bRTpYtjx23kyMv4N4oY40nRrsoi9yWtWY2LyXtiOL/d2FQDfHWwP0/WpJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372894590"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="372894590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="771956903"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="771956903"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:27:09 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	chao.song@linux.intel.com
Subject: [PATCH 18/27] ASoC: Intel: sof_nau8825: use common module for BT
 offload link
Date: Mon, 27 Nov 2023 17:26:45 +0200
Message-ID: <20231127152654.28204-19-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
References: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 32CWJI35MRYLRLP7BWN74PZY5REPASE7
X-Message-ID-Hash: 32CWJI35MRYLRLP7BWN74PZY5REPASE7
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/32CWJI35MRYLRLP7BWN74PZY5REPASE7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Use intel_board module for BT offload DAI link initialization.

Signed-off-by: Brent Lu <brent.lu@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_nau8825.c | 42 +++++++++-------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index cc2a11b3de97..32a43d1b5846 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -138,13 +138,6 @@ static struct snd_soc_ops sof_nau8825_ops = {
 	.hw_params = sof_nau8825_hw_params,
 };
 
-static struct snd_soc_dai_link_component platform_component[] = {
-	{
-		/* name might be overridden during probe */
-		.name = "0000:00:1f.3"
-	}
-};
-
 static int sof_card_late_probe(struct snd_soc_card *card)
 {
 	struct sof_card_private *ctx = snd_soc_card_get_drvdata(card);
@@ -212,7 +205,6 @@ sof_card_dai_links_create(struct device *dev, enum sof_ssp_codec amp_type,
 			  int ssp_codec, int ssp_amp, int dmic_be_num,
 			  int hdmi_num, bool idisp_codec)
 {
-	struct snd_soc_dai_link_component *cpus;
 	struct snd_soc_dai_link *links;
 	int i;
 	int id = 0;
@@ -220,9 +212,7 @@ sof_card_dai_links_create(struct device *dev, enum sof_ssp_codec amp_type,
 
 	links = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
 			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
-	cpus = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
-			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
-	if (!links || !cpus)
+	if (!links)
 		goto devm_err;
 
 	/* codec SSP */
@@ -311,23 +301,11 @@ sof_card_dai_links_create(struct device *dev, enum sof_ssp_codec amp_type,
 		int port = (sof_nau8825_quirk & SOF_BT_OFFLOAD_SSP_MASK) >>
 				SOF_BT_OFFLOAD_SSP_SHIFT;
 
-		links[id].id = id;
-		links[id].cpus = &cpus[id];
-		links[id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
-							  "SSP%d Pin", port);
-		if (!links[id].cpus->dai_name)
-			goto devm_err;
-		links[id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT", port);
-		if (!links[id].name)
-			goto devm_err;
-		links[id].codecs = &snd_soc_dummy_dlc;
-		links[id].num_codecs = 1;
-		links[id].platforms = platform_component;
-		links[id].num_platforms = ARRAY_SIZE(platform_component);
-		links[id].dpcm_playback = 1;
-		links[id].dpcm_capture = 1;
-		links[id].no_pcm = 1;
-		links[id].num_cpus = 1;
+		ret = sof_intel_board_set_bt_link(dev, &links[id], id, port);
+		if (ret)
+			return NULL;
+
+		id++;
 	}
 
 	return links;
@@ -365,6 +343,10 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if (mach->mach_params.codec_mask & IDISP_CODEC_MASK)
 		ctx->hdmi.idisp_codec = true;
 
+	/* port number of peripherals attached to ssp interface */
+	ctx->ssp_bt = (sof_nau8825_quirk & SOF_BT_OFFLOAD_SSP_MASK) >>
+			SOF_BT_OFFLOAD_SSP_SHIFT;
+
 	ctx->ssp_amp = (sof_nau8825_quirk & SOF_NAU8825_SSP_AMP_MASK) >>
 			SOF_NAU8825_SSP_AMP_SHIFT;
 
@@ -376,8 +358,10 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if (ctx->amp_type != CODEC_NONE)
 		sof_audio_card_nau8825.num_links++;
 
-	if (sof_nau8825_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
+	if (sof_nau8825_quirk & SOF_SSP_BT_OFFLOAD_PRESENT) {
+		ctx->bt_offload_present = true;
 		sof_audio_card_nau8825.num_links++;
+	}
 
 	dai_links = sof_card_dai_links_create(&pdev->dev, ctx->amp_type,
 					      ctx->ssp_codec, ctx->ssp_amp,
-- 
2.43.0

