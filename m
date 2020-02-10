Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC182C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:17:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DD820714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d/L0Yz0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DD820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA77D1699;
	Mon, 10 Feb 2020 15:08:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA77D1699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581343737;
	bh=xwqtipwTRm0soBKRLMeHgKlfTpdF5oqeJexmZPJd2FE=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=d/L0Yz0+Ni2PJZZ/0B0Ls4olun6K0ddu6ySuq90JsPlEYruMwT5RUXaHzs+TapMWC
	 /Fy1NgseNS9IKmhjyrNLkctQRr1CYjzu1zwU1gFEFgxrElXGhI2UYi6t0Z+E1QZWUK
	 ttdyNq7PckKMbDZpOz740gPbvSMUKXxsdo5OCHcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76D4AF8020B;
	Mon, 10 Feb 2020 15:07:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95CE9F8020B; Mon, 10 Feb 2020 15:07:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id B9D96F800FD
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9D96F800FD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D265031B;
 Mon, 10 Feb 2020 06:07:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A433F68E;
 Mon, 10 Feb 2020 06:07:27 -0800 (PST)
Date: Mon, 10 Feb 2020 14:07:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20200206200223.7715-3-kai.vehmanen@linux.intel.com>
Message-Id: <applied-20200206200223.7715-3-kai.vehmanen@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com
Subject: [alsa-devel] Applied "ASoC: SOF: Intel: hda: move i915 init
	earlier" to the asoc tree
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

   ASoC: SOF: Intel: hda: move i915 init earlier

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From af7aae1b1f6306a1cda4da393e920a1334eaa3d4 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Thu, 6 Feb 2020 22:02:23 +0200
Subject: [PATCH] ASoC: SOF: Intel: hda: move i915 init earlier

To be compliant with i915 display driver requirements, i915 power-up
must be done before any HDA communication takes place, including
parsing the bus capabilities. Otherwise the initial codec probe
may fail.

Move i915 initialization earlier in the SOF HDA sequence. This
sequence is now aligned with the snd-hda-intel driver where the
display_power() call is before snd_hdac_bus_parse_capabilities()
and rest of the capability parsing.

Also remove unnecessary ifdef around hda_codec_i915_init(). There's
a dummy implementation provided if CONFIG_SND_SOC_SOF_HDA is not
enabled.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200206200223.7715-3-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 8fddafb5c1d4..25946a1c2822 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -286,6 +286,13 @@ static int hda_init(struct snd_sof_dev *sdev)
 	/* HDA base */
 	sdev->bar[HDA_DSP_HDA_BAR] = bus->remap_addr;
 
+	/* init i915 and HDMI codecs */
+	ret = hda_codec_i915_init(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: init i915 and HDMI codec failed\n");
+		return ret;
+	}
+
 	/* get controller capabilities */
 	ret = hda_dsp_ctrl_get_caps(sdev);
 	if (ret < 0)
@@ -353,15 +360,6 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	if (bus->ppcap)
 		dev_dbg(sdev->dev, "PP capability, will probe DSP later.\n");
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* init i915 and HDMI codecs */
-	ret = hda_codec_i915_init(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: init i915 and HDMI codec failed\n");
-		return ret;
-	}
-#endif
-
 	/* Init HDA controller after i915 init */
 	ret = hda_dsp_ctrl_init_chip(sdev, true);
 	if (ret < 0) {
@@ -611,6 +609,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	iounmap(sdev->bar[HDA_DSP_BAR]);
 hdac_bus_unmap:
 	iounmap(bus->remap_addr);
+	hda_codec_i915_exit(sdev);
 err:
 	return ret;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
