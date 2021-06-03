Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BDBC47096
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 11:04:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF3613D7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 11:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF3613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 094BA16EE;
	Thu,  3 Jun 2021 13:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 094BA16EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622718266;
	bh=qB9IAX8LmwMD2qcZWXzit9JXON959MAs9XA2FNSlMYM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=smGrBWJEfzACBugmsZxZvSKzuO+a49dAGSGuglTjqV9HahNAABMmoXJ6Jsaxgz3wb
	 r2IIRYqNafHU6grgNWD8ifXCDKHay4Cusk172nu3kenHVENYPbnp/xKGrAq/BcNlND
	 wFEJSRX/KnPoWnbLBosQzr+tDbXKP37NWBZpT85g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EE58F80253;
	Thu,  3 Jun 2021 13:03:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D981F80103; Thu,  3 Jun 2021 13:03:34 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 979A6F80103
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 13:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 979A6F80103
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1lol87-0001vJ-K7; Thu, 03 Jun 2021 11:03:15 +0000
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH][next][V2] ASoC: rsnd: check for zero node count
Date: Thu,  3 Jun 2021 12:03:15 +0100
Message-Id: <20210603110315.81146-1-colin.king@canonical.com>
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

Most callers of_get_child_count() check that "nr" is non-zero so it
causes a static checker warning when we don't do that here.  This
does not cause a problem or a crash, but having zero SSUIes does not
make sense either so let's add a check.

Addresses-Coverity: ("Unchecked return value")
Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: Rephrase commit message based on Dan Carpenter's suggestion.
    Thanks Dan!
---

 sound/soc/sh/rcar/ssiu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 5682c74bb7ff..0d8f97633dd2 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -515,6 +515,9 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 	else
 		nr = priv->ssi_nr;
 
+	if (!nr)
+		return -EINVAL;
+
 	ssiu	= devm_kcalloc(dev, nr, sizeof(*ssiu), GFP_KERNEL);
 	if (!ssiu)
 		return -ENOMEM;
-- 
2.31.1

