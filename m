Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED3C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:50:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B922070C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tKUGg7CR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wmc2HURf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B922070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED0A81671;
	Fri,  6 Sep 2019 21:49:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED0A81671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567799416;
	bh=La29u3APkXgJj5ZTthgCpidD16Yct7qrKbdo8y/+HLE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKUGg7CRiwgARU+gFtcC1wDeAUzPMk+xNzsqB70atzmpc71NVNjPO/vZoN+HXMDUV
	 z0bOKDC/WyTI7lqwF/z1PxFKiYn+0GgcT5hJceHEHQ4vVmaDSWi6swwg9B/StxxxpK
	 OABuMCpF2mQKL43kcK1rOZVTCeCML8YC4EsudJ0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10782F805FE;
	Fri,  6 Sep 2019 21:47:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86B48F80600; Fri,  6 Sep 2019 21:47:48 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 456C3F805FE
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 21:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 456C3F805FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Wmc2HURf"
Received: by mail-pf1-x443.google.com with SMTP id q10so5228932pfl.0
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2019 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VMZf9y8f78GCqGODfxIvn20OROjDjSr5IHdEDwFOH+Q=;
 b=Wmc2HURf/sjhxQelDf2rrIZimmJgaPiwbo4I06HQ3bgQgG/xa3z5YtuznwKgOnVXVZ
 qdJyUw2nOyLavUHIY1rI5mpKIODabKoCHbCb9xnTH/XTtNZkenBEpU5drxOuIMfC6cNE
 NekqLN8tBgU3GkPwvTEycjUmE7BUoGySn5Kdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VMZf9y8f78GCqGODfxIvn20OROjDjSr5IHdEDwFOH+Q=;
 b=XUkazi/eco3Np3p005FkgxcnNKiF3yibqrkgw2dLBVv3zpoA/OwJ1zrFDXhFxJREWM
 b1pgS3eK6BNyzR7F29cRyArd42SkIriWu/s5qguM9H/B2Zsde4nVYjTQpHFht56808Sc
 KO4GGsOCYkWuf+jOQ95ZDs/L9l9k1Asp4hezs5p/4uBRwyRcGHrBA/Rryaoi6Kk2oL2k
 Kg4TwOrerckaFQHekAcDkFkL4Yew7HNPP5CQbmBy03Gox5KTtX+2TIZ5s5ZVR0ctnoOL
 18hqiUQd282fx8mIlc/iT5OW7qHkrCWb4pHNlipwPhbZUv//KnlE57uLcgdKAdTTn/5c
 D7wQ==
X-Gm-Message-State: APjAAAUbr79iMkSsogsuR4jtwZBPDLWauEkn6Z/LUbds7AQpIZCjCAhO
 dEm0WZb/H8ojvCPIFSYWRhPUZQE/Sw==
X-Google-Smtp-Source: APXvYqzSqTTVtPR7R0z/60g2LvYBYYsvccPN0Yg+m9ObhpYL3KBSIuLeyzn6wjrOdsC8sNDFHmfzIA==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr12701017pfa.135.1567799262919; 
 Fri, 06 Sep 2019 12:47:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id g11sm5626075pgu.11.2019.09.06.12.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 12:47:42 -0700 (PDT)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Fri,  6 Sep 2019 12:46:24 -0700
Message-Id: <20190906194636.217881-3-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906194636.217881-1-cujomalainey@chromium.org>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
 Curtis Malainey <cujomalainey@chromium.org>
Subject: [alsa-devel] [RFC 02/15] ASoC: rt5677: keep analog power register
	at SND_SOC_BIAS_OFF
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ben Zhang <benzh@chromium.org>

Instead of clearing RT5677_PWR_ANLG2 (MX-64h) to 0 at SND_SOC_BIAS_OFF,
we only clear the RT5677_PWR_CORE bit which is set at SND_SOC_BIAS_PREPARE.
MICBIAS control bits are left unchanged.

This fixed the bug where if MICBIAS1 widget is forced on, MICBIAS
control bits will be cleared at suspend and never turned back on again,
since DAPM thinks the widget is always on.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 5b6ca3ced13b..315a3d39bc09 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4493,11 +4493,11 @@ static int rt5677_set_bias_level(struct snd_soc_component *component,
 	case SND_SOC_BIAS_OFF:
 		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x1, 0x0);
 		regmap_write(rt5677->regmap, RT5677_PWR_DIG1, 0x0000);
-		regmap_write(rt5677->regmap, RT5677_PWR_DIG2, 0x0000);
 		regmap_write(rt5677->regmap, RT5677_PWR_ANLG1,
 			2 << RT5677_LDO1_SEL_SFT |
 			2 << RT5677_LDO2_SEL_SFT);
-		regmap_write(rt5677->regmap, RT5677_PWR_ANLG2, 0x0000);
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
+			RT5677_PWR_CORE, 0);
 		regmap_update_bits(rt5677->regmap,
 			RT5677_PR_BASE + RT5677_BIAS_CUR4, 0x0f00, 0x0000);
 
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
