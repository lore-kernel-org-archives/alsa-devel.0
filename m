Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D597C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:20:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A02720678
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o+0cauJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14F241663;
	Mon,  3 Aug 2020 16:19:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14F241663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596464443;
	bh=VJPI7XRLltjBW4LXoNG7pzyn34oFaqsLy12l4I5LyR0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+0cauJt7vg/wCPSuZ5zWVZ3zHpWa4oFf1Ag8SVkRFT6qBn/Z6+f9xWrX2uhq0gTy
	 eGphhVOD5RL9CQ6+Tg3tRQgA6F8FpXZDPcYTm6BvfbujMJwjT+Fz8CSRs5q/VEOW8K
	 GwVn2HPX3sphMxuJ7s+uuDZh+SIxXI7KjaI+sFbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72988F802BE;
	Mon,  3 Aug 2020 16:19:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FB07F80148; Mon,  3 Aug 2020 16:18:58 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31508F80148
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 16:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31508F80148
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C6B2BB66E;
 Mon,  3 Aug 2020 14:19:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] ASoC: tegra: tegra210_admaif: Fix compile warning with
 CONFIG_PM=n
Date: Mon,  3 Aug 2020 16:18:47 +0200
Message-Id: <20200803141850.23713-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200803141850.23713-1-tiwai@suse.de>
References: <20200803141850.23713-1-tiwai@suse.de>
Cc: Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org
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

Fix trivial compile warnings wrt unused functions by adding
__maybe_unused prefix:
  sound/soc/tegra/tegra210_admaif.c:232:12: warning: 'tegra_admaif_runtime_resume' defined but not used [-Wunused-function]
  sound/soc/tegra/tegra210_ahub.c:567:12: warning: 'tegra_ahub_runtime_suspend' defined but not used [-Wunused-function]

Fixes: f74028e159bb ("ASoC: tegra: Add Tegra210 based ADMAIF driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra210_admaif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_admaif.c b/sound/soc/tegra/tegra210_admaif.c
index 4894e8e6ee7f..1268046b345d 100644
--- a/sound/soc/tegra/tegra210_admaif.c
+++ b/sound/soc/tegra/tegra210_admaif.c
@@ -219,7 +219,7 @@ static const struct regmap_config tegra186_admaif_regmap_config = {
 	.cache_type		= REGCACHE_FLAT,
 };
 
-static int tegra_admaif_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_admaif_runtime_suspend(struct device *dev)
 {
 	struct tegra_admaif *admaif = dev_get_drvdata(dev);
 
@@ -229,7 +229,7 @@ static int tegra_admaif_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_admaif_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_admaif_runtime_resume(struct device *dev)
 {
 	struct tegra_admaif *admaif = dev_get_drvdata(dev);
 
-- 
2.16.4

