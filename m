Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC8BC11F68
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:28:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1995C613AF
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1995C613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A818716D1;
	Sat, 10 Jul 2021 04:28:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A818716D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884130;
	bh=psjiZPoJqTbIx9wY8pQaLI33HJVWFseOA6R/5ygYdO4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHIfx1phlXbUhdLKmsfzlD5V24uxPG+LyGlv4/9PluIvTch+K9Q4tPlT//5c8YCxU
	 HSqYTLS25QCP15XK0WWvSFVYbH6HfHVu8KNMJ7MesgwPTheG8A2M7USqsbsuhMQ/md
	 0oDJeyO/DFXBTRm7GrJsY2t2HmI/gBGvlhiowTF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BB21F804ED;
	Sat, 10 Jul 2021 04:22:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 173E5F80511; Sat, 10 Jul 2021 04:22:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F661F80506
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F661F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k6NI+Kkf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A349F613C3;
 Sat, 10 Jul 2021 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883755;
 bh=psjiZPoJqTbIx9wY8pQaLI33HJVWFseOA6R/5ygYdO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k6NI+KkfrBIHJuOy6BQjE1eXy+a32PC1SStf++dDIiWG5GJw8Yzm++FbzhmscTHHJ
 f+r/axvxL3g0/ppjpalCosl4STMoWgKrbNgxaiNu0hNWfT+Itre5XyB9xELETXQlVP
 5RA4CKk0xHxgG6Wzgsz4C09rK3sOhrzn/+XRtWZpGcIiuyn4YoNlnEdqXflMiaCvDI
 HZ0JgrQyDwjA1ez8SNsvju6HOOMIwKUklTW7R2lhnbX4aD6ozeDFlIlqO/DwAGNuB6
 dO8QHG5GdAs4SqX7FYqEzyouikvAHMIlf2vgBVdYvyI1JPnLTmiByKNQTJwXFFfgSz
 aOmdIjP6QhXWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 030/104] ALSA: ac97: fix PM reference leak in
 ac97_bus_remove()
Date: Fri,  9 Jul 2021 22:20:42 -0400
Message-Id: <20210710022156.3168825-30-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Hulk Robot <hulkci@huawei.com>,
 alsa-devel@alsa-project.org, Yufen Yu <yuyufen@huawei.com>,
 Sasha Levin <sashal@kernel.org>
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

[ Upstream commit a38e93302ee25b2ca6f4ee76c6c974cf3637985e ]

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Link: https://lore.kernel.org/r/20210524093811.612302-1-yuyufen@huawei.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/ac97/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index d9077e91382b..6ddf646cda65 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -520,7 +520,7 @@ static int ac97_bus_remove(struct device *dev)
 	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2

