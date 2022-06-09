Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53199C43334
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jun 2022 09:01:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B68A1FBD;
	Thu,  9 Jun 2022 11:00:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B68A1FBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654765275;
	bh=HOcPOmel0iDl4N8LHrdunpSE1jq8fjx5VN8kBqXwwNE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnzn0/w1PU7xwW8Fe+zrcdEkkjTr4442uBfaRcQRQuwuYPjIacDDt/tOIcgfeFelm
	 4DY6b1jCEgSIoZ9TkvNLkqm5VILPpLSwqTRjfH9y0CfMeF9ToMACZ8gCMSiZg6CdB3
	 32oXYfTXC6IXqXk8iNHf/UW6/3iYLmlEwmDj9Mp8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2C35F80534;
	Thu,  9 Jun 2022 10:59:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5996F801F5; Thu,  9 Jun 2022 10:59:36 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE4F9F801F5
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2022 10:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE4F9F801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Hgc4F0LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654765172; x=1686301172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HOcPOmel0iDl4N8LHrdunpSE1jq8fjx5VN8kBqXwwNE=;
 b=Hgc4F0LGdqY46OFyBGvygvjdeMhNslBof/Am0BpgKom3Czu2vz3P+6Wq
 3wi53rKqDYUCCvEZ24YUCQrqbLvEjrTVsWwqQrkwomCHCfFkF7t9GgsHb
 zWVAcowjJHym36E2HhJ2ICyZwyC0vjBocekyfW2SNl1GvtBNuZ9KyvWLs
 eIXSEt/KoFNQDS4EksoMzr4oMrh/AcnP0x8fBnfJ5lJIstwXjq+6O0g0O
 VktCZXkTipBi9uZJVCW97dYA53/Eo406TFImYxMfAmNvR1Gw7HUlkKCB3
 SqQq5CpdjdNNLEMg6elbE2jPVWv+oyZ0A0Zvmz5egySaZTDH8qGRF+Bs9 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274732406"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="274732406"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 01:59:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="637369173"
Received: from ekoledex-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.94])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 01:59:21 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 3/3] ASoC: SOF: Intel: hda-loader: Clarify the cl_dsp_init()
 flow
Date: Thu,  9 Jun 2022 11:59:49 +0300
Message-Id: <20220609085949.29062-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609085949.29062-1-peter.ujfalusi@linux.intel.com>
References: <20220609085949.29062-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
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

Update the comment for the cl_dsp_init() to clarify what is done by the
function and use the chip->init_core_mask instead of BIT(0) when
unstalling/running the init core.

Complements: 2a68ff846164 ("ASoC: SOF: Intel: hda: Revisit IMR boot sequence")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 103e62bcfa82..d3ec5996a9a3 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -95,9 +95,9 @@ struct hdac_ext_stream *hda_cl_stream_prepare(struct snd_sof_dev *sdev, unsigned
 }
 
 /*
- * first boot sequence has some extra steps. core 0 waits for power
- * status on core 1, so power up core 1 also momentarily, keep it in
- * reset/stall and then turn it off
+ * first boot sequence has some extra steps.
+ * power on all host managed cores and only unstall/run the boot core to boot the
+ * DSP then turn off all non boot cores (if any) is powered on.
  */
 static int cl_dsp_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 {
@@ -127,7 +127,7 @@ static int cl_dsp_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 	snd_sof_dsp_write(sdev, HDA_DSP_BAR, chip->ipc_req, ipc_hdr);
 
 	/* step 3: unset core 0 reset state & unstall/run core 0 */
-	ret = hda_dsp_core_run(sdev, BIT(0));
+	ret = hda_dsp_core_run(sdev, chip->init_core_mask);
 	if (ret < 0) {
 		if (hda->boot_iteration == HDA_FW_BOOT_ATTEMPTS)
 			dev_err(sdev->dev,
-- 
2.36.1

