Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC6BC636D7
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Feb 2023 01:07:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A540B207;
	Mon, 13 Feb 2023 02:06:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A540B207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676250436;
	bh=d023Do/NqwobL46TZL7Neu840/dUx7+w551YhSJz3M0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RylBWekfN9SAZw+vPEgwLaRIKXZUigem/18fkacODZgxTaNlTo4UA4HAUTWoBdAc6
	 WeVzm6le+qSY7nAqG7U8paOHsdVqVBkEjlPpJdmsF3BGQ3c+fUGFOu5Puf51U6Didc
	 yCGc+wyFD1kvorp5YUOjxwavcXl2PsrJul3kgoOU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CBA2AF804B0;
	Mon, 13 Feb 2023 02:06:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14B8AF804B0; Mon, 13 Feb 2023 02:05:59 +0100 (CET)
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4CCB5F800B0
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2023 02:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CCB5F800B0
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VbRudjG_1676250347;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VbRudjG_1676250347)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 09:05:48 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: tiwai@suse.com
Subject: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Date: Mon, 13 Feb 2023 09:05:47 +0800
Message-Id: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CFNDZMHRAACAVYMH4QWS6LZPJM3V6THQ
X-Message-ID-Hash: CFNDZMHRAACAVYMH4QWS6LZPJM3V6THQ
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: herve.codina@bootlin.com, lgirdwood@gmail.com, broonie@kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CFNDZMHRAACAVYMH4QWS6LZPJM3V6THQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

./sound/soc/codecs/peb2466.c:1851:2-3: Unneeded semicolon
./sound/soc/codecs/peb2466.c:1887:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4045
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/peb2466.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 4640b1860312..5dec69be0acb 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -1848,7 +1848,7 @@ static int peb2466_chip_direction_input(struct gpio_chip *c, unsigned int offset
 	if (offset < 16) {
 		/* SOx_{0,1} */
 		return -EINVAL;
-	};
+	}
 
 	ret = peb2466_chip_gpio_offset_to_dir_regmask(offset, &xr_reg, &mask);
 	if (ret) {
@@ -1884,7 +1884,7 @@ static int peb2466_chip_direction_output(struct gpio_chip *c, unsigned int offse
 	if (offset < 16) {
 		/* SOx_{0,1} */
 		return 0;
-	};
+	}
 
 	ret = peb2466_chip_gpio_offset_to_dir_regmask(offset, &xr_reg, &mask);
 	if (ret) {
-- 
2.20.1.7.g153144c

