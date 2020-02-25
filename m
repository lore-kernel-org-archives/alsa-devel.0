Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D530C35DE1
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:25:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF27D20726
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T2ELRCWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF27D20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E2F11671;
	Tue, 25 Feb 2020 14:24:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E2F11671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582637100;
	bh=GL0fXsOxCKFCxkB5D7HGQMAMwEWPl+S/mALOPU2bQxY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=T2ELRCWMMYgvl1qCd+PG5V1Pyb/msj265G0hLDDDggDov7JTJ6qNipEuTffsO1xBM
	 c3vvIdx50WGDJmibNmdkBxc6Cnwnq4+2KSVrrovo+eNrNMRQuOsbd+YCeCgXGc6FMm
	 ESLGtB6UE13l9RwS04gmkDbednrrlpVJrv7ME+UA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87F2AF8013E;
	Tue, 25 Feb 2020 14:24:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 006CAF80142; Tue, 25 Feb 2020 14:24:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 57EDEF80090
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 14:24:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57EDEF80090
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A8C6FEC;
 Tue, 25 Feb 2020 05:24:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A746D3F703;
 Tue, 25 Feb 2020 05:24:02 -0800 (PST)
Date: Tue, 25 Feb 2020 13:24:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Subject: Applied "ASoC: Intel: mrfld: fix incorrect check on p->sink" to the
 asoc tree
In-Reply-To: <20191119113640.166940-1-colin.king@canonical.com>
Message-Id: <applied-20191119113640.166940-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
 linux-kernel@vger.kernel.org
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

   ASoC: Intel: mrfld: fix incorrect check on p->sink

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

From f5e056e1e46fcbb5f74ce560792aeb7d57ce79e6 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 19 Nov 2019 11:36:40 +0000
Subject: [PATCH] ASoC: Intel: mrfld: fix incorrect check on p->sink

The check on p->sink looks bogus, I believe it should be p->source
since the following code blocks are related to p->source. Fix
this by replacing p->sink with p->source.

Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Copy-paste error")
Link: https://lore.kernel.org/r/20191119113640.166940-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index baef461a99f1..f883c9340eee 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 				dai->capture_widget->name);
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
-			if (p->connected && !p->connected(w, p->sink))
+			if (p->connected && !p->connected(w, p->source))
 				continue;
 
 			if (p->connect &&  p->source->power &&
-- 
2.20.1

