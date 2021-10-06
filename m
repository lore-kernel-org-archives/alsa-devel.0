Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05173C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:09:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71386610CC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71386610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EDFD1685;
	Wed,  6 Oct 2021 13:08:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EDFD1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518568;
	bh=Hdo2Zqtb2+fpwa2tD9oBacxukHZpCips/mgW+9Lorx4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3OGrCgE3cQHD+qYx/S3W6GzLpN5nf0q5JhqFJqq/eRsNeR2XrtpiyjS5qRsX2fNn
	 4FCgZiP7sVN9/385z9JF8QzQIIWgwvTIf++4rpdOHlwIv6CuexcK2/0fkFTsb64CDs
	 hCtpGTZqCGWOYA1zBHRaU/552w3fAmLLG3LfsQlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 592DCF80249;
	Wed,  6 Oct 2021 13:07:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDAA5F804FD; Wed,  6 Oct 2021 13:07:04 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80152F80249
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80152F80249
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223366434"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="223366434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="439080975"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:46 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 03/19] ASoC: SOF: ipc and dsp dump: Add markers for better
 visibility
Date: Wed,  6 Oct 2021 14:06:29 +0300
Message-Id: <20211006110645.26679-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
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

Add markers to identify the start and end of the IPC and DSP dumps in the
kernel log.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index a93aa5b943b2..d143a35f16fc 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -243,14 +243,20 @@ snd_sof_dsp_set_power_state(struct snd_sof_dev *sdev,
 /* debug */
 static inline void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
 {
-	if (sof_ops(sdev)->dbg_dump)
+	if (sof_ops(sdev)->dbg_dump) {
+		dev_err(sdev->dev, "------------[ DSP dump start ]------------\n");
 		sof_ops(sdev)->dbg_dump(sdev, flags);
+		dev_err(sdev->dev, "------------[ DSP dump end ]------------\n");
+	}
 }
 
 static inline void snd_sof_ipc_dump(struct snd_sof_dev *sdev)
 {
-	if (sof_ops(sdev)->ipc_dump)
+	if (sof_ops(sdev)->ipc_dump) {
+		dev_err(sdev->dev, "------------[ IPC dump start ]------------\n");
 		sof_ops(sdev)->ipc_dump(sdev);
+		dev_err(sdev->dev, "------------[ IPC dump end ]------------\n");
+	}
 }
 
 static inline int snd_sof_debugfs_add_region_item(struct snd_sof_dev *sdev,
-- 
2.33.0

