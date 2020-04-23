Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C9C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:40:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303AC2084D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HBmmNlGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303AC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88C06169C;
	Thu, 23 Apr 2020 10:39:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88C06169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587631227;
	bh=QeParkXYpL36mPo7eGEquE0H0KvHsdZumXnyDTkPgHo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HBmmNlGtke3PNJVzT2/vVa9JiKBKP8JhoTPN8W+pmzItodo9s06mSePmwTH9NxzsQ
	 f4iFubSvsnAibLnbRJQq52D9naVs6rzVQWTuZC4TWVA+fIjtjxSYc4W+dSASQHgWn3
	 8XXxxJ6XJuNoL6+Rya/xgKcYD2IFSt0N8m3Rewgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9A4DF8014A;
	Thu, 23 Apr 2020 10:39:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC2ECF801EC; Thu, 23 Apr 2020 10:39:33 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D2F1F800F2
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 10:39:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D2F1F800F2
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1jRXOE-0006dm-9L; Thu, 23 Apr 2020 08:39:22 +0000
From: Colin King <colin.king@canonical.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][next] ASoC: fsl_easrc: fix spelling mistake "prefitler" ->
 "prefilter"
Date: Thu, 23 Apr 2020 09:39:22 +0100
Message-Id: <20200423083922.8159-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
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

There is a spelling mistake in a deb_dbg message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 233f26ff885c..97658e1f4989 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1769,7 +1769,7 @@ static void fsl_easrc_dump_firmware(struct fsl_asrc *easrc)
 	}
 
 	dev_dbg(dev, "Firmware v%u dump:\n", firm->firmware_version);
-	dev_dbg(dev, "Num prefitler scenarios: %u\n", firm->prefil_scen);
+	dev_dbg(dev, "Num prefilter scenarios: %u\n", firm->prefil_scen);
 	dev_dbg(dev, "Num interpolation scenarios: %u\n", firm->interp_scen);
 	dev_dbg(dev, "\nInterpolation scenarios:\n");
 
-- 
2.25.1

