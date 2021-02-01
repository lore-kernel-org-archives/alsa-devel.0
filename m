Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0EBC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 09:35:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6B564EAA
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 09:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6B564EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6DD51753;
	Mon,  1 Feb 2021 10:35:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6DD51753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612172154;
	bh=1nOE8m8993W8muA3kTCQnxpMaHXc6Iklxo2292hQJkU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MPNnsULejL8cSOdkBwo3utJO2DlTcduQ40wz9AsDYW4LiKXpwhIXaMizwmDDdriPH
	 XN7buFZHJeiRdiD44fdIR49aQE097ydBOiR7nlLS/ukvCG6qM4CrbxIaJ0Qt8jeFFr
	 U2Rr/e5vUEsvYI/yAKd933hOfIDT40yqzzmQvfBo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22A10F8015A;
	Mon,  1 Feb 2021 10:35:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74B01F80224; Mon,  1 Feb 2021 10:35:02 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 889FBF8015A
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 10:34:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 889FBF8015A
IronPort-SDR: l+HchcytvkrlXxggvr5m1Fl4XOVjbyMwnoCKerdXoQGNz9QY/68i9NNk+Q2oqLZ/scf+msPZwU
 n2QxMq/mqsiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="168340873"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; d="scan'208";a="168340873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 01:34:49 -0800
IronPort-SDR: VbPUtqZD1wVEAcj5c3Sq9NWpxe9/fFej6smU7Y17QYhK24eOkYZrVQhWITekZPJqtjq4U06Ej7
 an6AiTs2YwWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; d="scan'208";a="478800242"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 01:34:46 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: topology: Prevent NULL pointer dereference with no
 TLV
Date: Mon,  1 Feb 2021 11:31:28 +0200
Message-Id: <20210201093128.1226603-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, Paul Olaru <paul.olaru@oss.nxp.com>,
 daniel.baluta@nxp.com, Bard Liao <bard.liao@intel.com>
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

When there is no TLV data in topology, extracting the TLV data
could result in a NULL pointer exception. Prevent this by making
sure that the TLV data exists before extracting it.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b69f493b5faa..46089000524d 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1073,7 +1073,7 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 	scontrol->cmd = SOF_CTRL_CMD_VOLUME;
 
 	/* extract tlv data */
-	if (get_tlv_data(kc->tlv.p, tlv) < 0) {
+	if (!kc->tlv.p || get_tlv_data(kc->tlv.p, tlv) < 0) {
 		dev_err(scomp->dev, "error: invalid TLV data\n");
 		ret = -EINVAL;
 		goto out_free;

base-commit: 8ac9e476b86851c94e0f33bea758e0a00e3f875e
-- 
2.29.2

