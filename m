Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BBC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:36:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748BD613C4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748BD613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D9F716CA;
	Fri, 21 May 2021 11:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D9F716CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621589764;
	bh=D9HvSWFpsReoOpQ2dw0WNU1XIrjO951irBsBZmp/uic=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dw76/ZKxFjpxx1K4cqSQBI1qemFQAvdk/+vZ3yfDThCyxfUdGql/Ih+xvtcfW6wHr
	 XxvcO88vFT775XAg2WdPX1N6Jamw8MC+T+kdpL2JeLsdeflAwj3OlZaXK7r3ZsaclD
	 D+1Oc9Z1NfM1vQcInbxj/hglieZ9xrVPIeEfuBMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04FEF804B0;
	Fri, 21 May 2021 11:33:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C584F80258; Fri, 21 May 2021 11:33:24 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0FB8F801DB
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 11:33:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0FB8F801DB
IronPort-SDR: eLfladFry+7Ks3DOQiDlGTTzVFIN3BbGdBZ0z1oZivl0DbZokcBt0WogdAE8Pj6YV8jJDZc6ci
 Ow1CWBkSBwAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262664191"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="262664191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 02:33:20 -0700
IronPort-SDR: qSK6GVQnQSK2QiIbHiu9cxhShYwIre0HIZwA74y2lPTzDZiKQ/OVutKm1cO+m6LmaQ2NCh8XJF
 R4awj0Euecqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="475640870"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga002.fm.intel.com with ESMTP; 21 May 2021 02:33:18 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/7] ASoC: SOF: loader: Use snd_sof_dsp_block_read() instead
 sof_block_read()
Date: Fri, 21 May 2021 12:28:01 +0300
Message-Id: <20210521092804.3721324-5-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521092804.3721324-1-kai.vehmanen@linux.intel.com>
References: <20210521092804.3721324-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

SOF core should use the IO functions via callbacks and not directly to
ensure that it remains platform independent.

Fixes: 83ee7ab1627b7 ("ASoC: SOF: Intel: byt: Refactor fw ready / mem windows creation")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 6efaf766f2ab..2b38a77cd594 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -517,7 +517,7 @@ int sof_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
 		return 0;
 
 	/* copy data from the DSP FW ready offset */
-	sof_block_read(sdev, bar, offset, fw_ready, sizeof(*fw_ready));
+	snd_sof_dsp_block_read(sdev, bar, offset, fw_ready, sizeof(*fw_ready));
 
 	/* make sure ABI version is compatible */
 	ret = snd_sof_ipc_valid(sdev);
-- 
2.31.0

