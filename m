Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1099CC07E9D
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 10:31:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AD561006
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 10:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AD561006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7263682E;
	Mon, 19 Jul 2021 12:30:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7263682E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626690709;
	bh=Dn4JRemfgLHYg6P2PuPq3Al7j7o0iRqOc0U7NC9wfEE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ac8hOgPe0kFraaoXJqrbcbhX3SC10QU7ncKAEncUqItCYVqO3s3lDbTiMFSiFKhzj
	 DVTCvBAOdU8Mm0u4fAuplex0Kp9NtEoUmB7317q0kl5QBGiUR3f8LfCyYrPASWiW9o
	 EMEjtGR/WCt8f0kk8XyLCxWNmPPCa8aLnPUozoGk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06E2FF80218;
	Mon, 19 Jul 2021 12:30:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0848DF80227; Mon, 19 Jul 2021 12:30:57 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E4FBF800DA
 for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2021 12:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E4FBF800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="r9RMg/uw"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 649FB40207; 
 Mon, 19 Jul 2021 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626690644;
 bh=hya7L108CUJRjE5JN1TFdEqd6eaNpO4wxcvgoKtlo4E=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=r9RMg/uw6Hh0RhemOxOA48/WC6wWMhhZaTazsd8bzf7WwLE8AB4J75mBB7uW50AF7
 VdpuGf9RK92KMGZ+cUWE1DlZKQx7mUALg/5RPu0gfIGo214asrEAg60n7OO/Zt0JkV
 13eoczS+BP/jC+vSG4Sytsmyce6xonS/4dHd1/75ufQjiywSeVYJnSMsoOlYlUlYml
 O8/p26IDhLgfhPNA/FGMOJkEiD3AXws/Nmf37a0IflXM8YC3cRlzC2cUC+hspIUsOa
 D1RCIgtzQMVdoGlyfACT63DD4jlzv7p4w+J1vchiLIiJRz3l07/EjK5xJUTHhiUkd5
 wLxe7hE61o0KA==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] sound: Fix spelling mistake "synchronization" ->
 "synchronization"
Date: Mon, 19 Jul 2021 11:30:44 +0100
Message-Id: <20210719103044.15315-1-colin.king@canonical.com>
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

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/drivers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 7141f73cddd3..ca4cdf666f82 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -102,7 +102,7 @@ config SND_ALOOP
 	  configured number of substreams (see the pcm_substreams module
 	  parameter).
 
-	  The loopback device allows time sychronization with an external
+	  The loopback device allows time synchronization with an external
 	  timing source using the time shift universal control (+-20%
 	  of system time).
 
-- 
2.31.1

