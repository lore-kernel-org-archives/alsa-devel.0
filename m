Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B971C07E9B
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58CC613C5
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58CC613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6095516D9;
	Sat, 10 Jul 2021 04:37:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6095516D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884673;
	bh=1tBw5Zt9YPIrQK/9dRp5GoREl6y7xA8VRfsxmcF8F8I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtZI995UnUbhUfycWNA9j1XYBGOeKSyYNZgVTJ7X69xaQ1IIOHdm5qFVJPcEHkJl1
	 FXC0BvmNyOFHpyva/o0PJHDaxDu+Myy535Y39P6A8lv3WWYPsBOVDz9B7jOTi3YkyQ
	 DbOxuSfe5Ph2bC8RLFGHgIdjUk7juwYbRdzqQ1+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D8D6F80107;
	Sat, 10 Jul 2021 04:25:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3C80F8055A; Sat, 10 Jul 2021 04:25:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D327EF80552
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:25:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D327EF80552
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MpqqBhtR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE84613F4;
 Sat, 10 Jul 2021 02:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883930;
 bh=1tBw5Zt9YPIrQK/9dRp5GoREl6y7xA8VRfsxmcF8F8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MpqqBhtRDP1MZdvQObU42OqkWHjFjSAslm28T35diLCCnCiZrB0KxYpQrK5OqyUTw
 Vp+hPWm6S73xhcPG4sCk7caDEX2rCwN1Y97cqd+YewgOmm2FNQz/w9lUXbiHQ9Trml
 8qHPNwHpy003e+h2LiBxkCu5HoWSbtPJXhywVEa/Uq44I5Sngq4tv2vAbHmM4vrM5g
 0hxJFoXGY1PCvf+/nWdroTRk1xDvqFMxCnMQnF6+8XYosVwWrk1AEqOvYjoD/uxpZm
 OJgubjOT3o6dLiTu0XW1r+ymmN+3GYFKyhRn8nXnhszkcqzXNuEbVRlnNIK7RKR6Vw
 5RQm968xte23A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 47/93] ASoC: img: Fix PM reference leak in
 img_i2s_in_probe()
Date: Fri,  9 Jul 2021 22:23:41 -0400
Message-Id: <20210710022428.3169839-47-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Hulk Robot <hulkci@huawei.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Yufen Yu <yuyufen@huawei.com>
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

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 81aad47278539f02de808bcc8251fed0ad3d6f55 ]

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Link: https://lore.kernel.org/r/20210524093521.612176-1-yuyufen@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-i2s-in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 0843235d73c9..fd3432a1d6ab 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -464,7 +464,7 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_pm_disable;
 	}
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		goto err_suspend;
 
-- 
2.30.2

