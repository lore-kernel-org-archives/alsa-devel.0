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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2928C47082
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:12:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AC9613C3
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AC9613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E991732;
	Thu, 27 May 2021 01:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E991732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622070769;
	bh=isoMeugTez54myAgsKJevLLjw6zLhmI6jiunXBsdv14=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GIcvXgmwe6XlWURR9sfZEXyWH1JWe0Ebwzun5bKW2UYXxtWT7uY/r4WbA+VPLIdOY
	 IGRXm+YgHxQSSd8rIw27mhl2LpRJKzbaH//nbXHhg8g4I6eX1WgKv918UwZH0xWjLN
	 58pv7cUVZR+y55JXn9nr+NV6lVxDWCBR2xBCQoi8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E4F3F80301;
	Thu, 27 May 2021 01:10:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE769F802CA; Thu, 27 May 2021 01:10:30 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFD4CF802BE
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 01:10:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFD4CF802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YR9BmeUR"
Received: by mail-lf1-x12f.google.com with SMTP id q7so5060414lfr.6
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wxumGjjKmyhy9AtNX/EtM7gYeJBe+fSFWDY+3BCIpJU=;
 b=YR9BmeUR/SYPMeg44xeLZIrjLsDpNsbNs1BHLe9YOZCku+u9FMj/5Q/EtP+jIcxg61
 7UbRVsnNsynH//WdoJ2KPnTSHRBhVZGYltbLHewlvJCP23PfWwY2g/HE56gq5jT3sH/Y
 mnbCcCokGDs8mLyVgNjkQZHu0fahoJPD+fzGn5YNnz8zM51jusobKXgx+FA0EMhGvbi/
 jbxYeQKw/eTyDPBRab0KtPq6wuXmO/UnYfYDUWt8APYN0MvCXPj4Qn7V1tcA3KYrZU1I
 jSjJMMZqZJxJXy2qeeRpbLrSxqXR0RalN4rtyWnjRH6eV235rlSL7toVVLb3pOs7jsMu
 9rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wxumGjjKmyhy9AtNX/EtM7gYeJBe+fSFWDY+3BCIpJU=;
 b=IfUJ4yYUk2yHpZ+lCUbC+QI/B0gqFigMjiui3rehwzb55PIBUaxsY93jaOkKLYlUNx
 JRykjo5dNjO+Nz3sy88jAJJ43LFC9nZEkcXG7PSgBVBnQBxNoQL6vfWv9iZc3hTlk8gh
 14zoLFxB0YO8JejiEKPmJ0whzKNVHy5cUQzKIEeIlkWAwuZ50EmiqQIGyTTvid/veP3k
 Tgak8HUkEbcZIy+KpQWVZ9ZtSsfTPVUKn1U+fRg84LzNMFt+8dP4yd6+bTAPOPoQYYDd
 LcIQ0cxdfJthQRB6pAzbXRhmNEC1kIU33dAvCdAekZ8yvDvh3ZJkhWwP6f8ZfkQDYd1l
 YMbQ==
X-Gm-Message-State: AOAM532qCFPOz3f1nYJn1O37Qv08bFrCnM7b5ICfA456RFI+duUBC2is
 WdRBZugvh+UdIR15SHfu6xQ=
X-Google-Smtp-Source: ABdhPJzU0//HLO1M/s3OeXk8PSoCR7XVVz3EuRNaT6s/U8dFBo9RZn0KG+0JF/za48r6ATihAp0Dlg==
X-Received: by 2002:ac2:5304:: with SMTP id c4mr313085lfh.634.1622070624981;
 Wed, 26 May 2021 16:10:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 16:10:24 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: wm5110: Constify static struct snd_compress_ops
Date: Thu, 27 May 2021 01:10:11 +0200
Message-Id: <20210526231013.46530-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
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
 sound/soc/codecs/wm5110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 76efca0fe515..5c2d45d05c97 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2355,7 +2355,7 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_6R,
 };
 
-static struct snd_compress_ops wm5110_compress_ops = {
+static const struct snd_compress_ops wm5110_compress_ops = {
 	.open		= wm5110_open,
 	.free		= wm_adsp_compr_free,
 	.set_params	= wm_adsp_compr_set_params,
-- 
2.31.1

