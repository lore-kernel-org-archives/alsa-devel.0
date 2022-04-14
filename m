Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C08BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Apr 2022 18:52:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1A071910;
	Thu, 14 Apr 2022 20:51:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1A071910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649962358;
	bh=pkDFQnRzO9fgCTtOmq6hYf8ZlS+WZ987021bDWO1fts=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oycfR9IcJuK09Vkh1jVvjVwHLzMEYqzfjLHdG/chHIu52o08AA3aoHpbc+rtzgNhK
	 9yopMtWNBJqkSydnsk4XG8Tpudj4ttgd0EHcBPrN1lLcAsQW+WfCDN4UmPgTWt+c8f
	 pvgbobP6seiUMpMLH7nAN17oX4VHgrkAIpU+vAas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8451BF80566;
	Thu, 14 Apr 2022 20:49:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79C2FF80551; Thu, 14 Apr 2022 20:49:09 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85AC4F80534
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 20:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85AC4F80534
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ayOei94n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649962139; x=1681498139;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pkDFQnRzO9fgCTtOmq6hYf8ZlS+WZ987021bDWO1fts=;
 b=ayOei94nBYtqHyvuzsRLiXtKkeyam/361zyCuDe4XOA2YWW+B/uxqTND
 0uM/DEaYvnMT1CuOU1v4c3uB5AgsIaLsizM4rnntkRqQFjveS7wfC7Ljl
 zJcfOYjr1KdEvugRv9CZql3Bc3S9gLstyF0p70UFI/tAM3+LB7hco2aYo
 mO3TUzV5GHqKVq3sqjMwpu6FeTeIQz/euiyWQ4izgIasznb7RGLC4DsxA
 VCJNWEMVHJzwQ1H3SOFTEjDFnDVn8T4KSOny+ibWFRv/+YpfCj2ldCtdd
 Zukn6O9e+4rrRlfVkXZDBey8SP9SKINOealyzCYNB/7GfmtjLPwqDwa66 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349442355"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; d="scan'208";a="349442355"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2022 11:48:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; d="scan'208";a="560304648"
Received: from rrsolima-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.252.130.212])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2022 11:48:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 10/15] ASoC: SOF: Intel: move HDA_CL_STREAM_FORMAT
 definition to header
Date: Thu, 14 Apr 2022 13:48:12 -0500
Message-Id: <20220414184817.362215-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414184817.362215-1-pierre-louis.bossart@linux.intel.com>
References: <20220414184817.362215-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Use the definition of the HDA_CL_STREAM_FORMAT macro from the header
file.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 2 --
 sound/soc/sof/intel/hda.h        | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 697d18a41a6e..625bc1e67f1e 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -24,8 +24,6 @@
 #include "../sof-priv.h"
 #include "hda.h"
 
-#define HDA_CL_STREAM_FORMAT 0x40
-
 static void hda_ssp_set_cbp_cfp(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 5d083ebbb886..cc55439ab187 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -588,6 +588,7 @@ int hda_dsp_ipc_cmd_done(struct snd_sof_dev *sdev, int dir);
  */
 int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev);
 int hda_dsp_cl_boot_firmware_iccmax(struct snd_sof_dev *sdev);
+#define HDA_CL_STREAM_FORMAT 0x40
 
 /* pre and post fw run ops */
 int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev);
-- 
2.30.2

