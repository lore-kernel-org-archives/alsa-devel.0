Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C965C76196
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Apr 2023 17:01:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43505EF9;
	Tue, 11 Apr 2023 19:00:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43505EF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681232485;
	bh=Lw/ZnXt1q+4EeZW1u7iSq1HM1gNpMOsxCIdEh4us6Oo=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ukUALoNpM0NHkjGGPx/UsgADr13DKjfkK7ze5LrIjEmHiKdb1nuijDJpUEB8e4SgT
	 eCdOxyj71auQlHlOlVsPsUBaPiWPa69Ls+n9Sorb72W0OX3en2t5tjYpUWQOKu/YAb
	 RcH/JqoVsha6ApW0tVLfbqFeMp0i1Usqx4cVXD7E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED3C9F80149;
	Tue, 11 Apr 2023 19:00:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD3B4F80448; Tue, 11 Apr 2023 19:00:07 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 51483F80100
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2023 18:59:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51483F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=DOAGbpdR
Received: by mail-ej1-x630.google.com with SMTP id xi5so22101692ejb.13
        for <alsa-devel@alsa-project.org>;
 Tue, 11 Apr 2023 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGiYwUojezuY+RxgL04VGSeCZx3NAMwWwAXac6CUEj4=;
        b=DOAGbpdR8fzZ9Gbbh7RUCSNW8UQIyEyKCkF2XEomSySEKliCZYU0I0ZXcq4Fe27va4
         ORMmfWHTLGSvcd14rBdrvYZUymX3QMl1nzwoIJNEoMdMrZwWIvWhl0/IYnxKerFm7oXE
         mL4cbApBYeVNCmycJghTPN4+Fc5oe0b+zqNNBEf3HW76LmEPGmY9rcm9g1AAcPD6TIA7
         Drl/+PS9CmF0Uoui4ZzE4+6g3G6Q1G8oNT9ULpSasBmZJYP0FbFMr2To7TWyzAax8FW8
         Ne/Pwu3o5nHngHK93n+tX8viY7vOK5+u6ziHAbJt+UH3EOxpFFkONo56THp75xj1Oy+K
         P91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGiYwUojezuY+RxgL04VGSeCZx3NAMwWwAXac6CUEj4=;
        b=YQdFvRPK3x2dGKU/Vfmn38ZluJYtCl9ywLLjr88Krg0y1SzZhxj6iK11rlM6Q84sv0
         mpOQsrqMWVjOwEjNNm8rN9diL0tkqp7krAWAoM2Y3hwedLftVgnr7rNHIgd5IJDfID4H
         HVPqfhVZ+xfEM/UCvekLjolaBwXsJoUAI/0yG461pBJyT0MdkDAipfLzJbPiKaY8fOBE
         aYFeqwq/mIua+lyGvtpHv1C/0CbCHWwOXaI8F9zMKKAOS8L7GkZIZRJOsmI+DuRF4j9t
         nwYWm7CmV5ttKOagOnQl9o20BqTX+ilEH463ppzAVYJFnYHUoVoNBwWiguhmFEMscc14
         BoYg==
X-Gm-Message-State: AAQBX9eH6JPL0zP5q0KymTLLxOOHcbZ4Fz0g5+pTVAAOIV9d8Ff8sKfx
	P7iowwsGVcgfHGxd84HDxySyUBMTllcZdA==
X-Google-Smtp-Source: 
 AKy350a5SgWGjIHXpkAStyJFnVJ5KpXf1ETC00q63RutMcZw80dQpaUSiqlTZh8An7yLdQfENLRrfQ==
X-Received: by 2002:a17:906:d29a:b0:94a:826c:df57 with SMTP id
 ay26-20020a170906d29a00b0094a826cdf57mr8234940ejb.39.1681232395197;
        Tue, 11 Apr 2023 09:59:55 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id
 sg35-20020a170907a42300b0092b8c1f41ebsm6299061ejc.24.2023.04.11.09.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:59:54 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] ASoC: ep93xx: Add OF support
Date: Tue, 11 Apr 2023 18:59:51 +0200
Message-Id: <20230411165951.2335899-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
References: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DSV32KU4R2Y5EEFRBOHL5SNWAEC4HGL4
X-Message-ID-Hash: DSV32KU4R2Y5EEFRBOHL5SNWAEC4HGL4
X-MailFrom: alexander.sverdlin@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DSV32KU4R2Y5EEFRBOHL5SNWAEC4HGL4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add the new cirrus,ep9301-ac97 and cirrus,ep9301-i2s compatibles.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v3:
- rebased onto
 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
v2:
 - Dropped AC97 (deleted from the tree)

 sound/soc/cirrus/ep93xx-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 2abd1bce2290..afc6b5b570ea 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
@@ -514,11 +515,18 @@ static void ep93xx_i2s_remove(struct platform_device *pdev)
 	clk_put(info->mclk);
 }
 
+static const struct of_device_id ep93xx_i2s_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-i2s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_i2s_of_ids);
+
 static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
 	.remove_new = ep93xx_i2s_remove,
 	.driver	= {
 		.name	= "ep93xx-i2s",
+		.of_match_table = ep93xx_i2s_of_ids,
 	},
 };
 
-- 
2.40.0

