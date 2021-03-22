Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBCCC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A236198D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A236198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10037165D;
	Mon, 22 Mar 2021 17:40:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10037165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616431273;
	bh=prkQXPdX7Uss1oQGe8Z4JMIIeEzdPVvkorLCGRN5awI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ocnb6oa+BizCRDBLF+73dxUn5DxxAAuqdfmXyKnauUgQ5dyrCOVQVZEjSTV0aVje1
	 l/th5Sw9m8y46uFXIXu0dAbNP1qTkO2m597HGZpUb+1q/1Qf58ZlP745KmP3+z4tBF
	 zEq79oDUCzYTRUYbY0Fq6wGP1AaanKkGvfBurN4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF6BBF804A9;
	Mon, 22 Mar 2021 17:38:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37477F801EB; Mon, 22 Mar 2021 17:38:02 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0E56F801EC
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 17:37:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0E56F801EC
IronPort-SDR: wzu701tdv/O+1I9+T2B0/2OzoZDrjmcqGu0Lr1Zt80/MeL2XdESKuadVf6oj6p6L1if6wZ1ps/
 zZ7pYyINmjyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210376626"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="210376626"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:45 -0700
IronPort-SDR: LxnBqNPdr3Yd3ooHm0hVN+0O3xwLsU1MP/nx9YzwawVGAwwawq9FJbSoEHsAC/dL9WLhgJL6fF
 BBN0QrRw1u+Q==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="407899109"
Received: from josemari-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.40.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:44 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/8] ASoC: SOF: Intel: ICL: set shutdown callback to
 hda_dsp_shutdown
Date: Mon, 22 Mar 2021 11:37:25 -0500
Message-Id: <20210322163728.16616-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
References: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org,
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

From: Libin Yang <libin.yang@intel.com>

According to hardware spec and PMC FW requirement, the DSP must be
in D3 state before entering S5. Set shutdown call to hda_dsp_shutdown.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/icl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/icl.c b/sound/soc/sof/intel/icl.c
index e9d5a0a58504..88a74be8a0c1 100644
--- a/sound/soc/sof/intel/icl.c
+++ b/sound/soc/sof/intel/icl.c
@@ -26,9 +26,10 @@ static const struct snd_sof_debugfs_map icl_dsp_debugfs[] = {
 
 /* Icelake ops */
 const struct snd_sof_dsp_ops sof_icl_ops = {
-	/* probe and remove */
+	/* probe/remove/shutdown */
 	.probe		= hda_dsp_probe,
 	.remove		= hda_dsp_remove,
+	.shutdown	= hda_dsp_shutdown,
 
 	/* Register IO */
 	.write		= sof_io_write,
-- 
2.25.1

