Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176BCC433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Nov 2022 17:17:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F82F166C;
	Sun,  6 Nov 2022 18:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F82F166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667755073;
	bh=oF0/D4qWndnp4p2zWUMltEaD5+xi723ayYB6dsaUmqM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQ3JVk3ASxeHemMIT4n5tq7mObIH+HrwuxaxTZ3/P4rzTZskS1f1w75zs/a6Pc80G
	 Lwt5KqHGdF33RlvWfCmQFAJG2MWZgnD7eFZRU7ajp45dOcjJ0l35rd11QnwMsKUKpb
	 EZdft6GlZ15Aw0sLdQHbleqExWzo/kRJ8fiiVhkk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D2DCF8063C;
	Sun,  6 Nov 2022 18:07:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C43AF8067D; Sun,  6 Nov 2022 18:07:18 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B5AFF8067C
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2022 18:07:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B5AFF8067C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TJ/e6y1p"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EE7E560C8F;
 Sun,  6 Nov 2022 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485CBC433C1;
 Sun,  6 Nov 2022 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667754434;
 bh=oF0/D4qWndnp4p2zWUMltEaD5+xi723ayYB6dsaUmqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TJ/e6y1pRTeY7hUrxwYo3oC5dyVUNoMRIl+kQwlSLzH4y4se7JA6B3FNxRlb9xx3M
 hqbjNIz2hv4OJKi3zT7314pOg2RNlrKRE2tZeazl6aCnEfLn+aL8ddbdZmFHCxp9S4
 CzSFehvUltKyxXZlAeNML+ArethPJhJbJUXl6qT5LguZ8c6KDt4b5pufJzeJFM6hAk
 vMD5K65yN6/d3Nu6SHLokiJtLa1JMASV9Br1jhJSinR2+zDM9H8iFe5W+A35EPgKv1
 yGgPpsLFCa27ELTNTKH8B4awcCLvCArkyDhs94DFnLbskt1d2rN5ippGGO9vhx4HEj
 up1Y2mfK4yIaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/7] ASoC: wm8997: Revert "ASoC: wm8997: Fix PM
 disable depth imbalance in wm8997_probe"
Date: Sun,  6 Nov 2022 12:07:00 -0500
Message-Id: <20221106170705.1580963-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106170705.1580963-1-sashal@kernel.org>
References: <20221106170705.1580963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Zhang Qilong <zhangqilong3@huawei.com>, tiwai@suse.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>
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

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit 68ce83e3bb26feba0fcdd59667fde942b3a600a1 ]

This reverts commit 41a736ac20602f64773e80f0f5b32cde1830a44a.

The pm_runtime_disable is redundant when error returns in
wm8997_probe, we just revert the old patch to fix it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20221010114852.88127-4-zhangqilong3@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8997.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 9f819113af1e..bb6a95be8726 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1159,6 +1159,9 @@ static int wm8997_probe(struct platform_device *pdev)
 		regmap_update_bits(arizona->regmap, wm8997_digital_vu[i],
 				   WM8997_DIG_VU, WM8997_DIG_VU);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_idle(&pdev->dev);
+
 	arizona_init_common(arizona);
 
 	ret = arizona_init_vol_limit(arizona);
@@ -1177,9 +1180,6 @@ static int wm8997_probe(struct platform_device *pdev)
 		goto err_spk_irqs;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_idle(&pdev->dev);
-
 	return ret;
 
 err_spk_irqs:
-- 
2.35.1

