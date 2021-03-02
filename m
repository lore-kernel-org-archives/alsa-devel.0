Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F15C2BA17
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:36:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CED360238
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CED360238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD33B1698;
	Tue,  2 Mar 2021 01:35:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD33B1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614645391;
	bh=67iaoqpIoCZMeqyyfj5iX2KIs/p/sCCtvadN5XpJDZE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f7eSMmYSzrek6L0yndMDnLSjLPrFarP4ePiX8wK2CWKULb4PGBhEM+vP3M6vGdtiF
	 nieTt9WF1BbCzJ3qDNqBKWLeA7VDFoy9eChYomSEDZoJSQvX4jButqtd7H2Khq+VCn
	 lUT9cVNvyIWuUpjj4mg9rXbnTGq1YO5zInKlxcLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6669F8025E;
	Tue,  2 Mar 2021 01:34:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72B16F8025E; Tue,  2 Mar 2021 01:34:53 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2E76F8026A
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 01:34:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2E76F8026A
IronPort-SDR: eL2mWUDLmxZYI46aB0hOwQ1eW+jmm2YAtNzvdV9m8iliGkFDu39s42UzaM1NbyroC2Aq+k22DN
 ORpQF45760yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183241833"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="183241833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:34:39 -0800
IronPort-SDR: zi4SaNbjcJKDa9A8KKfCaKKKZP+rJA+urZdgpde0HyIkrOBywDr60YEmM02X0eZtKS1Zp8C7ZS
 YmpzDO63NpMg==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="397987378"
Received: from josemrod-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.215.233])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:34:35 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: unregister DMIC device on probe error
Date: Mon,  1 Mar 2021 18:34:10 -0600
Message-Id: <20210302003410.1178535-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

We only unregister the platform device during the .remove operation,
but if the probe fails we will never reach this sequence.

Suggested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Fixes: dd96daca6c83e ("ASoC: SOF: Intel: Add APL/CNL HW DSP support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 0e092877f550..5317dfa4a4bf 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -895,6 +895,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 /* dsp_unmap: not currently used */
 	iounmap(sdev->bar[HDA_DSP_BAR]);
 hdac_bus_unmap:
+	platform_device_unregister(hdev->dmic_dev);
 	iounmap(bus->remap_addr);
 	hda_codec_i915_exit(sdev);
 err:
-- 
2.25.1

