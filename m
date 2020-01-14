Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761DC33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:21:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39AA24655
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qw7jl3f8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HrKBts6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39AA24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F35161833;
	Tue, 14 Jan 2020 17:20:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F35161833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579018890;
	bh=S1i1xPZMXX3lYZvsKqCk/6vj1fvFbXvUvvbvaaXkrCE=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qw7jl3f8Z+lvPj8yZEWOdtRsb1miOwwcA6ZomPZuXjsOsMepNaS+BtqNxN9nfR3e8
	 NYGQn58oGWnTL8LKrJ6RTDUxz891SgcIfHdbP3otC9zC6IvaDwCfIFsZ11CcDbIfeP
	 c+loYKFZbFdtCxrCVxtWY87kdJCbNYiogCtU8pTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BD4FF8028F;
	Tue, 14 Jan 2020 17:10:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64305F80329; Tue, 14 Jan 2020 17:10:08 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05742F8027C
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 17:09:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05742F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="HrKBts6E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=lXZ19upwkhMk+xRdcs/ZKINinzvJGBfvwuhk1R5K6ok=; b=HrKBts6EZ6Y2
 HhKdy+HyppzSh2qUsV25EXnLXGXcSbt4olOUJ2QhcbljR6GDb500c/UAb8qFGn+7BeoBSGfudUnQN
 ZSzFTecc3oKH+kmuPCn96xWN1nIaXumUJ6wPd9jIO2MMrqS9KZlwdHAN+bd6zWpW7raYZUOytEHJM
 hmbb0=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1irOkd-0001V7-Vw; Tue, 14 Jan 2020 16:09:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A8EE7D02C77; Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20200103011754.GA260926@dtor-ws>
Message-Id: <applied-20200103011754.GA260926@dtor-ws>
X-Patchwork-Hint: ignore
Date: Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: Intel: bytcr_rt5651: switch to using
	devm_fwnode_gpiod_get()" to the asoc tree
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

   ASoC: Intel: bytcr_rt5651: switch to using devm_fwnode_gpiod_get()

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

From e26c4e900b1a75b1e0c9e19e1f807666a8ad2fa1 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 2 Jan 2020 17:17:54 -0800
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: switch to using
 devm_fwnode_gpiod_get()

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20200103011754.GA260926@dtor-ws
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3bb2732a9f7e..6d71352ea864 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -990,10 +990,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "ext-amp-enable", 0,
-						codec_dev->fwnode,
-						GPIOD_OUT_LOW, "speaker-amp");
+		priv->ext_amp_gpio = devm_fwnode_gpiod_get(&pdev->dev,
+							   codec_dev->fwnode,
+							   "ext-amp-enable",
+							   GPIOD_OUT_LOW,
+							   "speaker-amp");
 		if (IS_ERR(priv->ext_amp_gpio)) {
 			ret_val = PTR_ERR(priv->ext_amp_gpio);
 			switch (ret_val) {
@@ -1009,10 +1010,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				return ret_val;
 			}
 		}
-		priv->hp_detect = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "hp-detect", 0,
-						codec_dev->fwnode,
-						GPIOD_IN, "hp-detect");
+		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
+							codec_dev->fwnode,
+							"hp-detect",
+							GPIOD_IN,
+							"hp-detect");
 		if (IS_ERR(priv->hp_detect)) {
 			ret_val = PTR_ERR(priv->hp_detect);
 			switch (ret_val) {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
