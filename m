Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77153C35671
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:43:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003A92082F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HzXe8lGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003A92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 230C8167C;
	Mon, 24 Feb 2020 14:42:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 230C8167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582551818;
	bh=ZOzVybOYVC4CBHM5d8bpe9dlvbOWYAWyUT4hQNsoR7M=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HzXe8lGpzp7PVaUQmubbKsh0PO7IHNIUBRCA+loknNxG2/XNlXyzBocoAncRJO1o9
	 hH9SDcXiN2OEyOcjPlY1nCzo43QP3xPGYQnnLxHnsa6XJFD9SheeA9AfFeit5nSbah
	 XU03hCapC4TwTSkwO+sAEzDmUiEy6kZOctdsZbyE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA35CF801F2;
	Mon, 24 Feb 2020 14:41:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 978F3F80213; Mon, 24 Feb 2020 14:41:55 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5F23EF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 14:41:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F23EF80137
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E909D30E;
 Mon, 24 Feb 2020 05:41:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EC433F534;
 Mon, 24 Feb 2020 05:41:50 -0800 (PST)
Date: Mon, 24 Feb 2020 13:41:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Applied "ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout" to the asoc
 tree
In-Reply-To: <20200224112537.14483-1-geert@linux-m68k.org>
Message-Id: <applied-20200224112537.14483-1-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
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

   ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout

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

From 5a309875787db47d69610e45f00a727ef9e62aa0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2020 12:25:37 +0100
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout

On i386 randconfig:

    sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
    wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
    wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
    wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'

Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20200224112537.14483-1-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e9d54e4576c..a7e89567edbe 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.20.1

