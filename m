Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA55C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:41:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7C364F2B
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7C364F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C67D017AB;
	Mon, 15 Mar 2021 17:40:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C67D017AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615826504;
	bh=/T8T8xL0CvzNFtYdfbir+KBipGmA/M8LYEraKZY7C5E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwKoDV7wtHpuPvmKb0EmUfS5kJmDpSXY1ZaxplnxtR7kCS/awv5R43L7Yde+skzgq
	 fquGUQzXiZBySuMc5CM0K7Q1Wy2yu3dPz28jVqNBvH33gxiMfsHZSgEadXKWCvtiZl
	 vXHFayWqZ+18C7Rr6+ae5EPs/TcI2YiqFMxyYkXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC7A4F80254;
	Mon, 15 Mar 2021 17:40:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46DD3F80272; Mon, 15 Mar 2021 17:40:05 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3EC4F8010E
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 17:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3EC4F8010E
IronPort-SDR: yfDzh2MQEOt79JotnXyeRyXWdhlZNNHozpYZnQ6erLfUm3E556JuspuuxFG+SsUc09P0NdlP0M
 m4GoUqQiCiDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274160568"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="274160568"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 09:39:45 -0700
IronPort-SDR: cz8pBa77F9UTSoYb1C1Rl0JvbBQwNKqK4xtqVSCGe7hy22uDcW/hdhuRrueEQhkCB8ACdTIJBS
 scXV3qZqawEw==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="604912872"
Received: from pwells-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.5.38])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 09:39:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: SOF: fix debugfs initialisation error handling
Date: Mon, 15 Mar 2021 11:39:30 -0500
Message-Id: <20210315163932.18663-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315163932.18663-1-pierre-louis.bossart@linux.intel.com>
References: <20210315163932.18663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Xiuli Pan <xiulipan@outlook.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

If debugfs initialisation fails partially in sof_probe_continue() some
debugfs files and the root directory might have been created
successfully. They have to be cleaned up if some of them failed too.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Xiuli Pan <xiulipan@outlook.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 6d8f7d9fd192..495295a34c3a 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -154,7 +154,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(sdev->dev, "error: failed to get machine info %d\n",
 			ret);
-		goto dbg_err;
+		goto dsp_err;
 	}
 
 	/* set up platform component driver */
@@ -257,8 +257,9 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 fw_load_err:
 	snd_sof_ipc_free(sdev);
 ipc_err:
-	snd_sof_free_debug(sdev);
 dbg_err:
+	snd_sof_free_debug(sdev);
+dsp_err:
 	snd_sof_remove(sdev);
 
 	/* all resources freed, update state to match */
-- 
2.25.1

