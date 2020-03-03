Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B16C3F2C6
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6258220728
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iNUxPozL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6258220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAB631661;
	Tue,  3 Mar 2020 18:10:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAB631661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583255461;
	bh=N2Rj7BTaqLNbfk7IGJRVqaLIxu9A6SFQlF4K9s+8mgE=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=iNUxPozL1m8unIHpWSMD3I1hU2ooi+3Ew5L6raVh1Pohfee84f9BmhKE137v6lua9
	 4RBO1vwilWsXDjT/28qMuNlG5w/nwUWC34OBiy5D4pzDMdayu143l3JNtNfSiVq3eG
	 T7yLVBsmvqxuRrC8QiK9slKxA4/HNHgR6f0qCWDI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FDE2F8028E;
	Tue,  3 Mar 2020 18:08:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5EB6F8028F; Tue,  3 Mar 2020 18:08:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 77070F8028B
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 18:08:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77070F8028B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C153C101E;
 Tue,  3 Mar 2020 09:08:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4152D3F534;
 Tue,  3 Mar 2020 09:08:02 -0800 (PST)
Date: Tue, 03 Mar 2020 17:08:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Applied "ASoC: rt1015: modify pre-divider for sysclk" to the asoc tree
In-Reply-To: <20200303025913.24499-1-jack.yu@realtek.com>
Message-Id: <applied-20200303025913.24499-1-jack.yu@realtek.com>
X-Patchwork-Hint: ignore
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, shumingf@realtek.com,
 albertwang@realtek.com, flove@realtek.com
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

   ASoC: rt1015: modify pre-divider for sysclk

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

From 4b01618b624736fc7d74f150f623d11b17b7b288 Mon Sep 17 00:00:00 2001
From: Jack Yu <jack.yu@realtek.com>
Date: Tue, 3 Mar 2020 10:59:13 +0800
Subject: [PATCH] ASoC: rt1015: modify pre-divider for sysclk

Modify pre-divider for system clock.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://lore.kernel.org/r/20200303025913.24499-1-jack.yu@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 9f151c7c3d2d..66eb55b4ffd4 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -664,7 +664,7 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, RT1015_TDM_MASTER,
 		RT1015_I2S_DL_MASK, val_len);
 	snd_soc_component_update_bits(component, RT1015_CLK2,
-		RT1015_FS_PD_MASK, pre_div);
+		RT1015_FS_PD_MASK, pre_div << RT1015_FS_PD_SFT);
 
 	return 0;
 }
-- 
2.20.1

