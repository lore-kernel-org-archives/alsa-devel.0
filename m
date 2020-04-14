Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BEC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:57:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A152076B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jjMkHTmP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDUnpX3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A152076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 374ED16B9;
	Tue, 14 Apr 2020 16:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 374ED16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586876247;
	bh=cJrGG4yiej9TCD9AKARgX2YIrPkIqSEEZI1+VbdzPvc=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=jjMkHTmPOwZovOYvX2l4ZQz4FA8IMK01YQjyOjlY6znfbiJ1kw477oGravgyMDQmY
	 Yg3mWMIiEPZzvC/Y4met+8Cbek3dTqxSPu9R8A/hBg2v6yoG+TjVAjNkt7MUqMcNeO
	 bQPr08Lqq2tbKHX4pNpgGZGYcglKTUarV3/QZpbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EB1DF80339;
	Tue, 14 Apr 2020 16:48:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16D4FF80332; Tue, 14 Apr 2020 16:47:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 659C1F80334
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:47:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 659C1F80334
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SDUnpX3s"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2A0B20578;
 Tue, 14 Apr 2020 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586875646;
 bh=cJrGG4yiej9TCD9AKARgX2YIrPkIqSEEZI1+VbdzPvc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=SDUnpX3sX7nVMDh1PeFH+AKvCO8Zw1hksbJPISukppA6s8SjATFTJHWJDXJtVklBu
 k52DU3X5MlrhUXECkITFwwu3hRzv6QDgpG0iT90Ja8ClVpP0Yb95Nk0eEalQWYznb1
 jGwMoC5l5P4OhubjNebjMqzWrNyyDxgXb1QAvb9k=
Date: Tue, 14 Apr 2020 15:47:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Applied "ASoC: Intel: sof_sdw_rt711: remove codec_dai use" to the
 asoc tree
In-Reply-To: <20200409185827.16255-14-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200409185827.16255-14-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

   ASoC: Intel: sof_sdw_rt711: remove codec_dai use

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

From 30e3edfbd1bf2f79287a5586508bb51f3fce5826 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 9 Apr 2020 13:58:27 -0500
Subject: [PATCH] ASoC: Intel: sof_sdw_rt711: remove codec_dai use

Use macro.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200409185827.16255-14-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_sdw_rt711.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
index 2a4917e3d561..8590a8a8889f 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711.c
@@ -71,7 +71,8 @@ static int rt711_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
-	struct snd_soc_component *component = rtd->codec_dai->component;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_component *component = codec_dai->component;
 	struct snd_soc_jack *jack;
 	int ret;
 
-- 
2.20.1

