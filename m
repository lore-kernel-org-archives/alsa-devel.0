Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75AEC3F2D1
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:40:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D4A21775
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uME8Q5QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D4A21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92B0216C5;
	Mon,  2 Mar 2020 15:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92B0216C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583160026;
	bh=mmuQLJGbIb4o6LHXXyO6kBRTmDXxmACKwE9bcXI9F2U=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=uME8Q5QWT9oSUMzfMZmjsdWdM9AOjU6UwONRdLOE+f7eHbOOe8BGHsCR3N7VODedR
	 euq1xapcVwbhFQa3Hapx1j73MoAwpmLT4cVSel+6Chf6qzHEuNOJUPZYk+9hkOxQe5
	 pjr5g1fwkznJ3nYnwDc8lx0BaymgYzhgIHh9SE08=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F8A4F8027B;
	Mon,  2 Mar 2020 15:37:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D764F8028B; Mon,  2 Mar 2020 15:37:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 32D37F80229
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 15:37:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32D37F80229
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB06101E;
 Mon,  2 Mar 2020 06:37:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57CF3F534;
 Mon,  2 Mar 2020 06:37:09 -0800 (PST)
Date: Mon, 02 Mar 2020 14:37:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: use snd_sof_dsp_set_power_state() op"
 to the asoc tree
In-Reply-To: <20200228234225.6963-1-ranjani.sridharan@linux.intel.com>
Message-Id: <applied-20200228234225.6963-1-ranjani.sridharan@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
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

The patch

   ASoC: SOF: Intel: hda: use snd_sof_dsp_set_power_state() op

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 787c5214ea6f6e9b7c75ae670d6b6a7deecb2d45 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 28 Feb 2020 15:42:25 -0800
Subject: [PATCH] ASoC: SOF: Intel: hda: use snd_sof_dsp_set_power_state() op

Replace the calls to hda_dsp_set_power_state() with the
top-level SOF op snd_sof_set_power_state().
Along with this, modify the hda_dsp_resume() function to return
the value of snd_sof_set_power_state() directly.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200228234225.6963-1-ranjani.sridharan@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

