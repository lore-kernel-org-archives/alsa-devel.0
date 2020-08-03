Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F0C433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:23:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04DC2076E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CMpK5gKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04DC2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47E7A166C;
	Mon,  3 Aug 2020 16:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47E7A166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596464590;
	bh=C3xPIeI/8xLEr3Ocgl4onvX6I/p53BfgcXHRasZINw4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMpK5gKa69GA623WDT1rLrPegV1tc+X3Sn+g+vqrarJKuUPUkxQdSSG7fGJ2B4siK
	 V6WQk9Seml8Tx+cie69ZwaCKYbLT2w4prfHt9s4NPNX6U7/5dkVdIf0RTfleiHCcTb
	 MCjIg6P0fR5jhA0GNdBnpGGL6LKNxGJOG5Mv9Uv8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D7CFF802DF;
	Mon,  3 Aug 2020 16:19:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98A0CF80218; Mon,  3 Aug 2020 16:19:05 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02780F80249
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 16:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02780F80249
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D410FB69D;
 Mon,  3 Aug 2020 14:19:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: tegra: tegra210_ahub: Fix compile warning with
 CONFIG_PM=n
Date: Mon,  3 Aug 2020 16:18:48 +0200
Message-Id: <20200803141850.23713-4-tiwai@suse.de>
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
  sound/soc/tegra/tegra210_ahub.c:567:12: warning: 'tegra_ahub_runtime_suspend' defined but not used [-Wunused-function]
  sound/soc/tegra/tegra210_ahub.c:579:12: warning: 'tegra_ahub_runtime_resume' defined but not used [-Wunused-function]

Fixes: 16e1bcc2caf4 ("ASoC: tegra: Add Tegra210 based AHUB driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra210_ahub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 5123a96fdde8..66287a7c9865 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -564,7 +564,7 @@ static const struct of_device_id tegra_ahub_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_ahub_of_match);
 
-static int tegra_ahub_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_ahub_runtime_suspend(struct device *dev)
 {
 	struct tegra_ahub *ahub = dev_get_drvdata(dev);
 
@@ -576,7 +576,7 @@ static int tegra_ahub_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_ahub_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_ahub_runtime_resume(struct device *dev)
 {
 	struct tegra_ahub *ahub = dev_get_drvdata(dev);
 	int err;
-- 
2.16.4

