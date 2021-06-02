Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E0C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 10:38:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BCF613B4
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 10:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BCF613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D85D116DC;
	Wed,  2 Jun 2021 12:37:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D85D116DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622630309;
	bh=8ZZE2/ED4CPEC6IKa8r1ekARFoBMBHNUKLrhQYN5128=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ptPud8eV9CAhVY+Ai6LMWdBS+afRcTBIlTVBHKXv6cTOfZKMiRTAELej/PxxNyM0K
	 t+2Ox88IT2rFHDKNlqnHd60ud3gByQ1ndd8zLzwuRnrp0p3vIzXhHhBNbXxWYtP8Xe
	 Z2C3QS+Uj+L2QZlKnDJR+9AXJAYDVmnUBx1puLGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64BB3F80273;
	Wed,  2 Jun 2021 12:37:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7958EF80424; Wed,  2 Jun 2021 12:37:38 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37C1DF80273
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 12:37:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37C1DF80273
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1loOFW-0001Bi-Eu; Wed, 02 Jun 2021 10:37:22 +0000
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH][next] ASoC: rsnd: check for zero node count
Date: Wed,  2 Jun 2021 11:37:22 +0100
Message-Id: <20210602103722.12128-1-colin.king@canonical.com>
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

The call to rsnd_node_count can potentially return a zero node count
so add a check for this corner case. (Note that the two other calls
to rsnd_node_count in the kernel perform this check, so I think it
justifies adding this). This avoids using a zero nr in a devm_kcalloc
call.

Addresses-Coverity: ("Unchecked return value")
Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
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

