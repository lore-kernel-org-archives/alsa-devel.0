Return-Path: <SRS0=Vq+j=XC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49364C43331
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Sep 2019 07:38:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9FF21835
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Sep 2019 07:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vecAyLSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9FF21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0993C84D;
	Sat,  7 Sep 2019 09:38:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0993C84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567841931;
	bh=ZmBQO+WCG/0TXmD6J1Jwrx0+CczLKLNejt65PPmmbiE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vecAyLSmK/sGtkxpUVNleHaOaluCiWXf44tof5U6pPfRmuF9hxkDEkV7Zw6HmDEol
	 hbyHKp7/RuixagO+sX81A2tM8Bxy5CqpwPtCXSRxXCAaeew+4SlZm12/nPmcLW6RC4
	 j2W4l+gwBOPGRpWFoPFCH8ViFlBoBJKZyn+05YUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18CA5F800C6;
	Sat,  7 Sep 2019 09:38:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85771F80448; Sat,  7 Sep 2019 09:37:58 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22600F80171
 for <alsa-devel@alsa-project.org>; Sat,  7 Sep 2019 09:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22600F80171
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.76) (envelope-from <colin.king@canonical.com>)
 id 1i6VHZ-0005mc-Mc; Sat, 07 Sep 2019 07:37:17 +0000
From: Colin King <colin.king@canonical.com>
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Date: Sat,  7 Sep 2019 08:37:17 +0100
Message-Id: <20190907073717.21632-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: rt1011: make array pd static const,
	makes object smaller
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array pd on the stack but instead make it
static const. Makes the object code smaller by 100 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  51463	  13016	    128	  64607	   fc5f	sound/soc/codecs/rt1011.o

After:
   text	   data	    bss	    dec	    hex	filename
  51299	  13080	    128	  64507	   fbfb	sound/soc/codecs/rt1011.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt1011.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index f9235764ad32..be1e276e3631 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1519,7 +1519,8 @@ static const struct snd_soc_dapm_route rt1011_dapm_routes[] = {
 
 static int rt1011_get_clk_info(int sclk, int rate)
 {
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
+	int i;
+	static const int pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
 
 	if (sclk <= 0 || rate <= 0)
 		return -EINVAL;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
