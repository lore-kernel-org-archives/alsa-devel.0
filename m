Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFECC3F2D2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:43:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6B7246B6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S5ALkZ2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6B7246B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C0FC16CA;
	Sat, 29 Feb 2020 00:42:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C0FC16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582933404;
	bh=AFuRyuFTJCa01oKjh12HG3L4smSLxHyOqw8XeRG6RdI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S5ALkZ2BlwABsu2v5qem2znBlZsfiXzflM16fPXHou9JVmvBQW4LEO/6oQt8xNRAY
	 0QPpCldjzZooHcDmucafyyLX/+BBw4C/de6iW/4d1XfqXqIglX99q1Rqe/8BACsrTW
	 VbMxPUIbPj5yvMkXg5yeC2CjMljjRX0oC+vbd24M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 198F5F8014D;
	Sat, 29 Feb 2020 00:42:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86343F8014E; Sat, 29 Feb 2020 00:42:31 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53101F80113
 for <alsa-devel@alsa-project.org>; Sat, 29 Feb 2020 00:42:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53101F80113
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 15:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="232409749"
Received: from lacoffin-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.99.56])
 by orsmga008.jf.intel.com with ESMTP; 28 Feb 2020 15:42:24 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: hda: use snd_sof_dsp_set_power_state() op
Date: Fri, 28 Feb 2020 15:42:25 -0800
Message-Id: <20200228234225.6963-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

Replace the calls to hda_dsp_set_power_state() with the
top-level SOF op snd_sof_set_power_state().
Along with this, modify the hda_dsp_resume() function to return
the value of snd_sof_set_power_state() directly.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 0e61c27785a3..79ce52c32ef1 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -662,7 +662,7 @@ int hda_dsp_resume(struct snd_sof_dev *sdev)
 		hda_codec_i915_display_power(sdev, true);
 
 		/* Set DSP power state */
-		ret = hda_dsp_set_power_state(sdev, &target_state);
+		ret = snd_sof_dsp_set_power_state(sdev, &target_state);
 		if (ret < 0) {
 			dev_err(sdev->dev, "error: setting dsp state %d substate %d\n",
 				target_state.state, target_state.substate);
@@ -686,8 +686,7 @@ int hda_dsp_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	hda_dsp_set_power_state(sdev, &target_state);
-	return ret;
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
 }
 
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
@@ -702,7 +701,7 @@ int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hda_dsp_set_power_state(sdev, &target_state);
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
 }
 
 int hda_dsp_runtime_idle(struct snd_sof_dev *sdev)
@@ -730,7 +729,7 @@ int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hda_dsp_set_power_state(sdev, &target_state);
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
 }
 
 int hda_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
@@ -753,7 +752,7 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 		hda_codec_i915_display_power(sdev, false);
 
 		/* Set DSP power state */
-		ret = hda_dsp_set_power_state(sdev, &target_dsp_state);
+		ret = snd_sof_dsp_set_power_state(sdev, &target_dsp_state);
 		if (ret < 0) {
 			dev_err(sdev->dev, "error: setting dsp state %d substate %d\n",
 				target_dsp_state.state,
@@ -781,7 +780,7 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 		return ret;
 	}
 
-	return hda_dsp_set_power_state(sdev, &target_dsp_state);
+	return snd_sof_dsp_set_power_state(sdev, &target_dsp_state);
 }
 
 int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
@@ -849,7 +848,7 @@ void hda_dsp_d0i3_work(struct work_struct *work)
 		return;
 
 	/* This can fail but error cannot be propagated */
-	ret = hda_dsp_set_power_state(sdev, &target_state);
+	ret = snd_sof_dsp_set_power_state(sdev, &target_state);
 	if (ret < 0)
 		dev_err_ratelimited(sdev->dev,
 				    "error: failed to set DSP state %d substate %d\n",
-- 
2.17.1

