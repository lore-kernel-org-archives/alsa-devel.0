Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BDC3F2D1
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:42:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877D82166E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VDKAFFfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877D82166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF48A16AF;
	Mon,  2 Mar 2020 15:41:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF48A16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583160127;
	bh=0T2GeZbNOfhVuYOUKHaTcYNYH0FKdcxlUtAVHb9X5s0=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VDKAFFfFNPimCYBC0ojA2yPODBF2e9kD61NUCk1ErMlW0AkkLfqaohLmUBtr89AKJ
	 QixtIf+d9oqgj6ffJKdATIJ1srTzgqceEVmnXXU5CFx+WBhR05aBbS9k163nWFtRCL
	 G9qtWLQQYPI0AlRTHcKS/0iJc1VNbbBCQErHT2ug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4B27F802A2;
	Mon,  2 Mar 2020 15:37:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AABAFF80299; Mon,  2 Mar 2020 15:37:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D3FC8F80292
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 15:37:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3FC8F80292
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE75F2F;
 Mon,  2 Mar 2020 06:37:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530933F534;
 Mon,  2 Mar 2020 06:37:23 -0800 (PST)
Date: Mon, 02 Mar 2020 14:37:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Subject: Applied "ASoC: SOF: ipc: check ipc return value before data copy" to
 the asoc tree
In-Reply-To: <20200228231850.9226-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200228231850.9226-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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

   ASoC: SOF: ipc: check ipc return value before data copy

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

From 1919b42ca4ad75a2397081164661af3ce5a7b8f4 Mon Sep 17 00:00:00 2001
From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Date: Fri, 28 Feb 2020 17:18:48 -0600
Subject: [PATCH] ASoC: SOF: ipc: check ipc return value before data copy

In tx_wait_done the ipc payload is copied before the DSP transaction
error code is checked. This might lead to corrupted data in kernel side
even though the error would be handled later. It is also pointless to
copy the data in case of error. So change the order of error check and
copy.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Link: https://lore.kernel.org/r/20200228231850.9226-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 22d296f95761..cc5762706c9c 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -214,15 +214,17 @@ static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
 		snd_sof_handle_fw_exception(ipc->sdev);
 		ret = -ETIMEDOUT;
 	} else {
-		/* copy the data returned from DSP */
 		ret = msg->reply_error;
-		if (msg->reply_size)
-			memcpy(reply_data, msg->reply_data, msg->reply_size);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(sdev->dev, "error: ipc error for 0x%x size %zu\n",
 				hdr->cmd, msg->reply_size);
-		else
+		} else {
 			ipc_log_header(sdev->dev, "ipc tx succeeded", hdr->cmd);
+			if (msg->reply_size)
+				/* copy the data returned from DSP */
+				memcpy(reply_data, msg->reply_data,
+				       msg->reply_size);
+		}
 	}
 
 	return ret;
-- 
2.20.1

