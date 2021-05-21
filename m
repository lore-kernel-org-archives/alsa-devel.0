Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625FDC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 13:51:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6FB611AD
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6FB611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 491F5169E;
	Fri, 21 May 2021 15:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 491F5169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621605098;
	bh=9w/TV9CVLpUQs7q8+82gghUqBoYNgZn2AI/mp8PWTbM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PaGlGNQuiSOgQLtFMmNUfKSAWA4xketB5sZA/AesuR/1qitKOqEKG8LtRnq386IRW
	 eV1uz5LOG0OLb6WbDgEFzdyhYZ86fYQM0MUO87xX/9L6NnEPv3H19S+7fENfb5aONr
	 /gRyoyOccoAMFQ7czvPJm0mRLwac6AIBniFhM8IU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D52E3F8016E;
	Fri, 21 May 2021 15:50:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02827F801DB; Fri, 21 May 2021 15:50:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A529F800C1
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 15:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A529F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="EJrY1exu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621605037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V1gxdxAqE5/3jzNTtDShs24ciotxYSKj3fPo7ElvmCQ=;
 b=EJrY1exuXB4On1R2Ib2BLLCKqJyHA4qFD9TNK85vsIanpwM15EQmwqFN0FT0yVMu5OZYPF
 Ss/BOj0RYkinAayB7bwjBvLEU60ZgLbDHc+eJVj5E6VWHrqCXjf/0UhJI36ClF7IqAFfC4
 wMomAf16Eizv8aePPQNLIPoyNVsjZ50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-SUnhcu_BOSGsfXalEPfgww-1; Fri, 21 May 2021 09:50:33 -0400
X-MC-Unique: SUnhcu_BOSGsfXalEPfgww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8A4A40C5;
 Fri, 21 May 2021 13:50:31 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-187.ams2.redhat.com [10.36.114.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CA0410013D6;
 Fri, 21 May 2021 13:50:29 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH] mfd: arizona: Allow building arizona MFD-core as module
Date: Fri, 21 May 2021 15:50:23 +0200
Message-Id: <20210521135023.192688-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
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

There is no reason why the arizona core,irq and codec model specific
regmap bits cannot be build as a module. All they do is export symbols
which are used by the arizona-spi/i2c and arizona-codec modules, which
themselves can be built as module.

Change the Kconfig and Makefile arizona bits so that the arizona MFD-core
can be built as a module.

This is especially useful on x86 platforms with a WM5102 codec, this
allows the arizona MFD driver necessary for the WM5102 codec to be
enabled in generic distro-kernels without growing the base kernel-image
size.

Note this also adds an explicit "depends on MFD_ARIZONA" to all the
arizona codec Kconfig options. The codec drivers use functions from mfd
arizona-core. These new depends are necessary to disallow the codec
drivers being builtin when the arizona-core is build as a module,
otherwise we end up with missing symbol errors when building vmlinuz.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add explicit "depends on MFD_ARIZONA" to all the arizona codec Kconfigs
---
 drivers/mfd/Kconfig        |  2 +-
 drivers/mfd/Makefile       | 14 +++++++-------
 drivers/mfd/arizona-core.c |  2 ++
 sound/soc/codecs/Kconfig   | 10 +++++-----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..3fb048361b11 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1788,7 +1788,7 @@ config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
 	select MFD_CORE
-	bool
+	tristate
 
 config MFD_ARIZONA_I2C
 	tristate "Cirrus Logic/Wolfson Microelectronics Arizona platform with I2C"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4f6d2b8a5f76..ebc9b6704e87 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -41,24 +41,24 @@ obj-$(CONFIG_MFD_TQMX86)	+= tqmx86.o
 
 obj-$(CONFIG_MFD_LOCHNAGAR)	+= lochnagar-i2c.o
 
-obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
-obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
+arizona-objs			:= arizona-core.o arizona-irq.o
+obj-$(CONFIG_MFD_ARIZONA)	+= arizona.o
 obj-$(CONFIG_MFD_ARIZONA_I2C)	+= arizona-i2c.o
 obj-$(CONFIG_MFD_ARIZONA_SPI)	+= arizona-spi.o
 ifeq ($(CONFIG_MFD_WM5102),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm5102-tables.o
+arizona-objs			+= wm5102-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM5110),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm5110-tables.o
+arizona-objs			+= wm5110-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM8997),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm8997-tables.o
+arizona-objs			+= wm8997-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM8998),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm8998-tables.o
+arizona-objs			+= wm8998-tables.o
 endif
 ifeq ($(CONFIG_MFD_CS47L24),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
+arizona-objs			+= cs47l24-tables.o
 endif
 obj-$(CONFIG_MFD_WCD934X)	+= wcd934x.o
 obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index ce6fe6de34f8..9323b1e3a69e 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1447,3 +1447,5 @@ int arizona_dev_exit(struct arizona *arizona)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arizona_dev_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a7b3e363069..45aa92598066 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -689,7 +689,7 @@ config SND_SOC_CS47L15
 
 config SND_SOC_CS47L24
 	tristate
-	depends on MFD_CS47L24
+	depends on MFD_CS47L24 && MFD_ARIZONA
 
 config SND_SOC_CS47L35
 	tristate
@@ -1558,11 +1558,11 @@ config SND_SOC_WM5100
 
 config SND_SOC_WM5102
 	tristate
-	depends on MFD_WM5102
+	depends on MFD_WM5102 && MFD_ARIZONA
 
 config SND_SOC_WM5110
 	tristate
-	depends on MFD_WM5110
+	depends on MFD_WM5110 && MFD_ARIZONA
 
 config SND_SOC_WM8350
 	tristate
@@ -1727,11 +1727,11 @@ config SND_SOC_WM8996
 
 config SND_SOC_WM8997
 	tristate
-	depends on MFD_WM8997
+	depends on MFD_WM8997 && MFD_ARIZONA
 
 config SND_SOC_WM8998
 	tristate
-	depends on MFD_WM8998
+	depends on MFD_WM8998 && MFD_ARIZONA
 
 config SND_SOC_WM9081
 	tristate
-- 
2.31.1

