Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B10C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:57:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54EA20714
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uAbDpyhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54EA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486DB165D;
	Tue, 11 Feb 2020 16:57:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486DB165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581436670;
	bh=v4UE3ezlL3eRw4jalivSPkycFHVudcvuhKp6Eou+hLs=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=uAbDpyhA5MxSfbRtVpY0NeVKv0+kc5HrOAL3cDH0lQBGP1cRoJqzrbswLUpnU9WUF
	 SYMcNboFQ14gXSTtwmXppCo4b2gV+3q7mNuhtqFDOwkR+C/RxJaRQDjFo9UwCA/M6G
	 piq0JTGcKczTDROqxN/Iv78r67I9RvFMCcEeFCc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A112BF80321;
	Tue, 11 Feb 2020 16:49:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBCCBF80307; Tue, 11 Feb 2020 16:48:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CB705F802F8
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:48:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB705F802F8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29213113E;
 Tue, 11 Feb 2020 07:48:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C833F68E;
 Tue, 11 Feb 2020 07:48:53 -0800 (PST)
Date: Tue, 11 Feb 2020 15:48:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <20200129220726.31792-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200129220726.31792-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: pm: Unify suspend/resume routines"
	to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: SOF: pm: Unify suspend/resume routines

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From fb9a81192d44ae9f334b1d88651dec427fa751d8 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 29 Jan 2020 16:07:19 -0600
Subject: [PATCH] ASoC: SOF: pm: Unify suspend/resume routines

Unify the suspend/resume routines for both the D0I3/D3
DSP targets in sof_suspend()/sof_resume().

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200129220726.31792-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pm.c | 91 ++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index a0cde053b61a..5b186bceedb9 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -50,6 +50,7 @@ static void sof_cache_debugfs(struct snd_sof_dev *sdev)
 static int sof_resume(struct device *dev, bool runtime_resume)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	enum sof_d0_substate old_d0_substate = sdev->d0_substate;
 	int ret;
 
 	/* do nothing if dsp resume callbacks are not set */
@@ -60,6 +61,17 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 	if (sdev->first_boot)
 		return 0;
 
+	/* resume from D0I3 */
+	if (!runtime_resume && old_d0_substate == SOF_DSP_D0I3) {
+		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I0);
+		if (ret < 0 && ret != -ENOTSUPP) {
+			dev_err(sdev->dev,
+				"error: failed to resume from D0I3 %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * if the runtime_resume flag is set, call the runtime_resume routine
 	 * or else call the system resume routine
@@ -74,6 +86,10 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 		return ret;
 	}
 
+	/* Nothing further to do if resuming from D0I3 */
+	if (!runtime_resume && old_d0_substate == SOF_DSP_D0I3)
+		return 0;
+
 	sdev->fw_state = SOF_FW_BOOT_PREPARE;
 
 	/* load the firmware */
@@ -140,10 +156,7 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 		return 0;
 
 	if (sdev->fw_state != SOF_FW_BOOT_COMPLETE)
-		goto power_down;
-
-	/* release trace */
-	snd_sof_release_trace(sdev);
+		goto suspend;
 
 	/* set restore_stream for all streams during system suspend */
 	if (!runtime_suspend) {
@@ -156,6 +169,22 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 		}
 	}
 
+	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
+		/* suspend to D0i3 */
+		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I3);
+		if (ret < 0) {
+			dev_err(sdev->dev, "error: failed to enter D0I3, %d\n",
+				ret);
+			return ret;
+		}
+
+		/* Skip to platform-specific suspend if DSP is entering D0I3 */
+		goto suspend;
+	}
+
+	/* release trace */
+	snd_sof_release_trace(sdev);
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
 	/* cache debugfs contents during runtime suspend */
 	if (runtime_suspend)
@@ -179,13 +208,13 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 			 ret);
 	}
 
-power_down:
+suspend:
 
 	/* return if the DSP was not probed successfully */
 	if (sdev->fw_state == SOF_FW_BOOT_NOT_STARTED)
 		return 0;
 
-	/* power down all DSP cores */
+	/* platform-specific suspend */
 	if (runtime_suspend)
 		ret = snd_sof_dsp_runtime_suspend(sdev);
 	else
@@ -195,6 +224,10 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 			"error: failed to power down DSP during suspend %d\n",
 			ret);
 
+	/* Do not reset FW state if DSP is in D0I3 */
+	if (sdev->d0_substate == SOF_DSP_D0I3)
+		return ret;
+
 	/* reset FW state */
 	sdev->fw_state = SOF_FW_BOOT_NOT_STARTED;
 
@@ -275,58 +308,12 @@ EXPORT_SYMBOL(snd_sof_set_d0_substate);
 
 int snd_sof_resume(struct device *dev)
 {
-	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
-	int ret;
-
-	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
-		/* resume from D0I3 */
-		dev_dbg(sdev->dev, "DSP will exit from D0i3...\n");
-		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I0);
-		if (ret == -ENOTSUPP) {
-			/* fallback to resume from D3 */
-			dev_dbg(sdev->dev, "D0i3 not supported, fall back to resume from D3...\n");
-			goto d3_resume;
-		} else if (ret < 0) {
-			dev_err(sdev->dev, "error: failed to exit from D0I3 %d\n",
-				ret);
-			return ret;
-		}
-
-		/* platform-specific resume from D0i3 */
-		return snd_sof_dsp_resume(sdev);
-	}
-
-d3_resume:
-	/* resume from D3 */
 	return sof_resume(dev, false);
 }
 EXPORT_SYMBOL(snd_sof_resume);
 
 int snd_sof_suspend(struct device *dev)
 {
-	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
-	int ret;
-
-	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
-		/* suspend to D0i3 */
-		dev_dbg(sdev->dev, "DSP is trying to enter D0i3...\n");
-		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I3);
-		if (ret == -ENOTSUPP) {
-			/* fallback to D3 suspend */
-			dev_dbg(sdev->dev, "D0i3 not supported, fall back to D3...\n");
-			goto d3_suspend;
-		} else if (ret < 0) {
-			dev_err(sdev->dev, "error: failed to enter D0I3, %d\n",
-				ret);
-			return ret;
-		}
-
-		/* platform-specific suspend to D0i3 */
-		return snd_sof_dsp_suspend(sdev);
-	}
-
-d3_suspend:
-	/* suspend to D3 */
 	return sof_suspend(dev, false);
 }
 EXPORT_SYMBOL(snd_sof_suspend);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
