Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EDDC4BA24
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:49:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E29D20714
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O1e3Y4jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E29D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C14AB1689;
	Wed, 26 Feb 2020 19:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C14AB1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582742987;
	bh=PxNFpD8FpKx31qOUaTdsyYNPm0u56FKyfLv2VWXFM4U=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=O1e3Y4jo2t1xe8cGHTDKpUjufwn9X4vHgbw3fNNHcR9XngfxJgQGK2qNKWk0jx+CN
	 Xez2mn4TPVDnBGxuaE3YEFYBbMy/HDWrt99zpsuKLghDLiOHl0xYhv9+LriQ3m9n4x
	 NIZ9XL9G4rd8NQmysHaBNitLF2/SXnzjooModL3I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ABFEF80278;
	Wed, 26 Feb 2020 19:47:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 046CEF8027D; Wed, 26 Feb 2020 19:47:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 90A13F80213
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 19:47:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90A13F80213
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271AB30E;
 Wed, 26 Feb 2020 10:47:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91FD33F881;
 Wed, 26 Feb 2020 10:47:18 -0800 (PST)
Date: Wed, 26 Feb 2020 18:47:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Applied "ASoC: amd: Allow I2S wake event after ACP is powerd On" to
 the asoc tree
In-Reply-To: <20200226104746.208656-1-akshu.agrawal@amd.com>
Message-Id: <applied-20200226104746.208656-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Cc: , "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

   ASoC: amd: Allow I2S wake event after ACP is powerd On

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

From 911abf8b050e76591479d35c928f7e72605067ac Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 26 Feb 2020 16:17:44 +0530
Subject: [PATCH] ASoC: amd: Allow I2S wake event after ACP is powerd On

ACP_PME_EN allows wake interrupt to be generated when I2S wake
feature is enabled. On turning ACP On, ACP_PME_EN gets cleared.
Setting the bit back ensures that wake event can be received
when ACP is On.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200226104746.208656-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/pci-acp3x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index da60e2ec5535..f25ce50f1a90 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -38,8 +38,13 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	timeout = 0;
 	while (++timeout < 500) {
 		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if (!val)
+		if (!val) {
+			/* Set PME_EN as after ACP power On,
+			 * PME_EN gets cleared
+			 */
+			rv_writel(0x1, acp3x_base + mmACP_PME_EN);
 			return 0;
+		}
 		udelay(1);
 	}
 	return -ETIMEDOUT;
-- 
2.20.1

