Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493AAC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 07:05:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8749817E0;
	Mon, 14 Mar 2022 08:04:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8749817E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647241499;
	bh=gxAptMgA5LFeFRtPEazMS5MrTNNqis4W8L1yiCUHzOA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bjXKAJh+nro4gmqrFAsjiroh7ffs2LwTKAfF7FaGXappvREItrv+eLnIyUcgwyVqJ
	 GYXJfmgZvpWI39jAc2rMiW5Gd5V/ALOLxWmUKl+4Gh0QDzNmev9PBMHFud8HPaYymW
	 uym0AmCl1hpMo79++BrOqW0u1Jo9UwnNQUz9FK1M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61354F80589;
	Mon, 14 Mar 2022 07:59:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1C7AF8012C; Sat, 12 Mar 2022 01:25:07 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 634A0F8012C
 for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2022 01:25:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 634A0F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mJ+3x6VV"
Received: by mail-pj1-x1041.google.com with SMTP id b8so9570189pjb.4
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 16:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=pyncn/uVxB66BCY7x3SIh/kgQlmj4ZSWJds3wQzq3I4=;
 b=mJ+3x6VVmBDGt9svMNU3c2pcW9D5V3ir9bCVeO30pI0nvR7IrUFZ9jsGJAHJ289UZR
 W49rMzoQSA/SvCW8bbJqD2V3NugBbe+JI5UqNMErJDbpOsZl9Gwn8LNTMVk7yYwYH0V/
 TxUgXfjKWR7w8YrH7mVvf1AsTSL8wM7aUZ8865ZrxcH55E5TBNMMCIwhO+tTz1H8v3QA
 MfEZQ1wkMSArrDugBkQIABPFSG7ApJFki8iOwgJ2lYyNe/jRGov7/9vKNghXoZFEIgRs
 YQl7s2JU/g1Pe9D/XgEp88rZI5NBJ5qirSY7/vPPeXMope0H5vSuyJXYTbRqOMMJaCTP
 BiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pyncn/uVxB66BCY7x3SIh/kgQlmj4ZSWJds3wQzq3I4=;
 b=Zyen1F8//T5Bwh7K6POJryARQyxu7PhRW+Rsy9xvrMES9QIwYG4CqxPurEoLldDaBj
 JgGRXBTsuxUPLq+AmvWEdBRd2yGJz1EnOyXT5ohYUT+HB4qbtoetskQstaWOctsB/lK+
 xFEzqVeReaFFH75Std03VHO7sdkMlE+9rpJmJqrMp5Y+72Mj63upzO/yfLeFvPhwNLSL
 A3cSs7pV7YwqhDlncDFqSGYobW/XE9eCOLZRVvvCLU1GlJiThqhnOmYVE/EAmZs8dN4Z
 kf8as8jVnMxyvILR8o5XV69Vc2jAfXp1NbJEUSyGOLYcc2/kQQ1AlvfI8P2jHcif8vZX
 7ACA==
X-Gm-Message-State: AOAM532BivxGO8ZgCVnjr6Rk0M93ccVMLdZvspGj3qTk8uPPOJPSDaR6
 aeQDnrkY2M3AjvVNg5bG78c=
X-Google-Smtp-Source: ABdhPJy7jWE6Md6pE8pvBgnIfPc7YYjI1QJZMcnZ13NcS6fw/v7htifKwzVzPLu/bkle6WXYqdZZug==
X-Received: by 2002:a17:90b:4f8c:b0:1bf:3ef:d668 with SMTP id
 qe12-20020a17090b4f8c00b001bf03efd668mr13122156pjb.219.1647044700923; 
 Fri, 11 Mar 2022 16:25:00 -0800 (PST)
Received: from localhost.localdomain ([211.212.143.131])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056a001a0600b004f2a4316a0asm11325696pfv.60.2022.03.11.16.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Mar 2022 16:25:00 -0800 (PST)
From: Steve Lee <steve.lee.analog@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
 rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
 srinivas.kandagatla@linaro.org, krzk@kernel.org, jack.yu@realtek.com,
 nuno.sa@analog.com, ryans.lee@maximintegrated.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RESEND V2] ASoC: max98390: Add reset gpio control
Date: Sat, 12 Mar 2022 09:24:29 +0900
Message-Id: <20220312002429.16175-1-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 14 Mar 2022 07:58:50 +0100
Cc: Steve Lee <steve.lee.analog@gmail.com>
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

 Add reset gpio control to support RESET PIN connected to gpio.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
 sound/soc/codecs/max98390.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 40fd6f363f35..9a9299e5cc5a 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 
 	struct max98390_priv *max98390 = NULL;
 	struct i2c_adapter *adapter = i2c->adapter;
+	struct gpio_desc *reset_gpio;
 
 	ret = i2c_check_functionality(adapter,
 		I2C_FUNC_SMBUS_BYTE
@@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
+					     "maxim,reset-gpios", GPIOD_OUT_LOW);
+
+	/* Power on device */
+	if (reset_gpio) {
+		usleep_range(1000, 2000);
+		/* bring out of reset */
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98390->regmap,
 		MAX98390_R24FF_REV_ID, &reg);
-- 
2.17.1

