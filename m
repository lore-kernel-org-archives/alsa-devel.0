Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7DC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:27:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AF8206FA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="amp6Xqii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF8206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0443184B;
	Fri, 13 Mar 2020 17:26:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0443184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116862;
	bh=NYte44uwGPjehLhbAFQ1nIPqqJni6wzMWROaN5Uq+5w=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=amp6XqiiFnYhhCCwv8hatOyRfVUsiU3/ZfIAkPRc9EVlQ2dqPbkCZggHubZkZ+418
	 2n2LkLtSy32iIa7158CbFJRK++1O6t9x7WgRJODegtATddWcoCaKAfPGdcVQOawecX
	 PKhFVbKSdLgJ0YKE8Q8EnqlUKeTioD03hu6sAC1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B31E6F80335;
	Fri, 13 Mar 2020 17:19:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF6DAF80307; Fri, 13 Mar 2020 17:18:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 79B4BF802FD
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:18:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79B4BF802FD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA5DFEC;
 Fri, 13 Mar 2020 09:18:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41C5A3F6CF;
 Fri, 13 Mar 2020 09:18:19 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:18:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Amery Song <chao.song@intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: remove unnecessary ROM IPC filter
 function" to the asoc tree
In-Reply-To: <20200312200622.24477-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200312200622.24477-5-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

   ASoC: SOF: Intel: hda: remove unnecessary ROM IPC filter function

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

From 9b65b2a80e700c0dbc5c554d198e50a9e798a6d0 Mon Sep 17 00:00:00 2001
From: Amery Song <chao.song@intel.com>
Date: Thu, 12 Mar 2020 15:06:20 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: remove unnecessary ROM IPC filter
 function

The HDA_DSP_IPC_PURGE_FW IPC from ROM is already handled in
cl_dsp_init(), and as IPC IRQ is disabled at this stage, this
IPC will be never received in the IRQ thread. The function
hda_dsp_ipc_is_sof for filtering the ROM IPC can be removed
safely.

Signed-off-by: Amery Song <chao.song@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Keyon <yang.jie@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200312200622.24477-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-ipc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 922052883b0a..a60528495551 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -125,12 +125,6 @@ void hda_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 
 }
 
-static bool hda_dsp_ipc_is_sof(uint32_t msg)
-{
-	return (msg & (HDA_DSP_IPC_PURGE_FW | 0xf << 9)) != msg ||
-		(msg & HDA_DSP_IPC_PURGE_FW) != HDA_DSP_IPC_PURGE_FW;
-}
-
 /* IPC handler thread */
 irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 {
@@ -176,11 +170,9 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 		 */
 		spin_lock_irq(&sdev->ipc_lock);
 
-		/* handle immediate reply from DSP core - ignore ROM messages */
-		if (hda_dsp_ipc_is_sof(msg)) {
-			hda_dsp_ipc_get_reply(sdev);
-			snd_sof_ipc_reply(sdev, msg);
-		}
+		/* handle immediate reply from DSP core */
+		hda_dsp_ipc_get_reply(sdev);
+		snd_sof_ipc_reply(sdev, msg);
 
 		/* wake up sleeper if we are loading code */
 		if (sdev->code_loading)	{
-- 
2.20.1

