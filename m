Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E3C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 10:51:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF40461284
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF40461284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F48217DB;
	Wed, 15 Sep 2021 12:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F48217DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631703089;
	bh=M4UwPTS87ulCKrDyLeLW9sayu32P5G6iwk1TZ57MkgU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XHBHepV1ZUTHb5YDY4AjKJpJd4i5zi1Cf79TIYnObjYTInOe7NnJVPYyD8mNx2TtR
	 FZ0h/xWKIUh0pUdfkTZmq9uEnV8MwM/QkXr2LtKAmhkRencGUfnYr1DJDeMHuYLSUI
	 pLDSvS5GCisM95aJySaP5K3Mgowz2ooolsH/zWms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86B36F80227;
	Wed, 15 Sep 2021 12:50:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 136BEF80227; Wed, 15 Sep 2021 12:50:36 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76AEFF800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 12:50:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76AEFF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="nqkapOap"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6468A3F10B; 
 Wed, 15 Sep 2021 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631703027;
 bh=xn+5nToJ2orf+Up6k7sn+oX06VsYAXKMy44e0Mtdtig=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=nqkapOaphl4IBekkRVekUgd37nzYvqKGinzjKir5PmQxIcAmKmOtaLHBg6jHzKAAt
 n8i8+chi6FUvQXNlm40v+uCxQww727wSAFEEmzlLV7vw21OEgTvGU8cNw+eHfTINOc
 yBfSQIaNtaIIPWyLiMXQvLNK2dU7h9u1J9/xrMoL3gIkmhI5yKbLe5nR9R71c9JSzI
 bCggbYOi5eBMBwrtv5mmIVacvScO6Omkg0xllNLklR4HfvH+snXTU8veF9LaotvP/7
 4duE7N1fALbqsEgNT+thVhYnL5iF957CHuieXykK9PzgXxnyDGJZUvLQOF7MJaLICm
 sqca0K7RMdZPg==
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8195: make array adda_dai_list static const
Date: Wed, 15 Sep 2021 11:50:27 +0100
Message-Id: <20210915105027.10805-1-colin.king@canonical.com>
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

Don't populate the array adda_dai_list on the stack but instead it
static const. Also makes the object code smaller by 33 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  28271	  11640	      0	  39911	   9be7	mt8195/mt8195-dai-adda.o

After:
   text	   data	    bss	    dec	    hex	filename
  28142	  11736	      0	  39878	   9bc6	mt8195/mt8195-dai-adda.o

(gcc version 11.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
index 878dec0b69ed..f04bd1781356 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
@@ -788,9 +788,11 @@ static int init_adda_priv_data(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_dai_adda_priv *adda_priv;
-	int adda_dai_list[] = { MT8195_AFE_IO_DL_SRC,
-				MT8195_AFE_IO_UL_SRC1,
-				MT8195_AFE_IO_UL_SRC2};
+	static const int adda_dai_list[] = {
+		MT8195_AFE_IO_DL_SRC,
+		MT8195_AFE_IO_UL_SRC1,
+		MT8195_AFE_IO_UL_SRC2
+	};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(adda_dai_list); i++) {
-- 
2.32.0

