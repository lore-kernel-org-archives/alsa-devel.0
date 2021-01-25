Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B31C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 07:10:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7DF22581
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 07:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7DF22581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 888D11867;
	Mon, 25 Jan 2021 08:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 888D11867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611558619;
	bh=kTnkeKm801xKvS/Oy76DLLKF+3G/+lhuFHZdu/tt0LM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bhx0zvhWEVZLm+OEhaA7+RPMX2K+NPFMEaJtLND1NolnEnQCMQXVy81sduk+Ml4PN
	 oWo+3CVAavea9dyZH/a3rQP/bhjJB7U4A5so28TWLHrve07KB0zweulcq0+ohIAUbE
	 mkH59lc8RG3jDV78HV4E/IRnW96iCASB03rhMczo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17F34F80269;
	Mon, 25 Jan 2021 08:08:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F437F80218; Mon, 25 Jan 2021 08:08:30 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25833F8012D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 08:08:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25833F8012D
IronPort-SDR: tdUMIOKq5xii6TVuDmc2OxQj8BKFudREG1efABSfiHrN92wrlDlTdpZOl7hqUre9bvaF3aJV/q
 06swgwOdJUGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="264497709"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="264497709"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2021 23:08:15 -0800
IronPort-SDR: LRTdaIMMBsh7obF7owSO1V3aACAzUooqC3eFzPDqn+fIozuWVExn2gdf6ozcB/KY4W+Y8oYxsB
 0ytdGo0nLW7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="429154793"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001.jf.intel.com with ESMTP; 24 Jan 2021 23:08:13 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/3] ASoC: SOF: allow soundwire use desc->default_fw_filename
Date: Mon, 25 Jan 2021 09:04:58 +0200
Message-Id: <20210125070500.807474-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
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

From: Libin Yang <libin.yang@intel.com>

The old code always uses sof_fw_filename in struct snd_soc_acpi_mach
as the firmware name. However, firmware name should depend on the platform
instead of the machine. For example, different machines may use the same
soundwire link topology, but they are using the different firmware. In this
case, it's hard to determine in struct snd_soc_acpi_mach which firmware it
should use.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7e703ce22fcd..d99a552eea53 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1169,7 +1169,10 @@ static int hda_sdw_machine_select(struct snd_sof_dev *sdev)
 			mach->mach_params.links = mach->links;
 			mach->mach_params.link_mask = mach->link_mask;
 			mach->mach_params.platform = dev_name(sdev->dev);
-			pdata->fw_filename = mach->sof_fw_filename;
+			if (mach->sof_fw_filename)
+				pdata->fw_filename = mach->sof_fw_filename;
+			else
+				pdata->fw_filename = pdata->desc->default_fw_filename;
 			pdata->tplg_filename = mach->sof_tplg_filename;
 		} else {
 			dev_info(sdev->dev,
-- 
2.29.2

