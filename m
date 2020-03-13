Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4BBC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:28:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6C9206FA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OEd+xlzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6C9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DECBA1860;
	Fri, 13 Mar 2020 17:27:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DECBA1860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116916;
	bh=cndZifNVO5EnBxS4STcT+NKRPohcXjP4qV9ERQ/Uu9o=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=OEd+xlzs3LYdkLQHRIV2hr1vDWn6YFh7xpVmwG31FSvxIlvXU9bl9R22i98WLV6z5
	 9CfFNd0PMJnetmv4lkx2ft2DvBiJqs5U0Ndzt5MYMi2mK3bvKaoOPnu9gth5vjK2Y1
	 ecYnZxi3O29aFvFfuWKnvPi59yC3oSrcaatz7078=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4171F80345;
	Fri, 13 Mar 2020 17:19:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F6D3F80323; Fri, 13 Mar 2020 17:18:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4E8ABF80317
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:18:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E8ABF80317
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974051045;
 Fri, 13 Mar 2020 09:18:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D40C3F6CF;
 Fri, 13 Mar 2020 09:18:27 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:18:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Subject: Applied "ASoC: SOF: Make sof_ipc_ext_data enum more rigid" to the
 asoc tree
In-Reply-To: <20200312200622.24477-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200312200622.24477-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Make sof_ipc_ext_data enum more rigid

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

From 4ea25785259a9e7a542a5e8ceb8b208ae6929739 Mon Sep 17 00:00:00 2001
From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Date: Thu, 12 Mar 2020 15:06:18 -0500
Subject: [PATCH] ASoC: SOF: Make sof_ipc_ext_data enum more rigid

It's a part of ABI interface, so enum value shouldn't change
for example after removing some old enum code.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200312200622.24477-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/info.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index 1c560144996c..cc3b50b6ae52 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -28,9 +28,9 @@
 
 /* extended data types that can be appended onto end of sof_ipc_fw_ready */
 enum sof_ipc_ext_data {
-	SOF_IPC_EXT_DMA_BUFFER = 0,
-	SOF_IPC_EXT_WINDOW,
-	SOF_IPC_EXT_CC_INFO,
+	SOF_IPC_EXT_DMA_BUFFER		= 0,
+	SOF_IPC_EXT_WINDOW		= 1,
+	SOF_IPC_EXT_CC_INFO		= 2,
 };
 
 /* FW version - SOF_IPC_GLB_VERSION */
-- 
2.20.1

