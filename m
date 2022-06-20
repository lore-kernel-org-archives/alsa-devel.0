Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15B1C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:28:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA6C01FDF;
	Wed, 22 Jun 2022 17:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA6C01FDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655911718;
	bh=oJdm5C/8BCNEai6FUvuxoVhFY9oVD4JM7IowAgb8EvE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFg0zZFXPevtc93w7jriWFNaHZrM/Nt/Fv6pwsGdxnZXTBVn72vk9RgNVBBoPbaPB
	 qV320rfYuC6+utA+UPBVEM17j5sE1nkJ+NdnzAYHkYWMLkmdHjWOTohs+Bk6kPm07T
	 Wets5C/rHJ6A+qgPZEpkxzA1Ghgtf05R2ilLTe+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4264FF805C2;
	Wed, 22 Jun 2022 17:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F1D5F804EB; Mon, 20 Jun 2022 22:06:49 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61F0BF800CB
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 22:06:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61F0BF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="e+BrKFyU"
Received: by mail-wm1-x32e.google.com with SMTP id e5so6390840wma.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F4wATPKotQB5JDuhaBZ5Jb5Nh8kCkmxeR4cD85ob0jA=;
 b=e+BrKFyUAEKrBpsdiTI0hXdQRnQfzScB8duoVAuFg+GJ0Jh4zZD5Q/yH5NsPA1D9fK
 uaNwGLpdVywtGRLROPl5tTxFT7A8jPHaWbjaPAMdsjcQoj2Fxm0OgNstaADl0insuEPU
 P50NDcoj6V57762q+5c86res9ZHtgVjfYyuGy0xSGWhhHkfr1HpoVpzrKy1Z/3zFEUFZ
 67Fh85T75VnGSm9kPme9xBV7w8ac712S9ul2GLnNaWtQDEdomD1S1aBv1jYpvYeu5a7r
 MGwYhNujO4gNlNbVwu8A+bWELyeb6pNXvwP3xhw3JTzKit4mY+kzcbb6HrnaUC5RjRIY
 8xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F4wATPKotQB5JDuhaBZ5Jb5Nh8kCkmxeR4cD85ob0jA=;
 b=hEdL0TfjC84gPTg8mKquJvq/C2VXPObRU4V6P+1AQzY+PKFW+8p4D69wjeG+Fd/ZiU
 XaqMsJ/G9/B4FRcYnwQpy1GX+Grb0m+luSDbQ63kCOpcHK7/PA3AugGeenSC0Mix/gLU
 ayEfUGm7ejsUK/hFVPTWcM8I1gTaukmF9QMWxNGCN9m9icH0C6XSwj5JzvfRSm11Dwvz
 qusLOPpfdJ8SB0jcO21o+qw8+uadG6LV6GeBxD6um3U3Xbnhf0FuFsnhPdQEOSNOzF2n
 Vv5UDrVewonfdqrajSQrJZrTjXTJC9l4IG8XElbKie4jcfDSaPghggIxFdEFr0WUTbxT
 7/1w==
X-Gm-Message-State: AJIora/1fJgCCTj/96+pr6Dnl36XxRnKpY2p81pqI7jKXr2t3hwIjEJg
 EW3eNxZZV4jIROv9B/iFyQw=
X-Google-Smtp-Source: AGRyM1viZL39dZzsNTWFK1Nii5H/dfYG1kHfbnLLGc84T/J91auGii4XODLgdHEKlU2wd9OGVZncsg==
X-Received: by 2002:a7b:cc8e:0:b0:39c:829d:609b with SMTP id
 p14-20020a7bcc8e000000b0039c829d609bmr27634897wma.160.1655755604433; 
 Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5d6150000000b0021b932de5d6sm2486492wrt.39.2022.06.20.13.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 19/49] mfd: stpmic1: Add broken_mask_unmask irq chip flag
Date: Mon, 20 Jun 2022 21:06:14 +0100
Message-Id: <20220620200644.1961936-20-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jun 2022 17:23:17 +0200
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

The STPMIC1 has a normal "1 to disable" mask register with
separate set and clear registers. It's relying on masks and
unmasks being inverted from their intuitive meaning, so it
needs the broken_mask_unmask flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/stpmic1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..2307d1b0269d 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -110,6 +110,7 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.status_base = INT_PENDING_R1,
 	.mask_base = INT_CLEAR_MASK_R1,
 	.unmask_base = INT_SET_MASK_R1,
+	.broken_mask_unmask = true,
 	.ack_base = INT_CLEAR_R1,
 	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
 	.irqs = stpmic1_irqs,
-- 
2.35.1

