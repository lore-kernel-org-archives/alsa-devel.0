Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD85C3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:29:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905C2246A3
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eYInEM6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905C2246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E49F116ED;
	Fri, 28 Feb 2020 19:28:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E49F116ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582914590;
	bh=AjNaO1ynVhGu4veAbpJK2ixFEw2KR6+DdEdLWJP+/Do=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=eYInEM6xjKVzYQ+Ph4BjHlUyFjPL7EGzBoqcP5TATzLRW3swwr5SGvwPeyrKf2J/F
	 Cby9pPCGacCs4cFMzVMKaiW204X321Ebcf6UdRDJiyChsh3cAYTsvhUOodTk2SFC5R
	 /h68L6O6bMEwVc+lWWGxeFtvVd379j9KhF8La5SI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC39AF802BE;
	Fri, 28 Feb 2020 19:25:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C1BBF80291; Fri, 28 Feb 2020 19:25:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8E849F80171
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 19:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E849F80171
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3298106F;
 Fri, 28 Feb 2020 10:25:13 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 476493F7B4;
 Fri, 28 Feb 2020 10:25:13 -0800 (PST)
Date: Fri, 28 Feb 2020 18:25:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Applied "ASoC: dapm: Correct DAPM handling of active widgets during
 shutdown" to the asoc tree
In-Reply-To: <20200228153145.21013-1-ckeepax@opensource.cirrus.com>
Message-Id: <applied-20200228153145.21013-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, lars@metafoo.de, lgirdwood@gmail.com
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

   ASoC: dapm: Correct DAPM handling of active widgets during shutdown

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

From 9b3193089e77d3b59b045146ff1c770dd899acb1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 28 Feb 2020 15:31:45 +0000
Subject: [PATCH] ASoC: dapm: Correct DAPM handling of active widgets during
 shutdown

commit c2caa4da46a4 ("ASoC: Fix widget powerdown on shutdown") added a
set of the power state during snd_soc_dapm_shutdown to ensure the
widgets powered off. However, when commit 39eb5fd13dff
("ASoC: dapm: Delay w->power update until the changes are written")
added the new_power member of the widget structure, to differentiate
between the current power state and the target power state, it did not
update the shutdown to use the new_power member.

As new_power has not updated it will be left in the state set by the
last DAPM sequence, ie. 1 for active widgets. So as the DAPM sequence
for the shutdown proceeds it will turn the widgets on (despite them
already being on) rather than turning them off.

Fixes: 39eb5fd13dff ("ASoC: dapm: Delay w->power update until the changes are written")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200228153145.21013-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9b130561d562..9fb54e6fe254 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4772,7 +4772,7 @@ static void soc_dapm_shutdown_dapm(struct snd_soc_dapm_context *dapm)
 			continue;
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, false);
-			w->power = 0;
+			w->new_power = 0;
 			powerdown = 1;
 		}
 	}
-- 
2.20.1

