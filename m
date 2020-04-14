Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE952C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C74520768
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cgi9s6a5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuIb20jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C74520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAFBA1709;
	Tue, 14 Apr 2020 17:09:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAFBA1709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586877015;
	bh=xIr41tO/7fIbW7ZCrk2TbWX51nkE56ASJpFWD/S9mY4=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Cgi9s6a5kVO5lOWIBLDK3HPDEcS1Im+eiXMYxkSBVfTJd5lPIhPFuLFgZLO80oexL
	 Bo+cny+5NdYrOM8YRmQWBUcn9Cf81vSnPydakN85WQgUok6cOIbl0obD5R62fGfTZl
	 yygxyCGdhvtLAKF7whSfKzIy4lyjWHnUCqnOHb8A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9CA5F80443;
	Tue, 14 Apr 2020 16:49:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FDD7F80444; Tue, 14 Apr 2020 16:49:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77111F8043B
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77111F8043B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XuIb20jf"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9707E2076D;
 Tue, 14 Apr 2020 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586875760;
 bh=xIr41tO/7fIbW7ZCrk2TbWX51nkE56ASJpFWD/S9mY4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=XuIb20jfB34UZQ6ABweJElk3kIeLv+cjWkjUixThGT4bf4v358SydZ3sqEsmUj7fN
 MNBaN4LivZtxLWCNHAmqLgUrzCom9HqS/afqN5+nOzbu2dCmdZI6IIc0RMETE0T9Tf
 75A9v1E0hjbf6oWPXwjPHynrzHo7/73RUYBMD5C0=
Date: Tue, 14 Apr 2020 15:49:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Subject: Applied "ASoC: SOF: remove unneeded variables" to the asoc tree
In-Reply-To: <20200409184853.15896-2-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200409184853.15896-2-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: remove unneeded variables

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

From 1d03c19e970e7457b755d736a81e9e8601e1a407 Mon Sep 17 00:00:00 2001
From: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Date: Thu, 9 Apr 2020 13:48:52 -0500
Subject: [PATCH] ASoC: SOF: remove unneeded variables

Remove unneeded temporary local variables and their declarations.
Change suggested by coccinelle.

Signed-off-by: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200409184853.15896-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 5 +----
 sound/soc/sof/nocodec.c         | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 3041fbbb010a..7e7e296a3953 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -207,7 +207,6 @@ EXPORT_SYMBOL_NS(hda_codec_i915_init, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
-	int ret;
 
 	if (!bus->audio_component)
 		return 0;
@@ -215,9 +214,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 	/* power down unconditionally */
 	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 
-	ret = snd_hdac_i915_exit(bus);
-
-	return ret;
+	return snd_hdac_i915_exit(bus);
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index 2233146386cc..5bf67b2aa4e7 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -66,7 +66,6 @@ int sof_nocodec_setup(struct device *dev,
 		      const struct snd_sof_dsp_ops *ops)
 {
 	struct snd_soc_dai_link *links;
-	int ret;
 
 	/* create dummy BE dai_links */
 	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
@@ -74,9 +73,8 @@ int sof_nocodec_setup(struct device *dev,
 	if (!links)
 		return -ENOMEM;
 
-	ret = sof_nocodec_bes_setup(dev, ops, links, ops->num_drv,
-				    &sof_nocodec_card);
-	return ret;
+	return sof_nocodec_bes_setup(dev, ops, links, ops->num_drv,
+				     &sof_nocodec_card);
 }
 EXPORT_SYMBOL(sof_nocodec_setup);
 
-- 
2.20.1

