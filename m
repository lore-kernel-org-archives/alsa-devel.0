Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39110EB64DC
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jun 2023 01:07:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2444C839;
	Sun, 25 Jun 2023 03:06:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2444C839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687655245;
	bh=ZO9AYbqjJIyowhm5wC2XjXtFZYVZWjD/BOwOs81Hp6U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XzBEjVGLJQL+D9Ya3ilDWVxE76jyBbeAQRveegDoDp1qyKmi9FMlm7qLroE2z1yBP
	 ddNcSMGCJDxgQ5njay2fIBbM99X7z/vfy55x3Aqe+F3LMBT4Gy8SRXoQzV1CdW5IMj
	 LuKVvr2CZ2V4Bat9LmMzyw8D6iyvmJ1GAT0u4E1Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39D82F80246; Sun, 25 Jun 2023 03:06:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D59C9F80246;
	Sun, 25 Jun 2023 03:06:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37439F80246; Sun, 25 Jun 2023 03:06:06 +0200 (CEST)
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 700F4F80093
	for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2023 03:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 700F4F80093
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlqM4JC_1687655148;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VlqM4JC_1687655148)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 09:05:49 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: tas2781: No need to set device_driver owner
Date: Sun, 25 Jun 2023 09:05:47 +0800
Message-Id: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FJZDI5L65IF6DSLNWQG7IPJOFJECS6GY
X-Message-ID-Hash: FJZDI5L65IF6DSLNWQG7IPJOFJECS6GY
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FJZDI5L65IF6DSLNWQG7IPJOFJECS6GY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Remove .owner field if calls are used which set it automatically.

to silence the warning:
./sound/soc/codecs/tas2781-i2c.c:746:3-8: No need to set .owner here.  The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5589
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/tas2781-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 4c59429a42b7..55cd5e3c23a5 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -743,7 +743,6 @@ MODULE_DEVICE_TABLE(acpi, tasdevice_acpi_match);
 static struct i2c_driver tasdevice_i2c_driver = {
 	.driver = {
 		.name = "tas2781-codec",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(tasdevice_of_match),
 #ifdef CONFIG_ACPI
 		.acpi_match_table = ACPI_PTR(tasdevice_acpi_match),
-- 
2.20.1.7.g153144c

