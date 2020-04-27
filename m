Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB0C4CECD
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:44:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFDC214AF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sZ2N9tvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFDC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 285961690;
	Mon, 27 Apr 2020 19:43:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 285961690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588009451;
	bh=hgGmhJiEoIWBXMblP/9poO0dYhLc+JfAzy7pYggeeGA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sZ2N9tvUlA8pU2/XsitelO7nEc4pGU9z3QjdNkZhYhDiWwuzVWDOo7T2etQ43hIGx
	 gCHANmj4sxTJuT5pOnuATXs6rLQeOQOLm9dbJLFECpusb/ytTBtQwJe6dmZxV6hg81
	 gFaP0wx9dhYRTQOXCfIplQv/fDOiM9yZanSJab74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C495AF802E9;
	Mon, 27 Apr 2020 19:30:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFDC4F802E0; Mon, 27 Apr 2020 19:29:55 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29B19F802C4
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 19:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29B19F802C4
IronPort-SDR: PBgPJ9DRaFJRFr8c3aCHLhzlhKIYvpH8T8BhiOuLg3QHToad+f6f+bN47JTp5CNR/rNgX98Wuv
 tNRBxZqcT4tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 10:29:40 -0700
IronPort-SDR: rB0jl63b/h7iivFU4eIpzKUUSasIcC+elf33B9RFz0RJcVRUHtpIJ/h6G/cpJm1RgjEEjF7Hm7
 zXHaN3zZ6eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="458935998"
Received: from dbombien-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.51.189])
 by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:29:39 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ASoC: SOF: topology: replace sof_link_hda_process by
 sof_set_dai_config
Date: Mon, 27 Apr 2020 10:29:38 -0700
Message-Id: <20200427172939.25848-4-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427172939.25848-1-ranjani.sridharan@linux.intel.com>
References: <20200427172939.25848-1-ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Now we send ipc in sof_set_dai_config(), too. Therefore, we can use
sof_set_dai_config() in sof_link_hda_load() just like other link load
functions do.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/topology.c | 64 ++--------------------------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 0ed3ab35e9f9..6fd75fe9f699 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3008,66 +3008,6 @@ static int sof_link_dmic_load(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
-/*
- * for hda link, playback and capture are supported by different dai
- * in FW. Here get the dai_index, set dma channel of each dai
- * and send config to FW. In FW, each dai sets config by dai_index
- */
-static int sof_link_hda_process(struct snd_sof_dev *sdev,
-				struct snd_soc_dai_link *link,
-				struct sof_ipc_dai_config *config)
-{
-	struct sof_ipc_reply reply;
-	u32 size = sizeof(*config);
-	struct snd_sof_dai *sof_dai;
-	int found = 0;
-	int ret;
-
-	list_for_each_entry(sof_dai, &sdev->dai_list, list) {
-		if (!sof_dai->name)
-			continue;
-
-		if (strcmp(link->name, sof_dai->name) == 0) {
-			config->dai_index = sof_dai->comp_dai.dai_index;
-			found = 1;
-
-			config->hda.link_dma_ch = DMA_CHAN_INVALID;
-
-			/* save config in dai component */
-			sof_dai->dai_config = kmemdup(config, size, GFP_KERNEL);
-			if (!sof_dai->dai_config)
-				return -ENOMEM;
-
-			sof_dai->cpu_dai_name = link->cpus->dai_name;
-
-			/* send message to DSP */
-			ret = sof_ipc_tx_message(sdev->ipc,
-						 config->hdr.cmd, config, size,
-						 &reply, sizeof(reply));
-
-			if (ret < 0) {
-				dev_err(sdev->dev, "error: failed to set DAI config for direction:%d of HDA dai %d\n",
-					sof_dai->comp_dai.direction,
-					config->dai_index);
-
-				return ret;
-			}
-		}
-	}
-
-	/*
-	 * machine driver may define a dai link with playback and capture
-	 * dai enabled, but the dai link in topology would support both, one
-	 * or none of them. Here print a warning message to notify user
-	 */
-	if (!found) {
-		dev_warn(sdev->dev, "warning: failed to find dai for dai link %s",
-			 link->name);
-	}
-
-	return 0;
-}
-
 static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 			     struct snd_soc_dai_link *link,
 			     struct snd_soc_tplg_link_config *cfg,
@@ -3104,7 +3044,9 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 		return -EINVAL;
 	}
 
-	ret = sof_link_hda_process(sdev, link, config);
+	config->hda.link_dma_ch = DMA_CHAN_INVALID;
+
+	ret = sof_set_dai_config(sdev, size, link, config);
 	if (ret < 0)
 		dev_err(scomp->dev, "error: failed to process hda dai link %s",
 			link->name);
-- 
2.17.1

