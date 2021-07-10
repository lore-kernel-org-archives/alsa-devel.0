Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FAC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:43:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E336124C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E336124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A7641723;
	Sat, 10 Jul 2021 04:42:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A7641723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885023;
	bh=cjFLiYvpXgJg5R8/A0oRgy/TxHOhY+yBWW71dNTeMZw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ImV1zUxdidASWrG4oV5Fx8rFFNUezpIvRe75ST6Nh0IOawJPsVu1TQ4mSvqPRAmI6
	 efj0BvmF+2mNdZOkKAp9uPLdidLba8OB7g9WID8Ap4ZqLHbK4o4NC4Hwdv9O9BT4qD
	 86H3vKf4aatwlW0L7UskgK87c8XNes3y1rUPEh1k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90E19F8062D;
	Sat, 10 Jul 2021 04:27:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52D4DF8062E; Sat, 10 Jul 2021 04:27:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E640F80624
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:27:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E640F80624
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RAPYi8Yb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D51461418;
 Sat, 10 Jul 2021 02:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884049;
 bh=cjFLiYvpXgJg5R8/A0oRgy/TxHOhY+yBWW71dNTeMZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RAPYi8YbQiSbENerZKu0d421JUr8WFn0J6mmkkyzPCgkG+MmTUlw9uHspvU/DhIEt
 j2hate/RrPFBBeYJjod21QPl2geCv1wBnqdyu6ePbw5dKzXIOZkeuB9rFmuSJGiiS+
 YlzAUj2Iv/532E5EV+AIMcQhJ6jUkvOWwJONzlChO0rlfGPHwRggnIXXW8KamqPa69
 4+0nPWoHnob5qDEjGWaXLYGN6GhIEkO4PFv9Ca9RYs3n1wPBDuhD2rdXhkqwtDfGH1
 zsBP3r+V04mFj3AkZFl+OAH5CQy6IgsdG1ZzzWiZI1WZKAdCzjnM2UGJ+YVLQoUJ7Z
 qW7DJajIgDd5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/63] ALSA: ac97: fix PM reference leak in
 ac97_bus_remove()
Date: Fri,  9 Jul 2021 22:26:22 -0400
Message-Id: <20210710022709.3170675-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022709.3170675-1-sashal@kernel.org>
References: <20210710022709.3170675-1-sashal@kernel.org>
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
index 7985dd8198b6..99e1728b52ae 100644
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

