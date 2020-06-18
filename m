Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CACC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:33:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEA9207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qBeoAyi1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vf243AJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEA9207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBA4A169C;
	Thu, 18 Jun 2020 03:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBA4A169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592444022;
	bh=082nMbW7W4EL25ot2oiMRYNGZ531syXYTu7mVW7Gabo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBeoAyi1txI2APuM2n1zLD0/JtRAYQHg2X90qT6PZvFUCqFnkv21xSjrPpeE2wVQ0
	 s4EyCtIuUREdhkNkFX0ubUilcpVmpl4Uhkl/Ew7qdb5k3bWK+73IWs2nC7dk82G6ub
	 jYBiXdugSKiWAI0teAqbZ+R4kvmuOdkyYRlS0kM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60D6CF80407;
	Thu, 18 Jun 2020 03:16:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F469F80407; Thu, 18 Jun 2020 03:16:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF6E9F80315
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF6E9F80315
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vf243AJj"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5EA71221ED;
 Thu, 18 Jun 2020 01:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443005;
 bh=082nMbW7W4EL25ot2oiMRYNGZ531syXYTu7mVW7Gabo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vf243AJj/k+EsVeXSSw/2fKB9ZWYnapKldOO1HYH3sZ/RhFUDKL9dPXX2jHsjCFIB
 twDlHUGDnbaqbUYV9wP/FrSHetIFoUbSDYPVVGKxebiBdoWTdQ9EXSl9/EEekMXnwJ
 ifRc0jnJOZhpmEyQS4dYG+zGk5lE7u8NI7caGif8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 010/266] ASoC: fsl_esai: Disable exception
 interrupt before scheduling tasklet
Date: Wed, 17 Jun 2020 21:12:15 -0400
Message-Id: <20200618011631.604574-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 1fecbb71fe0e46b886f84e3b6decca6643c3af6d ]

Disable exception interrupt before scheduling tasklet, otherwise if
the tasklet isn't handled immediately, there will be endless xrun
interrupt.

Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7a49d03463a..84290be778f0 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -87,6 +87,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE)) &&
 	    esai_priv->reset_at_xrun) {
 		dev_dbg(&pdev->dev, "reset module for xrun\n");
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				   ESAI_xCR_xEIE_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				   ESAI_xCR_xEIE_MASK, 0);
 		tasklet_schedule(&esai_priv->task);
 	}
 
-- 
2.25.1

