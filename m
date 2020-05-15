Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29838C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:11:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AF42065C
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kb7Z4Xj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AF42065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E44141661;
	Fri, 15 May 2020 23:10:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E44141661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589577101;
	bh=fyXKFOoS/U68fYRANU7SAhXZ5Pme2G0VxF5ObdIrU0s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kb7Z4Xj5bCOr6hUUdYrqWAQWl38xmQvRzYk5wL/iShVUmWlnYAIxHBik8mK2epy9Z
	 /SaWNh4Rwfvhv59fU1sXVWFU8V8lJj8piSqeLO32r1x4utnPLLLB13EqJ/DERQBnJH
	 L8kPt+GvSkqbzV+djUwFNMEkujAlQcpIIYjLvveY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ADBBF80101;
	Fri, 15 May 2020 23:10:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5325F80274; Fri, 15 May 2020 23:08:30 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C40B0F80247
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 23:08:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C40B0F80247
IronPort-SDR: +pJaloNdNI61puLVP13kezmnBatNPyBrZ5Py4bK8+GvUM4JvNkVbw+UU51SMRejq90kD7o7LpM
 UU0Jh62Z6Fhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 14:07:56 -0700
IronPort-SDR: Nw1xgSxvhNUnnqdOEYDKnQYsPBcebBiRp4Pj5k4xdt7Wp4PrbqrLGZjJXjrx72ZJkjvpLqjIHF
 sxDQr83OP/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="410589921"
Received: from btchambe-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.66.225])
 by orsmga004.jf.intel.com with ESMTP; 15 May 2020 14:07:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/5] ASoC: Intel: sof_sdw: fix typo in components string
Date: Fri, 15 May 2020 16:07:28 -0500
Message-Id: <20200515210731.10942-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515210731.10942-1-pierre-louis.bossart@linux.intel.com>
References: <20200515210731.10942-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

The component string attributes are separated by spaces, not commas.

Fixes: b1ca2f63e20b4 ("ASoC: Intel: sof_sdw: add amp number in components string for ucm")
Reported-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index bbbc802624f8..47820316df57 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -945,7 +945,7 @@ static int mc_probe(struct platform_device *pdev)
 		amp_num += codec_info_list[i].amp_num;
 
 	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
-					  "cfg-spk:%d, cfg-amp:%d",
+					  "cfg-spk:%d cfg-amp:%d",
 					  (sof_sdw_quirk & SOF_SDW_FOUR_SPK)
 					  ? 4 : 2, amp_num);
 	if (!card->components)
-- 
2.20.1

