Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB0C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:38:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E072077B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tP+Q+p8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E072077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90A4A1678;
	Tue, 10 Dec 2019 14:37:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90A4A1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575985125;
	bh=alERZKm4xDZvJXUVIomY39RT+eCXGmDaTZJ16Ev1HmY=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=tP+Q+p8CW4BtAdW2L/V19eoz5ZYbVK/AC/1FU0/Lmn7h1aGKn8t6TPvPU2GADr0GL
	 WbLLVaoDauLRFeqU73fY/MsIKnmaTgQPRl1Abt/D2/ssThfbTXQDApocjZCXwTFxUe
	 7PcJAug63N+g3RsUQJEWZxCU3NGP6JpEXPqYCjw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC05EF80252;
	Tue, 10 Dec 2019 14:23:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 441F6F80360; Tue, 10 Dec 2019 14:23:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 32D08F8035E
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32D08F8035E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803DB1396;
 Tue, 10 Dec 2019 05:23:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11633F52E;
 Tue, 10 Dec 2019 05:23:31 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
In-Reply-To: <20191210004854.16845-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191210004854.16845-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: loader: snd_sof_fw_parse_ext_data
	log warning on unknown header" to the asoc tree
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

   ASoC: SOF: loader: snd_sof_fw_parse_ext_data log warning on unknown header

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 8edc95667646a75f0fc97e08ecb180581fdff300 Mon Sep 17 00:00:00 2001
From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Date: Mon, 9 Dec 2019 18:48:48 -0600
Subject: [PATCH] ASoC: SOF: loader: snd_sof_fw_parse_ext_data log warning on
 unknown header

Added warning log when found some unknown FW boot ext header,
to improve debuggability.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210004854.16845-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 9a9a381a908d..a041adf0669d 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -66,6 +66,8 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
 			ret = get_ext_windows(sdev, ext_hdr);
 			break;
 		default:
+			dev_warn(sdev->dev, "warning: unknown ext header type %d size 0x%x\n",
+				 ext_hdr->type, ext_hdr->hdr.size);
 			break;
 		}
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
