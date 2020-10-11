Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36F4C433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:07:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9B5207FB
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DYI/vWXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9B5207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CBFA1690;
	Sun, 11 Oct 2020 12:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CBFA1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602410829;
	bh=QD7lRcQppXJuEOF8kaXkCeXxq9m4ho031PrNqmPi6Ao=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYI/vWXXrKFCNYcL/wtTU02cRgX2bnfKHXV6xyxA26vThlw21IrQTi9i99iVxrEbm
	 lAa4XtQO7wampCrqgL5Dtvj0Mpb9+WRwSzrCO7x2llocLECkhpDsT0XCCjmbvMy4iT
	 zSiqf8XtdGxHZaWwjvXNLTxpxg1kdkyA8BoYqPbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 250EBF802A1;
	Sun, 11 Oct 2020 12:03:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C74EEF8028A; Sun, 11 Oct 2020 12:03:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FC30F80255
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 12:02:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FC30F80255
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; d="scan'208";a="471981625"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 11 Oct 2020 12:02:41 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 7/8] ASoC: madera: use semicolons rather than commas to
 separate statements
Date: Sun, 11 Oct 2020 11:19:38 +0200
Message-Id: <1602407979-29038-8-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
Cc: alsa-devel@alsa-project.org,
 =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>,
 Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
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

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/codecs/madera.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 680f31a6493a..f4ed7e04673f 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -3019,11 +3019,11 @@ static int madera_hw_params_rate(struct snd_pcm_substream *substream,
 		tar = 2 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	case MADERA_CLK_ASYNCCLK_1:
-		reg = MADERA_ASYNC_SAMPLE_RATE_1,
+		reg = MADERA_ASYNC_SAMPLE_RATE_1;
 		tar = 8 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	case MADERA_CLK_ASYNCCLK_2:
-		reg = MADERA_ASYNC_SAMPLE_RATE_2,
+		reg = MADERA_ASYNC_SAMPLE_RATE_2;
 		tar = 9 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	default:

