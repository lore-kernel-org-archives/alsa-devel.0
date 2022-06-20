Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F7C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:32:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A040F1B12;
	Wed, 22 Jun 2022 17:31:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A040F1B12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655911924;
	bh=W21nd+qHnfH96gWk9NjFRNYdpcqrHxetX2GVYicJgC4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ohk4PVEmKs3LxbmJsVByK2NIuDBJAMR1OwOjkOs6gqDLit5x7DNPvRHzZXUDGXi/E
	 yhbs6NM6tuqjm72icC3aocsLZkRQzqJe7kGtyQdjPgw2Z3/o1SN42VgO3BvAyxsSxM
	 n13VZ0JDN2gfis4dlmE67YKBGrZ3jL4R4oB3WQms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5B69F80602;
	Wed, 22 Jun 2022 17:23:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68B7FF804EB; Mon, 20 Jun 2022 22:07:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D761AF800E3
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 22:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D761AF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bnHiwq/O"
Received: by mail-wm1-x32e.google.com with SMTP id q15so6374680wmj.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ioRXJqRjZqDXf4uhS+zPl4sLu26/rBgrPA3q0xnI1Pk=;
 b=bnHiwq/OClrzuqi/qkl++cxkoDtbanVKeopfnQWVzhU6b4gvB+73xPfwfecrFvG0fg
 c94hGekA8YHpGAXe9zm4qRYYRU0MygrSlEa2zYIu7XgB36o7uYhJEoYrROKQmUBSIY4o
 GC/IaRLTd6YmBywt5HAzxlmtbcVviB558rpnzU3IVr9JxhUY6/cumMLeOBejkhO41DwT
 DsEaO5ReO1eTDEIa8hszhVJBZB5Hbw7MzANj+u8x+/yO6D10YAQ3WQUnywEkt8FEYgLt
 +TQ57DgXgy4ZTyDpkcfoqzaf3zEuCixQ6UraTBXfq3S+ppuoQQgmhycH0ATq77SlYom2
 h4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ioRXJqRjZqDXf4uhS+zPl4sLu26/rBgrPA3q0xnI1Pk=;
 b=gAdDAfLwpL/QLm9cGT1jnCDsHQQQ1D7JozmlGWZt7jsxWHT43jfrBYEJ1w/L9CYfeN
 LOV85zL2BrKHa2FYIPESNjGFDX1GcPbfJGaSQJ9RX8E8ZXtNbUBGOAko97orTttxs+NO
 b4u7afbsQLt3zL79yJMTMQbF3s9OTHOoBOdarfvWncDO9BSKISMO7dkppxOlAyXCpKNJ
 bIdPyXOGXrbDvgLCrohTTjWEDloS4P9va8uPekNuLacI/Qfu76Frnro1UcGIctmdEPPV
 lS+fXtE6JAcy3MhJ7EckUgTaxnBJwzr1n+2l8cHFY0CPAkO2G7rGKcFKL4/ln4/15frZ
 AgRw==
X-Gm-Message-State: AOAM531rieMjWFdEGxYUfIO1ETpNd77+zC5Y+1UaACu2inMq9qQBZhfD
 ssAHE15STOSkyEE7dW7o9n4=
X-Google-Smtp-Source: ABdhPJyk2pG0lVa2PXgg+IL73pDXXybyl784/0CAFzghroiptrtMxz7E7l4unjYw5iEqpwxxNZmr7A==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id
 z13-20020a1c4c0d000000b0039c52331873mr37323556wmf.28.1655755627588; 
 Mon, 20 Jun 2022 13:07:07 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c4d0a000000b003942a244ee6sm15738587wmh.43.2022.06.20.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 13:07:07 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 33/49] mfd: rohm-bd718x7: drop useless mask_invert flag on
 irqchip
Date: Mon, 20 Jun 2022 21:06:28 +0100
Message-Id: <20220620200644.1961936-34-aidanmacdonald.0x0@gmail.com>
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

There's no need to set the flag explicitly to false, since that
is the default value from zero initialization.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/rohm-bd718x7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index bfd81f78beae..ad6c0971a997 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -70,7 +70,6 @@ static struct regmap_irq_chip bd718xx_irq_chip = {
 	.mask_base = BD718XX_REG_MIRQ,
 	.ack_base = BD718XX_REG_IRQ,
 	.init_ack_masked = true,
-	.mask_invert = false,
 };
 
 static const struct regmap_range pmic_status_range = {
-- 
2.35.1

