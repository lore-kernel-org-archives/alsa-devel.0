Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D2CC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D5B206B7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jj4PFWIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D5B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 203521813;
	Fri, 13 Mar 2020 17:17:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 203521813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116291;
	bh=M5DNWO8UN0jkySMEuOnbP0fSiq0UED9gtwCAuyR6k9s=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=jj4PFWIU+jRBAUjL3ueev7cZYLIbh3ASGg0Q+JUF0hOm3OM1DREnbJFzwhHlXau8R
	 jEqBwS0w2HXvTvxWrmtVdzwUDzIAuGZqIKKn1vw4fio80fEk6MeFybrL4tGijLBPfK
	 kycsQNgwrIwOm5r10ZtZagU5jBzFJTzlmrfHDkKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53D6AF801A3;
	Fri, 13 Mar 2020 17:17:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3EB7F80090; Fri, 13 Mar 2020 17:17:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 60566F80090
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:17:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60566F80090
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 785A0FEC;
 Fri, 13 Mar 2020 09:17:12 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9D33F6CF;
 Fri, 13 Mar 2020 09:17:11 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:17:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>
Subject: Applied "ASoC: rt5682: Fine tune the HP performance in soundwire
 mode" to the asoc tree
In-Reply-To: <20200313023850.28875-1-oder_chiou@realtek.com>
Message-Id: <applied-20200313023850.28875-1-oder_chiou@realtek.com>
X-Patchwork-Hint: ignore
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

   ASoC: rt5682: Fine tune the HP performance in soundwire mode

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

From a252d78cf772f86c2dcc40df8117d9461eed88d6 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Fri, 13 Mar 2020 10:38:49 +0800
Subject: [PATCH] ASoC: rt5682: Fine tune the HP performance in soundwire mode

The setting is sync with I2C/I2S mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Link: https://lore.kernel.org/r/20200313023850.28875-1-oder_chiou@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index e1df2d076533..f4b8af128828 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3462,6 +3462,8 @@ int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 			RT5682_HPA_CP_BIAS_CTRL_MASK, RT5682_HPA_CP_BIAS_3UA);
 	regmap_update_bits(rt5682->regmap, RT5682_CHARGE_PUMP_1,
 			RT5682_CP_CLK_HP_MASK, RT5682_CP_CLK_HP_300KHZ);
+	regmap_update_bits(rt5682->regmap, RT5682_HP_CHARGE_PUMP_1,
+			RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
 
 	/* Soundwire */
 	regmap_write(rt5682->regmap, RT5682_PLL2_INTERNAL, 0xa266);
-- 
2.20.1

