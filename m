Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91767C3F2CD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:41:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D95E2166E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nxAewuyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D95E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C35B16A1;
	Mon,  2 Mar 2020 15:40:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C35B16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583160065;
	bh=65nNxJt98EcETgcJkdrZ+MLMgSnKA9fJr9zC/FzyWzc=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=nxAewuyI+GSNF2dlwVa/Z/j3DDmlHzuer2FwkEaiD0Es2tizfNiCnwFQf6EO0foI6
	 EwHE9yEaM6coXNXIysrE65BtRUUGK4jEnVyAlA1bB7ol+PQ3LzK405Ghiiqy4g2DOs
	 ZV+01t6m5uBfD9aUF/ixaBV4aGLsXkGffgF19IDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63128F8028D;
	Mon,  2 Mar 2020 15:37:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33FEDF80291; Mon,  2 Mar 2020 15:37:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 48701F8028D
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 15:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48701F8028D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF80D2F;
 Mon,  2 Mar 2020 06:37:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D333F534;
 Mon,  2 Mar 2020 06:37:14 -0800 (PST)
Date: Mon, 02 Mar 2020 14:37:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Tomasz Lauda <tomasz.lauda@linux.intel.com>
Subject: Applied "ASoC: SOF: add core id to sof_ipc_comp" to the asoc tree
In-Reply-To: <20200228231850.9226-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200228231850.9226-5-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: add core id to sof_ipc_comp

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

From 1a2289fdf678b780b2d68f408523c09b7074982e Mon Sep 17 00:00:00 2001
From: Tomasz Lauda <tomasz.lauda@linux.intel.com>
Date: Fri, 28 Feb 2020 17:18:50 -0600
Subject: [PATCH] ASoC: SOF: add core id to sof_ipc_comp

Adds core id to sof_ipc_comp. The intention of this change
is to inform FW on which core that particular component
should run. Right now core id is only passed when pipeline
is created, which is not flexible enough and doesn't allow
for FW to handle this the right way.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Tomasz Lauda <tomasz.lauda@linux.intel.com>
Link: https://lore.kernel.org/r/20200228231850.9226-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/topology.h | 3 ++-
 include/uapi/sound/sof/abi.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 8e76178fedf0..402e0250c508 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -53,9 +53,10 @@ struct sof_ipc_comp {
 	uint32_t id;
 	enum sof_comp_type type;
 	uint32_t pipeline_id;
+	uint32_t core;
 
 	/* reserved for future use */
-	uint32_t reserved[2];
+	uint32_t reserved[1];
 } __packed;
 
 /*
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index c0ef1643c753..5995b79d6df1 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 12
+#define SOF_ABI_MINOR 13
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
-- 
2.20.1

