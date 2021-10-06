Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2CDC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 10:41:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF62861027
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 10:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF62861027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E2E8836;
	Wed,  6 Oct 2021 12:40:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E2E8836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633516901;
	bh=rpbafMWHntEEkxTAM9Yf3pIwIPonhZzg4N6CKBhnvi4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dBZL6IUNDFnGCU3L0W0SFCjM0fMVgY4xlgoug3e5V7J+0xspptCsULQcS2THQGyAF
	 uri6Jb1eooGfvegkrWOzdaPeaoMaIyq7Lq8MJtK+L+3cqe93GBLZmwrOn2+k602diQ
	 cV5gETUI4VkVBbi4onTeAw2knTQQIM+vmbl67Caw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA2A6F8020D;
	Wed,  6 Oct 2021 12:40:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90AECF80240; Wed,  6 Oct 2021 12:40:49 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0405F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 12:40:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0405F8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="312171289"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="312171289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 03:40:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="488442749"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 03:40:33 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: SOF: topology: do not power down primary core during
 topology removal
Date: Wed,  6 Oct 2021 13:40:41 +0300
Message-Id: <20211006104041.27183-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

When removing the topology components, do not power down
the primary core. Doing so will result in an IPC timeout
when the SOF PCI device runtime suspends.

Fixes: 0dcdf84289fb ("ASoC: SOF: add a "core" parameter to widget loading functions")

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 534f004f6162..1723dd11acd7 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2514,6 +2514,15 @@ static int sof_widget_unload(struct snd_soc_component *scomp,
 
 		/* power down the pipeline schedule core */
 		pipeline = swidget->private;
+
+		/*
+		 * Runtime PM should still function normally if topology loading fails and
+		 * it's components are unloaded. Do not power down the primary core so that the
+		 * CTX_SAVE IPC can succeed during runtime suspend.
+		 */
+		if (pipeline->core == SOF_DSP_PRIMARY_CORE)
+			break;
+
 		ret = snd_sof_dsp_core_power_down(sdev, 1 << pipeline->core);
 		if (ret < 0)
 			dev_err(scomp->dev, "error: powering down pipeline schedule core %d\n",
-- 
2.33.0

