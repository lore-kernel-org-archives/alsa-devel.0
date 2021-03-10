Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D3C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 19:34:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDDC64FB2
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 19:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDDC64FB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82A1F1702;
	Wed, 10 Mar 2021 20:33:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82A1F1702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615404838;
	bh=gwXRZ5UJgu1hAM5FqZTaeDqfPX+e70coJ6SxO4EqahY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NvZbhdq+tNA3dortw86yMwvBFIJ2+QtVpBf/9+GtfQVWo/OZO5dFnyduwfHukE1uA
	 1BY0fy8lrQFnpQhR6P8rMsLxs6elwVgSchYGirGCZ9+NBg3RO78X8wRLK620exF73c
	 rwHEZ2/zm7kV2aneK3wxI6NrguzNhFd37BIR7ygU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1734F8010D;
	Wed, 10 Mar 2021 20:33:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6571F801D8; Wed, 10 Mar 2021 20:33:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFB8BF8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 20:33:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFB8BF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YOvJsN6T"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B523B64EF6;
 Wed, 10 Mar 2021 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615404776;
 bh=gwXRZ5UJgu1hAM5FqZTaeDqfPX+e70coJ6SxO4EqahY=;
 h=From:To:Cc:Subject:Date:From;
 b=YOvJsN6TCfMtjSBAln04iUJm6N65fMwIiUNbErAkavduoU8h6zxQMhvwS/p2hIHK9
 A3UYTsttiL86iZWxbFFbULMD63KUDegYsnQgcnFCb1l22KnLOm0o3v6TYqBEHHycBi
 GorVFe9druHSl6Qr21BA3qKnrMjVUvdqrlrKO6g+jfu8egSgd+tbAU0Ef+JOyZwjxI
 jujvGVKaVhxOYQaYIza+Y0pJAhyjaDAWgRzRgbaTehmJMyTDQ7HsfeE5bmtl1hgc1W
 eb+okHttbgJkjy0Y8ifgl+ZFgDnrvHU1OWhIe2uXS737dZ0Jik5eutW+Y+qquzTD3R
 V+9oc09fRW62Q==
From: Wolfram Sang <wsa@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: ppc: keywest: remove outdated comment
Date: Wed, 10 Mar 2021 20:32:27 +0100
Message-Id: <20210310193227.333140-1-wsa@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org
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

The I2C attach_adapter callback is gone. Remove this reference.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 sound/ppc/keywest.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index a6c1905039de..a8915100d6bb 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -13,12 +13,7 @@
 #include <sound/core.h>
 #include "pmac.h"
 
-/*
- * we have to keep a static variable here since i2c attach_adapter
- * callback cannot pass a private data.
- */
 static struct pmac_keywest *keywest_ctx;
-
 static bool keywest_probed;
 
 static int keywest_probe(struct i2c_client *client,
-- 
2.30.0

