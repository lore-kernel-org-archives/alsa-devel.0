Return-Path: <SRS0=bNm3=2P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19608C2D0C3
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 00:14:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9644520679
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I/01CXO/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iTz0/DPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9644520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0A7C16BA;
	Wed, 25 Dec 2019 01:14:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0A7C16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577232897;
	bh=p4P3A8nS0a+6GBeENFLTS5ouiuMxJAOttjkmVtzZDwo=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=I/01CXO/bumvuF36oxP61OozaKP2SQ6iX24KNP+F/cYmxCRPP79VEucxqsNwuO1Kj
	 w3STa4ewTd3aWxPAPlHPFc2Ur2dfKFiz2J/osvzH0xatRK0jCoYx2+86EBAzhxUyjs
	 nkDaCTkxFysyyQv7ORklY15ugQVysy4ZTGQfkZXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A411DF802A9;
	Wed, 25 Dec 2019 01:09:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15245F8027D; Wed, 25 Dec 2019 01:09:18 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79B7EF800E3
 for <alsa-devel@alsa-project.org>; Wed, 25 Dec 2019 01:09:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79B7EF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="iTz0/DPV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=4W5HfLIfwUdrt3/2lU7BxRO+SDUjDxhkYLcwq17mi1c=; b=iTz0/DPVXdrj
 60vcmg/eKXMB7B6mwq6jmSr8eyWGAE6kbANVMT/LHjfMX89y1QasYcYudhKruU2wVEbPDvzwYyhg5
 pP48btxFHanNWv8Eu3+4WogGvXwILwfc/9sJiH6uOofIUycA0wHomf7LJ8Y4hx3TdYD2D+0vebvkT
 wXu+g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ijuEY-0007LM-4c; Wed, 25 Dec 2019 00:09:02 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A06DED01957; Wed, 25 Dec 2019 00:09:01 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Date: Wed, 25 Dec 2019 00:09:01 +0000 (GMT)
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: fsl_audmix: add missed
	pm_runtime_disable" to the asoc tree
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
Message-ID: <20191225000901.Jj8KWXvtT2PMEzb1zjb3iCQvq7yKwLNUZw7mSNaK7_c@z>

The patch

   ASoC: fsl_audmix: add missed pm_runtime_disable

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

From 77fffa742285f2b587648d6c72b5c705633f146f Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 3 Dec 2019 19:13:03 +0800
Subject: [PATCH] ASoC: fsl_audmix: add missed pm_runtime_disable

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20191203111303.12933-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index a1db1bce330f..5faecbeb5497 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -505,15 +505,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_disable_pm;
 	}
 
 	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
 		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
+		goto err_disable_pm;
 	}
 
+	return 0;
+
+err_disable_pm:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -521,6 +526,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
