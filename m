Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36FCC54FCB
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D9E206D5
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iAMrfPQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D9E206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98EC61679;
	Mon, 20 Apr 2020 14:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98EC61679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587387345;
	bh=8fzhGCgld7/tgc4hmG3wKNfwEsn1G/yxdYo8/YZG9VQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAMrfPQbuL45Z0ju9DaQRXsIBllOoy1Mo31nw6vdl+NX+m3w//aTtnj0MVG51X6wb
	 CHugYC0Pz4qTkO01dyEuIR1l8HH2LXkUFpBIRMExOd0vS16+2a2KaxGshsg4UGh9Ud
	 TpWvD4VrDva7xtlGxmqOV++RwZGKGsnX3fCASdgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31AF5F801D9;
	Mon, 20 Apr 2020 14:54:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DE4EF8021C; Mon, 20 Apr 2020 14:54:48 +0200 (CEST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2747CF8013E
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 14:54:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2747CF8013E
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DFF9BFC3FD05B4C312C1;
 Mon, 20 Apr 2020 20:54:30 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 20:54:24 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <geert@linux-m68k.org>
Subject: [PATCH] ASoC: wm89xx: Add missing dependency
Date: Mon, 20 Apr 2020 20:53:43 +0800
Message-ID: <20200420125343.20920-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200418090853.30340-1-yuehaibing@huawei.com>
References: <20200418090853.30340-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org,
 ckeepax@opensource.cirrus.com, linux-kernel@vger.kernel.org
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

sound/soc/codecs/wm8900.o: In function `wm8900_i2c_probe':
wm8900.c:(.text+0xa36): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8900.o: In function `wm8900_modinit':
wm8900.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8900.o: In function `wm8900_exit':
wm8900.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
sound/soc/codecs/wm8988.o: In function `wm8988_i2c_probe':
wm8988.c:(.text+0x857): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8988.o: In function `wm8988_modinit':
wm8988.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8988.o: In function `wm8988_exit':
wm8988.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
sound/soc/codecs/wm8995.o: In function `wm8995_i2c_probe':
wm8995.c:(.text+0x1c4f): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8995.o: In function `wm8995_modinit':
wm8995.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8995.o: In function `wm8995_exit':
wm8995.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'

Add SND_SOC_I2C_AND_SPI dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e6a0c5d05fa5..e60e0b6a689c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1525,6 +1525,7 @@ config SND_SOC_WM8804_SPI
 
 config SND_SOC_WM8900
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8903
 	tristate "Wolfson Microelectronics WM8903 CODEC"
@@ -1576,6 +1577,7 @@ config SND_SOC_WM8985
 
 config SND_SOC_WM8988
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8990
 	tristate
@@ -1594,6 +1596,7 @@ config SND_SOC_WM8994
 
 config SND_SOC_WM8995
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8996
 	tristate
-- 
2.17.1


