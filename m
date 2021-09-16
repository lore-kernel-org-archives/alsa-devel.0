Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A6C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 12:50:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B05610D1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53B05610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BEF51897;
	Thu, 16 Sep 2021 14:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BEF51897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631796611;
	bh=Gc/MXl11PhBahRpMucsV+LDBArcHxSHa+6DPsLGe2pM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u+Z5IGQRNQ+IZdGV8lMSy8Pua1XqQ1kvautyLQRBtASerxLI/0sDOjUoZhwV1k+I4
	 UJM3EGU6kz86ltqVqNUC4JQfe58dfkyserDDAoyJFah4oHwLQiApo2gBh9qL5TmUOb
	 OrJ78yp/ER6Mi1GGrYGtAYykL41/1MAWU5jbP9z0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E561F8025A;
	Thu, 16 Sep 2021 14:49:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EA76F8025E; Thu, 16 Sep 2021 14:49:18 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC9E1F800D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 14:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC9E1F800D3
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286239508"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; d="scan'208";a="286239508"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 05:49:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; d="scan'208";a="471353359"
Received: from gkapusti-mobl.ccr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.35.152])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 05:49:03 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: SOF: core: Move probe work related code under a single
 if () branch
Date: Thu, 16 Sep 2021 15:49:02 +0300
Message-Id: <20210916124902.24248-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

Relocate the INIT_WORK() at the same place where we schedule the work to
make the code simpler and easier to follow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 6be4f159ee35..9cbf7d72ae92 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -325,9 +325,6 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 	spin_lock_init(&sdev->hw_lock);
 	mutex_init(&sdev->power_state_access);
 
-	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
-		INIT_WORK(&sdev->probe_work, sof_probe_work);
-
 	/* set default timeouts if none provided */
 	if (plat_data->desc->ipc_timeout == 0)
 		sdev->ipc_timeout = TIMEOUT_DEFAULT_IPC_MS;
@@ -339,6 +336,7 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 		sdev->boot_timeout = plat_data->desc->boot_timeout;
 
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
+		INIT_WORK(&sdev->probe_work, sof_probe_work);
 		schedule_work(&sdev->probe_work);
 		return 0;
 	}
-- 
2.33.0

