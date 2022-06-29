Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57018C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jun 2022 20:19:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A62401636;
	Wed, 29 Jun 2022 22:18:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A62401636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656533952;
	bh=vvE6+ynEKPLV3x4FPj/3cRzObBkucDVL/aUBiNCvqc8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A1aZissCswUCGKdOM3Sxwx3jfZQVCWJMinvNRgeisMyIfg1oyTyoduhd/ofbj0r/D
	 JonflN6FLMW+iyng1J8MB4FTN1ro9+9lAPNUr/haDZdgwKNR7YjaIoTEyqCvpkrASI
	 OXa6lFY2h8otP1zAdjQA1IjIXzRW8wtbGfDwt/fM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43230F800F8;
	Wed, 29 Jun 2022 22:18:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB0A5F8020D; Wed, 29 Jun 2022 22:18:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C1E9F800F8
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2022 22:18:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C1E9F800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="WA5JemMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656533896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T0mox+cZBa8xwfwYuYJx+Qa0zDUEAbigaM/mBFWN0C8=;
 b=WA5JemMA8pAj/oNikcMcsFEfJZm7OqBs+ZD9EJutkS7vs+99xwiMkJ095NovxPUfzEUBmN
 K0LisBik6yY1GfdH0GORdIqWAnFud7SwXkcxCFSV3TVGUUZ16V/5yp7IHzq5+oxJhpm4W0
 Rzc3wDO6sSnFEcOzBBOHJnKcEUhOSEI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-D3_k1ndtOqapDeTWlnDi3g-1; Wed, 29 Jun 2022 16:18:15 -0400
X-MC-Unique: D3_k1ndtOqapDeTWlnDi3g-1
Received: by mail-qv1-f71.google.com with SMTP id
 ke24-20020a056214301800b00470b5eb1debso10716035qvb.7
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2022 13:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T0mox+cZBa8xwfwYuYJx+Qa0zDUEAbigaM/mBFWN0C8=;
 b=u09QJZVTaxjCdKy+urEd/I8g67D47qpLraM1iD9PUyKFo5P9gHwbiGlm6oqxYiZVvr
 qFduB1RA1nAOwu9ROaNoYKqCVyV00Uj2/FCy1X8+sjSzBYGrIfh1BIE/304lGPkl28yK
 aRu487Z8sTKS0nY4avK+dNj+Nk5FfYEabRngXkY3sD6N7vVaqFkRlSdklAFAOjDNPqfy
 TIVy78DAdQ7SD5TC0xyK/T/se8QZYS4fK5ap2TOS189jzmY9NXYgnyZHHOw9mLCLhpJe
 9J+WgVk09CVinQHxvL0vVCiAnJMz1mdljZXjt98258YI+eumtajKoL8m4zNPcrDVZL0S
 sm0g==
X-Gm-Message-State: AJIora+wD5AJgcs3Ys4lyZ27dUCFNmy4YxHzOF+dZR7gib7SLXUHA2L4
 zZ5WYA//C7Wj662hsLl8l9B1ERYabmLR2x735Vvu6Mz7l560A+9aKTj/4OCa4/JM6Q8khlfxlu4
 VBrt4n7KJN33bPOkZIbqn6LI=
X-Received: by 2002:ac8:588e:0:b0:318:88fe:1959 with SMTP id
 t14-20020ac8588e000000b0031888fe1959mr4303799qta.71.1656533894926; 
 Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slW7VD3ZQGeed3+3fKdmGDpjVcX9mn4+bPEdb315aSnZv/k9kpPrgsLRzmOnT9bZdoU9+nHQ==
X-Received: by 2002:ac8:588e:0:b0:318:88fe:1959 with SMTP id
 t14-20020ac8588e000000b0031888fe1959mr4303766qta.71.1656533894587; 
 Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 q15-20020ac8450f000000b003177f0fb61esm10874582qtn.75.2022.06.29.13.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 arnd@arndb.de
Subject: [PATCH] ASoC: samsung: change neo1973_audio from a global to static
Date: Wed, 29 Jun 2022 16:18:11 -0400
Message-Id: <20220629201811.2537853-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Cc: Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
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

sparse reports
sound/soc/samsung/neo1973_wm8753.c:347:24: warning: symbol 'neo1973_audio' was not declared. Should it be static?

neo1973_audio is only used in neo1973_wm8753.c, so it's
storage class specifier should be static.

Fixes: e26a2abcc246 ("ASoC: samsung: neo1973: turn into platform driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/samsung/neo1973_wm8753.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index c98b68567a89..e9f2334028bf 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -344,7 +344,7 @@ static int neo1973_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(dev, &neo1973);
 }
 
-struct platform_driver neo1973_audio = {
+static struct platform_driver neo1973_audio = {
 	.driver = {
 		.name = "neo1973-audio",
 		.pm = &snd_soc_pm_ops,
-- 
2.27.0

