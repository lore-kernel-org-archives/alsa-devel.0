Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFDFC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:26:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AE361E74;
	Wed, 22 Jun 2022 17:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AE361E74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655911609;
	bh=z7ZwsKqeKSWPYOB0EYoi34bX/UVdC4kOWeg+hmpmleo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BX+ag81iLq8+Bu+ytDbirIpGs571v7B3uBOt9ri+p0SImXTYJ4oJxALoituLwT7hr
	 7qTLKaLxnl+swjzpghAaIXJm9z0Sx5sJj21WRW1ImNgsFcTWuY0lkih4Dc4JGkAypJ
	 T6Hw3GYJUl4jk3t3v1wejsnn1apfPhvI3ev0jqLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 114DCF8057C;
	Wed, 22 Jun 2022 17:23:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7803DF804DA; Mon, 20 Jun 2022 22:06:37 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28EBEF800E3
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 22:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28EBEF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="T/UvuXuo"
Received: by mail-wr1-x42a.google.com with SMTP id g27so9431561wrb.10
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ygggAhOijcuCf3qt1rizt96GNeoo90FsvWvR8LV1nyI=;
 b=T/UvuXuobHYQjUmOyYbANq63UlOF39LoQ9F0gifyzekhcyCOQUypCEyXG/OKpb2La8
 Q6xZerE2gogPQTVjnWE4wmzodDreHkzH5Hob1Yofhw+6nVU3v+x19k/F+1fzWd07Nhyx
 t3dlqulqzXj03B/a7eof6RPLvdFSbbKgQ0qPPyyfUc0DvtgH5rSWtXFv/QKk3GFNsmgf
 ba5ere/Jpb7EyG3rOfQF0QhkkW/aBY4cYS4Nq+Vs12xBWeLC+F11zEPyoGk+7XAQtopt
 0onYAtqYMepxk8EG5VyJd6DPsfXoBs96h/qfy/t4bsS9pyheZRo3qyXWG31pXvk7VX4q
 +KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ygggAhOijcuCf3qt1rizt96GNeoo90FsvWvR8LV1nyI=;
 b=0jEGs5zulqS1DwgJtBmE+04dJJGihKVDyZ4XG6eivwJadn9Zy/GMashqURYom2Hy4n
 ZgpAYV0yJdWb2KGtBi+nUX41pTUFoviK3Pecy7g4Q+tjy5Y0hPqpNmNSJFeqDcfs/VF9
 WkBHAojsYWqwAHIkfjFaiXdUbTiaid6ds3Ux265NkPUgPRE2pm30SzdwBke1307uqLZJ
 0tqjyLCJRBsjGU+yhF3vT1qqQ5oQs89apxzGXEn+6l144ZUMmKiwy7AcmgkAaWsUh4ol
 KGz1yCx9hatjNGRTbR9J7RYTwqrt8c4B5JfoOqCzFPpts5sjtfjxY3/DjswIQoRINAQg
 L7Zw==
X-Gm-Message-State: AJIora8P1HtBfNGUR2xyocQz0GSt3q6qgOwp0agDtKtJ+zkrIOFBIgUw
 cKFtHZ07aUBneIorLyOQYos=
X-Google-Smtp-Source: AGRyM1solEebsJ8aWFaYBBFyec3sD94nnN3uwK9ZwQuWOqy8ZNWOPbTCC9XYFknZ9HYg3JgppifEhQ==
X-Received: by 2002:adf:ef42:0:b0:21b:8e58:f24b with SMTP id
 c2-20020adfef42000000b0021b8e58f24bmr7538227wrp.257.1655755593841; 
 Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
 by smtp.gmail.com with ESMTPSA id
 a17-20020adffad1000000b0021b8749728dsm8178248wrs.73.2022.06.20.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 12/49] regmap-irq: Remove unused type_reg_stride field
Date: Mon, 20 Jun 2022 21:06:07 +0100
Message-Id: <20220620200644.1961936-13-aidanmacdonald.0x0@gmail.com>
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

It appears that no chip ever required a nonzero type_reg_stride
and commit 1066cfbdfa3f ("regmap-irq: Extend sub-irq to support
non-fixed reg strides") broke support. Just remove the field.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 6 ------
 include/linux/regmap.h           | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 85d7fd4e07d7..b24818ad36e6 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -40,7 +40,6 @@ struct regmap_irq_chip_data {
 	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
-	unsigned int type_reg_stride;
 
 	bool clear_status:1;
 };
@@ -738,11 +737,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
-	if (chip->type_reg_stride)
-		d->type_reg_stride = chip->type_reg_stride;
-	else
-		d->type_reg_stride = 1;
-
 	if (!map->use_single_read && map->reg_stride == 1 &&
 	    d->irq_reg_stride == 1) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 879afdc81526..1966ad4d0fa5 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1483,8 +1483,6 @@ struct regmap_irq_sub_irq_map {
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
- * @type_reg_stride: Stride to use for chips where type registers are not
- *			contiguous.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
@@ -1535,7 +1533,6 @@ struct regmap_irq_chip {
 
 	int num_config_bases;
 	int num_config_regs;
-	unsigned int type_reg_stride;
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-- 
2.35.1

