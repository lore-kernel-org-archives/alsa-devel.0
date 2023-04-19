Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D418C77B73
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Apr 2023 19:57:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA1E5F06;
	Wed, 19 Apr 2023 21:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA1E5F06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681934274;
	bh=1TIjV+3pmSFyRtElpQplh8V/ePhxtOCFPODPHSIZDhQ=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZfiAtZERC6dTI7AhPh7pFxZHetqjwkhA17cpVxU+dZzQwhi/YG6RGpkpAb16MryO6
	 Skz2LKoC1TrlH1ZB0O/ckg1TiMyRNlVWZNcBbKNCE/CZGfYiZjJa1ZqbA+fK9MSALR
	 R4vEpmTH+5Vn/dzr1Tz4N9VJ0FxVABs4ipmcOMVE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ADA6F8053B;
	Wed, 19 Apr 2023 21:56:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DAE9F8052E; Wed, 19 Apr 2023 21:56:08 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF856F80149
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2023 21:56:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF856F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VpDxNH0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681934166; x=1713470166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1TIjV+3pmSFyRtElpQplh8V/ePhxtOCFPODPHSIZDhQ=;
  b=VpDxNH0hnpJcrub+tQRVUxupiiMBZEiT5RFRPihlCABfBR64qCAJ2jZp
   xP6+r3scE3ZZaghulugfeDVJbrqNlE4BFwN2fpXazpEhIODyc7trXcmS8
   /nWr8uCUvaN3v2zTPVRHxHSreTfk7ELYQHo4X+VcvhY//tVTSc3y355WQ
   QlQ1PT3+TVQPY2bAaJQSZaI2zlKyB1Y9QkMqKTvroCC0zEPg2PkFUHBX7
   TipcNkcyIqU5QpCEDJEKJGPBJ7Ef8iz+NrLf9ud9UEHyyhua64/5M7jfS
   aFsUzFfrRl9MDSeb77nxMx6wWDPL7k6aQF1atN3bIyXDDJbKXaYeOuhB3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373434389"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200";
   d="scan'208";a="373434389"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2023 12:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="815728102"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200";
   d="scan'208";a="815728102"
Received: from gargicha-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.74.38])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2023 12:56:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/7] ASoC: Intel: sof_sdw: remove late_probe flag in struct
 sof_sdw_codec_info
Date: Wed, 19 Apr 2023 14:55:20 -0500
Message-Id: <20230419195524.46995-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230419195524.46995-1-pierre-louis.bossart@linux.intel.com>
References: <20230419195524.46995-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 35LKAAPLXR24PXGRIBW3DJNQS32J4U47
X-Message-ID-Hash: 35LKAAPLXR24PXGRIBW3DJNQS32J4U47
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.de, broonie@kernel.org, Yong Zhi <yong.zhi@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/35LKAAPLXR24PXGRIBW3DJNQS32J4U47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Yong Zhi <yong.zhi@intel.com>

Just use codec_card_late_probe ptr in struct sof_sdw_codec_info
for validation check and drop late_probe variable.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c          | 11 +++++------
 sound/soc/intel/boards/sof_sdw_common.h   |  1 -
 sound/soc/intel/boards/sof_sdw_max98373.c |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 6897705a193c..7d398b45d48f 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -621,7 +621,6 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.direction = {true, true},
 		.dai_name = "max98373-aif1",
 		.init = sof_sdw_mx8373_init,
-		.codec_card_late_probe = sof_sdw_mx8373_late_probe,
 		.codec_type = SOF_SDW_CODEC_TYPE_AMP,
 	},
 	{
@@ -1490,12 +1489,12 @@ static int sof_sdw_card_late_probe(struct snd_soc_card *card)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(codec_info_list); i++) {
-		if (!codec_info_list[i].late_probe)
-			continue;
+		if (codec_info_list[i].codec_card_late_probe) {
+			ret = codec_info_list[i].codec_card_late_probe(card);
 
-		ret = codec_info_list[i].codec_card_late_probe(card);
-		if (ret < 0)
-			return ret;
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ctx->idisp_codec)
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 350010b0e5f4..4962dc11a088 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -74,7 +74,6 @@ struct sof_sdw_codec_info {
 		     bool playback);
 
 	int (*exit)(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
-	bool late_probe;
 	int (*codec_card_late_probe)(struct snd_soc_card *card);
 };
 
diff --git a/sound/soc/intel/boards/sof_sdw_max98373.c b/sound/soc/intel/boards/sof_sdw_max98373.c
index 77a3f32db11e..22bd1e356e22 100644
--- a/sound/soc/intel/boards/sof_sdw_max98373.c
+++ b/sound/soc/intel/boards/sof_sdw_max98373.c
@@ -130,7 +130,7 @@ int sof_sdw_mx8373_init(struct snd_soc_card *card,
 	if (info->amp_num == 2)
 		dai_links->init = spk_init;
 
-	info->late_probe = true;
+	info->codec_card_late_probe = sof_sdw_mx8373_late_probe;
 
 	dai_links->ops = &max_98373_sdw_ops;
 
-- 
2.37.2

