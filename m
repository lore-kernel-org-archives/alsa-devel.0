Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19D9C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Apr 2022 20:22:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD6C11772;
	Mon, 11 Apr 2022 22:21:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD6C11772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649708542;
	bh=pkDFQnRzO9fgCTtOmq6hYf8ZlS+WZ987021bDWO1fts=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KG6RbDey4QsoWDaIlNn8maXuawf8LhMTB2FqKraFXbq8b/GKRLZkZpDJGwMZqulRA
	 Kz7n838r9W3KLAFOXSasH468o/SPYvZKgmkMh+ZFUyn72ZgPwo6rqDScDmROrDpGp0
	 nNPMc0bB6m6RveX3ySXrqSZkrmLFHgDTwYttZZls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FDA3F80568;
	Mon, 11 Apr 2022 22:18:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27F8BF80543; Mon, 11 Apr 2022 22:18:19 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86447F80506
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2022 22:18:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86447F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="g2nVGZO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649708283; x=1681244283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pkDFQnRzO9fgCTtOmq6hYf8ZlS+WZ987021bDWO1fts=;
 b=g2nVGZO/6xCXzVpezJNCfndFMUmstSMsqY2FKKKqvGj9glbZAe/CYMoN
 uPSZjzc5eBhf4rRHjgoLsS2dVaEV3V8MlLyicYIZFamr/+V3Y+UqUzTGB
 Y47ZG9PrSlgomC6iFR7YWOmhRCRWXSVXrrhtRxp+V3RuLqEu0lc2ngB+4
 6urwKQExykLelZH86/5GiXzUAjQITNendXpOrT55HBuY7EXbhdOFk5Pge
 qTk0lrn4z4LUzUrDvdQVkQ196ViVzieY/QKzDhqy+bfFISsUC50CnZAX9
 LsJzmc2b7a9+OdrQe5l/sCa49RhjOwZI4Lu5lrci3/3yrataH2T+opqC8 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244090840"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="244090840"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="526135683"
Received: from prposam-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.162.151])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/16] ASoC: SOF: Intel: move HDA_CL_STREAM_FORMAT definition
 to header
Date: Mon, 11 Apr 2022 15:17:21 -0500
Message-Id: <20220411201727.77971-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
References: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
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

