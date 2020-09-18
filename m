Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E95C43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:08:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7642389E
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tBHdZJ75";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxvgzwtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7642389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD60116D1;
	Fri, 18 Sep 2020 04:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD60116D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600394901;
	bh=HRxq0ht/+5yrMdIpMbPQqA0bDRkCKb/DJ6jydnj2H9A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tBHdZJ757eMt5aj8od3v4GAh0/Dz/s91Ml/L8p0KoQRcUJJer2O2LP2/eDra5KQj5
	 HDLmIh7M3J13j0AMvifpHYE+u0lHwC4+EMtjHiP+Y+Jws6XlORIS+wuwaz8Tnb7z7H
	 qW/CLAhcdqsziLZXLk/ZtHncWOrlyEbBWRhAbxjo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28D9BF8015C;
	Fri, 18 Sep 2020 04:07:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 616F1F8015C; Fri, 18 Sep 2020 04:07:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D736F8012D
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 04:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D736F8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FxvgzwtE"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 136C7238E5;
 Fri, 18 Sep 2020 02:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394841;
 bh=HRxq0ht/+5yrMdIpMbPQqA0bDRkCKb/DJ6jydnj2H9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FxvgzwtEqgWsTY6jiPgdJFapAWW7GkBXHeMVOg/TixZtNdsOJnvHtKbNBvXyLq207
 j+DhSSUQPEc5rx7Mar9atRRrKG67KBttmont+PHJixjQJnpRO6yEONphWQipeO8DN6
 7wdbWDMeLE1CvFU4s2x9ipOvi32GGx7YNjoTw9S4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 299/330] ASoC: img-i2s-out: Fix runtime PM
 imbalance on error
Date: Thu, 17 Sep 2020 22:00:39 -0400
Message-Id: <20200918020110.2063155-299-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Dinghao Liu <dinghao.liu@zju.edu.cn>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 65bd91dd6957390c42a0491b9622cf31a2cdb140 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a pairing decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20200529012230.5863-1-dinghao.liu@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-i2s-out.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 4b18534096336..9c4212f2f7269 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -347,8 +347,10 @@ static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	chan_control_mask = IMG_I2S_OUT_CHAN_CTL_CLKT_MASK;
 
 	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2s->dev);
 		return ret;
+	}
 
 	img_i2s_out_disable(i2s);
 
@@ -488,8 +490,10 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_suspend;
+	}
 
 	reg = IMG_I2S_OUT_CTL_FRM_SIZE_MASK;
 	img_i2s_out_writel(i2s, reg, IMG_I2S_OUT_CTL);
-- 
2.25.1

