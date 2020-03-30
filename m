Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6235DC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:33:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19B720786
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t8HiOrfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19B720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4369A15F2;
	Mon, 30 Mar 2020 16:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4369A15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585578824;
	bh=1kXTpX/yWwozFlgHWWi66FpvqsLhyioW/SMPlj9tlsw=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=t8HiOrfTXyVQW7DBLru5I7d41wSUMWs19aCihLUMvoUqgTcGmfJGqIBk/KAnaEED+
	 usZlEm0bs+GPNUDNJyTqptINjINE7YU4dxutbjk61tSHEaiVia8LTwss1DgOfgLhki
	 F7FAcsSQS86awM3Z+SvtfP48Jsz9pZ6ZGvpl7Lis=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE438F80148;
	Mon, 30 Mar 2020 16:32:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E90E6F80148; Mon, 30 Mar 2020 16:32:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3288CF800AA
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 16:32:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3288CF800AA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE42F1042;
 Mon, 30 Mar 2020 07:32:45 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5803F71E;
 Mon, 30 Mar 2020 07:32:45 -0700 (PDT)
Date: Mon, 30 Mar 2020 15:32:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Applied "ASoC: AMD: Clear format bits before setting them" to the
 asoc tree
In-Reply-To: <20200328093921.32211-1-akshu.agrawal@amd.com>
Message-Id: <applied-20200328093921.32211-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Cc: , "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>,
 Wei Yongjun <weiyongjun1@huawei.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

   ASoC: AMD: Clear format bits before setting them

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

From a91ab6509cd382dae4b7953155f47f276ff0d22f Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Sat, 28 Mar 2020 03:39:16 -0600
Subject: [PATCH] ASoC: AMD: Clear format bits before setting them

This avoids residual bit form previous format when the format is changed.
Hence, the resultant format is not an invalid one.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/20200328093921.32211-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-i2s.c | 1 +
 sound/soc/amd/raven/acp3x.h     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 3a3c47e820ab..f160d35a6832 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -139,6 +139,7 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
 		rv_writel(adata->tdm_fmt, rtd->acp3x_base + frmt_reg);
 	}
 	val = rv_readl(rtd->acp3x_base + reg_val);
+	val &= ~ACP3x_ITER_IRER_SAMP_LEN_MASK;
 	val = val | (rtd->xfer_resolution  << 3);
 	rv_writel(val, rtd->acp3x_base + reg_val);
 	return 0;
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 21e7ac017f2b..03fe93913e12 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -76,6 +76,8 @@
 #define ACP_POWERED_OFF			0x02
 #define ACP_POWER_OFF_IN_PROGRESS	0x03
 
+#define ACP3x_ITER_IRER_SAMP_LEN_MASK	0x38
+
 struct acp3x_platform_info {
 	u16 play_i2s_instance;
 	u16 cap_i2s_instance;
-- 
2.20.1

