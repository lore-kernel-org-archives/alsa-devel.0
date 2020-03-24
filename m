Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09836C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:38:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB8E20775
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HmmXslY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB8E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD48115F8;
	Tue, 24 Mar 2020 17:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD48115F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585067886;
	bh=z57hpe1IUusb/CPgsearl2ftWvBEMroUg9OEgRAwMIs=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HmmXslY+Y9qIX/4mLmNYuBlwQOzgj1Colqzq7XBo6Uq3NhO/iKdXdeDSYzXqkhPjA
	 93QC7RW0DM8nXOIU2zzaa6BkXE9G5GZ9zJIEGvKVe2s9xBqaweVLdYQPQV8wX5HfDV
	 c7Wj1psNIGGcEzl7/HS2i5q0hrl7smH5kmrdiT1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 486AEF801F8;
	Tue, 24 Mar 2020 17:37:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 879F6F801F9; Tue, 24 Mar 2020 17:37:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id ED72CF800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 17:37:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED72CF800B9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EAFF1FB;
 Tue, 24 Mar 2020 09:37:06 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20F393F52E;
 Tue, 24 Mar 2020 09:37:05 -0700 (PDT)
Date: Tue, 24 Mar 2020 16:37:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonghwan Choi <charlie.jh@kakaocorp.com>
Subject: Applied "ASoC: tas2562: Fixed incorrect amp_level setting." to the
 asoc tree
In-Reply-To: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
Message-Id: <applied-20200319140043.GA6688@jhbirdchoi-MS-7B79>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Dan Murphy <dmurphy@ti.com>
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

   ASoC: tas2562: Fixed incorrect amp_level setting.

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

From eedf8a126629bf9db8ad3a2a5dc9dc1798fb2302 Mon Sep 17 00:00:00 2001
From: Jonghwan Choi <charlie.jh@kakaocorp.com>
Date: Thu, 19 Mar 2020 23:00:44 +0900
Subject: [PATCH] ASoC: tas2562: Fixed incorrect amp_level setting.

According to the tas2562 datasheet,the bits[5:1] represents the amp_level value.
So to set the amp_level value correctly,the shift value should be set to 1.

Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200319140043.GA6688@jhbirdchoi-MS-7B79
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index be52886a5edb..fb2233ca9103 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =
 			1, 1);
 
 static const struct snd_kcontrol_new tas2562_snd_controls[] = {
-	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,
+	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
 		       tas2562_dac_tlv),
 };
 
-- 
2.20.1

