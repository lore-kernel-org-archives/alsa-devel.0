Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C889C3F68F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D4D2176D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rRXajpiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D4D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C80C984F;
	Mon, 16 Dec 2019 13:05:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C80C984F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576497959;
	bh=b8BjKXhVeaVBEdg9X5hTE0L2XVSLlYdy+tLbsgDMXTA=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=rRXajpiTu+fhPy/3tFTJnfpd27SKmXmi3jsP3YjMMZNYx5BrGyuAV1xoKOqumkJr6
	 v24/LA/+N3OoLoSEdmWJ2jFDurGxR15QuFluznlyZ9KHDC0JcouGUhSy1Bz/LAN71u
	 67IBJbiGizjXyPOXaWACLrvTS3i3/hqj2YvqXqkk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 092D6F80255;
	Mon, 16 Dec 2019 13:05:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6449EF8014F; Mon, 16 Dec 2019 13:05:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5B272F8014F
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 13:05:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B272F8014F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4A01FB;
 Mon, 16 Dec 2019 04:05:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1E73F719;
 Mon, 16 Dec 2019 04:05:01 -0800 (PST)
Date: Mon, 16 Dec 2019 12:04:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871rt959ic.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-871rt959ic.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: remove legacy style of
	codec_conf" to the asoc tree
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

   ASoC: soc-core: remove legacy style of codec_conf

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

From ee8f537fd8b71c555d01a89e0834413bbf5373d4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Dec 2019 09:55:55 +0900
Subject: [PATCH] ASoC: soc-core: remove legacy style of codec_conf

Now all driver is using snd_soc_dai_link_component for codec_conf.
Let's remove legacy style

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/871rt959ic.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 3 ---
 sound/soc/soc-core.c | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a94e5d2fc2b2..9787c80e548b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -960,9 +960,6 @@ struct snd_soc_codec_conf {
 	 * specify device either by device name, or by
 	 * DT/OF node, but not both.
 	 */
-	const char *dev_name;
-	struct device_node *of_node;
-
 	struct snd_soc_dai_link_component dlc;
 
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 411b83ba2fc0..0bd2cb2e7a67 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1185,12 +1185,6 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 	for (i = 0; i < card->num_configs; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 
-		/* fixme */
-		if (map->dev_name)
-			map->dlc.name = map->dev_name;
-		if (map->of_node)
-			map->dlc.of_node = map->of_node;
-
 		if (snd_soc_is_matching_component(&map->dlc, component)) {
 			component->name_prefix = map->name_prefix;
 			return;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
