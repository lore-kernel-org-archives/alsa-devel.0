Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC8C07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033E061428
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033E061428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90DB616BB;
	Sat, 10 Jul 2021 04:23:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90DB616BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625883887;
	bh=1BWtIQ+bDDju4B6IewjLGl2AaJcRH26LIim6FejbrmU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uw0ectiVZIxhgIaK7ZOlQLiz8ZFgGTHsAezOVqVydInEQwHczqYKI1Cq/Rxk4nxzD
	 5LxciHaO/xhGdmCrp62KZA31qNhEKBp7ao6dbQpM/A+MUJu3kwS+gt7/LW34QP3o35
	 bGfVOqc/w+jAvuGyJ1tUbwzGLXaaXsPJczfB2cVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11283F8054A;
	Sat, 10 Jul 2021 04:19:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04574F80551; Sat, 10 Jul 2021 04:19:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D343BF80542
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D343BF80542
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jesDHPTP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7920613D6;
 Sat, 10 Jul 2021 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883559;
 bh=1BWtIQ+bDDju4B6IewjLGl2AaJcRH26LIim6FejbrmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jesDHPTPLQQb75QxNMKYwuQCzUMwURiMNsy6Xz2cc0jgrf8qxSKfqqgEL9+dRn5nk
 ARCLsh1Jp+xoV9BogWbUen54lZ4VHsamM7IJBDyxTSkY1Lxztz3faTH9cAF8atzTpZ
 bTaio/Tv6ET3VYz6CSBVq/okIJJ9gDq0Ey3VQNwBwgJ+c1gK7m+DlNS/NgB3kcjE4/
 ZUSK+ZTk81UnVs5heZk7GNtP2wHdxajLX4ReqaFBkzMFLfGIkMwMudRVaHs5JfrXcm
 aUDXh8AZl+rV3xt3FifQc1HlRbyU5njLumnFVRBAr39e4/Zjvas92EWPfMgp6LtTUn
 ZGbPm92LGcjSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 067/114] ALSA: n64: check return value after
 calling platform_get_resource()
Date: Fri,  9 Jul 2021 22:17:01 -0400
Message-Id: <20210710021748.3167666-67-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710021748.3167666-1-sashal@kernel.org>
References: <20210710021748.3167666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Yang Yingliang <yangyingliang@huawei.com>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit be471fe332f7f14aa6828010b220d7e6902b91a0 ]

It will cause null-ptr-deref if platform_get_resource() returns NULL,
we need check the return value.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20210610124958.116142-1-yangyingliang@huawei.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/mips/snd-n64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/mips/snd-n64.c b/sound/mips/snd-n64.c
index e35e93157755..463a6fe589eb 100644
--- a/sound/mips/snd-n64.c
+++ b/sound/mips/snd-n64.c
@@ -338,6 +338,10 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	strcpy(card->longname, "N64 Audio");
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		err = -EINVAL;
+		goto fail_dma_alloc;
+	}
 	if (devm_request_irq(&pdev->dev, res->start, n64audio_isr,
 				IRQF_SHARED, "N64 Audio", priv)) {
 		err = -EBUSY;
-- 
2.30.2

