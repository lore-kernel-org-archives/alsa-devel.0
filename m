Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC73C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:46:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC21B206ED
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fD3zawV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC21B206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE1C516ED;
	Fri, 10 Jan 2020 14:45:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE1C516ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578663965;
	bh=KyuDcu5ngReGbJSeC7XFOev+MAKDLOm+Ldd8EAkWJwU=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=fD3zawV0XAJXdTkGR82AUUctDqpeT0L/Z3CtJvaRt4WM+e4re9TY2oA4uTOnOOsa/
	 u5S9SgdxLQqVaywoCeHV7H04x/pD37yIFbxW1xNlF2DeBibHpBFw6CGdX/+I33MrHA
	 u9hTk26efUlgmz2Em6kW0NNiB0X/7Yxg61xqhY1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 284D6F802FF;
	Fri, 10 Jan 2020 14:38:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEC9EF802F7; Fri, 10 Jan 2020 14:38:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8E805F802C4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 14:38:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E805F802C4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74E3DA7;
 Fri, 10 Jan 2020 05:38:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59C4B3F534;
 Fri, 10 Jan 2020 05:38:06 -0800 (PST)
Date: Fri, 10 Jan 2020 13:38:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [alsa-devel] Applied "ASoC: max98090: Drop incorrectly applied
	duplicate commit" to the asoc tree
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
Message-ID: <20200110133804.7r9lmPokYnIV9kLIHFh8qbE8nYkxgNNCz1yRQQCxXI0@z>

The patch

   ASoC: max98090: Drop incorrectly applied duplicate commit

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

From a84188eced6109983af54f9435a26d21eac3f8cc Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 10 Jan 2020 13:24:02 +0000
Subject: [PATCH] ASoC: max98090: Drop incorrectly applied duplicate commit

This reverts commit 4e93c1294f4b051 (ASoC: max98090: fix incorrect
helper in max98090_dapm_put_enum_double()) which was misapplied.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index ba0e3ba162f8..454cb8e5b0a1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -98,7 +98,7 @@ static int max98090_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
-		snd_soc_dapm_kcontrol_component(kcontrol);
+		snd_soc_kcontrol_component(kcontrol);
 	struct max98090_priv *max98090 =
 		snd_soc_component_get_drvdata(component);
 	int ret;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
