Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A8CC2D0ED
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E34F208FE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S1RBea7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E34F208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F991167E;
	Thu, 26 Mar 2020 20:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F991167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585249705;
	bh=RzuPgjygFV+hNHdJVK4js4n2zi11qUPG+8EYzegSePM=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=S1RBea7hwnU5JkDOn3AVOf9jnIJbVz9Kc6++rVFRoE0PNLMfhHOoKm6+4ZVigigoV
	 /ATm69icEadTNbw+1mVUOH8xgIp+0KL889j01F8abbgzHCvwTCgKXsHrIgfUhTlkAN
	 6aM6IRtQXd5DVCraUruEuvWRpYyDvFY8dXowWSAA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47B59F802A0;
	Thu, 26 Mar 2020 20:05:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F0F5F80299; Thu, 26 Mar 2020 20:05:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2DE37F8028C
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 20:05:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DE37F8028C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCEB7FA;
 Thu, 26 Mar 2020 12:05:02 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4EE43F71F;
 Thu, 26 Mar 2020 12:05:01 -0700 (PDT)
Date: Thu, 26 Mar 2020 19:05:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: call codec wake at chip init" to the
 asoc tree
In-Reply-To: <20200325211233.27394-6-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200325211233.27394-6-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

The patch

   ASoC: SOF: Intel: hda: call codec wake at chip init

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

From 7e26df0ced1643679922d197e798d469ac3bf9c0 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Wed, 25 Mar 2020 16:12:33 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: call codec wake at chip init

Further align HDA init sequence to the legacy non-DSP HDA driver by
calling snd_hdac_set_codec_wakeup() during the chip init sequence.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200325211233.27394-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 93be6fc51ccd..f88dbcc4ba66 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
+#include <sound/hda_component.h>
 #include "../ops.h"
 #include "hda.h"
 
@@ -176,6 +177,9 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 	if (bus->chip_init)
 		return 0;
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	snd_hdac_set_codec_wakeup(bus, true);
+#endif
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
 
 	if (full_reset) {
@@ -271,6 +275,9 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 
 err:
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	snd_hdac_set_codec_wakeup(bus, false);
+#endif
 
 	return ret;
 }
-- 
2.20.1

