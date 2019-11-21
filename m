Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C236C43215
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:14:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DD3206D7
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pgr7kR8G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fj/q972O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DD3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2F7517BA;
	Thu, 21 Nov 2019 18:13:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2F7517BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574356460;
	bh=dQCe/FfoyDUeLP1DiC36jY+nw5HtGP22prdnHUBiu24=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgr7kR8GshzmNYs3KUJfLNPamS8TnBtBpTRIm3+s1fqa+rhCwLbJMTjSMj7XNIKwv
	 ykniDF2WIq/spENf6B21cT00Q3QArgma/3g3SqdHm7SCYDUtkeBmADxdXCXPl8sMOG
	 fwU9b9bvqf+JaeCM85MXPz0zTeazayJgHURacL5E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65E22F80265;
	Thu, 21 Nov 2019 18:06:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1656F80258; Thu, 21 Nov 2019 18:06:09 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4E4AF8022D
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 18:05:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4E4AF8022D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Fj/q972O"
Received: by mail-wm1-x343.google.com with SMTP id x26so4281346wmk.4
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KYUxe40Wol2l12APUosgjjHbStmZ9vI8Y93vuvE0IMw=;
 b=Fj/q972O6NzUzRqqoKcM+qwH0llcsqcI03zOHVs2Xjro3wGmfgwBxhBMAgfctGYbZ/
 H4Z49RWmZiMiRUlI5aQp0fq2lo++40eHTv7EQVo6XAOIRsoNbs18O46k8OMPjq3JC0d7
 tMuOClISTjj6wUrESFTA8nxM/kXvCxBWeOQtB5u0rrNfxV/7aqjLBTC+k8qLg7d3lRUO
 vw34CGHXeV7ywVgJW9Qy9dO0YEjpOsDc0gv/tHkWaBX9vO9RSCelmpHS66m28YgrM7Ap
 5qDA7A1/wuGDbRLPstGSqE7NemgAevZUBiJGv7gOPYtoc0/TQT+ugT6hhMPC8bFFK7aM
 GhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KYUxe40Wol2l12APUosgjjHbStmZ9vI8Y93vuvE0IMw=;
 b=JpbA1sSE7JiWbrfpxAyT2hO8mATIz1TRsqK9zlIzXg8Iol0ezCaOdodCGFNooTNzIN
 Y8bG2FImZf6pvEBqXdATYII8n9VjlSbNcy66TztlHPctwlUNNP6eWkF/oIRwZLcd9UAQ
 0K66Y5EKiuow+eMFNgXBj9bXDePTMsICer1dKsHMaUMnlTqG2zi8HjYRjmPLWGCM4S6J
 dC+YQKJVCadoArl65zwOTvpWRuLQxZJ5IYZEBgGnM1CqEXplI4/k4vFkZv01j2PzYYIf
 3t6MzZeKexmT1FR64+jajheuIqEAZK16RJJy4IH0UDoZ433HdcUNBwn92Qd4yHS2q6Ia
 3qSA==
X-Gm-Message-State: APjAAAUjzJPV/2p9FQ2ip6Cf5czZ4Dm5KuFcUp9MBRh23P/aVONM9Tjl
 DKc9IvAyFqcN0ydJkyhyfX804g==
X-Google-Smtp-Source: APXvYqxdxsnBUxoNO4Gz6MWG8MFggURKxQena3Rmf/BnvPO8Zkt/7sUjczEpPb7cyu9Bo5ZzmPz1UQ==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr10892438wmi.17.1574355958461; 
 Thu, 21 Nov 2019 09:05:58 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id i71sm4423731wri.68.2019.11.21.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 09:05:57 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
 linus.walleij@linaro.org
Date: Thu, 21 Nov 2019 17:05:07 +0000
Message-Id: <20191121170509.10579-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
References: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, vinod.koul@linaro.org, spapothi@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v4 10/12] gpio: wcd934x: Add support to wcd934x
	gpio controller
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch adds support to wcd934x gpio block found in
WCD9340/WC9341 Audio codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/gpio/Kconfig        |   8 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-wcd934x.c | 104 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/gpio/gpio-wcd934x.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 38e096e6925f..4be583933b1e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -586,6 +586,14 @@ config GPIO_VX855
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config GPIO_WCD934X
+	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 gpio controller driver"
+	depends on MFD_WCD934X && OF_GPIO
+	select GPIO_GENERIC
+	help
+         This driver is to supprot GPIO block found on the Qualcomm Technologies
+	 Inc WCD9340/WCD9341 Audio Codec.
+
 config GPIO_XGENE
 	bool "APM X-Gene GPIO controller support"
 	depends on ARM64 && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d2fd19c15bae..496f632ac5c5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VR41XX)		+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
+obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
 obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
 obj-$(CONFIG_GPIO_WM831X)		+= gpio-wm831x.o
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
new file mode 100644
index 000000000000..0aac33235c5f
--- /dev/null
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+
+#define WCD_PIN_MASK(p) BIT(p - 1)
+#define WCD_REG_DIR_CTL_OFFSET 0x42
+#define WCD_REG_VAL_CTL_OFFSET 0x43
+#define WCD934X_NPINS		5
+
+struct wcd_gpio_data {
+	struct regmap *map;
+	struct gpio_chip chip;
+};
+
+static int wcd_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+
+	return regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+				  WCD_PIN_MASK(pin), 0);
+}
+
+static int wcd_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
+				     int val)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+
+	regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+			   WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+
+	return regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
+				  WCD_PIN_MASK(pin),
+				  val ? WCD_PIN_MASK(pin) : 0);
+}
+
+static int wcd_gpio_get(struct gpio_chip *chip, unsigned int pin)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+	int value;
+
+	regmap_read(data->map, WCD_REG_VAL_CTL_OFFSET, &value);
+
+	return !!(value && WCD_PIN_MASK(pin));
+}
+
+static void wcd_gpio_set(struct gpio_chip *chip, unsigned int pin, int val)
+{
+	wcd_gpio_direction_output(chip, pin, val);
+}
+
+static int wcd_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct wcd_gpio_data *data;
+	struct gpio_chip *chip;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->map = dev_get_regmap(dev->parent, NULL);
+	if (!data->map) {
+		dev_err(dev, "%s: failed to get regmap\n", __func__);
+		return  -EINVAL;
+	}
+
+	chip = &data->chip;
+	chip->direction_input  = wcd_gpio_direction_input;
+	chip->direction_output = wcd_gpio_direction_output;
+	chip->get = wcd_gpio_get;
+	chip->set = wcd_gpio_set;
+	chip->parent = dev;
+	chip->base = -1;
+	chip->ngpio = WCD934X_NPINS;
+	chip->label = dev_name(dev);
+	chip->of_gpio_n_cells = 2;
+	chip->can_sleep = false;
+
+	return devm_gpiochip_add_data(dev, chip, data);
+}
+
+static const struct of_device_id wcd_gpio_of_match[] = {
+	{ .compatible = "qcom,wcd9340-gpio" },
+	{ .compatible = "qcom,wcd9341-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wcd_gpio_of_match);
+
+static struct platform_driver wcd_gpio_driver = {
+	.driver = {
+		   .name = "wcd934x-gpio",
+		   .of_match_table = wcd_gpio_of_match,
+	},
+	.probe = wcd_gpio_probe,
+};
+
+module_platform_driver(wcd_gpio_driver);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc WCD GPIO control driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
