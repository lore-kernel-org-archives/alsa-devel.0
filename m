Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D35C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 21 May 2022 11:13:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E994116FE;
	Sat, 21 May 2022 13:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E994116FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653131604;
	bh=2WV95uA4L77JkahOplR1U6cew5t0+jVHs1csJdX7rNA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L5PF9zXj5VpR1V2V1CaD1/Z8RM0mlqgtCM+y4vH73JCT6h63cr4lh3byQCrzyWU7W
	 +w88jvRl+c/JOweUa93GmUnKQ8LDN35eKcpWIrc6h24TB1cWdd13ygZ1Hqzvtl1Y81
	 ojPHap0zFIDk1BoBsab1iCF7W+FeO//93Hmd66Nw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30FB5F804CA;
	Sat, 21 May 2022 13:12:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BAEAF80212; Sat, 21 May 2022 13:12:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25182F800D2
 for <alsa-devel@alsa-project.org>; Sat, 21 May 2022 13:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25182F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr
 header.b="mEpdmp9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N3RDg1x0n+WbKnIQmUyewjqWSlz3Ckp24b++BGrDZF8=;
 b=mEpdmp9QBpryUwFXcRalpXycTdjluSdOqCWavqcvuK+bAcVMB/dp7yNk
 g8uflwSRXq23Hx0hxKJsW10mBbBbUqbsZ68ILjOeL5NTFIh9Fg/2n9jTt
 btP34bMnLF6mkGa/5j+SbRN2U+WBpVwbs6W/2KH+DG9PxGfDP1XVo6f9r M=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; d="scan'208";a="14727941"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:59 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: ctxfi: fix typo in comment
Date: Sat, 21 May 2022 13:10:54 +0200
Message-Id: <20220521111145.81697-44-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
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

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/ctxfi/cthw20k1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 0cea4982ed7d..9edbf5d8c3c7 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1916,7 +1916,7 @@ static int hw_card_start(struct hw *hw)
 
 	}
 
-	/* Switch to X-Fi mode from UAA mode if neeeded */
+	/* Switch to X-Fi mode from UAA mode if needed */
 	if (hw->model == CTUAA) {
 		err = uaa_to_xfi(pci);
 		if (err)

