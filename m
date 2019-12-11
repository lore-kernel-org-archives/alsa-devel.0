Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08FC2D0C6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:09:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D9C21556
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BA4tj6kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D9C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 319901691;
	Wed, 11 Dec 2019 18:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 319901691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576084162;
	bh=G1L3dVVKcBZzC3bGAZSNGvQBU3JGZBZM1m1Luv6eHss=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=BA4tj6kJX+Zw82zLS42IZKQ9nxoV7bEqBKKI6FYNX8K3GIex4gEvsFXxDdSw2WJGi
	 w2HRQpuiHiWiTfoTO3fXvUD8dz+LNuD/wg+R3/dHUaDEGwYBsGHU1CK3z3CX9w8ZSx
	 z7dH537cJLgCAy7sNEEJoG2htOw8Hn/vzSxJxwqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46D4DF80363;
	Wed, 11 Dec 2019 17:54:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E6E3F8034A; Wed, 11 Dec 2019 17:54:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id BF4F9F80329
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF4F9F80329
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A61C30E;
 Wed, 11 Dec 2019 08:54:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE9A63F52E;
 Wed, 11 Dec 2019 08:54:00 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0cvbhyj.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87d0cvbhyj.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-core: tidyup for CONFIG_DEBUG_FS"
	to the asoc tree
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

   ASoC: soc-core: tidyup for CONFIG_DEBUG_FS

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

From a4072cdfa9fe79adcd41320355847e77de22baf0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Dec 2019 13:32:20 +0900
Subject: [PATCH] ASoC: soc-core: tidyup for CONFIG_DEBUG_FS

soc-core.c has 2 #ifdef CONFIG_DEBUG_FS, but we can merge these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87d0cvbhyj.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 51a404fb89e2..3eb874c4a340 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -45,11 +45,6 @@
 
 #define NAME_SIZE	32
 
-#ifdef CONFIG_DEBUG_FS
-struct dentry *snd_soc_debugfs_root;
-EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
-#endif
-
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(component_list);
 static LIST_HEAD(unbind_card_list);
@@ -133,6 +128,9 @@ static const struct attribute_group *soc_dev_attr_groups[] = {
 };
 
 #ifdef CONFIG_DEBUG_FS
+struct dentry *snd_soc_debugfs_root;
+EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
+
 static void soc_init_component_debugfs(struct snd_soc_component *component)
 {
 	if (!component->card->debugfs_card_root)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
