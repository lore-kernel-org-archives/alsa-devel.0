Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C566C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:33:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1C3B2080;
	Wed, 22 Jun 2022 17:32:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1C3B2080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655912002;
	bh=VHYdr7QfZJ2tX5PnSrpqgiTvM/4aEjFRbj0kPGHeAkA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAWE7uW+DfSCixROTqRMXzxF8KpyPDkcrTF9N8/kEw/Vn9J90xbP93ZuJM/uKK/K8
	 ENy0Y6fT6f4+XhHk24WVMFZstgIrjoXpp5XaAHO/bnlmXgDGtIJtwBnvwaAWHlDd80
	 QdlB4HMLA8cBkXLAhX7Pi1bwipH01ta9DAhKdUn4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF3B9F80615;
	Wed, 22 Jun 2022 17:23:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68B11F804E5; Mon, 20 Jun 2022 22:07:17 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D55FF804DA
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 22:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D55FF804DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="N5XPG9Op"
Received: by mail-wr1-x429.google.com with SMTP id o16so16088316wra.4
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y97fwLubKQPhfVzVr/BJ8A0OiHWSUnBqrgJCFHiEuQo=;
 b=N5XPG9OplADmbLH0pHfxycXOk0ogBS6as/63+9NbBIR+tpKjwFF8jaDqvXytgN7eFN
 iCIGHlH+jU+vvt27pchv5bzTabl6azkQzKY7vFkafPwH50QQyWfkBzOGOCCVxQXhvncE
 YaWxNzKfmxeTvJUbcVoUMVUAWlE3JvZZ4lB+5+QyyAHS3e43yyMBrnmUQcQabmJqyNxu
 yz5S4TVH2O8DPD2Rf80CaJq7lQH+C0gh4FsLbgYgRXSmVebkFxyjrNjhCPP76XpsYQIa
 zUI7t6/WnGNbz1TtlV3gFxQsN1aO4fpmL8EGt0pWJOiQvv0pEELOjmzyWY2VXTtrFst3
 zOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y97fwLubKQPhfVzVr/BJ8A0OiHWSUnBqrgJCFHiEuQo=;
 b=Pnms0Hr010XOe/yl97K10bB0mv667gbxh75mINRuJ3gued38ryKCAYBWHBG2lkCK8c
 AsTysG21EugLteDH+/gXifjco7ttdrs+c0+5JRA+5wOfyZgBE+JTZaPh1zuW3ubq+uoh
 iT0LzlPacUKLMAsSQDeG4+mOHkoGivcFU4cmSeVdrbptBbRi7b5i76YkKHWfT6kthpcd
 JWfK3XiRzUteiPaT2zLraa2LlUux6onDHqgXJoJuAQMbkGCqCnZoq9XLgEj4MIWlt1Kw
 wU55evDqUDIpcnfKKM28sHqSQkw573M4CWvBEDMQQlUXs+NMDB/G30iTQNCIy1SvysVF
 jTsg==
X-Gm-Message-State: AJIora90sSBQpoJq8dcAiKj9CkgReotNN/1Lr+sFsUgEWwXj2YDxKnL5
 nkw2jDqI5NBZVX4mqxkrh2U=
X-Google-Smtp-Source: AGRyM1snTNRqPq+iZgzXYj3YO4MyMbr+ecuPp+zCi4PLi5xytxdvLNbc3QFI/5y6NXWpWtWF0rRckQ==
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id
 ck18-20020a5d5e92000000b0021a278cb901mr24824370wrb.461.1655755632740; 
 Mon, 20 Jun 2022 13:07:12 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a05600c0a4500b0039c4ba160absm33779394wmq.2.2022.06.20.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 13:07:12 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 36/49] extcon: sm5502: drop useless mask_invert flag on irqchip
Date: Mon, 20 Jun 2022 21:06:31 +0100
Message-Id: <20220620200644.1961936-37-aidanmacdonald.0x0@gmail.com>
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
 drivers/extcon/extcon-sm5502.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index f706f5288257..8401e8b27788 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -227,7 +227,6 @@ static const struct regmap_irq_chip sm5502_muic_irq_chip = {
 	.name			= "sm5502",
 	.status_base		= SM5502_REG_INT1,
 	.mask_base		= SM5502_REG_INTMASK1,
-	.mask_invert		= false,
 	.num_regs		= 2,
 	.irqs			= sm5502_irqs,
 	.num_irqs		= ARRAY_SIZE(sm5502_irqs),
@@ -276,7 +275,6 @@ static const struct regmap_irq_chip sm5504_muic_irq_chip = {
 	.name			= "sm5504",
 	.status_base		= SM5502_REG_INT1,
 	.mask_base		= SM5502_REG_INTMASK1,
-	.mask_invert		= false,
 	.num_regs		= 2,
 	.irqs			= sm5504_irqs,
 	.num_irqs		= ARRAY_SIZE(sm5504_irqs),
-- 
2.35.1

