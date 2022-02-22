Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628A6C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 18:33:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3105717E9;
	Tue, 22 Feb 2022 19:32:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3105717E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645554804;
	bh=LukVhENZJbYHOheXWdIeNlYDx8kWx/MZ6ONycZ+afKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nF5Trzg+HyNnasnvz5YQKyxtk4ACLcdzwFey/eluAd+HuIrMjpKuJ/1MHDikklU49
	 mo7X1GWOt52I8rH4c7we1Fq7Rg9jodaFIv2bkg+ZQRq4Yr/rNrsY4MJTBVaA+wqGeF
	 Me+fXSvCo3KX9S9OEkQxIZow8x765BS2MZUjFVCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 954E1F801F5;
	Tue, 22 Feb 2022 19:32:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44898F801EC; Tue, 22 Feb 2022 19:32:31 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85F52F80118
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 19:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85F52F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="fa6fU0ur"
Received: by mail-wr1-x42d.google.com with SMTP id f17so10241301wrh.7
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a2IntjpP6aGlRoP92/2s3f+MRINe2OeBdydIabsC62Q=;
 b=fa6fU0ur9L169TRYp27zAxmivEOazbzaB4rd/kLtLTMVeweV7BnaVM3VgK6MW3IYKc
 +mLLQ5oUeYRHgNP1xo2p6QRJIg9q6yt9bo6AvhELaktVmDZpaQO2gRxEjoVYCb+mvT0e
 iKvDJy/rTGkHwzIQJWsJOQlHG2uh6jMpSxF11PY7JuGG3NoFeE4oitT4nhAJYHo8cMqE
 brCEUFzoCQBDtxLkWu/la0p+tn9eyvCEPujnYqPCH5pnq5YbbV1v8pbtrVnJ3keijSNj
 0Dho05wNjuKGci7QugL0DXnHBJYf0VONFAoJdGMbkIxpg7Fuq4LoV2OAKeWBfvhRC93C
 uKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a2IntjpP6aGlRoP92/2s3f+MRINe2OeBdydIabsC62Q=;
 b=gFH1lyTSxuNkSjnJ7IM8IjUlBaPl+4KU91ZQnDXmv+tIe+AkQyTMp7jC12PKKGfOZb
 uMnDP0MQF1wMF+Lt4hUUBktAcoIBpxBheFRA16On9R6AoWe1KvU+oHm8rCClu2NMZ/iN
 YegrmY4RUUi4tJP1GenPLaR6nim4EXnhKgRQNYtMNEwYQ50/kvAaDkFt4Cj61IUwvfu8
 i/czVoy8KvQc2xhNSUJkqnts1z7iiHGBwg25edJxAlNuAXlUDFddws2lk5EQr0DiUhxv
 bmWHjFmVPYubo7AI+OOl7grYtzS8jB7AeKV9KGTQdOzB1ShPG3V8OrJDHvbZx0cOdEBc
 kq6Q==
X-Gm-Message-State: AOAM530/Y4si48uguuy1Ft81Ubksi+QMdsESPdG1RS5LGQknguezAa+g
 J2z+hzJbZxhnNnLg7qfg/GdihA==
X-Google-Smtp-Source: ABdhPJzkFkr4gCWqEerHsP3/wvheZekWZ2fcKAHOo/mOTIilwJkpleU3K3VsYUQJRRfUkpNNoUdvwQ==
X-Received: by 2002:a5d:5988:0:b0:1e8:b518:ad7f with SMTP id
 n8-20020a5d5988000000b001e8b518ad7fmr20021303wri.193.1645554747227; 
 Tue, 22 Feb 2022 10:32:27 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 10:32:26 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 1/9] ASoC: codecs: rx-macro: fix accessing compander for aux
Date: Tue, 22 Feb 2022 18:32:04 +0000
Message-Id: <20220222183212.11580-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 quic_srivasam@quicinc.com
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

AUX interpolator does not have compander, so check before accessing
compander data for this.

Without this checkan array of out bounds access will be made in
comp_enabled[] array.

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 2b272a82eabf..32e85d2e9b90 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2039,6 +2039,10 @@ static int rx_macro_load_compander_coeff(struct snd_soc_component *component,
 	int i;
 	int hph_pwr_mode;
 
+	/* AUX does not have compander */
+	if (comp == INTERP_AUX)
+		return 0;
+
 	if (!rx->comp_enabled[comp])
 		return 0;
 
-- 
2.21.0

