Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2043CC2BB84
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:38:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E8D20797
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mnRC5CoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E8D20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EE5F1EDE;
	Fri,  4 Sep 2020 15:37:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EE5F1EDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599226692;
	bh=TA1R0r1BFIWF34F/7Gn8pM3C9xTDMoz8Atozxjt9iMI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mnRC5CoQTae0VAycmx9v7DSkmwEN7+p9fFjXx9DdezG53w9VyTA4Diwycu6ZAfJ/2
	 exwuAAE3uVCR6u4ELehepJVdtamjQAxiKBEZxtUDcGsBFr1101gMtuY5iNlHVN+bkU
	 6EggGe0M2p0m1cNq/oqS5wcGgE50aWxn/TEqBimw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65C1CF80343;
	Fri,  4 Sep 2020 15:30:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EA17F80336; Fri,  4 Sep 2020 15:30:12 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10866F802FF
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 15:29:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10866F802FF
IronPort-SDR: /BDGD1G/AtO/RMXBhR4pjl3xWfZDTDTAu/NWfqMbB4+lHqkZNif1lZy02YOI3XIxshlHruZiQH
 H87lNAJy+Cdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="157002877"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="157002877"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 06:29:57 -0700
IronPort-SDR: wFnYG8sXq0GcX27Cq1I7E7bTalYl2CT1KtCU8kMrfA6GMvScw+8pfZpNn973pWgjghElrcae1T
 B7wGNWhi834g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="284416771"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 06:29:55 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 13/16] ASoC: SOF: append extended data to sof_ipc_comp_tone
Date: Fri,  4 Sep 2020 16:27:41 +0300
Message-Id: <20200904132744.1699575-14-kai.vehmanen@linux.intel.com>
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

Append the extended data to the end of the struct sof_ipc_comp_tone,
construct the ipc for COMP_NEW during the topology load stage.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 476f78839fa8..c61f46350def 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2066,19 +2066,16 @@ static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_private *private = &tw->priv;
 	struct sof_ipc_comp_tone *tone;
+	size_t ipc_size = sizeof(*tone);
 	int ret;
 
-	tone = kzalloc(sizeof(*tone), GFP_KERNEL);
+	tone = (struct sof_ipc_comp_tone *)
+	       sof_comp_alloc(swidget, &ipc_size, index, core);
 	if (!tone)
 		return -ENOMEM;
 
 	/* configure siggen IPC message */
-	tone->comp.hdr.size = sizeof(*tone);
-	tone->comp.hdr.cmd = SOF_IPC_GLB_TPLG_MSG | SOF_IPC_TPLG_COMP_NEW;
-	tone->comp.id = swidget->comp_id;
 	tone->comp.type = SOF_COMP_TONE;
-	tone->comp.pipeline_id = index;
-	tone->comp.core = core;
 	tone->config.hdr.size = sizeof(tone->config);
 
 	ret = sof_parse_tokens(scomp, tone, tone_tokens,
@@ -2106,7 +2103,7 @@ static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
 	swidget->private = tone;
 
 	ret = sof_ipc_tx_message(sdev->ipc, tone->comp.hdr.cmd, tone,
-				 sizeof(*tone), r, sizeof(*r));
+				 ipc_size, r, sizeof(*r));
 	if (ret >= 0)
 		return ret;
 err:
-- 
2.27.0

