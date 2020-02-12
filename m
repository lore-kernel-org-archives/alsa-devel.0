Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A8C352A4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:04:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF021739
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o3CHYn3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF021739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B12B41679;
	Thu, 13 Feb 2020 01:03:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B12B41679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581552264;
	bh=5Mdif9lWdZlXpIeDEdv/4paFmjOu1DUs9Ero0DEpDro=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=o3CHYn3JRCWRxE9RwYrKY9hMfoefstx1wFbdmKHb3rlkz3q50P35Bgk0r4PoOK7wW
	 u0bGV1337LKEjldNisFg73oiCCQP7mqmN+Y/gY0v75sIzfoUl0vuOHiO8r1oxYk0ul
	 ZCyxGilDrvvaI07/rmxt4ggox8UY1kDF7P+wqgTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C93EF802E8;
	Thu, 13 Feb 2020 00:57:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 397C1F802EA; Thu, 13 Feb 2020 00:57:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 6F67EF802E8
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 00:57:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F67EF802E8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFB6113E;
 Wed, 12 Feb 2020 15:57:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F373F68E;
 Wed, 12 Feb 2020 15:57:38 -0800 (PST)
Date: Wed, 12 Feb 2020 23:57:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20200212085008.9652-1-geert+renesas@glider.be>
Message-Id: <applied-20200212085008.9652-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [alsa-devel] Applied "ASoC: sh: fsi: Restore devm_ioremap()
	alignment" to the asoc tree
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

   ASoC: sh: fsi: Restore devm_ioremap() alignment

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

From 82dabf599b221a712e951b9061c56669565552a9 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 12 Feb 2020 09:50:08 +0100
Subject: [PATCH] ASoC: sh: fsi: Restore devm_ioremap() alignment

The alignment of the continuation of the devm_ioremap() call in
fsi_probe() was broken.  Join the lines, as all parameters can fit on a
single line.

Fixes: 4bdc0d676a643140 ("remove ioremap_nocache and devm_ioremap_nocache")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200212085008.9652-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 4b35ef402604..5ef4221be6c3 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1938,8 +1938,7 @@ static int fsi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->base = devm_ioremap(&pdev->dev,
-					    res->start, resource_size(res));
+	master->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!master->base) {
 		dev_err(&pdev->dev, "Unable to ioremap FSI registers.\n");
 		return -ENXIO;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
