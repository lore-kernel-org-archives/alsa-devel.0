Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC6AC3F2CD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:38:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BC21775
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MR81CQW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BC21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2A5A1683;
	Mon,  2 Mar 2020 15:37:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2A5A1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583159932;
	bh=+9oF1zZoYnvddeA35g9qY7GcZxtKtbT7C4WpHm5AJTU=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=MR81CQW9lEV5YpYxE18XYELBXT1gNjc7/JBCWvF3v8a2DwZo1HNSE3a763dJakCRW
	 RXqDgZ1XRrSjoAmsguP9CpAoyGkciaGJ7OqBnhLPLhk6RbPjxPvvXYPaNgo0c8l1oH
	 Q21M7cOiXYlZA1zZwUxzD/nKdwQTeWdl7UBGdSDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 697C9F801ED;
	Mon,  2 Mar 2020 15:37:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 571D0F801ED; Mon,  2 Mar 2020 15:37:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 34DE3F800E5
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 15:37:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34DE3F800E5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB6D2F;
 Mon,  2 Mar 2020 06:37:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1D893F534;
 Mon,  2 Mar 2020 06:37:00 -0800 (PST)
Date: Mon, 02 Mar 2020 14:36:59 +0000
From: Mark Brown <broonie@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: rt1015: set snd_soc_dai_ops in rt1015_dai driver" to
 the asoc tree
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
Message-ID: <20200302143659.ipaaL6TQOWhUSiAswRNLnM7st-PMLMV7FmiKzstnnPM@z>

The patch

   ASoC: rt1015: set snd_soc_dai_ops in rt1015_dai driver

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

From a79ee2e095c0a60c32d5b1fce39d58e0fc4d9ec5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 2 Mar 2020 15:05:22 +0800
Subject: [PATCH] ASoC: rt1015: set snd_soc_dai_ops in rt1015_dai driver

snd_soc_dai_driver should set ops in rt1015_dai driver.
Also make the two variable static to fix sparse warnings.

Fixes: df31007400c3 ("ASoC: rt1015: add rt1015 amplifier driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200302070522.48104-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1015.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index c118d030bd2d..100b8c89d537 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -857,6 +857,7 @@ static struct snd_soc_dai_driver rt1015_dai[] = {
 			.rates = RT1015_STEREO_RATES,
 			.formats = RT1015_FORMATS,
 		},
+		.ops    = &rt1015_aif_dai_ops,
 	}
 };
 
-- 
2.20.1

