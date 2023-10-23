Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46537C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 15:18:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9456852;
	Mon, 23 Oct 2023 17:17:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9456852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698074315;
	bh=8l6LrReEsdXY3wsFOnu1y31oaeyLD5tAw1JFThsHPlE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sZqAGAv9xT/6HxLcH0APktyBmxT3bG9s0sx/uiylTrhfrxh0wIK5vsj1dpZBUsucj
	 OM54Ypit69yyjBeQz46GoXORN8HDQWe6LXbSxfJBfZMIXyKruhHnkrijCw6qUF38Wc
	 ys5OT+dR2bZOsLMkqoeMIPWtotdURen39A+tmMH8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67264F80558; Mon, 23 Oct 2023 17:17:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E106F80552;
	Mon, 23 Oct 2023 17:17:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0197F804F3; Mon, 23 Oct 2023 17:17:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6AE7EF8024E
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 17:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AE7EF8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Mc37FqpX
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so2486072f8f.2
        for <alsa-devel@alsa-project.org>;
 Mon, 23 Oct 2023 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698074226; x=1698679026;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyRkZU+G6EHBgXjNlQRdapo8Bo6bVrz7BpJ95EsKKo=;
        b=Mc37FqpXkKycMeYDloZ/npzD/Ku1MH/7d/+n57CrLxwROHahnQKCjVCc6o9yUTJsZc
         ZZV6V3vLNlgCw4Ln2AfD5Jgk0aBQXNDnazGRMwi3ITf+F2nYI83Es7egMzeieYv95B8C
         5jGD6jtvP0NMn2xRRuo+DHt4YCw6anryn9B1ND8T/wms/N/m2G8aHk1g5Qsc4VVn7Yb1
         S/2vHpvczPBdFBIfYJBO+v6T5EjYA2fScU92xTVexlgaN/DuoMT5tR9dhxUNhXHGrlaI
         sCH+9xZLSIF1MzB6C0bRlsq+iljggw0vcaosa64xiHSLLnYWD3AVHSAr53arN6uCGzSh
         LKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698074226; x=1698679026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAyRkZU+G6EHBgXjNlQRdapo8Bo6bVrz7BpJ95EsKKo=;
        b=ZAo1O4chL6F2FEVYrseOX6nVHmWyyp+9Fx6SPj8yUK4wXmTLgQ3Xlb7G7XzuWcRBYR
         WRvEvBjonPdPCPm8b/aChvBre6vCKIZ30bb6HhVCeXPx4QCGjpv2xfXGyInFOKHYcQyg
         lR+g5D3tb8HMz9l9o/MlevskRXtMSQZWSvHS6nEBzqu9jjEvF5Tp9azR2K9v7ZCRObQM
         zQoaz8v7Kuu09jpLRzqpoWNVEFOAILIn1bu+iSZjAJ8a4g27iGxfjasHMgrZ/0dMP5dw
         He6N0Ec/hlmdLG9lUk3mBWXw2Uff5TaZKS38f86YXqLsiinotvnNMmPaD6FzmN5h7fSK
         yDjQ==
X-Gm-Message-State: AOJu0YxsTgD6GsrGLSeHqSmjN94fWzXbDE2BftL9mB/Bqxf7fdyb6CCJ
	6Ch6pOUclPaZ7BYkAJrgQw8=
X-Google-Smtp-Source: 
 AGHT+IG/PhtGCsg7wXm8Rc5Irl5IiMZvAOjGLp6Od9Km/HS5gzwHrgf4OZgoP6sqwU+2RfvtoTXxsQ==
X-Received: by 2002:adf:9dcb:0:b0:32d:a29a:b6ef with SMTP id
 q11-20020adf9dcb000000b0032da29ab6efmr6726291wre.23.1698074225584;
        Mon, 23 Oct 2023 08:17:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id
 b16-20020a5d5510000000b0032d2489a399sm7913701wrv.49.2023.10.23.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:17:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: mediatek: mt8186: remove redundant assignments to
 variable tdm_con
Date: Mon, 23 Oct 2023 16:17:04 +0100
Message-Id: <20231023151704.670240-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZYGFN4KQXBVZV2GDMNHU5IRLTXZH4JY5
X-Message-ID-Hash: ZYGFN4KQXBVZV2GDMNHU5IRLTXZH4JY5
X-MailFrom: colin.i.king@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZYGFN4KQXBVZV2GDMNHU5IRLTXZH4JY5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There are two occurrences where variable tdm_con is being initialized
to zero and the next statement re-assigns tdm_con to a new value. The
initializations are redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
index 4148dceb3a4c..ef2801f84d27 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
@@ -416,12 +416,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(afe->regmap, ETDM_IN1_CON1, ETDM_IN_CON1_CTRL_MASK, tdm_con);
 
 	/* ETDM_IN1_CON3 */
-	tdm_con = 0;
 	tdm_con = ETDM_IN_CON3_FS(tran_rate);
 	regmap_update_bits(afe->regmap, ETDM_IN1_CON3, ETDM_IN_CON3_CTRL_MASK, tdm_con);
 
 	/* ETDM_IN1_CON4 */
-	tdm_con = 0;
 	tdm_con = ETDM_IN_CON4_FS(tran_relatch_rate);
 	if (slave_mode) {
 		if (lrck_inv)
-- 
2.39.2

