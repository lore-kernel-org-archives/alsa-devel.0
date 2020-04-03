Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E6C2BA18
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:42:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E9F207FF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UpELrsQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D0921674;
	Fri,  3 Apr 2020 15:41:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D0921674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585921323;
	bh=RdP/oJgLag3mwVzhkIGZUVkKsaYlkeApB9xMRgx/gZo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=UpELrsQuSgvUKtdEF2xKxLHdDKvcNXNrnv9E4hQOCEu5coL7Mj2n5R0MDSFjzwsZU
	 ZLCkmSsYu3yt1aIC2O+cE4+ER8RmrUHXjaEgGKLAc9VojRfCfBQ2TBa4cJGIXUrdw8
	 L53ElqPM7M8xSJtvX3T5uS7w6zRtV1mWpXREsJzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58879F8021E;
	Fri,  3 Apr 2020 15:40:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9DC5F8014C; Fri,  3 Apr 2020 15:40:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5D93AF800E4
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2020 15:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D93AF800E4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDEF7FA;
 Fri,  3 Apr 2020 06:40:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828163F68F;
 Fri,  3 Apr 2020 06:40:14 -0700 (PDT)
Date: Fri, 03 Apr 2020 14:40:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Applied "ASoC: Intel: atom: Check drv->lock is locked in
 sst_fill_and_send_cmd_unlocked" to the asoc tree
In-Reply-To: <20200402185359.3424-2-hdegoede@redhat.com>
Message-Id: <applied-20200402185359.3424-2-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, shumingf@realtek.com, flove@realtek.com
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

   ASoC: Intel: atom: Check drv->lock is locked in sst_fill_and_send_cmd_unlocked

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

From 0bb2be2d1b78f18ae68633b89ad49d84e0cb9bf6 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 2 Apr 2020 20:53:58 +0200
Subject: [PATCH] ASoC: Intel: atom: Check drv->lock is locked in
 sst_fill_and_send_cmd_unlocked

sst_fill_and_send_cmd_unlocked must be called with the drv->lock mutex
locked already. In the past there have been cases where this was not the
case, add a WARN_ON to check for drv->lock being locked.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200402185359.3424-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index df8f7994d3b7..69f3af4524ab 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -50,6 +50,8 @@ static int sst_fill_and_send_cmd_unlocked(struct sst_data *drv,
 {
 	int ret = 0;
 
+	WARN_ON(!mutex_is_locked(&drv->lock));
+
 	ret = sst_fill_byte_control(drv, ipc_msg,
 				block, task_id, pipe_id, len, cmd_data);
 	if (ret < 0)
-- 
2.20.1

