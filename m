Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE19C001DE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 12:13:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C8E11530;
	Tue, 25 Jul 2023 14:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C8E11530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690287188;
	bh=1lY0T9Ti82+JLzLCZik0VXvRAKpjLy/FHwieH+M9KD8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Se8q/awK88j58NaClsrZZ74Uvw9F0YcGd82216DoMsoqAdAcyB5ZIxceetkf7vyyt
	 T9eIys/NDapGicb5yPhn6/QtgyvDCbPNS/bJsJBgvjJWxwH/oQ1zJUgGBRbxqYyAfe
	 okzGMv50/iy+3x8e07gKp9hlHcsYk1t1wDn5NRR4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 230CDF8053B; Tue, 25 Jul 2023 14:11:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A59B2F802E8;
	Tue, 25 Jul 2023 14:11:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02A02F8019B; Tue, 25 Jul 2023 14:11:51 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E262FF80149
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 14:11:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E262FF80149
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9G5K2kqGzCrJT;
	Tue, 25 Jul 2023 20:08:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 20:11:43 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 20:11:43 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
CC: <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
	<rf@opensource.cirrus.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next] ASoC: cs42l51: change cs42l51_of_match to static
Date: Tue, 25 Jul 2023 20:09:17 +0800
Message-ID: <20230725120917.513064-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Message-ID-Hash: WHP2DGG4WJQQP6MJNES7X2COHA42RG6E
X-Message-ID-Hash: WHP2DGG4WJQQP6MJNES7X2COHA42RG6E
X-MailFrom: yangyingliang@huawei.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WHP2DGG4WJQQP6MJNES7X2COHA42RG6E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

cs42l51_of_match is only used in cs42l51-i2c.c now,
change it to static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/codecs/cs42l51-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index e7db7bcd0296..5ed2ef83dcdb 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -19,7 +19,7 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
-const struct of_device_id cs42l51_of_match[] = {
+static const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
 };
-- 
2.25.1

