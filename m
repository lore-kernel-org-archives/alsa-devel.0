Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE87ECE7B1A
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Sep 2023 11:00:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1057BDF2;
	Thu, 28 Sep 2023 13:00:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1057BDF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695898852;
	bh=4NcSBBMI/oUp6MCEkQRBn4RU73rS+qS8sPWL6Y9zlWs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rLSSZ0jmkK5kb6CH0kXw7/Ql6cd7BdoyXK0yFCVftXav8UYAz0AF83MHrCGRnXnFc
	 v3wE/aBkqbKv8lCDb2XlDPhTRmyKEtUlQayN+s4gcZf557x6+5eIUecdMdyjpRIZtu
	 NMbddq3GFrpkBZs/nEO+Mod2AEWOVaQQa+XzChvQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00968F805C8; Thu, 28 Sep 2023 12:58:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFE50F805C6;
	Thu, 28 Sep 2023 12:58:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 872E0F805BF; Thu, 28 Sep 2023 12:58:40 +0200 (CEST)
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com
 [115.124.28.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81C0DF80551
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 12:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81C0DF80551
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.3076728|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0160282-0.00019851-0.983773;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=30;RT=30;SR=0;TI=SMTPD_---.UqYH8we_1695898702;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.UqYH8we_1695898702)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 18:58:30 +0800
From: wangweidong.a@awinic.com
To: girdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	rf@opensource.cirrus.com,
	shumingf@realtek.com,
	herve.codina@bootlin.com,
	rdunlap@infradead.org,
	13916275206@139.com,
	ryans.lee@analog.com,
	linus.walleij@linaro.org,
	ckeepax@opensource.cirrus.com,
	doug@schmorgal.com,
	ajye_huang@compal.corp-partner.google.com,
	harshit.m.mogalapalli@oracle.com,
	arnd@arndb.de,
	yang.lee@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	liweilei@awinic.com,
	yijiangtao@awinic.com,
	trix@redhat.com,
	dan.carpenter@linaro.org,
	colin.i.king@gmail.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 06/10] ASoC: codecs: Modify i2c driver name
Date: Thu, 28 Sep 2023 18:57:23 +0800
Message-ID: <20230928105727.47273-7-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928105727.47273-1-wangweidong.a@awinic.com>
References: <20230928105727.47273-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KNX7MQDMIUJB7M5RF65FSYPZECYNIAR6
X-Message-ID-Hash: KNX7MQDMIUJB7M5RF65FSYPZECYNIAR6
X-MailFrom: wangweidong.a@awinic.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KNX7MQDMIUJB7M5RF65FSYPZECYNIAR6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

Change the name of the i2c driver, this is to
be consistent with the "awinic,aw88395.yaml" file

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.h         | 2 +-
 sound/soc/codecs/aw88395/aw88395.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 4f3dbf438510..bd0841fa9b77 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -370,7 +370,7 @@
 #define AW88261_START_RETRIES		(5)
 #define AW88261_START_WORK_DELAY_MS	(0)
 
-#define AW88261_I2C_NAME		"aw88261_smartpa"
+#define AW88261_I2C_NAME		"aw88261"
 
 #define AW88261_RATES (SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_96000)
diff --git a/sound/soc/codecs/aw88395/aw88395.h b/sound/soc/codecs/aw88395/aw88395.h
index 8036ba27f68d..c2a4f0cb8cd5 100644
--- a/sound/soc/codecs/aw88395/aw88395.h
+++ b/sound/soc/codecs/aw88395/aw88395.h
@@ -16,7 +16,7 @@
 
 #define AW88395_DSP_16_DATA_MASK		(0x0000ffff)
 
-#define AW88395_I2C_NAME			"aw88395_smartpa"
+#define AW88395_I2C_NAME			"aw88395"
 
 #define AW88395_RATES (SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_96000)
-- 
2.41.0

