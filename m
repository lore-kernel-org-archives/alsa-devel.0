Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EFCC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 01:53:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F16522DD6
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 01:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F16522DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD06717CD;
	Tue, 26 Jan 2021 02:52:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD06717CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611626016;
	bh=Upu5JtGBTPIu8a8Nvf/B7wsdHgSfV0tYiyfRuHdsiL0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e5L4PDCkDx9r9qOW5e1R9v9Lo5NXzuAxCRWrSFLpX7eQgM92LO/iz3i1zt5+frGzQ
	 Xwhgux+2YvXUfQOOQ6Kgs8nTTom8d42TXnSbYT3P/D5c4pN4bNVLqH38Ja77Ci20Fm
	 WRlArnaW6yuSVCWQ80/W4sw7iPTwDPZV4rYDq9sM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDA3DF80278;
	Tue, 26 Jan 2021 02:51:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF97BF80260; Tue, 26 Jan 2021 02:51:51 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DB24F80130
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 02:51:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DB24F80130
IronPort-SDR: Pr37ADQXJEtk9HtofT3wVRvw8WoAHVKlZyY8F9/Z+5w4HgpL2Keo1h6AiaECDRMlVvxChnEuuE
 k98nLh/ia2qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159610096"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="159610096"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 17:51:39 -0800
IronPort-SDR: PsuMSi6nHuF40t+aNcAemAanN1HPD3WZJ/BeV6YNQTIYopTQLcGn4Z3bKcg5mOI6G/SnvFEtdp
 JSumL4N986iA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="356564916"
Received: from sugatabx-mobl.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.212.73.120])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 17:51:39 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: SOF: Intel: hda: Enable DMI L1 for trace
Date: Mon, 25 Jan 2021 17:51:30 -0800
Message-Id: <20210126015130.1023840-3-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126015130.1023840-1-ranjani.sridharan@linux.intel.com>
References: <20210126015130.1023840-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, tiwai@suse.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Enabling DMI L1 for capture streams could result in xruns during
pause/release. As pause/release is not a valid scenario for trace,
we can safely enable DMI L1 for it.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-trace.c b/sound/soc/sof/intel/hda-trace.c
index ca869038e909..81d76d3debc6 100644
--- a/sound/soc/sof/intel/hda-trace.c
+++ b/sound/soc/sof/intel/hda-trace.c
@@ -42,7 +42,8 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag)
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	int ret;
 
-	hda->dtrace_stream = hda_dsp_stream_get(sdev, SNDRV_PCM_STREAM_CAPTURE, 0);
+	hda->dtrace_stream = hda_dsp_stream_get(sdev, SNDRV_PCM_STREAM_CAPTURE,
+						SOF_HDA_STREAM_DMI_L1_COMPATIBLE);
 
 	if (!hda->dtrace_stream) {
 		dev_err(sdev->dev,
-- 
2.25.1

