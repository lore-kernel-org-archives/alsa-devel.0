Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90638C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:52:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1911624649
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pYw/tqw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911624649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61469851;
	Tue, 10 Mar 2020 14:51:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61469851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583848329;
	bh=MnbKE3+8+yRHBSr9ea+uJWhvu++UWbY8ieJZgBJB2L8=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=pYw/tqw+wGSNNUsnZevSO0PDX3/C89zfLUzK6QAvVE9WA1k5AHHwvM7KDl52kiwZf
	 jCNSg7+tM8k01A49LJ4wb09pltHMsDTMq89RIS+XHGz/ERcp0FllKxQpYRH8137YuM
	 2cMnQA805B2vvyAnFz9Gmb4ue3KzfoTCO4GuzDrA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAA9FF80217;
	Tue, 10 Mar 2020 14:51:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF983F80217; Tue, 10 Mar 2020 14:51:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E871CF80123
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 14:51:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E871CF80123
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9C330E;
 Tue, 10 Mar 2020 06:51:11 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DAF3F6CF;
 Tue, 10 Mar 2020 06:51:11 -0700 (PDT)
Date: Tue, 10 Mar 2020 13:51:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: SOF: Fix probe point getter" to the asoc tree
In-Reply-To: <20200309142124.29262-1-cezary.rojewski@intel.com>
Message-Id: <applied-20200309142124.29262-1-cezary.rojewski@intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Fix probe point getter

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

From a3b7343e3f8c4c74516df41827b6d81905e346a1 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Mon, 9 Mar 2020 15:21:24 +0100
Subject: [PATCH] ASoC: SOF: Fix probe point getter

Firmware API changes which introduced 'num_elems' param in several probe
structs such as sof_ipc_probe_dma_add_params also impacted getter for
both, DMA and probe points. All struct handlers except for
sof_ipc_probe_info_params have been updated. Align said handler too to
calculate payload size correctly.

Fixes: f3b433e4699f ("ASoC: SOF: Implement Probe IPC API")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200309142124.29262-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/probe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/probe.c b/sound/soc/sof/probe.c
index 2b2f3dcfc7e9..c38169fe00c5 100644
--- a/sound/soc/sof/probe.c
+++ b/sound/soc/sof/probe.c
@@ -95,13 +95,17 @@ static int sof_ipc_probe_info(struct snd_sof_dev *sdev, unsigned int cmd,
 	if (!reply->num_elems)
 		goto exit;
 
-	bytes = reply->num_elems * sizeof(reply->dma[0]);
+	if (cmd == SOF_IPC_PROBE_DMA_INFO)
+		bytes = sizeof(reply->dma[0]);
+	else
+		bytes = sizeof(reply->desc[0]);
+	bytes *= reply->num_elems;
 	*params = kmemdup(&reply->dma[0], bytes, GFP_KERNEL);
 	if (!*params) {
 		ret = -ENOMEM;
 		goto exit;
 	}
-	*num_params = msg.num_elems;
+	*num_params = reply->num_elems;
 
 exit:
 	kfree(reply);
-- 
2.20.1

