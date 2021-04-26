Return-Path: <SRS0=uf39=JX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2788BC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:50:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC85611C1
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC85611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CDDF170F;
	Mon, 26 Apr 2021 23:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CDDF170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619473800;
	bh=SugEg0UHumQ2WhgN2v6Xigujv0lQs0ITAQ2ZwIGW61s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2W0gwCauqKjl0kSalaGhJ46FAJfgLtj5FJeH6G8HZPIniyvDQYVoxcJp1k7lxtvD
	 Rka26oeaFhPiBFyIk7JA/PA7MlvEURKpAZZ8Z2dmvlYf7LarznpXU6KaYEOWrJhQ03
	 ofDgdAVvjTXY99xQ08OyNAZO4aXZcCNZj9hRuCPQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20B84F80475;
	Mon, 26 Apr 2021 23:47:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ABCCF8032D; Mon, 26 Apr 2021 23:47:37 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7A4BF80171
 for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2021 23:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7A4BF80171
IronPort-SDR: mGBZBi+Y0IzzDEosXi+i2+E/FW4BzhDqtKrite6FFgc8gGaaQWUZ1kaFeA5qcqE8xtSfH5iOgG
 ZWJi//sjNOyg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260363962"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="260363962"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:21 -0700
IronPort-SDR: rC5dBULe7sBhXlgAzjzQ5nYVhVTnwvJrzm1rZBX9OmUFOlWplyM0bt3DBOcL4M9Wg4zCG8R3rx
 81rnzHPXqfsA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="422810285"
Received: from bcochran-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.24.80])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ASoC: fsl: imx-pcm-rpmsg: remove useless initialization
Date: Mon, 26 Apr 2021 16:47:01 -0500
Message-Id: <20210426214701.235106-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
References: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck warning:

sound/soc/fsl/imx-pcm-rpmsg.c:547:18: style: Variable 'written_num' is
assigned a value that is never used. [unreadVariable]
 int written_num = 0;
                 ^
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 875c0d6df339..6d883a10efd1 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -544,7 +544,7 @@ static int imx_rpmsg_pcm_ack(struct snd_soc_component *component,
 	struct rpmsg_msg *msg;
 	unsigned long flags;
 	int buffer_tail = 0;
-	int written_num = 0;
+	int written_num;
 
 	if (!rpmsg->force_lpa)
 		return 0;
-- 
2.25.1

