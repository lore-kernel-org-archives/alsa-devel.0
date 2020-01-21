Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2BC2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8029B206A2
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qCtkMQor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8029B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D02E71679;
	Tue, 21 Jan 2020 18:28:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D02E71679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579627746;
	bh=hVvEDfLIhQkFdSwPswyadZFGiRgde1VZ76eBPVhjJ8A=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qCtkMQorXbNPNbI3sqLBzTSQ7zRnxmJJx/DXJhhqfZLD/DrLA9aEiegchb10kzrHg
	 h3uLpjwaU4aNjsDOcCCFpGGeK/faSePuIqrFyDepD1Z7t8M2w55hefwHsHCxUjrakd
	 Z9ClXTf4LK4xl0C+5SGVqHE8pZxZjmUDwckVMwXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57F09F801D9;
	Tue, 21 Jan 2020 18:28:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED371F801F9; Tue, 21 Jan 2020 18:28:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CA992F8015B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA992F8015B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291C2328;
 Tue, 21 Jan 2020 09:28:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E5D3F6C4;
 Tue, 21 Jan 2020 09:28:08 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200117073814.82441-4-tzungbi@google.com>
Message-Id: <applied-20200117073814.82441-4-tzungbi@google.com>
X-Patchwork-Hint: ignore
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
Subject: [alsa-devel] Applied "ASoC: max98090: fix deadlock in
	max98090_dapm_put_enum_double()" to the asoc tree
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

   ASoC: max98090: fix deadlock in max98090_dapm_put_enum_double()

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

From 294b7380ffe88d4a0626af1fee5843a3db0c913c Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 17 Jan 2020 15:38:14 +0800
Subject: [PATCH] ASoC: max98090: fix deadlock in
 max98090_dapm_put_enum_double()

Commit 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when
changing sensitive registers SHDN bit") uses dapm_mutex to protect SHDN
bit.  However, snd_soc_dapm_put_enum_double() in
max98090_dapm_put_enum_double() acquires the dapm_mutex again which
cause a deadlock.

Use snd_soc_dapm_put_enum_double_locked() instead to fix the deadlock.

Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers SHDN bit")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20200117073814.82441-4-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c01ce4a3f86d..0313e1183167 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -88,7 +88,7 @@ static int max98090_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	int ret;
 
 	max98090_shdn_save(max98090);
-	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+	ret = snd_soc_dapm_put_enum_double_locked(kcontrol, ucontrol);
 	max98090_shdn_restore(max98090);
 
 	return ret;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
