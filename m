Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36675C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:16:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF76621D7D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WR7YHqCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3A5A1667;
	Wed, 18 Dec 2019 21:15:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3A5A1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576700209;
	bh=onLeQ/5CjZkC3jcihb0DKJu90hiphZP4EQA44LKsYMo=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=WR7YHqCf158+xSUi5EDses7YwbHQfMD4Lc9wCwr6H/g3tUhCKRERLI2H4FnSCpRk/
	 aakLk3d2x96uW4gypmVK7T4xXYAfvZzgjPA8ljgHAzfXDPhwbGKIS64LoET31ivPhD
	 EzTglK75qT9qW8Bz8HKSr+HDHtR62UGRxpirHUrQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4070F8033E;
	Wed, 18 Dec 2019 21:06:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D40F8F80331; Wed, 18 Dec 2019 21:06:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 19724F80306
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19724F80306
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467DE1396;
 Wed, 18 Dec 2019 12:06:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B493F67D;
 Wed, 18 Dec 2019 12:06:04 -0800 (PST)
Date: Wed, 18 Dec 2019 20:06:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
In-Reply-To: <20191218002616.7652-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191218002616.7652-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: define struct with compiler name
	and version" to the asoc tree
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

   ASoC: SOF: define struct with compiler name and version

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

From e8b7cab8cec3386598de29bbca70d8d31aacc709 Mon Sep 17 00:00:00 2001
From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Date: Tue, 17 Dec 2019 18:26:10 -0600
Subject: [PATCH] ASoC: SOF: define struct with compiler name and version

Add compiler information structure sof_ipc_cc_version.
Add new enum value in sof_ipc_ext_data for new structure.
This struct will be used to show more information about firmware
in host system. It will be helpful during debugging.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191218002616.7652-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/info.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index a9156b4a062c..1c560144996c 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -30,6 +30,7 @@
 enum sof_ipc_ext_data {
 	SOF_IPC_EXT_DMA_BUFFER = 0,
 	SOF_IPC_EXT_WINDOW,
+	SOF_IPC_EXT_CC_INFO,
 };
 
 /* FW version - SOF_IPC_GLB_VERSION */
@@ -115,4 +116,18 @@ struct sof_ipc_window {
 	struct sof_ipc_window_elem window[];
 }  __packed;
 
+struct sof_ipc_cc_version {
+	struct sof_ipc_ext_data_hdr ext_hdr;
+	uint32_t major;
+	uint32_t minor;
+	uint32_t micro;
+
+	/* reserved for future use */
+	uint32_t reserved[4];
+
+	char name[16]; /* null terminated compiler name */
+	char optim[4]; /* null terminated compiler -O flag value */
+	char desc[]; /* null terminated compiler description */
+} __packed;
+
 #endif
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
