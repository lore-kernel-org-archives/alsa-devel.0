Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B11C2BA17
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:38:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7232072F
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BcpZ9qsJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzqH2n6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7232072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D48C61660;
	Mon,  6 Apr 2020 02:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D48C61660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586133490;
	bh=kBd41F7FgrmJ5j8qDKeWvnBeNpub8+ksWok7bSUQ4Mg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BcpZ9qsJRTKtxbbipVjn15HO10wCnohg0Oaunuo24/orSiMTFJ77Jrl5WA9RebknG
	 BC5iY1Fx8Z9mlGcAoFrFAYCS0rWoSjttaB/ccumVsfaDTe6z2/XbJv7NZcz/XOmuaV
	 TYDtfN9yhdqmLSooRK0jTcHu7HM/W62iqHKo2d98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D83BF8015A;
	Mon,  6 Apr 2020 02:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC07AF801D8; Mon,  6 Apr 2020 02:37:19 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C184FF800E4
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 02:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C184FF800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="PzqH2n6v"
Received: by mail-pj1-x1044.google.com with SMTP id v13so5769698pjb.0
 for <alsa-devel@alsa-project.org>; Sun, 05 Apr 2020 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HvYWLTBBEPzNhiod3cjeYc3OHqWvfXvPsRBTDrGfXnA=;
 b=PzqH2n6vYOaIRonvp9bghIFwf8QZOks+MnMgNadoVasEX189l4pmeNOm01fUvitnmX
 UnGU3frsDXMj/vr36zOlliSHbp1aPQ3UqSVlmvHd1mHsQw5Ps6zw4z3MDoj0sn2VGvuL
 N+hl42N4XnjOhmXpip+/j4o+JMpUdKDa+/0IXLXmj25gCCf1fwwcd39e0Qhu4psZrHFm
 3fppTGeOMtRIqHag9zGCHfbnyBB6Qg5FtibK4aACphe8cUOsFeq3E868uw/fEQ04ZzFL
 TbumhNaGSHLVcS1eziz0x4D7ilidZQHVBVaIQAA4/uglzZPWPHt5SZCltQGYHOnNxVoO
 EP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HvYWLTBBEPzNhiod3cjeYc3OHqWvfXvPsRBTDrGfXnA=;
 b=acARbkG/eLLGNUU1EG3bxUq0I1OySXc1ZEuvdDln6/BYU5JZEIufkMxliTOgh4YoEg
 puCmWnOWc868Fn915xtibaMtfbJJJ1Ba8+IytBPRVegoC8lONddkv994dPq6lwvd4rjO
 m+HThzRuTFIVI+Hlr2fwzZaaPWzdLuAVoQcJH/emkQjx2X9JoFOtxscVs3sioykT+60m
 BnRtLrTo1wckTI080fK0k2xORyLMXJvuTBqOJhLz6ytrkW2prDMb+jxMV0T0FJcVHJHX
 4+AVaU/4AXylcG4eI2S0yzxOo4/ejsSotQu1suAQvtJN191JDrvIkGy09pJZIhd+STVs
 fdvg==
X-Gm-Message-State: AGi0PubZCVwcmWdOyae+R79xjmbzUG0w5RhIX2L6+UCk2JZL6oITrqjd
 rxbq9XGtVxAnhORxP/nZH0necA==
X-Google-Smtp-Source: APiQypKZjQq4Rihame6g7Iyop+OqSZx5pqYbbK3jnpuQoiVNHhgj/jMLG2KrDy1T/fcXbrcqV7pKag==
X-Received: by 2002:a17:90a:ad87:: with SMTP id
 s7mr23267930pjq.52.1586133431315; 
 Sun, 05 Apr 2020 17:37:11 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r59sm11048920pjb.45.2020.04.05.17.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2020 17:37:10 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: qcom: common: Silence EPROBE_DEFER messages
Date: Sun,  5 Apr 2020 17:36:56 -0700
Message-Id: <20200406003656.2383978-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
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

The Qualcomm sound card typically depends on several other drivers,
resulting in plenty of noise in the kernel log due to probe deferral.
Silence these errors.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 6c20bdd850f3..cb266d7ec03e 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -80,7 +80,8 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
-			dev_err(card->dev, "%s: error getting cpu dai name\n", link->name);
+			if (ret != -EPROBE_DEFER)
+				dev_err(card->dev, "%s: error getting cpu dai name", link->name);
 			goto err;
 		}
 
@@ -96,7 +97,8 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
-				dev_err(card->dev, "%s: codec dai not found\n", link->name);
+				if (ret != -EPROBE_DEFER)
+					dev_err(card->dev, "%s: codec dai not found\n", link->name);
 				goto err;
 			}
 			link->no_pcm = 1;
-- 
2.24.0

