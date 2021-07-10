Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A17C07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:48:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863A1613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863A1613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22871176C;
	Sat, 10 Jul 2021 04:47:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22871176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885313;
	bh=AoD/7CWDXvR+9ak/sKEZmG77jR/GQC1p+n/HlENlaC4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQ5BRO/fVOiIEUqkiqtaLTqRe1gcetBAS+wDKNfYnVt5HEFyu6J2SHaMtEyI4+a7T
	 Y+JlMFIM6CrVAdrVLZE0wLwXb+Vk0jB/6dpb4mPpnV2MDYMczc137NLu6E5Nv6K8zR
	 MWQjpV0SeFDbvQWeslRY9YPHf6jZGvcjQJ7938Pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50838F80589;
	Sat, 10 Jul 2021 04:32:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7CB1F80589; Sat, 10 Jul 2021 04:32:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00140F8057A
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00140F8057A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="O/SFGDVe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39FFF613D3;
 Sat, 10 Jul 2021 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884335;
 bh=AoD/7CWDXvR+9ak/sKEZmG77jR/GQC1p+n/HlENlaC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O/SFGDVeo/SsBOA3ZyAK2JfixOFQSDo5mW1uZCreJA9u9MhlnTgoQotO31F/YD6si
 gR4esTJS4zc2pTG89P7MwAvwCq7c6LErGLDKm9GsTj+jZW34ErosGfpCw1t3szb5bZ
 wgoKUqZSc2LSwjVJTSfaZ3DI+hluPPeaoFTddem7jZjmn/+zdjpcVkLL6L8L9RjYGQ
 e3tblEAeDDxG01L5vkcl/x5Pg0fx3zB2cmZRAk/gYKKy/izhu2HvgbQc0IvEmVOq8t
 OsCsE+WbR9dwgx9RIi02amp0SmEH55LXDLKJzbfu7LP1v+EYYLLNifXWppSn74nyrV
 T1zn1ifARlQEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/39] ALSA: ac97: fix PM reference leak in
 ac97_bus_remove()
Date: Fri,  9 Jul 2021 22:31:34 -0400
Message-Id: <20210710023204.3171428-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023204.3171428-1-sashal@kernel.org>
References: <20210710023204.3171428-1-sashal@kernel.org>
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
index ca50ff444796..d8b227e6d4cf 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -523,7 +523,7 @@ static int ac97_bus_remove(struct device *dev)
 	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2

