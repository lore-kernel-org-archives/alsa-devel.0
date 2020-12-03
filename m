Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C9C001B0
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:44:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B971022CB8
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B971022CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2F951816;
	Thu,  3 Dec 2020 15:42:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2F951816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607006628;
	bh=pr8u4v1L17lZmDmkKunrZiR8bd4aGYSZbRk51XB6i2c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eM1BEj49DCB0C1R34BJxlEnYlp4YFE7JPRjkEcr/9khccIRBbwrY4Q9/g4vdBykNc
	 55h2uK0KHrj+5aryEKfjZdNkv1WXOLPWoSY35IzoXOwPZB0YV0y7zEs3VEmZONOPEG
	 Sc5PEKMNcawWuuFg8/AF52gMnHBpULTKx1lIv3U8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AA51F80082;
	Thu,  3 Dec 2020 15:42:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F64EF8016D; Thu,  3 Dec 2020 15:42:44 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B837F80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:42:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B837F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cu6WnOcz"
Received: by mail-pl1-x643.google.com with SMTP id t18so1268902plo.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2020 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X1uEb0a/fmwKssKVnSrBR+CZio6TfcFmqrf9Oztpt7Q=;
 b=cu6WnOczavFxEWRHaoPN6CUs+gLeJUD2zGzQ3oh9c5iR2hkaIo6eCLeAyCHQ9qVdX0
 +6SqEnDvIX/LnqDjW0+zKMgXHeqMrj2YmqvtaJ3HE60MqEt76xPz3BSyGBfWOJej6DhW
 UPjXJFKQyZMgNe39xyHKjMeRh+VZvK31FGCF3X85utpQgNj9/vp1DriMUOgLiWhNJsjo
 OacopigFvwkfVyVw4+I1Ma4/tlsJROvjRth0fPCx2wZgEvHmDiGMl48jSeL2cUqztsaA
 +hESuv1xIEks0908Xa58SvcYZu+xwvfcqAoZaHIGF53ISWQrW2Q65kfJMaOpVOi+CRGg
 ECnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X1uEb0a/fmwKssKVnSrBR+CZio6TfcFmqrf9Oztpt7Q=;
 b=DYtDP99m4/uvl7lMt3EvP4TN0Xd6Bw9UHvcI1ssJq6O2Ep8NGJn3EpwV3XmkWhKLiI
 D1gUoJLSOKvH0ulyEduKHS5i+3fsflqp2GHbMcrOvtpYF3JUKhNfU9ELbRQg/gqHswgx
 zVUGiGOX2sdCc9GleiRv1AgQen3u8OCKkBhfbHo7Frq5N48s3y8EYT+WkTqpoLZlwqiB
 ToOe2dxHM+7XoRYcc/LaEVfriq7DkiIr5rtQLwiUDLHyEOUWSAZ1eoN+JMxUm04y9Ofv
 e3z6UYMAg+DToN7SCACllsyrLRzDeIV2jPJT6rycsR42Fk/hLrh7PeN9n0SmFVO3zkEq
 DSqw==
X-Gm-Message-State: AOAM531wdIZFzEHv9QMxQc4JUp2K6RuHf9gojT3DD9KUNu7bqFziYmc5
 4ny2e/fi2L4PtNFONe/44F4=
X-Google-Smtp-Source: ABdhPJxdHH4SAMRmQgv5v1Pp3rTzUgxcXuJOi/Qz3P0KNxhymGiQgf33YHqxGp+RmfcgepouNJlSXQ==
X-Received: by 2002:a17:902:860c:b029:da:1ba0:3979 with SMTP id
 f12-20020a170902860cb02900da1ba03979mr3490630plo.8.1607006558805; 
 Thu, 03 Dec 2020 06:42:38 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.gmail.com with ESMTPSA id d2sm1689322pji.7.2020.12.03.06.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 06:42:38 -0800 (PST)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH] ASoC: jz4740-i2s: add missed checks for clk_get()
Date: Thu,  3 Dec 2020 22:42:27 +0800
Message-Id: <20201203144227.418194-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>, Mark Brown <broonie@kernel.org>
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

jz4740_i2s_set_sysclk() does not check the return values of clk_get(),
while the file dereferences the pointers in clk_put().
Add the missed checks to fix it.

Fixes: 11bd3dd1b7c2 ("ASoC: Add JZ4740 ASoC support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index c7bd20104b20..0793e284d0e7 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -312,10 +312,14 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	switch (clk_id) {
 	case JZ4740_I2S_CLKSRC_EXT:
 		parent = clk_get(NULL, "ext");
+		if (IS_ERR(parent))
+			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
 		break;
 	case JZ4740_I2S_CLKSRC_PLL:
 		parent = clk_get(NULL, "pll half");
+		if (IS_ERR(parent))
+			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
 		ret = clk_set_rate(i2s->clk_i2s, freq);
 		break;
-- 
2.26.2

