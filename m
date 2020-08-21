Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C8C433E3
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:23:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DCF20578
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y1URrbP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFRBWAqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DCF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CA4B16A5;
	Fri, 21 Aug 2020 18:23:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CA4B16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598027031;
	bh=wfyP6ErZoZxY7ltPAxt9V2YaYyKjCJkU6bza5vC6jfQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y1URrbP9+HnSCfWKMvsMHW6/pHMdhHRWiPcbkAgKUH69vAGafkW+se2i2u7nVRLBH
	 AqCynNkWTfDS5zkbNvvShSUemdbzppoLrnXctOt86W5ec9tXql99H03N+/sp4nVJ8w
	 r6smy7u6rct0E5GfMrs7Eqf9kuTEgbTsVw8H3nF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8D0AF80343;
	Fri, 21 Aug 2020 18:16:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22304F80338; Fri, 21 Aug 2020 18:16:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 306F3F80331
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 18:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 306F3F80331
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jFRBWAqb"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26B0522B47;
 Fri, 21 Aug 2020 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598026555;
 bh=wfyP6ErZoZxY7ltPAxt9V2YaYyKjCJkU6bza5vC6jfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jFRBWAqb/PZDW3dW7YLDBkv1oQkKPhYsp5ynrsLNZ2jOLUSL8+GFbbjJ7tuO8YObb
 vNFRkuoaGBI9v4C3m6VpKHSzPzrfcOs8tFTV05pSI1z6234AHsKq8+nZgijirOSJHP
 9SjypydrbZS4sC54XYVosymUcy60L4NjkVm7+Rhc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 08/61] ASoC: img-parallel-out: Fix a reference
 count leak
Date: Fri, 21 Aug 2020 12:14:52 -0400
Message-Id: <20200821161545.347622-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
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

[ Upstream commit 6b9fbb073636906eee9fe4d4c05a4f445b9e2a23 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200614033344.1814-1-wu000273@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-parallel-out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 5ddbe3a31c2e9..4da49a42e8547 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -163,8 +163,10 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	ret = pm_runtime_get_sync(prl->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(prl->dev);
 		return ret;
+	}
 
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
-- 
2.25.1

