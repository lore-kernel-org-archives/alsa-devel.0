Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D9C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 12:02:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7C461423
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 12:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F7C461423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06AAA1734;
	Thu,  9 Sep 2021 14:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06AAA1734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631188969;
	bh=GwWGm9WFdrC2XQPy9txcEwUY19vlnXcJNvKB8+v6fa0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExYXjhOeb2XzEmYt7zhVA++zPuCujTUiCsbGa8TJSe88XiafDiWzNT8OceZZ4XJWs
	 ZQEQiLetcL/TR1tvDXfbfpk9olDNz3sO1RHjCFc2Qmjlu+9PiZClKqLoWqympeGiuD
	 yGGoI9K97E/GUT9i+8uoSxi77HhIdoatmYpkXfPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA0F4F804FB;
	Thu,  9 Sep 2021 14:00:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A046F80510; Thu,  9 Sep 2021 14:00:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45B9CF804FB
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 14:00:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45B9CF804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BTivrnSB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9AD6329F;
 Thu,  9 Sep 2021 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188807;
 bh=GwWGm9WFdrC2XQPy9txcEwUY19vlnXcJNvKB8+v6fa0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BTivrnSBFF7BIaA2++vGxHWiMkHl21UndMKpHnpkKsRNDBdxneWz63ICZoyyDpmnC
 rup/4+5/neMn5KYeh2RLWKonI0NNfbE+pvxzGzbFHPw8iiF7whH7BEiJkqF/77SUCP
 lPO3pUJmpva1dWWFpeTaMl/ETfxK8DPquIpq9IRc0twkpR36d63LwVE2JAq63tqfys
 oZb2diDJkYSuB/H9cHsbEtqdEkFjc7PNWAY6SIWeMoegLZhfi7nFfU5Pf/iXjeyJ4t
 Vsx3XxJ58+PGu7pbboQmryhbiqjSrH2gMZxrWXvrhHOvRLH/UVmippxHQFzC856+tw
 1fug+JJWrUdIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 53/59] ASoC: rockchip: i2s: Fix regmap_ops hang
Date: Thu,  9 Sep 2021 07:58:54 -0400
Message-Id: <20210909115900.149795-53-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115900.149795-1-sashal@kernel.org>
References: <20210909115900.149795-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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

From: Sugar Zhang <sugar.zhang@rock-chips.com>

[ Upstream commit 53ca9b9777b95cdd689181d7c547e38dc79adad0 ]

API 'set_fmt' maybe called when PD is off, in the situation,
any register access will hang the system. so, enable PD
before r/w register.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Link: https://lore.kernel.org/r/1629950520-14190-4-git-send-email-sugar.zhang@rock-chips.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0e07e3dea7de..93a4829f80cc 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -188,7 +188,9 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct rk_i2s_dev *i2s = to_info(cpu_dai);
 	unsigned int mask = 0, val = 0;
+	int ret = 0;
 
+	pm_runtime_get_sync(cpu_dai->dev);
 	mask = I2S_CKR_MSS_MASK;
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -201,7 +203,8 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		i2s->is_master_mode = false;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_pm_put;
 	}
 
 	regmap_update_bits(i2s->regmap, I2S_CKR, mask, val);
@@ -215,7 +218,8 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		val = I2S_CKR_CKP_POS;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_pm_put;
 	}
 
 	regmap_update_bits(i2s->regmap, I2S_CKR, mask, val);
@@ -238,7 +242,8 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		val = I2S_TXCR_TFS_PCM | I2S_TXCR_PBM_MODE(1);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_pm_put;
 	}
 
 	regmap_update_bits(i2s->regmap, I2S_TXCR, mask, val);
@@ -261,12 +266,16 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		val = I2S_RXCR_TFS_PCM | I2S_RXCR_PBM_MODE(1);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_pm_put;
 	}
 
 	regmap_update_bits(i2s->regmap, I2S_RXCR, mask, val);
 
-	return 0;
+err_pm_put:
+	pm_runtime_put(cpu_dai->dev);
+
+	return ret;
 }
 
 static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
-- 
2.30.2

