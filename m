Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21CBC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 12:33:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D153560F35
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 12:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D153560F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 367671655;
	Mon,  9 Aug 2021 14:33:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 367671655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628512430;
	bh=D6HxvvXH18kMkFS7XC+BvIun40QiV9zMfQJq+JL32RM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JlRMbEHoC3uULECCNdvaCUF3V/aXbDkhVSorXA1gKfxsuQxiXxzA7BBGEXM0+4xb1
	 G2s6nmcMBXLNTByJqOtuDlaYuIVVzo6BT/HUbGognGZHcP8YViXlJwLJXI/Pra+Xpv
	 qrgQw3HKPwYbA4efJbLmNJ3Rvo1qHFtMQwlbHu5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBB7FF800CB;
	Mon,  9 Aug 2021 14:32:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D61AF802D2; Mon,  9 Aug 2021 14:32:03 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1C7FF80105
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 14:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1C7FF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="bFDNQ6xy"
Received: by mail-wr1-x42d.google.com with SMTP id h13so21196610wrp.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2021 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=51lUzZccKvH6yS4jgbBMyr0ZIf73Jibtm9v60S5oJn8=;
 b=bFDNQ6xykpHKDTt6gCBSy4I5bPetjQzlCFgS2SeQT4nQpFDOfS8tbzzst6n2nXM5Jn
 yoIu/UZKIhX17xN8M0wx7xcz+Y3i+KoSTPws/gWfiX16Gkd3J8ewKbvdRvdRPJyorZVT
 1klO/uufewTFk+dxD46athToPvf+Gt/8ZyEdw59h68lGayimB2Rzuk7pe5G2Y85XmPTC
 CzK2lUW9i4OwKC7fvUx8Ia+vcmtkyBawbtSpNU0bLT9E6w2s490A4pkVdWePGCdd/P0+
 9niSr3mbV3NXinc7T5WLCboy1NYGJ7cKlSuL/+DZa6b0Bgybh8WEzItI43xDQhlo4ihW
 bZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=51lUzZccKvH6yS4jgbBMyr0ZIf73Jibtm9v60S5oJn8=;
 b=qmd8YgM2I8N6uk04zq/jIwhDNChCeEk72nO2jLUtXwLHlSbKPQTzhbSxGRfAnig6pt
 OKA41ZmYPGeMFTyhG+nvXGwmLWSFflEvnV7yrTp9LX6ahd98KJAYE80uqS8/mIYotRko
 pFDdHqih1nXcPJwDglNkg27gPanBqC6IMe5jpfNOHaUOAKOu2LyU23Nx+3xyxHcGBQDS
 MkE/xtJniOY2UW1epf0WCkU17I1JwtTIHOo5gL0AXYlCpPY9x9+cJywQWAsRdZeLrtXx
 UBoV5JmY8Z1Z2GUcJXx/aWnetwF8TRo9ee7tTC5lGGkFKYOz7YD24cxOjtmoMwtuuXIu
 T8Bg==
X-Gm-Message-State: AOAM531BCBm1up/daiYMcIUpemwAAIpUyYcKuWfNq+9plA+HhOBvO6tm
 JdmYNfxWlWNqQagKGSpj/QSsHg==
X-Google-Smtp-Source: ABdhPJwqrwSKgnMXDH9S2o5Ey1PoIimoLQm/3WSXTUKUSz422rgDwwI6vUhlLqx7UssM5foBKsJ+mQ==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr25687377wru.33.1628512313875; 
 Mon, 09 Aug 2021 05:31:53 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id g12sm19369193wri.49.2021.08.09.05.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 05:31:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 2/2] ASoC: qdsp6: q6adm: fix cppcheck warnings for unnecessary
 initialization
Date: Mon,  9 Aug 2021 13:31:37 +0100
Message-Id: <20210809123137.14456-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210809123137.14456-1-srinivas.kandagatla@linaro.org>
References: <20210809123137.14456-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.de,
 lgirdwood@gmail.com
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

cppcheck reports below warning.

q6adm.c:475]: (style) Variable 'matrix_map' is reassigned a value before the
old one has been used.

This is due to unnecessary initialization of variable matrix_map, which is
now removed as part of this patch.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 1855b805eba2..3d831b635524 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -465,7 +465,7 @@ int q6adm_matrix_map(struct device *dev, int path,
 	struct apr_pkt *pkt;
 	uint16_t *copps_list;
 	int pkt_size, ret, i, copp_idx;
-	void *matrix_map = NULL;
+	void *matrix_map;
 	struct q6copp *copp;
 
 	/* Assumes port_ids have already been validated during adm_open */
-- 
2.21.0

