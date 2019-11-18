Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328BDC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:02:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87E220878
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TtHRhXz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87E220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E767A1684;
	Mon, 18 Nov 2019 14:01:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E767A1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574082145;
	bh=pJce/1xSNxIoAhU3XlyHWkFcBHbzu0Nz8+q/TuJz7Mw=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TtHRhXz3sqx3nw2Ov3Mq6mFZHK+kuMg/pSP3g3x1pB5+5toAGbkhWnvOfbICbWpO+
	 7SE6p2gVeM4/5co4gQM6OK5SJRkjNnlPr4/YYnA60zMn67B0xNqZ3QrcohCNPESx/F
	 QaaNTLRDkSwssbb5ASYJGZqQyCjFiF+B1pxA0Pbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81661F80141;
	Mon, 18 Nov 2019 14:00:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 957EBF800F1; Mon, 18 Nov 2019 14:00:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3D632F800F1
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 14:00:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D632F800F1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0C7BDA7;
 Mon, 18 Nov 2019 05:00:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2285F3F6C4;
 Mon, 18 Nov 2019 05:00:33 -0800 (PST)
Date: Mon, 18 Nov 2019 13:00:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
In-Reply-To: <20191118073633.28237-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191118130038.957EBF800F1@alsa1.perex.cz>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 "Cc:"@alsa-project.org
Subject: [alsa-devel] Applied "ASoC: wm2200: add missed operations in remove
	and probe failure" to the asoc tree
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

   ASoC: wm2200: add missed operations in remove and probe failure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 51af759a930c18d2ee450772e01c614564772b2a Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Mon, 18 Nov 2019 15:36:33 +0800
Subject: [PATCH] ASoC: wm2200: add missed operations in remove and probe
 failure

This driver misses calls to pm_runtime_disable and regulator_bulk_disable
in remove and a call to free_irq in probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191118073633.28237-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2200.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index cf64e109c658..7b087d94141b 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2410,6 +2410,8 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 
 err_pm_runtime:
 	pm_runtime_disable(&i2c->dev);
+	if (i2c->irq)
+		free_irq(i2c->irq, wm2200);
 err_reset:
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
@@ -2426,12 +2428,15 @@ static int wm2200_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm2200);
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
 	if (wm2200->pdata.ldo_ena)
 		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
+	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
+			       wm2200->core_supplies);
 
 	return 0;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
