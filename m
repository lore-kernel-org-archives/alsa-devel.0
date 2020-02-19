Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EA3C34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAC7207FD
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gj1GsmaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAC7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59BFE16C0;
	Wed, 19 Feb 2020 22:06:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59BFE16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146446;
	bh=6QlRd8Du69I3h8MdKFCWb+X+r3yEic82mNtWwK6yTXM=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=gj1GsmaPcqNPivDjBX2kFLE72f2Rfgk+SPzfedo1XGvSyENqNXgZ+Fu9lVLIuoDQ+
	 c0ztRQS+c1/8GNgynuKfQZEEjfhB3dX0iD2PGp/bHbYwK+sDv1ySy4lcqdNskQbav/
	 4iWas9rlOrdW6fJpDu0ihCZGllZ024EGmp87hzCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3797CF80339;
	Wed, 19 Feb 2020 21:58:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6E2CF80337; Wed, 19 Feb 2020 21:58:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5C955F80337
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C955F80337
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73597FEC;
 Wed, 19 Feb 2020 12:57:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC82E3F68F;
 Wed, 19 Feb 2020 12:57:57 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Applied "ASoC: fix card registration regression." to the asoc tree
In-Reply-To: <20200219102526.692126-1-jbrunet@baylibre.com>
Message-Id: <applied-20200219102526.692126-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

   ASoC: fix card registration regression.

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

From 6b62fa95b56bcc77cbbcc76e45f5170b4ec229b1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 19 Feb 2020 11:25:26 +0100
Subject: [PATCH] ASoC: fix card registration regression.

This reverts commit b2354e4009a773c00054b964d937e1b81cb92078.

This change might have been desirable to ensure the uniqueness of
the component name. It would have helped to better support linux
devices which register multiple components, something is which more
common than initially thought.

However, some card driver are directly using dev_name() to fill the
component names of the dai_link which is a problem if want to change
the way ASoC generates the component names.

Until we figure out the appropriate way to deal with this, revert the
change and keep the names as they were. There might be a couple of warning
related to debugfs (which were already present before the change) but it
is still better than breaking working audio cards.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20200219102526.692126-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 30c17fde14ca..518b652cf872 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2442,33 +2442,6 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	return ret;
 }
 
-static char *snd_soc_component_unique_name(struct device *dev,
-					   struct snd_soc_component *component)
-{
-	struct snd_soc_component *pos;
-	int count = 0;
-	char *name, *unique;
-
-	name = fmt_single_name(dev, &component->id);
-	if (!name)
-		return name;
-
-	/* Count the number of components registred by the device */
-	for_each_component(pos) {
-		if (dev == pos->dev)
-			count++;
-	}
-
-	/* Keep naming as it is for the 1st component */
-	if (!count)
-		return name;
-
-	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
-	devm_kfree(dev, name);
-
-	return unique;
-}
-
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2477,7 +2450,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = snd_soc_component_unique_name(dev, component);
+	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.20.1

