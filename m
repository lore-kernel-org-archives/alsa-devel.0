Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BFC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:24:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7985A61350
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7985A61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A4541856;
	Wed, 15 Sep 2021 14:23:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A4541856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631708662;
	bh=Aq+lrPawmkOgPNoZuQ4vI8/55FWuno1CVhBGCbFjleQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFnmDpu+SCPRH0Pkqn5awpTH9nt8F8MT+npanvNco/7eTMGhBBSGL/F+hoMSFFun3
	 v4ahnvE7DdSZWxL/GoyrOKcYmPPNTTkLWgHY4pRYOjjuJL5fYTrMRzuI122hMJB7XG
	 A+l9d/S9e6rPsACUVD8/tc8xbMkxzkzUh2/v+9K0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52BD8F80508;
	Wed, 15 Sep 2021 14:21:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF5D2F8049E; Wed, 15 Sep 2021 14:21:43 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 614C1F8049E
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 14:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 614C1F8049E
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="219117494"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="219117494"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 05:21:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="544901584"
Received: from msavu-mobl1.ti.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 05:21:25 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 03/12] ASoC: SOF: imx: Do not initialize the
 snd_sof_dsp_ops.read64
Date: Wed, 15 Sep 2021 15:21:07 +0300
Message-Id: <20210915122116.18317-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915122116.18317-1-peter.ujfalusi@linux.intel.com>
References: <20210915122116.18317-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 daniel.baluta@gmail.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

The read64 operation is not used by IMX along with other IO functions.
No need to set it for the ops.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/imx/imx8.c  | 6 ------
 sound/soc/sof/imx/imx8m.c | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index 12fedf0984bd..326aa65166c2 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -419,9 +419,6 @@ struct snd_sof_dsp_ops sof_imx8_ops = {
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
 
-	/* Module IO */
-	.read64	= sof_io_read64,
-
 	/* ipc */
 	.send_msg	= imx8_send_msg,
 	.fw_ready	= sof_fw_ready,
@@ -468,9 +465,6 @@ struct snd_sof_dsp_ops sof_imx8x_ops = {
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
 
-	/* Module IO */
-	.read64	= sof_io_read64,
-
 	/* ipc */
 	.send_msg	= imx8_send_msg,
 	.fw_ready	= sof_fw_ready,
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index cb822d953767..b5c739a5cbeb 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -271,9 +271,6 @@ struct snd_sof_dsp_ops sof_imx8m_ops = {
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
 
-	/* Module IO */
-	.read64	= sof_io_read64,
-
 	/* ipc */
 	.send_msg	= imx8m_send_msg,
 	.fw_ready	= sof_fw_ready,
-- 
2.33.0

