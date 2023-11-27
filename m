Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D9BC0755A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 15:43:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06388EC1;
	Mon, 27 Nov 2023 16:43:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06388EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701099807;
	bh=aVZx5EIhbQBJhRi0d0dJ2an+K0rSK/GJ6HT3ctw6O9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o+mweDOcNSv+abYDrGr3qNKUidPjHxOtmNKiHhIACShfYHRL5qRdJ4Jjz90ckPaEF
	 LMh63usdLbUzATQGC3SCXLTBbG3Tmj+bhBgI/B1WdP5tHyZRLAaaABRe80cFCAVMY7
	 lm6ffXzIAtt76/c25nYfJh/CYcPqQFTBqcehX3VA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DB34F897A6; Mon, 27 Nov 2023 16:36:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0461DF897A2;
	Mon, 27 Nov 2023 16:36:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3604F805FD; Mon, 27 Nov 2023 16:36:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4D5F3F80236
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 16:35:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D5F3F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lvjhpMKA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701099323; x=1732635323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVZx5EIhbQBJhRi0d0dJ2an+K0rSK/GJ6HT3ctw6O9M=;
  b=lvjhpMKAE7g3du5DFdPPlijL+PffD3OB7MxxccoSYmN/V/XUAiALMugI
   ogikifPh6lTH/Q30niPc7nWLorLWRso6R7ywnB1/GDonTzWY9jTaFgJ+7
   iGR+5JYg26MxWdL+WBJucCLvjoxwaZlEZq1yXlIAyB89sNgEw/34sJsr8
   KK/IBPHkEnVfqit6+A+wqRimOrG6OQNmMUDY3tCy3m3wTzBgTk6DEwcNS
   SnOnnv0IfqmykjWfXfPG10jqOoQoVP1wsUGt3nrMLZxc8SLDnrhHKcrnf
   ep8DoyVEBBihBYUff9QyJGfhuTUngFltfaBrpmunLWoq3koONxB4nTeux
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372894394"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="372894394"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="771956269"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="771956269"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:26:27 -0800
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
Subject: [PATCH 03/27] ASoC: Intel: sof_maxim_common: check return value
Date: Mon, 27 Nov 2023 17:26:30 +0200
Message-ID: <20231127152654.28204-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
References: <20231127152654.28204-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2C4J77TPMYT6FZ4LELDY5TRPB4VHNMIY
X-Message-ID-Hash: 2C4J77TPMYT6FZ4LELDY5TRPB4VHNMIY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2C4J77TPMYT6FZ4LELDY5TRPB4VHNMIY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

snd_soc_dai_set_tdm_slot() could return error.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_maxim_common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index f64124077ca7..cf2974718271 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -61,15 +61,21 @@ static int max_98373_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
+	int ret = 0;
 	int j;
 
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
 		if (!strcmp(codec_dai->component->name, MAX_98373_DEV0_NAME)) {
 			/* DEV0 tdm slot configuration */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 8, 32);
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 8, 32);
 		} else if (!strcmp(codec_dai->component->name, MAX_98373_DEV1_NAME)) {
 			/* DEV1 tdm slot configuration */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 8, 32);
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 8, 32);
+		}
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "fail to set tdm slot, ret %d\n",
+				ret);
+			return ret;
 		}
 	}
 	return 0;
-- 
2.43.0

