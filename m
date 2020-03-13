Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE04C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E970206E7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iO51blKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E970206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 576031847;
	Fri, 13 Mar 2020 19:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 576031847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584125362;
	bh=PsXS5/ExlMT0PYKOKNebee8S0mq/uBpvRcqCZkOk2Fg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=iO51blKkBuHpC4DVK02BsihbAUze6XfzHBcRiDd9oSWB609ZEahBjwtsaZGPnXz8m
	 K0dNB6kxmo+4/qasSH2AnaB4o6xmhz0Os5cdo1Fzg3drSqLXlmfJ4NnR/t8Ddg7IvG
	 GxVEKkknSVsXZRO48KJsnJqzmE6K4LAJIfeG03QQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D83B7F80086;
	Fri, 13 Mar 2020 19:48:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E79FF801A3; Fri, 13 Mar 2020 19:48:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4631AF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 19:48:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4631AF80086
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF0C31B;
 Fri, 13 Mar 2020 11:48:24 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32273F534;
 Fri, 13 Mar 2020 11:48:23 -0700 (PDT)
Date: Fri, 13 Mar 2020 18:48:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Yong Zhi <yong.zhi@intel.com>
Subject: Applied "ASoC: max98357a: Add ACPI HID MAX98360A" to the asoc tree
In-Reply-To: <1584114926-29287-1-git-send-email-yong.zhi@intel.com>
Message-Id: <applied-1584114926-29287-1-git-send-email-yong.zhi@intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Rajesh.Swaminathan@maximintegrated.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 sathyanarayana.nujella@intel.com, uday.m.bhat@intel.com
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

   ASoC: max98357a: Add ACPI HID MAX98360A

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

From 1a0f2433d7380c957d5d29e60a2eeb03ca3afe21 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Fri, 13 Mar 2020 10:55:26 -0500
Subject: [PATCH] ASoC: max98357a: Add ACPI HID MAX98360A

Maxim MAX98360A audio amplifier is functionally identical to MAX98357A,
add ACPI ID "MAX98360A" for driver reuse.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Link: https://lore.kernel.org/r/1584114926-29287-1-git-send-email-yong.zhi@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 16313b973eaa..eb3d8255ea6c 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -135,6 +135,7 @@ MODULE_DEVICE_TABLE(of, max98357a_device_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id max98357a_acpi_match[] = {
 	{ "MX98357A", 0 },
+	{ "MX98360A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, max98357a_acpi_match);
-- 
2.20.1

