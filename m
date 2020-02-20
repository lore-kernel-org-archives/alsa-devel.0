Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B55BC11D00
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 22:21:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FB2208CD
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lZpIzC5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FB2208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7056C16BE;
	Thu, 20 Feb 2020 23:20:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7056C16BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582237290;
	bh=+zKm1tUdGSsvuH3shu5fP3OUFzb9BuzSM3WNQ6rDguo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=lZpIzC5iNNpKD+pEehpHunWyqj9chdTTyYf4jhuAfBPfw7TldXMTloYMcJxc/VsIK
	 d63KnK5YKOgC+S35siLaj3CMrd6/9BhvtVDgTqPSt4YXSQ/TWV+y2FIJ1BMcMTxXeA
	 58ErvrEIc1YfhQUyD2sgTyPHhjMKGb4eFUQIGT8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55E00F80292;
	Thu, 20 Feb 2020 23:18:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96272F80299; Thu, 20 Feb 2020 23:18:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A748F80290
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 23:18:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A748F80290
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523BC1045;
 Thu, 20 Feb 2020 14:18:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1763F6CF;
 Thu, 20 Feb 2020 14:18:45 -0800 (PST)
Date: Thu, 20 Feb 2020 22:18:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: allow operation without i915 gfx" to
 the asoc tree
In-Reply-To: <20200220171028.22023-3-kai.vehmanen@linux.intel.com>
Message-Id: <applied-20200220171028.22023-3-kai.vehmanen@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com, tiwai@suse.de,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Mark Brown <broonie@kernel.org>
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

   ASoC: SOF: Intel: hda: allow operation without i915 gfx

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

From 71cc8abb6ec705ce4efbb54e401004687d40a641 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Thu, 20 Feb 2020 19:10:28 +0200
Subject: [PATCH] ASoC: SOF: Intel: hda: allow operation without i915 gfx

Add support to configure the HDA controller with an external HDA
codec even if iDisp codec in i915 is not available.

This can happen for multiple reasons:
 - internal graphics is disabled on the system
 - i915 driver is not enabled in kernel or it fails to init
 - i915 codec reports error in HDA codec probe
 - HDA codec driver probe fails

Address all these scenarios, but keep using the existing topology.
In case failures occur, HDMI PCM nodes are created, but they will
report error if application tries to use them. No ALSA mixer controls
are created. If the external HDA codec init fails as well, SOF probe
will return error as before.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206085
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1163677
BugLink: https://github.com/thesofproject/linux/issues/1658
Link: https://lore.kernel.org/r/20200220171028.22023-3-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 11 ++++++++++-
 sound/soc/sof/intel/hda.c       | 22 ++++++++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index ff45075ef720..3041fbbb010a 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -113,8 +113,14 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 	if (ret < 0)
 		return ret;
 
-	if ((resp & 0xFFFF0000) == IDISP_VID_INTEL)
+	if ((resp & 0xFFFF0000) == IDISP_VID_INTEL) {
+		if (!hdev->bus->audio_component) {
+			dev_dbg(sdev->dev,
+				"iDisp hw present but no driver\n");
+			return -ENOENT;
+		}
 		hda_priv->need_display_power = true;
+	}
 
 	/*
 	 * if common HDMI codec driver is not used, codec load
@@ -203,6 +209,9 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	int ret;
 
+	if (!bus->audio_component)
+		return 0;
+
 	/* power down unconditionally */
 	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 726a9ef2d627..7ca887041a34 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -288,10 +288,8 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* init i915 and HDMI codecs */
 	ret = hda_codec_i915_init(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: init i915 and HDMI codec failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_warn(sdev->dev, "init of i915 and HDMI codec failed\n");
 
 	/* get controller capabilities */
 	ret = hda_dsp_ctrl_get_caps(sdev);
@@ -365,9 +363,6 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(bus->dev, "error: init chip failed with ret: %d\n",
 			ret);
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-		hda_codec_i915_exit(sdev);
-#endif
 		return ret;
 	}
 
@@ -379,7 +374,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	hda_codec_probe_bus(sdev, hda_codec_use_common_hdmi);
 
 	if (!HDA_IDISP_CODEC(bus->codec_mask))
-		hda_codec_i915_exit(sdev);
+		hda_codec_i915_display_power(sdev, false);
 
 	/*
 	 * we are done probing so decrement link counts
@@ -699,12 +694,11 @@ static int hda_generic_machine_select(struct snd_sof_dev *sdev)
 		/*
 		 * If no machine driver is found, then:
 		 *
-		 * hda machine driver is used if :
-		 * 1. there is one HDMI codec and one external HDAudio codec
-		 * 2. only HDMI codec
+		 * generic hda machine driver can handle:
+		 *  - one HDMI codec, and/or
+		 *  - one external HDAudio codec
 		 */
-		if (!pdata->machine && codec_num <= 2 &&
-		    HDA_IDISP_CODEC(bus->codec_mask)) {
+		if (!pdata->machine && codec_num <= 2) {
 			hda_mach = snd_soc_acpi_intel_hda_machines;
 
 			/* topology: use the info from hda_machines */
@@ -714,7 +708,7 @@ static int hda_generic_machine_select(struct snd_sof_dev *sdev)
 			dev_info(bus->dev, "using HDA machine driver %s now\n",
 				 hda_mach->drv_name);
 
-			if (codec_num == 1)
+			if (codec_num == 1 && HDA_IDISP_CODEC(bus->codec_mask))
 				idisp_str = "-idisp";
 			else
 				idisp_str = "";
-- 
2.20.1

