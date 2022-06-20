Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D5FCCA47D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:31:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 656701F7C;
	Wed, 22 Jun 2022 17:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 656701F7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655911892;
	bh=+1KR/HarNT0msazKchOGjVXG+H/CEmGlWnzE8JjRC74=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iEz4JaeDC/tNgSfdDoGPDQNsPWgjhuFNQHmmvDCo8/0cs7hfnAUcwNBwz328HGkDn
	 5q6zP1cGyeuclHZxyOf+ofOVOu4FaSYMp+odeYvUqDLG7gAaLQw5iin5JVPK3VXfY/
	 tge4p/wkrJF3LgLi10Ob87mo9Y1QndcFoFYjlk6A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7502F805FA;
	Wed, 22 Jun 2022 17:23:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65FF2F804DA; Mon, 20 Jun 2022 22:07:07 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A5FCF800CB
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 22:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A5FCF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Mlv4ZVoH"
Received: by mail-wr1-x42e.google.com with SMTP id v14so16098443wra.5
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RL0fwUpj3N31VObGflnvTdc3SYbFvbOFJTIucbQixBw=;
 b=Mlv4ZVoHQKH/diZ7wxwIL4K/NMJzc8U94Vgk4Cv6mLqtv2zUYMSW25mN9q0aL0QiaD
 ypWyVxkxCSP8wGvJCokCsjQ6tDA09v/ytF7zvcl648K7FlONHBR2wfNK3QShVbur16Ms
 Etfs+ATYrdsjBlliM9yYPEfiDP24lw5E53L/DQ+aFBEaoSuyH0FKKVlxJgKMAVEDu74C
 qNbf8xDFV/CcJqFhatQhPeGSPTWRTO55xPy2YKxC6vO/a5lLkP3E2xpOBkHescTgDCGf
 6sV5K6mdGgz67dpXL7CLkkp/9x203Hye1oIstypDYQK4gwAVULEnVqIxaa7ZmZAes0sL
 9TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RL0fwUpj3N31VObGflnvTdc3SYbFvbOFJTIucbQixBw=;
 b=v9RBT0xs93AdL2qcD68ymLwRFPQXSKomzPiaNYksDSZ33PlLEVO4fYEAByuGz6WQ85
 i9PADjTTNILWh+eeztgp3Wq7VoSq3rRHqV/nBKvCHpQO7X/PzqACJGvBefc5URO3wAS0
 mP1rRV16HP4G3o1NEjxtL34IWMGPSxqA7XfoyVRZZTFuJasm5bVw/91ZAYvGZ/oMWCDi
 MdMrypttmjUkdJkkjWE94nBcVBdyYRfC1MrMXIJt6m/ZTllNlTwnkU8NA+3w2KdAvYy+
 wgEfXCEsvAzNiapgkv1f4Sqzmyyps767LoZvpqIaLZuuU8/I6d/BvvxQJjDWBz+/u9hZ
 mCog==
X-Gm-Message-State: AJIora9Iq88/CCoiRAIT/8SnfN/4aEmaWVnWohkPIugimFKaz7l4OKdt
 Q00xA45dWSLpPFxH3/jZorg=
X-Google-Smtp-Source: AGRyM1sc2kxmFsNd28wLHl+sBWx8EhrjSubA+8EnJdnvaG1LPBATT/Oqb8jppvaI5mcfhWVI8YU61A==
X-Received: by 2002:a5d:47a8:0:b0:217:b5ea:bdfb with SMTP id
 8-20020a5d47a8000000b00217b5eabdfbmr25488579wrb.492.1655755620510; 
 Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a05600c3b9700b0039c5224bfcbsm20985958wms.46.2022.06.20.13.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 29/49] mfd: atc260x: replace irqchip mask_invert with
 unmask_base
Date: Mon, 20 Jun 2022 21:06:24 +0100
Message-Id: <20220620200644.1961936-30-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jun 2022 17:23:18 +0200
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rafael@kernel.org,
 linus.walleij@linaro.org, bjorn.andersson@linaro.org,
 srinivas.kandagatla@linaro.org, myungjoo.ham@samsung.com, lee.jones@linaro.org,
 samuel@sholland.org, maz@kernel.org, brgl@bgdev.pl, mani@kernel.org,
 krzysztof.kozlowski@linaro.org, jernej.skrabec@gmail.com,
 cw00.choi@samsung.com, wens@csie.org, agross@kernel.org, orsonzhai@gmail.com,
 linux-sunxi@lists.linux.dev, b.zolnierkie@samsung.com,
 linux-arm-msm@vger.kernel.org, tharvey@gateworks.com,
 linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org, tiwai@suse.com,
 tglx@linutronix.de, cristian.ciocaltea@gmail.com,
 linux-arm-kernel@lists.infradead.org, rjones@gateworks.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 michael@walle.cc, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
 mazziesaccount@gmail.com
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

An inverted mask register can be described more directly
as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/atc260x-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
index 7148ff5b05b1..7c5de3ae776e 100644
--- a/drivers/mfd/atc260x-core.c
+++ b/drivers/mfd/atc260x-core.c
@@ -100,8 +100,7 @@ static const struct regmap_irq_chip atc2603c_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2603c_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2603C_INTS_PD,
-	.mask_base = ATC2603C_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2603C_INTS_MSK,
 };
 
 static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
@@ -110,8 +109,7 @@ static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2609a_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2609A_INTS_PD,
-	.mask_base = ATC2609A_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2609A_INTS_MSK,
 };
 
 static const struct resource atc2603c_onkey_resources[] = {
-- 
2.35.1

