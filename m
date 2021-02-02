Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE4C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 03:37:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EFA64ECE
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 03:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EFA64ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F30516DE;
	Tue,  2 Feb 2021 04:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F30516DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612237030;
	bh=NUjiK6g0HkdeFewHuNLMwOuQwRb+aLFuVBnUgwz+m84=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qdfEBSKMQ/9pfgsOdaaNeenT0JKnr/hqW0UVFNzBS5lC+U9ub4N04ZNh/vVBOUx5c
	 n8A8salfXCp4aQJasKSQgzmhg7LA07wzpOKJEFqBdx7NKL0mlGDVF2xJEdee+VGpY3
	 nfxNr78HVnjA1XP6cIrdffVGSeDSLAn/gSflQ6AU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D55BF80152;
	Tue,  2 Feb 2021 04:36:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04BF2F80171; Tue,  2 Feb 2021 04:36:19 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F955F8013C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 04:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F955F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="u57OfbsE"
Received: by mail-pj1-x1049.google.com with SMTP id o3so929714pju.6
 for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2021 19:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=bH+mqPaIeFGGqeZkLFYc430414YU8FhvnMqLf1FpoAA=;
 b=u57OfbsEH0p3KSZmSBLYYe+oNytD0oAnGy0jIHB3nZxBqB6CkoxJi5pEiCo/UqbmmN
 MEdFj8C+dOICBiRDOyC2ZAUew21Ckrmqw6Ex1SKfk3nIrvZr30pIA/RxZn6uHEY9IyF/
 MVo79wS8Zfsy3WCpTR0HBwO7PkRF4V3NkVdQKB5HsS71QqBwzaJVxvQI7jb3KlVO7oR/
 7hOFJWp8X1hDCMxf+H9pLjzYp+FL8+uGXxwKSZTQcd9wySeLYcfSsfBPHAU1h+GSOAU7
 4J0PVp8PnD8NK1QWGqmKlJuy2uBbfjg14cwpoqW2z2RWeJHu4w9BjLjDzaHbwv55qZ5B
 eyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=bH+mqPaIeFGGqeZkLFYc430414YU8FhvnMqLf1FpoAA=;
 b=L0hVaffpO2ZA64aIomPtewqZVH7EfiMidUvRp+ef87sqot3RKFh0coLGaMv0cZweFe
 t707gkE4KOosPAD/AYz2mmakpPl6wsCRyXuMmgiI49RlbY7/HoFMkLW2iXlzi03T/QJu
 ySOSxL3+pOvvb4DiXeFrzh3wUMEwAiNsJz9LcoVMEHFFSNFd/r836x+8wWHb4P4rWIYM
 K/87k7z4ELHTdzqaXLM7Sn7eoxPGC5xBV0Fk6vQycZppn1T2aw6rOC8ANjGTcWH5a3Vv
 0DbWxQArZiP5m08dNxs6eh5dgrBm7bQ+snNb45zCo9xJAY2PW85mIjR3Bbsp5VPWH85j
 DZfw==
X-Gm-Message-State: AOAM530qqILwkhhQfN0ieM1IHs21hsZUElSLzq6T4yLCYMEfDHE+BLTi
 3qDaRL0Kyj6Wr1yg2erHv2KASIc/C0z5
X-Google-Smtp-Source: ABdhPJxNWy3sK6XtpLtLBgBWVf8nNwnqpfFrOQSYqvJAW/TQeiZuE+Y43Jya8LJHIK/CNBY0PglxPkeTKjyF
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:dc88:dd2b:a03:4076])
 (user=tzungbi job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr251253pjo.0.1612236968649; Mon, 01 Feb 2021 19:36:08 -0800 (PST)
Date: Tue,  2 Feb 2021 11:35:57 +0800
Message-Id: <20210202033557.1621029-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] ASoC: mt6359: reduce log verbosity for optional DT properties
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: matthias.bgg@gmail.com, tzungbi@google.com, alsa-devel@alsa-project.org
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

DT properties "dmic-mode" and "mic-type-X" are optional.  Reduces the
log verbosity and changes the message a bit to avoid misleading.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Inspired by https://www.spinics.net/lists/arm-kernel/msg872744.html.

 sound/soc/codecs/mt6359.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 6de0d744fa9e..6f4b1da52082 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2754,7 +2754,8 @@ static int mt6359_parse_dt(struct mt6359_priv *priv)
 	ret = of_property_read_u32(np, "mediatek,dmic-mode",
 				   &priv->dmic_one_wire_mode);
 	if (ret) {
-		dev_warn(priv->dev, "%s() failed to read dmic-mode\n",
+		dev_info(priv->dev,
+			 "%s() failed to read dmic-mode, use default (0)\n",
 			 __func__);
 		priv->dmic_one_wire_mode = 0;
 	}
@@ -2762,24 +2763,27 @@ static int mt6359_parse_dt(struct mt6359_priv *priv)
 	ret = of_property_read_u32(np, "mediatek,mic-type-0",
 				   &priv->mux_select[MUX_MIC_TYPE_0]);
 	if (ret) {
-		dev_warn(priv->dev, "%s() failed to read mic-type-0\n",
-			 __func__);
+		dev_info(priv->dev,
+			 "%s() failed to read mic-type-0, use default (%d)\n",
+			 __func__, MIC_TYPE_MUX_IDLE);
 		priv->mux_select[MUX_MIC_TYPE_0] = MIC_TYPE_MUX_IDLE;
 	}
 
 	ret = of_property_read_u32(np, "mediatek,mic-type-1",
 				   &priv->mux_select[MUX_MIC_TYPE_1]);
 	if (ret) {
-		dev_warn(priv->dev, "%s() failed to read mic-type-1\n",
-			 __func__);
+		dev_info(priv->dev,
+			 "%s() failed to read mic-type-1, use default (%d)\n",
+			 __func__, MIC_TYPE_MUX_IDLE);
 		priv->mux_select[MUX_MIC_TYPE_1] = MIC_TYPE_MUX_IDLE;
 	}
 
 	ret = of_property_read_u32(np, "mediatek,mic-type-2",
 				   &priv->mux_select[MUX_MIC_TYPE_2]);
 	if (ret) {
-		dev_warn(priv->dev, "%s() failed to read mic-type-2\n",
-			 __func__);
+		dev_info(priv->dev,
+			 "%s() failed to read mic-type-2, use default (%d)\n",
+			 __func__, MIC_TYPE_MUX_IDLE);
 		priv->mux_select[MUX_MIC_TYPE_2] = MIC_TYPE_MUX_IDLE;
 	}
 
-- 
2.30.0.365.g02bc693789-goog

