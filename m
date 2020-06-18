Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54526C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:24:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EE6221EC
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HCUJDZLO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="blu8ZLwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EE6221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7511816B1;
	Thu, 18 Jun 2020 03:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7511816B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592443455;
	bh=eqqdhs6Sudw4/8RR0ac1++R01qSNRzWPhMXqDumOfwQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCUJDZLO1QAM07awaOARzgfW9BhPw59zEECrWl6HmsDxnuI64ALwKmYE6b8yg8R+q
	 ZF4ETFfTqDd4NpEbp39L51/bljdrmz4t07291BGL3woZDMdydxd+KLJCVZqcdyTBmX
	 HrkZMfR1j0H0yyhghh2R9ZwNdZIRvZ920ZDRcp6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7484BF8037E;
	Thu, 18 Jun 2020 03:12:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF46AF8037E; Thu, 18 Jun 2020 03:12:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF630F8036F
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:12:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF630F8036F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="blu8ZLwG"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0C58214DB;
 Thu, 18 Jun 2020 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442741;
 bh=eqqdhs6Sudw4/8RR0ac1++R01qSNRzWPhMXqDumOfwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=blu8ZLwGUxaKfJ4984BjKEymUUjJE6LjgiFkq64dOkVQtI1oT5nc5OjTwfj1xligB
 DuJqEhx3yYHeQ4FZ28/x5sCXj6TZrzvPoCFTjS7nZnA91XuZgsQYlIImvVudCX3v1r
 BHplt+4MqiczWDy4x9TW58UE/KBfiuwolz9cALgU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 195/388] ASoC: ti: omap-mcbsp: Fix an error
 handling path in 'asoc_mcbsp_probe()'
Date: Wed, 17 Jun 2020 21:04:52 -0400
Message-Id: <20200618010805.600873-195-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Peter Ujfalusi <peter.ujflausi@ti.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-omap@vger.kernel.org
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 03990fd58d2b7c8f7d53e514ba9b8749fac260f9 ]

If an error occurs after the call to 'omap_mcbsp_init()', the reference to
'mcbsp->fclk' must be decremented, as already done in the remove function.

This can be achieved easily by using the devm_ variant of 'clk_get()'
when the reference is taken in 'omap_mcbsp_init()'

This fixes the leak in the probe and has the side effect to simplify both
the error handling path of 'omap_mcbsp_init()' and the remove function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Peter Ujfalusi <peter.ujflausi@ti.com>
Link: https://lore.kernel.org/r/20200512134325.252073-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-mcbsp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 3d41ca2238d4..4f33ddb7b441 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -686,7 +686,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp,
 						SNDRV_PCM_STREAM_CAPTURE);
 
-	mcbsp->fclk = clk_get(&pdev->dev, "fck");
+	mcbsp->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
 		dev_err(mcbsp->dev, "unable to get fck: %d\n", ret);
@@ -711,7 +711,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		if (ret) {
 			dev_err(mcbsp->dev,
 				"Unable to create additional controls\n");
-			goto err_thres;
+			return ret;
 		}
 	}
 
@@ -724,8 +724,6 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 err_st:
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
-err_thres:
-	clk_put(mcbsp->fclk);
 	return ret;
 }
 
@@ -1442,8 +1440,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 
 	omap_mcbsp_st_cleanup(pdev);
 
-	clk_put(mcbsp->fclk);
-
 	return 0;
 }
 
-- 
2.25.1

