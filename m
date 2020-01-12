Return-Path: <SRS0=xNGQ=3B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5D1C32771
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jan 2020 05:50:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB0A214AF
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jan 2020 05:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hTbGE1nU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hnjy/C9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21253168D;
	Sun, 12 Jan 2020 06:49:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21253168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578808249;
	bh=pF2/GLpDmmV6beRuO+1OcVBkbrkuZnPU3uj/gnVx0/o=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hTbGE1nUrOYCSNo3huFmsl9MJs19IQ8lUX0gUI8Z2Eemc4yilHArUMknKwFRKWzuY
	 DOBUrMT3J8rz8Mpb3IAdYxmAr2to3YlICwoVGT8rKFxWlf6SiQ+pQK+yi1awEkiLBE
	 WB7fYo5IWiAFSWK7304Fi6ysNd2uAwyLArALT8ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7604BF8014D;
	Sun, 12 Jan 2020 06:49:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0B6FF8014E; Sun, 12 Jan 2020 06:49:56 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07B10F8012E
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2020 06:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B10F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Hnjy/C9/"
Received: by mail-pj1-x1041.google.com with SMTP id s94so2684546pjc.1
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 21:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yuiiLxis7UmO7qtPOBKseQeFyLzKkWcOkkI4cfgxzbE=;
 b=Hnjy/C9/lwj/YKklYxYqjyFlS0dhjQpRJdoiGfZpQuJFrG1CepD+olnANXmyvYt9HK
 IRL19y5/rQazLK5XRskk+rP51oky7FAFgyiPFNrOsrJfnEt9WhV6HMAFaQ1pEJEI6f3a
 686+XrmUmriSvDu2DbPi29ukU6EcAR2Wqs16w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yuiiLxis7UmO7qtPOBKseQeFyLzKkWcOkkI4cfgxzbE=;
 b=rogDbkPdPbDz2efHMVE/T46gCUJ8s++Y8LxAXYK00B1YjPUvGurjVYUB7twSsSkl8R
 yU1WLzscHXyQCtVDgPsy84bZNT9eB1f8srPxutMYkQhTsyQAT1Zr8B9BK+2ZO3qEnCpV
 XxLVVMhbFgKDEwzyijtuVxvQHYD0hapqyEj0zrgA9qA/6Ph+Fwve2xdQVr3d7SfAPqe4
 aIwEYkjgqFR9IimRU+2CH1N7yXbPKfSB4GX8dTtvXEuBvDEpBfifnOAIvtuKwbaFRnyW
 LhSdkkD1QhwI4g5M+1Cr2NAGNBLWiRTtl5yi/SI3D68asusGKDUpFMgM1clBotTMw/0L
 75kg==
X-Gm-Message-State: APjAAAXpqbjfiM0pUufM/hSw2QNFWjFf/7k+7IAPSvGSYLh7zy7XDYPd
 AKcyvr04tWp6yXMIY3G6cjDQTQ==
X-Google-Smtp-Source: APXvYqw8H+bveIPPoAnKYh5V1Z9dF/usIOThJroMZwLFSgEzbsKYs+qEUkX4u5ynq1X/6egf2QW76Q==
X-Received: by 2002:a17:90a:3244:: with SMTP id
 k62mr16102028pjb.43.1578808189512; 
 Sat, 11 Jan 2020 21:49:49 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
 by smtp.gmail.com with ESMTPSA id i127sm9575396pfe.54.2020.01.11.21.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jan 2020 21:49:48 -0800 (PST)
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 12 Jan 2020 13:49:00 +0800
Message-Id: <20200112054900.236576-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Tzung-Bi Shih <tzungbi@chromium.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>, Benson Leung <bleung@chromium.org>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [alsa-devel] [PATCH] ASoC: cros_ec_codec: Make the device acpi
	compatible
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

Add ACPI entry for cros_ec_codec.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index c81bbef2367a0f..6a24f570c5e86f 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -10,6 +10,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -1047,10 +1048,17 @@ static const struct of_device_id cros_ec_codec_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
 #endif
 
+static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
+	{ "GOOG0013", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_codec_acpi_id);
+
 static struct platform_driver cros_ec_codec_platform_driver = {
 	.driver = {
 		.name = "cros-ec-codec",
 		.of_match_table = of_match_ptr(cros_ec_codec_of_match),
+		.acpi_match_table = ACPI_PTR(cros_ec_codec_acpi_id),
 	},
 	.probe = cros_ec_codec_platform_probe,
 };
-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
