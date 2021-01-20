Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82416C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:52:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF32235F9
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF32235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8034817B4;
	Wed, 20 Jan 2021 22:51:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8034817B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611179519;
	bh=GhU8PGO1+yx8Njokzd23JuRMxpfYiQ6QA0BKKiNBVyY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kvNd19Iu6ykl+d1WIT9I0m4aEKfKHaRxlhpOe1QRmvGfA2ybowPzp5WcdccV6JxC3
	 TUgqhvJVhxjG39tWybkq7GjqGdy+mBsyp1lsnoKID4PN/XFsJjlzeqLUk5g5G62MGO
	 7p+FdHHWCB3XVYDAaWNqLBh/gXH8i/LO1B+7VkAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30DDFF804B2;
	Wed, 20 Jan 2021 22:50:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCE46F804B2; Wed, 20 Jan 2021 22:50:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AAA8F8019B
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 22:50:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AAA8F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Brg3nKvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611179409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwWb/jzvcF0HeOiU902re41Et7/qhlMHI34fzUY/I1I=;
 b=Brg3nKvJjCzp9VKIsxNJ6JMirvDCvHayOqJa6sEkKBbH13Ijy8e994svvQneQOVRdrjrHd
 5BPjgX+BUxNNnjvYlQatFKQP6JiEhvwrKyQSPn2230f5vDZPSlxYKBtQyIUYK+4sB4GHWd
 UWBLkRXqeTNyEgTsgSbzPmR5ajCm8mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-DW4KbaaFP52ECPAscXvJHw-1; Wed, 20 Jan 2021 16:50:06 -0500
X-MC-Unique: DW4KbaaFP52ECPAscXvJHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F18051BE;
 Wed, 20 Jan 2021 21:50:04 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9C6627DD;
 Wed, 20 Jan 2021 21:50:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/5] mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
Date: Wed, 20 Jan 2021 22:49:53 +0100
Message-Id: <20210120214957.140232-2-hdegoede@redhat.com>
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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

The (shared) probing code of the arizona-i2c and arizona-spi modules
takes the following steps during init:

1. Call mfd_add_devices() for a set of early child-devices, this
includes the arizona_ldo1 device which provides one of the
core-regulators.

2. Bulk enable the core-regulators.

3. Read the device id.

4. Call mfd_add_devices() for the other child-devices.

This sequence depends on 1. leading to not only the child-device
being created, but also the driver for the child-device binding
to it and registering its regulator.

This requires the arizona_ldo1 driver to be loaded before the
shared probing code runs. Add a softdep for this to both modules to
ensure that this requirement is met.

Note this mirrors the existing MODULE_SOFTDEP("pre: wm8994_regulator")
in the wm8994 code, which has a similar init sequence.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-i2c.c | 1 +
 drivers/mfd/arizona-spi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 4b58e3ad6eb6..2a4a3a164d0a 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -115,6 +115,7 @@ static struct i2c_driver arizona_i2c_driver = {
 
 module_i2c_driver(arizona_i2c_driver);
 
+MODULE_SOFTDEP("pre: arizona_ldo1");
 MODULE_DESCRIPTION("Arizona I2C bus interface");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 2633e147b76c..704f214d2614 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -110,6 +110,7 @@ static struct spi_driver arizona_spi_driver = {
 
 module_spi_driver(arizona_spi_driver);
 
+MODULE_SOFTDEP("pre: arizona_ldo1");
 MODULE_DESCRIPTION("Arizona SPI bus interface");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
2.28.0

