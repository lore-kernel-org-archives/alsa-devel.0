Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB1C33C8C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:52:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280A821744
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O4FEzJjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280A821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7268617F5;
	Mon,  6 Jan 2020 21:52:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7268617F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578343973;
	bh=ZCAmuyok3rHqXyplDdlYHfzhYh/ppkynCQeEwQQ9O14=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=O4FEzJjLgEUQmIbCLBykHE34YAxLyacCmdZs+KFkaZt6RjttM8g2n9bExMMAi7c+D
	 ovGOPW1dm1f1lYLKMa2LT/6uOJI8QwU3eq4DfUGS1y5K9+UrsnX60Z2Qf6Natf0lb1
	 xibo6EHdEXB6hm5BHTdNukthPr1imFeHmDPzi5tk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2FBDF801F2;
	Mon,  6 Jan 2020 21:51:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06F58F801F2; Mon,  6 Jan 2020 21:51:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5BA1DF80116
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 21:50:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BA1DF80116
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A151DA7;
 Mon,  6 Jan 2020 12:50:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5CF73F534;
 Mon,  6 Jan 2020 12:50:57 -0800 (PST)
Date: Mon, 06 Jan 2020 20:50:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20200106113903.279394-1-hdegoede@redhat.com>
Message-Id: <applied-20200106113903.279394-1-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, russianneuromancer@ya.ru,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: Intel: bytcht_es8316: Fix Irbis NB41
	netbook quirk" to the asoc tree
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

   ASoC: Intel: bytcht_es8316: Fix Irbis NB41 netbook quirk

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

From 869bced7a055665e3ddb1ba671a441ce6f997bf1 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 6 Jan 2020 12:39:03 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Fix Irbis NB41 netbook quirk

When a quirk for the Irbis NB41 netbook was added, to override the defaults
for this device, I forgot to add/keep the BYT_CHT_ES8316_SSP0 part of the
defaults, completely breaking audio on this netbook.

This commit adds the BYT_CHT_ES8316_SSP0 flag to the Irbis NB41 netbook
quirk, making audio work again.

Cc: stable@vger.kernel.org
Cc: russianneuromancer@ya.ru
Fixes: aa2ba991c420 ("ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook")
Reported-and-tested-by: russianneuromancer@ya.ru
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200106113903.279394-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 46612331f5ea..54e97455d7f6 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -442,7 +442,8 @@ static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "IRBIS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "NB41"),
 		},
-		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN2_MAP
+		.driver_data = (void *)(BYT_CHT_ES8316_SSP0
+					| BYT_CHT_ES8316_INTMIC_IN2_MAP
 					| BYT_CHT_ES8316_JD_INVERTED),
 	},
 	{	/* Teclast X98 Plus II */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
