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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CFC47082
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:12:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55752613C5
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55752613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D625B16FA;
	Thu, 27 May 2021 01:11:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D625B16FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622070733;
	bh=RK1+6RZCRH5a717yVji/EITwcmJ7fkj129RV8FDrWPU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NybfG8do+r7nPtJ/vie+pGp99mZBHrAnc3ON+un5VVI+Xkgxw5wA60tNGUEpu+KH8
	 jCU81MUAqZUrD/ad39IkugpJSy8as4zHV6QPhHIxd9ygVzO68K2cflNk9oRg85bZ40
	 w61KTmmfYEfzgMCLXSLPah58tg9AOtb0IwwdXH2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC0EFF802E8;
	Thu, 27 May 2021 01:10:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DDE0F80274; Thu, 27 May 2021 01:10:29 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20ABEF80264
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 01:10:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20ABEF80264
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="MIcepU19"
Received: by mail-lf1-x12d.google.com with SMTP id x38so3023953lfa.10
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J91A2ezJDwmmBjDbHzFnYK1SauhUWhSDtbv+ex6BQOE=;
 b=MIcepU1970vDHoUb96UFwfdYyRxbLToMCwifD7g/JcbLZv+mJFPdH5/BH15slSU09p
 OUpIpHClX62/SKVvDxMGfInkkAhYT57wIeHj5qgu8Kzf4PafVDYW4VcPDswnu6ZpC3VX
 nDNZfXNJCTJrsSM/Du2AjquLHl2Tz4oInZmK4VXmh9Kx1rG6Trfgtrzvs03+HHtUO6G5
 3Cq+k68/P/+yaxiTL1RS0tBci5pODFWxJzZaD2IegVe9TLbXk9rJi/Al29CsYF/mDCdO
 rEVYaPA1UwPo2z7OAZvxrIZgzys/RnpNV8C+PGdfG+Io+McJ7QNw92JsnFneNCyZJM1n
 bEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J91A2ezJDwmmBjDbHzFnYK1SauhUWhSDtbv+ex6BQOE=;
 b=B33dAwuH8UGlW0ajNqjKYzO5D4tKL7PCK2zj+OXutb1mh08X5LR7I0se8+zDrGg3O+
 zlLPTfKZpD0AqsdNDlBI3V7lggWjmuE1bUav4SYKnsowSHTT8IRfvLr43rQ1zVAWSFB3
 mAWvphJ9waXoFLGKdI1A2gUY0I6Z/x5CBon00jY39dWIPUlvnr5xQoK9xReZyF9tFZPR
 1VKbQmAmecxY4MU1Hnnl1fh3LfB+Occ6tbr17OZtaBXtmaSST5tuW4hyLOcmegG4Oej8
 nUXweBC0XHqSSnqTBQHovJJjq+DfX/W69vR0aCPMz1Cv59Z8JCmkfoOfQ0PYEeoJDwYo
 MJ+w==
X-Gm-Message-State: AOAM531YbOGCmtmF6lHOmmqOj7tCuN9ftFjC3YEV3RVveQJFN924lsyV
 9pE1kHTwlG9XSA4b2c20PEs=
X-Google-Smtp-Source: ABdhPJxT4uY6M8RKPTvy2BvhyVq4g0Cd0qirCeVYzU5lkL6YtQEwOkpw5HntEv08KNRZ9HTvwRgSnw==
X-Received: by 2002:a19:f012:: with SMTP id p18mr293953lfc.493.1622070624086; 
 Wed, 26 May 2021 16:10:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 16:10:23 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] ASoC: wm5102: Constify static struct snd_compress_ops
Date: Thu, 27 May 2021 01:10:10 +0200
Message-Id: <20210526231013.46530-3-rikard.falkeborn@gmail.com>
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
 sound/soc/codecs/wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 34b665895bdf..621598608bf0 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1989,7 +1989,7 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
-static struct snd_compress_ops wm5102_compress_ops = {
+static const struct snd_compress_ops wm5102_compress_ops = {
 	.open		= wm5102_open,
 	.free		= wm_adsp_compr_free,
 	.set_params	= wm_adsp_compr_set_params,
-- 
2.31.1

