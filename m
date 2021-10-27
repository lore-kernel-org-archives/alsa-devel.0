Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C9C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:22:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034926023F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 034926023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71CE016CA;
	Wed, 27 Oct 2021 04:21:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71CE016CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635301355;
	bh=0t6rQ0pp7xtD/0ZvRHnvLfYRqY+7ruLjAPJGMg3AFlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rf1WWeAmM43MWdv9gjqSmO87ZR6mPg/niWeMHsUkpwDJ+WiYH8GgGRb3TR623Lgd9
	 ++6jR5GzSD84waYYZgBHclX7VqVvyTHNngFOcv8SNjINp6gmCIPJa91ZVjUmwQUrp8
	 wkzw/RCSWswqRLoVo+50UT4py5yK2CtroqZTFtHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40BB1F80510;
	Wed, 27 Oct 2021 04:19:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1EF8F80516; Wed, 27 Oct 2021 04:19:07 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66D4BF804D0
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 04:18:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66D4BF804D0
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="217229416"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="217229416"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="486446315"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:51 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 08/10] ASoC: intel: sof_sdw: remove
 sof_sdw_mic_codec_mockup_init
Date: Wed, 27 Oct 2021 10:18:22 +0800
Message-Id: <20211027021824.24776-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
References: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

Now, we set DAI link id as SDW_DMIC_DAI_ID for all DMICs.
No need to set it in sof_sdw_mic_codec_mockup_init.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index c59e0a553ffb..2adadcf554ff 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -360,20 +360,6 @@ static const struct snd_soc_ops sdw_ops = {
 	.shutdown = sdw_shutdown,
 };
 
-static int sof_sdw_mic_codec_mockup_init(struct snd_soc_card *card,
-					 const struct snd_soc_acpi_link_adr *link,
-					 struct snd_soc_dai_link *dai_links,
-					 struct sof_sdw_codec_info *info,
-					 bool playback)
-{
-	/*
-	 * force DAI link to use same ID as RT715 and DMIC
-	 * to reuse topologies
-	 */
-	dai_links->id = SDW_DMIC_DAI_ID;
-	return 0;
-}
-
 static struct sof_sdw_codec_info codec_info_list[] = {
 	{
 		.part_id = 0x700,
@@ -496,7 +482,6 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.version_id = 0,
 		.direction = {false, true},
 		.dai_name = "sdw-mockup-aif1",
-		.init = sof_sdw_mic_codec_mockup_init,
 		.codec_type = SOF_SDW_CODEC_TYPE_MIC,
 	},
 };
-- 
2.17.1

