Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3CC34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6F324654
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K40KcK5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6F324654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AE31169F;
	Wed, 19 Feb 2020 21:59:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AE31169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146027;
	bh=m/xxIc8pk6Hrtp3ZYorOKXznPjkwzRrFh0CUoLUpqJw=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=K40KcK5XCWHq1GdbJIzb6/jpYwtGMT0aVVzqv04beNd4AEqlcQe2U8A+Cceg+Syaa
	 4yHNtV72PthikBpXX3kAt+9PiFODDH4z69A79Y/TPj572K53cRhyVtOXJG3V/2Hxc0
	 cXjmwF+W2RDGaGyIqC+tgj3FIQGTxlIxF8/A1nTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B31AF802A0;
	Wed, 19 Feb 2020 21:57:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED07CF802A1; Wed, 19 Feb 2020 21:57:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 28655F8029B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28655F8029B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA012101E;
 Wed, 19 Feb 2020 12:57:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EA583F68F;
 Wed, 19 Feb 2020 12:57:05 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Subject: Applied "ASoC: topology: Fix memleak in soc_tplg_link_elems_load()"
 to the asoc tree
In-Reply-To: <20200207185325.22320-2-dragos_tarcatu@mentor.com>
Message-Id: <applied-20200207185325.22320-2-dragos_tarcatu@mentor.com>
X-Patchwork-Hint: ignore
Cc: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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

   ASoC: topology: Fix memleak in soc_tplg_link_elems_load()

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

From 2b2d5c4db732c027a14987cfccf767dac1b45170 Mon Sep 17 00:00:00 2001
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Date: Fri, 7 Feb 2020 20:53:24 +0200
Subject: [PATCH] ASoC: topology: Fix memleak in soc_tplg_link_elems_load()

If soc_tplg_link_config() fails, _link needs to be freed in case of
topology ABI version mismatch. However the current code is returning
directly and ends up leaking memory in this case.
This patch fixes that.

Fixes: 593d9e52f9bb ("ASoC: topology: Add support to configure existing physical DAI links")
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Link: https://lore.kernel.org/r/20200207185325.22320-2-dragos_tarcatu@mentor.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 107ba3ed5440..953517a73298 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2376,8 +2376,11 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 		}
 
 		ret = soc_tplg_link_config(tplg, _link);
-		if (ret < 0)
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_link);
 			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size
-- 
2.20.1

