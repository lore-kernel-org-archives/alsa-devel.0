Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD64C3524E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8DC24654
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EbJ+BxbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8DC24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8093616A9;
	Wed, 19 Feb 2020 22:04:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8093616A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146311;
	bh=P1KLjcew85w8PQETBMaRQ3uvyYL6+OFP9x9C9RSn9KU=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=EbJ+BxbMYK4lZJUQUkih88eIxczrRGtRsCX3vWnpklSEpDH4dpWnDNJDA4wdHeiOL
	 DBXDTpWMeM6nFiPeeIagkJWukeZoUaZ/1c/AKVjVCCpQMDkQnC5QOgI9YGtP6ypbE6
	 LewgiO01W5w1uPMBY/N+iP1PGKpQUbp50Lpa05ZE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 627A4F8025F;
	Wed, 19 Feb 2020 21:57:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D426F80307; Wed, 19 Feb 2020 21:57:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0B658F802FE
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B658F802FE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B781FB;
 Wed, 19 Feb 2020 12:57:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B36D3F68F;
 Wed, 19 Feb 2020 12:57:40 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soundwaire: qcom: use for_each_rtd_codec_dai() macro"
 to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200219205738.ToijVc-KbFz4GFRXfjb8M9oUzKKNg7sAIuZOJ9PyyJI@z>

The patch

   ASoC: soundwaire: qcom: use for_each_rtd_codec_dai() macro

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

From ce83baca8526689c332135c0abca2667ba056009 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Feb 2020 15:55:53 +0900
Subject: [PATCH] ASoC: soundwaire: qcom: use for_each_rtd_codec_dai() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87o8tvjcbc.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/soundwire/qcom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 1c6c6a2e0def..fb30bbec999a 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -594,6 +594,7 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sdw_stream_runtime *sruntime;
+	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
 	sruntime = sdw_alloc_stream(dai->name);
@@ -602,12 +603,12 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 
 	ctrl->sruntime[dai->id] = sruntime;
 
-	for (i = 0; i < rtd->num_codecs; i++) {
-		ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sruntime,
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		ret = snd_soc_dai_set_sdw_stream(codec_dai, sruntime,
 						 substream->stream);
 		if (ret < 0 && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "Failed to set sdw stream on %s",
-				rtd->codec_dais[i]->name);
+				codec_dai->name);
 			sdw_release_stream(sruntime);
 			return ret;
 		}
-- 
2.20.1

