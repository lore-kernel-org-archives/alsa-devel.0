Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D10C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:54:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B9B22240
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GBVpy4Yo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVyFoOEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B9B22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A200F1727;
	Thu, 18 Jun 2020 03:53:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A200F1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592445242;
	bh=iUc/GN+5ZpqakFuu/t3oXtaFHF2zHmLqIPuR7EGbeYg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBVpy4YozpZOGze06qDbSVWNYpyMXTLCoTpaQsvFK8hyQX8XZX7CgrgL2Iep5S8gm
	 JUEYh8dVysqJCJlb/5u0w2HwLA1wpUfAZlDuaA/uFocq3vy+rVzMuzn4HCPR1nKEaa
	 D9UTClQ6MyboyNdJZOIcMVgZ6t7xO1+IHXHBSNnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62089F802E8;
	Thu, 18 Jun 2020 03:25:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57C23F80383; Thu, 18 Jun 2020 03:24:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26EA9F8037D
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26EA9F8037D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HVyFoOEk"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF77F21974;
 Thu, 18 Jun 2020 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443491;
 bh=iUc/GN+5ZpqakFuu/t3oXtaFHF2zHmLqIPuR7EGbeYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HVyFoOEkTfCSUl9TOZPpNtES6aJ5CuRTc+tifLUOyZb4smBXwLlTS/kDt19F53xtt
 twYZFhwrYahUI30mVzYxWJZGqALWNjxTZwbBAeZ1vgwM8y3bbDUE3zsd2lEj2iz3Ys
 gvitFfbhEvvrz5XvK8yy86/JB5RJm+1z26tOdAwE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/172] ASoC: fix incomplete error-handling in
 img_i2s_in_probe.
Date: Wed, 17 Jun 2020 21:21:25 -0400
Message-Id: <20200618012218.607130-119-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Qiushi Wu <wu000273@umn.edu>
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

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 25bf943e4e7b47282bd86ae7d39e039217ebb007 ]

Function "pm_runtime_get_sync()" is not handled by "pm_runtime_put()"
if "PTR_ERR(rst) == -EPROBE_DEFER". Fix this issue by adding
"pm_runtime_put()" into this error path.

Fixes: f65bb92ca12e ("ASoC: img-i2s-in: Add runtime PM")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200525055011.31925-1-wu000273@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-i2s-in.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 388cefd7340a..c22880aea82a 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -485,6 +485,7 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
+			pm_runtime_put(&pdev->dev);
 			goto err_suspend;
 		}
 
-- 
2.25.1

