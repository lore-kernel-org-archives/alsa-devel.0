Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD00CC34022
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:07:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463CF207FD
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kIRJUTDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463CF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B5991676;
	Mon, 17 Feb 2020 23:06:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B5991676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581977224;
	bh=J1ExObEGN1Pgle7d54IV0d2/aKr6NKI2b6CSAwzodsw=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=kIRJUTDwEUv8+YxWOCRzJgC+rz1rbJ7q5piftKe8Qg7FxtxIqRCTvTi64+aVRDsuG
	 c1NngEJCxbEpOZ74XN4vdLdDADVIm56xITZGEfFYKkzO8J1DNu1JU50BiX2vsBf2UE
	 qkaxCt/rp5k4xr7Yenix3ALMZ+rgboCbQQ+zJF9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13779F80278;
	Mon, 17 Feb 2020 23:04:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DC85F80279; Mon, 17 Feb 2020 23:04:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 67998F80233
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 23:04:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67998F80233
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB7C113E;
 Mon, 17 Feb 2020 14:04:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B873F703;
 Mon, 17 Feb 2020 14:04:03 -0800 (PST)
Date: Mon, 17 Feb 2020 22:04:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Applied "ASoC: rt1015: fix typo for bypass boost control" to the asoc
 tree
In-Reply-To: <20200217020311.12793-1-jack.yu@realtek.com>
Message-Id: <applied-20200217020311.12793-1-jack.yu@realtek.com>
X-Patchwork-Hint: ignore
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, shumingf@realtek.com,
 mingjane_hsieh@realtek.com, flove@realtek.com
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

   ASoC: rt1015: fix typo for bypass boost control

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

From 2f0b42034bd75a938cdf144149d6db4fa4d51208 Mon Sep 17 00:00:00 2001
From: Jack Yu <jack.yu@realtek.com>
Date: Mon, 17 Feb 2020 10:03:11 +0800
Subject: [PATCH] ASoC: rt1015: fix typo for bypass boost control

Fix typo for "Bypass Boost" control.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://lore.kernel.org/r/20200217020311.12793-1-jack.yu@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1015.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 6d490e2dbc25..d300b417dd50 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -444,7 +444,7 @@ static int rt1015_boost_mode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int rt5518_bypass_boost_get(struct snd_kcontrol *kcontrol,
+static int rt1015_bypass_boost_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
@@ -457,7 +457,7 @@ static int rt5518_bypass_boost_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int rt5518_bypass_boost_put(struct snd_kcontrol *kcontrol,
+static int rt1015_bypass_boost_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
@@ -497,7 +497,7 @@ static const struct snd_kcontrol_new rt1015_snd_controls[] = {
 		rt1015_boost_mode_get, rt1015_boost_mode_put),
 	SOC_ENUM("Mono LR Select", rt1015_mono_lr_sel),
 	SOC_SINGLE_EXT("Bypass Boost", SND_SOC_NOPM, 0, 1, 0,
-		rt5518_bypass_boost_get, rt5518_bypass_boost_put),
+		rt1015_bypass_boost_get, rt1015_bypass_boost_put),
 };
 
 static int rt1015_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
-- 
2.20.1

