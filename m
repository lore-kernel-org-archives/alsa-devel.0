Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6311FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B9F2076E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GVrI6bN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B9F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B6E1167E;
	Mon,  3 Aug 2020 16:21:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B6E1167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596464544;
	bh=5mdQ2P6w6h10d5BnTU+W0zCmKOJ2hm6MNyfcYSFn078=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVrI6bN6gi0jpPS1oWTh0JAfM/1oK5GEGt+T+P3ohqXsX7hqsELh1OKpzKFNt96g7
	 RBTzORgXzWFREZRnqjxiF9I+7bg+Ta44CS1VmV5j94Xr4OVNrQ8dIfwAwEXqdpxEyi
	 5txgfmKMAL5g8fM9tcTpxBNRvvOAWWnj3kr0zE7U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50F70F802DD;
	Mon,  3 Aug 2020 16:19:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55427F80218; Mon,  3 Aug 2020 16:19:05 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 021DDF801F7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 16:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 021DDF801F7
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E22BEB6B5;
 Mon,  3 Aug 2020 14:19:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: tegra: tegra210_dmic: Fix compile warning with
 CONFIG_PM=n
Date: Mon,  3 Aug 2020 16:18:49 +0200
Message-Id: <20200803141850.23713-5-tiwai@suse.de>
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
  sound/soc/tegra/tegra210_dmic.c:43:12: warning: 'tegra210_dmic_runtime_suspend' defined but not used [-Wunused-function]
  sound/soc/tegra/tegra210_dmic.c:55:12: warning: 'tegra210_dmic_runtime_resume' defined but not used [-Wunused-function]

Fixes: 8c8ff982e9e2 ("ASoC: tegra: Add Tegra210 based DMIC driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra210_dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_dmic.c b/sound/soc/tegra/tegra210_dmic.c
index d682414ad90d..a661f40bc41c 100644
--- a/sound/soc/tegra/tegra210_dmic.c
+++ b/sound/soc/tegra/tegra210_dmic.c
@@ -40,7 +40,7 @@ static const struct reg_default tegra210_dmic_reg_defaults[] = {
 	{ TEGRA210_DMIC_LP_BIQUAD_1_COEF_4, 0x0 },
 };
 
-static int tegra210_dmic_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra210_dmic_runtime_suspend(struct device *dev)
 {
 	struct tegra210_dmic *dmic = dev_get_drvdata(dev);
 
@@ -52,7 +52,7 @@ static int tegra210_dmic_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra210_dmic_runtime_resume(struct device *dev)
+static int __maybe_unused tegra210_dmic_runtime_resume(struct device *dev)
 {
 	struct tegra210_dmic *dmic = dev_get_drvdata(dev);
 	int err;
-- 
2.16.4

