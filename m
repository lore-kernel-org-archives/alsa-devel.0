Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EBC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197D32076E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ANXmGXwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197D32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D35E1668;
	Mon,  3 Aug 2020 16:21:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D35E1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596464525;
	bh=wmZlqZjBCObpUBM+P04gEBWf/mAv+EledPh9jR2EmAs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANXmGXwTuj5KJIwBUiKIsvpNoeNgkncE4hbBeUNZvG/N43jbJkiXs4L6vLWK0MMzR
	 XyB6EyrtBbaVQIF3uD3vk06U8G47wcnBXbQgKih6mmJGD5y5LZW+vsZCWEaD+zlBgH
	 6yvzFvjDtP8za3H1UDonCi4hTSRJmUybod2nOFMA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98DD1F80234;
	Mon,  3 Aug 2020 16:19:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D174F802C3; Mon,  3 Aug 2020 16:19:05 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73A2FF80234
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 16:18:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73A2FF80234
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EED45B6B6;
 Mon,  3 Aug 2020 14:19:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: tegra: tegra210_i2s: Fix compile warning with
 CONFIG_PM=n
Date: Mon,  3 Aug 2020 16:18:50 +0200
Message-Id: <20200803141850.23713-6-tiwai@suse.de>
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
  sound/soc/tegra/tegra210_i2s.c:167:12: warning: 'tegra210_i2s_runtime_suspend' defined but not used [-Wunused-function]
  sound/soc/tegra/tegra210_i2s.c:179:12: warning: 'tegra210_i2s_runtime_resume' defined but not used [-Wunused-function]

Fixes: c0bfa98349d1 ("ASoC: tegra: Add Tegra210 based I2S driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra210_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index 722092181583..a383bd5c51cd 100644
--- a/sound/soc/tegra/tegra210_i2s.c
+++ b/sound/soc/tegra/tegra210_i2s.c
@@ -164,7 +164,7 @@ static int tegra210_i2s_init(struct snd_soc_dapm_widget *w,
 	return tegra210_i2s_sw_reset(compnt, is_playback);
 }
 
-static int tegra210_i2s_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra210_i2s_runtime_suspend(struct device *dev)
 {
 	struct tegra210_i2s *i2s = dev_get_drvdata(dev);
 
@@ -176,7 +176,7 @@ static int tegra210_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra210_i2s_runtime_resume(struct device *dev)
+static int __maybe_unused tegra210_i2s_runtime_resume(struct device *dev)
 {
 	struct tegra210_i2s *i2s = dev_get_drvdata(dev);
 	int err;
-- 
2.16.4

