Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA4FC43461
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:36:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1C02078E
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yu1gD/9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1C02078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96D801EDF;
	Fri,  4 Sep 2020 15:35:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96D801EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599226593;
	bh=Pp4FnG4IqZSZ3dd69Migc5nXVwnhMb0WYGe2anoX2GU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yu1gD/9XW4Gp4IrQybaCqdip4GSfo1d9bmxxB0SefH0nfwthpQspVpSD6jNrix4Wb
	 QDFzTMBW7YuekGXIJ3XiX8OB+2su40jzsWx1JSFNpVismRpxZsQifnRdAsBQMscXs7
	 JqnkCN4jaiYGqxRq5N2UMkCWQO1J5ggNNrODyx7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E103F80336;
	Fri,  4 Sep 2020 15:30:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A079F80336; Fri,  4 Sep 2020 15:30:10 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAF09F802EA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 15:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAF09F802EA
IronPort-SDR: YYS54sb9ESOQttblKCW7ka/jEKCdzJCXCpWOYcs6cfnkzyigXQdSGNUbNE2N3Id2JN03LHKxb/
 B+q4hXf1iOtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="157002862"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="157002862"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 06:29:51 -0700
IronPort-SDR: 8osXJKjOFUEHX8zMjBk91hW89u9rfIs1hweBnS8riMq61Cb3aat32FO6VUb84Bbp7unlesGKqD
 U0nUej/Rzhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="284416740"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 06:29:50 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 10/16] ASoC: SOF: append extended data to sof_ipc_comp_host
Date: Fri,  4 Sep 2020 16:27:38 +0300
Message-Id: <20200904132744.1699575-11-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200904132744.1699575-1-kai.vehmanen@linux.intel.com>
References: <20200904132744.1699575-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, Keyon Jie <yang.jie@linux.intel.com>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Keyon Jie <yang.jie@linux.intel.com>

Append the extended data to the end of the struct sof_ipc_comp_host,
construct the ipc for COMP_NEW during the topology load stage.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index c908dbbe284a..5cf4497a4338 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1644,19 +1644,16 @@ static int sof_widget_load_pcm(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_private *private = &tw->priv;
 	struct sof_ipc_comp_host *host;
+	size_t ipc_size = sizeof(*host);
 	int ret;
 
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	host = (struct sof_ipc_comp_host *)
+	       sof_comp_alloc(swidget, &ipc_size, index, core);
 	if (!host)
 		return -ENOMEM;
 
 	/* configure host comp IPC message */
-	host->comp.hdr.size = sizeof(*host);
-	host->comp.hdr.cmd = SOF_IPC_GLB_TPLG_MSG | SOF_IPC_TPLG_COMP_NEW;
-	host->comp.id = swidget->comp_id;
 	host->comp.type = SOF_COMP_HOST;
-	host->comp.pipeline_id = index;
-	host->comp.core = core;
 	host->direction = dir;
 	host->config.hdr.size = sizeof(host->config);
 
@@ -1684,7 +1681,7 @@ static int sof_widget_load_pcm(struct snd_soc_component *scomp, int index,
 	swidget->private = host;
 
 	ret = sof_ipc_tx_message(sdev->ipc, host->comp.hdr.cmd, host,
-				 sizeof(*host), r, sizeof(*r));
+				 ipc_size, r, sizeof(*r));
 	if (ret >= 0)
 		return ret;
 err:
-- 
2.27.0

