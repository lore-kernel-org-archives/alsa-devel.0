Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4DEC3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:29:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED34246A3
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FSSyKOPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED34246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A4A316F4;
	Fri, 28 Feb 2020 19:28:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A4A316F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582914550;
	bh=n6yxZ42MjJ9G0miW5rDMaS1EBvKHDzWriw+LldtsFtE=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FSSyKOPShiKFA55VMQdeFWFl0eaTJfCjauUd0CBDeMNpjzNAoqzVRSvDLRhcaoaJ1
	 uObvl7RAIUBxl9HZo+G0V7HEDqpdY0Mx2USmdzUOiyiQb/zkM3CZcgs4+3ohkG6MfT
	 mC1zz0DH7WtcJyaSnHlajJB+fT6xJRjGauFJRd5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9EC2F802A8;
	Fri, 28 Feb 2020 19:25:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5C90F8028A; Fri, 28 Feb 2020 19:25:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EA22EF8028A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 19:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA22EF8028A
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53290106F;
 Fri, 28 Feb 2020 10:25:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD583F7B4;
 Fri, 28 Feb 2020 10:25:08 -0800 (PST)
Date: Fri, 28 Feb 2020 18:25:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-component: tidyup
 snd_soc_pcm_component_sync_stop()" to the asoc tree
In-Reply-To: <8736av7a8c.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-8736av7a8c.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
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

   ASoC: soc-component: tidyup snd_soc_pcm_component_sync_stop()

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

From f1861a7c58ba1ba43c7adff6909d9a920338e4a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Feb 2020 10:48:35 +0900
Subject: [PATCH] ASoC: soc-component: tidyup snd_soc_pcm_component_sync_stop()

commit 1e5ddb6ba73894 ("ASoC: component: Add sync_stop PCM ops")
added snd_soc_pcm_component_sync_stop(), but it is checking
ioctrl instead of sync_stop. This is bug.
This patch fixup it.

Fixes: commit 1e5ddb6ba73894 ("ASoC: component: Add sync_stop PCM ops")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/8736av7a8c.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 14e175cdeeb8..785a0385cc7f 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -451,7 +451,7 @@ int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream)
 	int i, ret;
 
 	for_each_rtd_components(rtd, i, component) {
-		if (component->driver->ioctl) {
+		if (component->driver->sync_stop) {
 			ret = component->driver->sync_stop(component,
 							   substream);
 			if (ret < 0)
-- 
2.20.1

