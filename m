Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E2C07E9B
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C35610FB
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C35610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3605C1669;
	Tue, 20 Jul 2021 18:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3605C1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626797896;
	bh=NSxCliurqzb5bRoE9YRmWM/9Y/raMoqU6AjOwdBBb0M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kASrd0ZGHmy2j+jIPy2OvRC4eII9WpLM0ZM80eSv6+JsgGfezMZMUo+TG3G2ZAzQk
	 pBemc584xFh4JcYnNSVSq6PCViLiNDl67eFq64VC1NTv4HfcgpH6aCC6Y/fXkxWyhJ
	 SfpN0QiuvPsHXv9yPiwOT4NIKTbZpgtgA9b4ZrXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C707DF80169;
	Tue, 20 Jul 2021 18:17:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB5D0F8020D; Tue, 20 Jul 2021 18:17:24 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B114DF80104
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 18:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B114DF80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="O1Js6ANg"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 42B8B40605; 
 Tue, 20 Jul 2021 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626797831;
 bh=ovWvZYpFeH2hDUTYYPI0Dy/ZjyO3fV33Wt5GPE9ZRIo=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=O1Js6ANgPeOxlDdF/qT7ORtEBigap9LaPwaPQbw+228N0cQf8XW6H/kf55Cb4NwSD
 HQwUfqt58DrJ0lVKwzmGONK4pEE31xHdWRxsuhxUgXyB2MBODlcYdH8+DsLRYCi09X
 YtCWOn+DbOd/zowSeBO0nrrACQGGtwaS8pxEjj1m/Lj4EPYrx0UxBHn8NdGX70+qpp
 7ZhM1rotaaYpb/zwU8G7HFXE7rsSvSRAzV5J6pXHaOpKt5ygGiHarzeRdci1n+MSaB
 3T/7bQSyzAsegfCy48MB3/WTu/1VkboUsKGbEl97PoC2bzdx1jgClSmePuvN/m7uGK
 z1zNCzLYOE2ug==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH][next] ALSA: sc6000: Fix incorrect sizeof operator
Date: Tue, 20 Jul 2021 17:17:07 +0100
Message-Id: <20210720161707.74197-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Static analysis is warning that the sizeof being used is should be
of *vport and not vport. Although these are the same size it is not
a portable assumption to assume this is true for all cases.  Fix this
by using sizeof(*vport).

Addresses-Coverity: ("Sizeof not portable")
Fixes: 111601ff76e9 ("ALSA: sc6000: Allocate resources with device-managed APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sc6000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 6236c4fa766a..44c05b55fc15 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -552,7 +552,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 
 
 	err = snd_devm_card_new(devptr, index[dev], id[dev], THIS_MODULE,
-				sizeof(vport), &card);
+				sizeof(*vport), &card);
 	if (err < 0)
 		return err;
 
-- 
2.31.1

