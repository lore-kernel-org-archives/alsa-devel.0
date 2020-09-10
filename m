Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC00C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:44:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488BA21D40
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VK+9R5/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488BA21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7305716C2;
	Thu, 10 Sep 2020 18:44:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7305716C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599756291;
	bh=f4APOjuCp128c0K7W3GFu8XlHQJRsQQc8y8lTUpVmmA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VK+9R5/xYm0GeEVu8RHYvVH/cHRnRxOKLIdRNzcLSZEiUYLc7SluMwauHPO/GasQ0
	 4x0Z7fNxynrNpbMNIBEG0RARvjJZRwguW66PwDI1ldFnmO13KboLdWL4Jm0RccQ/fQ
	 5mxuR26Vsa7DGE/Vs6EuaHHNiyG4F6DduuN97bgI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9155DF8028E;
	Thu, 10 Sep 2020 18:43:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87243F8026F; Thu, 10 Sep 2020 18:43:07 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC167F800D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 18:42:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC167F800D0
IronPort-SDR: LsIX4/Lnk0UoAs2AlUGZfga1cBrr7JTHPWYthAJsHF0A7WCiUh+KhYscqwjsozL2fd2tVEHpQs
 pYc6/VXxLA7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146278542"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="146278542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 09:42:55 -0700
IronPort-SDR: ZhhMnDVn4XNivDjmTwOpUJyBr7kLS1vK9cPiA5KQTBgUF5I992UPWSmqmdPMWfZAzLLuIYgWrw
 aF1eEvdtUWnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="304937895"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 10 Sep 2020 09:42:52 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/4] ASoC: SOF: Intel: hda: modify core_power_up/down op
Date: Thu, 10 Sep 2020 19:41:23 +0300
Message-Id: <20200910164125.2033062-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
References: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, Keyon Jie <yang.jie@linux.intel.com>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 Rander Wang <rander.wang@linux.intel.com>
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

Modify the core_power_up/down ops for HDA platforms to restrict
the core_mask to the ones allowed by chip->cores_mask. This is needed
because on some HDA platforms not all cores can be powered up/down
by the host and this must be handled internally in the FW.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 18d726669c6f..18ff1c2f5376 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -239,10 +239,15 @@ bool hda_dsp_core_is_enabled(struct snd_sof_dev *sdev,
 
 int hda_dsp_enable_core(struct snd_sof_dev *sdev, unsigned int core_mask)
 {
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
 	int ret;
 
-	/* return if core is already enabled */
-	if (hda_dsp_core_is_enabled(sdev, core_mask))
+	/* restrict core_mask to host managed cores mask */
+	core_mask &= chip->host_managed_cores_mask;
+
+	/* return if core_mask is not valid or cores are already enabled */
+	if (!core_mask || hda_dsp_core_is_enabled(sdev, core_mask))
 		return 0;
 
 	/* power up */
@@ -259,8 +264,17 @@ int hda_dsp_enable_core(struct snd_sof_dev *sdev, unsigned int core_mask)
 int hda_dsp_core_reset_power_down(struct snd_sof_dev *sdev,
 				  unsigned int core_mask)
 {
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
 	int ret;
 
+	/* restrict core_mask to host managed cores mask */
+	core_mask &= chip->host_managed_cores_mask;
+
+	/* return if core_mask is not valid */
+	if (!core_mask)
+		return 0;
+
 	/* place core in reset prior to power down */
 	ret = hda_dsp_core_stall_reset(sdev, core_mask);
 	if (ret < 0) {
-- 
2.27.0

