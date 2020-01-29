Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759DC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:55:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FCE206D4
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nPD41VxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FCE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9381C168F;
	Wed, 29 Jan 2020 18:54:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9381C168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580320528;
	bh=cnqLNhELIgDWMMdtQNgf3n0k4KzXJCHsWLDUqrPxopw=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=nPD41VxMl9DZ6tcQKDHHOVBKyqFSYHu/pzTc9C4t7uCE1BrJ5SeiSfRcEQX0GBt5g
	 WuB18GoU4+Fg17cu7heibC1/tgg1i1Z61EdQYQOe3+K8Um0i1HO19QJorQaXCbLmgq
	 RSAKx0ZqadGoOV/k/8SJuZFnu5CJc+HrBu1i+jP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 641D3F80218;
	Wed, 29 Jan 2020 18:54:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3DC9F80253; Wed, 29 Jan 2020 18:54:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CD541F80234
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 18:54:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD541F80234
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B2B328;
 Wed, 29 Jan 2020 09:54:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65B603F67D;
 Wed, 29 Jan 2020 09:54:11 -0800 (PST)
Date: Wed, 29 Jan 2020 17:54:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20200127192831.14057-4-tiwai@suse.de>
Message-Id: <applied-20200127192831.14057-4-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: rt711: Add __maybe_unused to PM
	callbacks" to the asoc tree
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
Content-Type: multipart/mixed; boundary="===============8444773522048558726=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

--===============8444773522048558726==
Content-Type: text/plain

The patch

   ASoC: rt711: Add __maybe_unused to PM callbacks

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

From 973649d38e2664eb45e1ae9adfdce53626c29f94 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 27 Jan 2020 20:28:30 +0100
Subject: [PATCH] ASoC: rt711: Add __maybe_unused to PM callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the compile warnings by adding __maybe_unused to PM callbacks:
  sound/soc/codecs/rt711-sdw.c:504:12: warning: ‘rt711_dev_resume’ defined but not used [-Wunused-function]
  sound/soc/codecs/rt711-sdw.c:490:12: warning: ‘rt711_dev_suspend’ defined but not used [-Wunused-function]

Fixes: 320b8b0d13b8 ("ASoC: rt711: add rt711 codec driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200127192831.14057-4-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt711-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 85e62e1059cd..fc3a3fa3d51b 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -487,7 +487,7 @@ static const struct sdw_device_id rt711_id[] = {
 };
 MODULE_DEVICE_TABLE(sdw, rt711_id);
 
-static int rt711_dev_suspend(struct device *dev)
+static int __maybe_unused rt711_dev_suspend(struct device *dev)
 {
 	struct rt711_priv *rt711 = dev_get_drvdata(dev);
 
@@ -501,7 +501,7 @@ static int rt711_dev_suspend(struct device *dev)
 
 #define RT711_PROBE_TIMEOUT 2000
 
-static int rt711_dev_resume(struct device *dev)
+static int __maybe_unused rt711_dev_resume(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct rt711_priv *rt711 = dev_get_drvdata(dev);
-- 
2.20.1


--===============8444773522048558726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8444773522048558726==--
