Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92510C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:18:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626A06108D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 626A06108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A12681685;
	Wed, 18 Aug 2021 17:18:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A12681685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629299931;
	bh=hsfJ0ac13TEY4MTKREFEYmNWAzMWz44gYf8stSnKUO0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eSCg/N981ZKicVRA30V0eYv5rUey69Vv2vTOx+1lfGplRejiGbm7xtA19Z7LPzkv4
	 5O9Ip9gE26ZjshomZOmg2ibCKXC2bwG5EI1aFvade9/ep4XxLEkuOnfximgFqedt5X
	 f1kuBqcWAvRx+6Z7N4imQD18yS4pVqai7Buik5ug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29EC9F80169;
	Wed, 18 Aug 2021 17:18:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B6DDF80249; Wed, 18 Aug 2021 17:17:59 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93105F80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 17:17:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93105F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="hf4+LckN"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B0AE13F361; 
 Wed, 18 Aug 2021 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629299866;
 bh=z5jVFxsMugjMYW/N4BEa1uHFJbg9/7T7WDVguO5VseE=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=hf4+LckNw4pkWkuwMlwbVkmrw9okQEDxKdkcCSMAUMHNySVa0i9QPu/En3qJSZJeU
 t4x9CtV6yubBhn1kFq/mRQfK6GOUMNmhDMO2fqqQznJY8/6lzi1aBQLByu44/Z2wvL
 ANfox6rDlHHMKnaVrXgSyWkagjTYyfQwiDgYn+Fj18bLYDG1mi8N9Iq49Zr3a7wC8l
 ieDDfsYsU1JlKDn+UgEryq+2MxlIBOV/7jUFqJokvreB2WX0HK+ovS+nSTCwlZc5VN
 u6tPsLrb9BOrni6AFUdKYYdQ17RQqbv6lhowtZgfydvFxbv8Do9muwQATqUbd31ii5
 3ANfJY9nwOIyQ==
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: uniphier: make arrays mul and div static const,
 makes object smaller
Date: Wed, 18 Aug 2021 16:17:46 +0100
Message-Id: <20210818151746.38520-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Don't populate the arrays mul and div on the stack but instead make them
static const. Makes the object code smaller by 4 bytes.

Before:
   text    data     bss     dec     hex filename
  16226    4984      64   21274    531a ./sound/soc/uniphier/aio-cpu.o

After:
   text    data     bss     dec     hex filename
  16062    5144      64   21270    5316 ./sound/soc/uniphier/aio-cpu.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/uniphier/aio-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index cf9814130067..4e8d5f7532ba 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -128,8 +128,8 @@ static const struct uniphier_aio_spec *find_spec(struct uniphier_aio *aio,
 static int find_divider(struct uniphier_aio *aio, int pll_id, unsigned int freq)
 {
 	struct uniphier_aio_pll *pll;
-	int mul[] = { 1, 1, 1, 2, };
-	int div[] = { 2, 3, 1, 3, };
+	static const int mul[] = { 1, 1, 1, 2, };
+	static const int div[] = { 2, 3, 1, 3, };
 	int i;
 
 	if (!is_valid_pll(aio->chip, pll_id))
-- 
2.32.0

