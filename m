Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06363C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 15:39:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25F3AE72;
	Mon, 27 Nov 2023 16:39:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25F3AE72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701099568;
	bh=RVDtpOggfIS7WzvfIL6DjjHWp2zJcFKyBU5rJtasFfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AiSUodMLfAnG+vNMvojWUFs2S9cAxegBD3hb6nvgMgaOJZxe/sk3EFLFnEWuG007F
	 anLf4I3HWjiBLZkIYCeMg+Vc62AsLR0DJUFEzaaa8N5lu35F+hHe01VYSEXWidQr6J
	 ga1WeV4iUX40k8X++7kC9NxxeC2jm7ykNwsHf2cw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58792F805B3; Mon, 27 Nov 2023 16:36:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F52BF80862;
	Mon, 27 Nov 2023 16:36:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4CBEF806B4; Mon, 27 Nov 2023 16:35:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DCD7EF805E8
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 16:35:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCD7EF805E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A+9M8QXr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701099333; x=1732635333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVDtpOggfIS7WzvfIL6DjjHWp2zJcFKyBU5rJtasFfI=;
  b=A+9M8QXrIl58wwf2i7biEVrz/MzTvf1xe9Ij+fmZJoTvOoalzBYyCZr0
   zogxn3E78iFouhlb9neYNmvWG2IZZsjDwxrVDwbXY/K24ZiBQvx5Lxbkx
   ziDLl5Kchm4iam7yjA61wzvomRC0pQq4dAQuNo69KaUw/v98oMfLgAs/N
   WOduITUHIsmgCAidl7AbqgaT6/AgE6bQUhBIL0a4AZ5U05H3rYljoNhf0
   aVI6d4ylXMKzkeHjYykAosqJQszqYygF1M2xp5JZFl44Lcos2WdP45fz2
   e4thDwtfarn5rFElr1YCrZfiL80COpQEqlquWLqbUw7NRZlSAg/10vSTn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372894519"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="372894519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="771956775"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="771956775"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:26:58 -0800
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
Subject: [PATCH 14/27] ASoC: Intel: sof_ssp_amp: use common module for amp
 link
Date: Mon, 27 Nov 2023 17:26:41 +0200
Message-ID: <20231127152654.28204-15-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
References: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VGLAETGQPXINQRQFVSRWPE3SO5P43V25
X-Message-ID-Hash: VGLAETGQPXINQRQFVSRWPE3SO5P43V25
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VGLAETGQPXINQRQFVSRWPE3SO5P43V25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Use intel_board module for speaker amplifier DAI link initialization.

Signed-off-by: Brent Lu <brent.lu@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_ssp_amp.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
index 22f37cf3a2ad..8e478d1cc875 100644
--- a/sound/soc/intel/boards/sof_ssp_amp.c
+++ b/sound/soc/intel/boards/sof_ssp_amp.c
@@ -154,12 +154,13 @@ sof_card_dai_links_create(struct device *dev, enum sof_ssp_codec amp_type,
 
 	/* codec SSP */
 	if (amp_type != CODEC_NONE) {
-		links[id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-Codec", ssp_codec);
-		if (!links[id].name)
+		be_id = fixed_be ? SPK_BE_ID : id;
+		ret = sof_intel_board_set_ssp_amp_link(dev, &links[id], be_id,
+						       amp_type, ssp_codec);
+		if (ret)
 			return NULL;
 
-		links[id].id = fixed_be ? SPK_BE_ID : id;
-
+		/* codec-specific fields */
 		switch (amp_type) {
 		case CODEC_CS35L41:
 			cs35l41_set_dai_link(&links[id]);
@@ -172,18 +173,6 @@ sof_card_dai_links_create(struct device *dev, enum sof_ssp_codec amp_type,
 			return NULL;
 		}
 
-		links[id].platforms = platform_component;
-		links[id].num_platforms = ARRAY_SIZE(platform_component);
-		links[id].dpcm_playback = 1;
-		/* feedback from amplifier or firmware-generated echo reference */
-		links[id].dpcm_capture = 1;
-		links[id].no_pcm = 1;
-		links[id].cpus = &cpus[id];
-		links[id].num_cpus = 1;
-		links[id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d Pin", ssp_codec);
-		if (!links[id].cpus->dai_name)
-			return NULL;
-
 		id++;
 	}
 
@@ -256,7 +245,7 @@ static int sof_ssp_amp_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
 	struct snd_soc_dai_link *dai_links;
 	struct sof_card_private *ctx;
-	int ret, ssp_codec;
+	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -272,7 +261,7 @@ static int sof_ssp_amp_probe(struct platform_device *pdev)
 	else
 		ctx->dmic_be_num = 0;
 
-	ssp_codec = sof_ssp_amp_quirk & SOF_AMPLIFIER_SSP_MASK;
+	ctx->ssp_amp = sof_ssp_amp_quirk & SOF_AMPLIFIER_SSP_MASK;
 
 	/* set number of dai links */
 	sof_ssp_amp_card.num_links = ctx->dmic_be_num;
@@ -303,7 +292,7 @@ static int sof_ssp_amp_probe(struct platform_device *pdev)
 		sof_ssp_amp_card.num_links++;
 
 	dai_links = sof_card_dai_links_create(&pdev->dev, ctx->amp_type,
-					      ssp_codec, ctx->dmic_be_num,
+					      ctx->ssp_amp, ctx->dmic_be_num,
 					      ctx->hdmi_num,
 					      ctx->hdmi.idisp_codec);
 	if (!dai_links)
-- 
2.43.0

