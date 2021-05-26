Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2414EC47088
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:13:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34133613CC
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34133613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD91F173F;
	Thu, 27 May 2021 01:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD91F173F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622070820;
	bh=Gi6jdcyOmlfiW0F48mVfAwD23JaGU1abAUimqzG6f/U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hTGY9OkRKzAXQEJ1eCpPW7K+f2NqCed5wa5mLG9+h5zEyp2wDOfcQBdXyV5rIm3/4
	 6CGEpYia/C9HCAO0xABDapdXSVhA07Mei92shop8TX22og41Gn0mPgs56SkjX+tlwy
	 iBmiFe/deQ99T9qEWMwzKllSMwsBYcmHfoUIrmvs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4281F804B2;
	Thu, 27 May 2021 01:10:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 952DFF80430; Thu, 27 May 2021 01:10:34 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBFC9F802CA
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 01:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBFC9F802CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Owjd8HWL"
Received: by mail-lf1-x133.google.com with SMTP id q1so5047046lfo.3
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rafWoYI/41oLLgH0zc0m9Aor5D1w1XH8dZGtN18a1Oo=;
 b=Owjd8HWLgAG1uF9eUcz4l+ojxm0RUTnNZxefGCvnrtLD7VD2G/cJfHxt8j2MsdgeCw
 lIIMx+FS5QWxozDGhHh+kLRt2PRo8HA9dXQ2kDt0kO2et3Cwe3RVCNd2wVSYvsrF98O1
 6YJ7PZQKyz6T9CsiTBsVhiQuBJGrrRb4DVIqBqOZ95324yQzPH/o9WKMUHp0wOv7w/gI
 dDMcsJSBcGG0IWxRybhx9DRlB9ZTSX/m70Hqv0SLchNUMrIIOPoGuXMPLa4TvYqRbPVv
 j8WsvmXygkf0u40PjKoRGFZe+PxGi37msbolBb0W+h1QNk9GvO+2XCbdkgfDg+8XialD
 6RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rafWoYI/41oLLgH0zc0m9Aor5D1w1XH8dZGtN18a1Oo=;
 b=IIYwZmGb3gHhOS3T1mcOPA2AS7Jy97McC4i85dJTvLAnXmxcZQzo54d6t+QMRjgZEX
 FJ3UgOTdwQkTzPcJBfDxIVR1A7/K5Rtl+NHwqZwkr2qEHbmDQfST1mTqvXwldX+SVu1V
 dgjeQBD24ojd0uNyqdWpKfgykAI6kvYD6sZ8GU8L2EM/KWgACx2ViUj5Rzz2DAHZ31MN
 LgbRCSiSjtGGt6oUkjJBQFoaBNsfW24QswoLCJQ2qEElPCZnkXUUtUdOgeOg2ANmJuSg
 0No7Cusc/R75PHHHI1c35GpxrmIjUzD0eEH9yr9leozCmCtO9zlq2nHJTVxvMybs7Kod
 yUMQ==
X-Gm-Message-State: AOAM531tyYaYmWBJ42u9lUQY+Orlx80hmI7JGUog6G07WgGx42znOBFe
 g+BFUP6s8uP2te7TX07Xitc=
X-Google-Smtp-Source: ABdhPJyitHNPPsdsydEW2Ko0uLs6O40Fb+AnkAS84YPdbkTVGgy3LG8qxDVCn86Lx9O0HZfndd8IrQ==
X-Received: by 2002:a05:6512:21a:: with SMTP id
 a26mr321020lfo.468.1622070625906; 
 Wed, 26 May 2021 16:10:25 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 16:10:25 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: qcom: q6asm-dai: Constify static struct
 snd_compress_ops
Date: Thu, 27 May 2021 01:10:12 +0200
Message-Id: <20210526231013.46530-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
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

The snd_compress_ops structs are only stored in the compress_ops field
of a snd_soc_component_driver struct, so make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9766725c2916..5ff56a735419 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1169,7 +1169,7 @@ static int q6asm_dai_compr_get_codec_caps(struct snd_soc_component *component,
 	return 0;
 }
 
-static struct snd_compress_ops q6asm_dai_compress_ops = {
+static const struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
-- 
2.31.1

