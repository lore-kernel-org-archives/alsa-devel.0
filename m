Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CFC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:56:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097642082F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lHZiP3ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097642082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45C77167C;
	Tue, 11 Feb 2020 16:55:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45C77167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581436569;
	bh=1XxSlV4j2qbQ4EEXIj36DEbHvmgwMzYVSalfHXx2g2g=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=lHZiP3ZUg85tfsl+lRiK+o8VwWZvSu4soLmR8ikpt3HDsCs9UnFPpSQuCeUpJ1NOT
	 a18DQGsdT2HrJSOQotiiQQQvDXPWe6K28uiPV6llpqWzwbuaHNqpR6iJLrQg2ip+tz
	 aaQwi8fSR43ZHo2dTo94XrMdwojMBCM6Ow2D2xOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB7BBF802F9;
	Tue, 11 Feb 2020 16:48:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE907F802EB; Tue, 11 Feb 2020 16:48:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0B4B1F802A8
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:48:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B4B1F802A8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7BA1045;
 Tue, 11 Feb 2020 07:48:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E5A3F68E;
 Tue, 11 Feb 2020 07:48:48 -0800 (PST)
Date: Tue, 11 Feb 2020 15:48:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <20200129220726.31792-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200129220726.31792-5-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: pm: Introduce DSP power states" to
	the asoc tree
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

   ASoC: SOF: pm: Introduce DSP power states

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

From 700d167739a099cdf12ed15c25fec7f4cb563d42 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 29 Jan 2020 16:07:21 -0600
Subject: [PATCH] ASoC: SOF: pm: Introduce DSP power states

Add a new enum sof_dsp_power_states for all the possible
the DSP device states. The SOF driver currently handles
only the D0 and D3 states and support for other states
will be added later as needed.

Also, add a helper to determine the target DSP power state
based on the system suspend target.
The snd_sof_dsp_d0i3_on_suspend() function is renamed to
snd_sof_stream_suspend_ignored() to be more indicative
of what it does and it used to determine the target
DSP state during system suspend.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200129220726.31792-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pm.c        | 38 +++++++++++++++++++++++++++++++++++++-
 sound/soc/sof/sof-audio.c |  2 +-
 sound/soc/sof/sof-audio.h |  2 +-
 sound/soc/sof/sof-priv.h  | 10 ++++++++++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index c86ac1e84bd7..bec25cb6beec 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -12,6 +12,42 @@
 #include "sof-priv.h"
 #include "sof-audio.h"
 
+/*
+ * Helper function to determine the target DSP state during
+ * system suspend. This function only cares about the device
+ * D-states. Platform-specific substates, if any, should be
+ * handled by the platform-specific parts.
+ */
+static u32 snd_sof_dsp_power_target(struct snd_sof_dev *sdev)
+{
+	u32 target_dsp_state;
+
+	switch (sdev->system_suspend_target) {
+	case SOF_SUSPEND_S3:
+		/* DSP should be in D3 if the system is suspending to S3 */
+		target_dsp_state = SOF_DSP_PM_D3;
+		break;
+	case SOF_SUSPEND_S0IX:
+		/*
+		 * Currently, the only criterion for retaining the DSP in D0
+		 * is that there are streams that ignored the suspend trigger.
+		 * Additional criteria such Soundwire clock-stop mode and
+		 * device suspend latency considerations will be added later.
+		 */
+		if (snd_sof_stream_suspend_ignored(sdev))
+			target_dsp_state = SOF_DSP_PM_D0;
+		else
+			target_dsp_state = SOF_DSP_PM_D3;
+		break;
+	default:
+		/* This case would be during runtime suspend */
+		target_dsp_state = SOF_DSP_PM_D3;
+		break;
+	}
+
+	return target_dsp_state;
+}
+
 static int sof_send_pm_ctx_ipc(struct snd_sof_dev *sdev, int cmd)
 {
 	struct sof_ipc_pm_ctx pm_ctx;
@@ -169,7 +205,7 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 		}
 	}
 
-	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
+	if (snd_sof_dsp_power_target(sdev) == SOF_DSP_PM_D0) {
 		/* suspend to D0i3 */
 		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I3);
 		if (ret < 0) {
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 345e42ee4783..d16571ca129c 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -11,7 +11,7 @@
 #include "sof-audio.h"
 #include "ops.h"
 
-bool snd_sof_dsp_d0i3_on_suspend(struct snd_sof_dev *sdev)
+bool snd_sof_stream_suspend_ignored(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pcm *spcm;
 
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index a62fb2da6a6e..a2702afbd9a1 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -202,7 +202,7 @@ int snd_sof_ipc_set_get_comp_data(struct snd_sof_control *scontrol,
 /* PM */
 int sof_restore_pipelines(struct device *dev);
 int sof_set_hw_params_upon_resume(struct device *dev);
-bool snd_sof_dsp_d0i3_on_suspend(struct snd_sof_dev *sdev);
+bool snd_sof_stream_suspend_ignored(struct snd_sof_dev *sdev);
 
 /* Machine driver enumeration */
 int sof_machine_register(struct snd_sof_dev *sdev, void *pdata);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 1839cc51957d..a7c6109acd98 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -54,6 +54,16 @@ extern int sof_core_debug;
 	(IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE) || \
 	 IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST))
 
+/* DSP power state */
+enum sof_dsp_power_states {
+	SOF_DSP_PM_D0,
+	SOF_DSP_PM_D1,
+	SOF_DSP_PM_D2,
+	SOF_DSP_PM_D3_HOT,
+	SOF_DSP_PM_D3,
+	SOF_DSP_PM_D3_COLD,
+};
+
 /* DSP D0ix sub-state */
 enum sof_d0_substate {
 	SOF_DSP_D0I0 = 0,	/* DSP default D0 substate */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
