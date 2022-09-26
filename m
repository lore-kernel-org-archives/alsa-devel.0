Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE7C07E9D
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 07:45:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6F7A1F4;
	Mon, 26 Sep 2022 09:44:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6F7A1F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664178318;
	bh=4l6+qdG48IxJe8wGnENlXr8yk1x2lc/wErPKayOZuhc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n2Dd6mtBRsYrKJ2bmMm46QoYDBWSqaJxU+i+5XsxwDdBcDPpjooy4FZ/H4R4TnR3l
	 bcfxAxSVSzBtw2ZRmdv9JWCy+hnskeWIj+WxV9rNluY+BugVWqsz+hsfTUWn9VNvFF
	 PM3kV0CV/T+vSh+qqEZyWdwkBbuA85kmSq4IbtHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76434F80254;
	Mon, 26 Sep 2022 09:44:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D228F8027D; Mon, 26 Sep 2022 09:44:25 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48330F8011C
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 09:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48330F8011C
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbZQW4DfgzHtqV;
 Mon, 26 Sep 2022 15:39:31 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:44:17 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 15:44:17 +0800
From: Ren Zhijie <renzhijie2@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <ckeepax@opensource.cirrus.com>,
 <krzysztof.kozlowski@linaro.org>, <tanureal@opensource.cirrus.com>,
 <james.schulman@cirrus.com>, <cy_huang@richtek.com>, <flatmax@flatmax.com>,
 <pierre-louis.bossart@linux.intel.com>, <lukas.bulwahn@gmail.com>,
 <srinivas.kandagatla@linaro.org>
Subject: [PATCH -next] ASoC: codecs: wcd934x: Fix Kconfig dependency
Date: Mon, 26 Sep 2022 07:40:42 +0000
Message-ID: <20220926074042.13297-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, Ren Zhijie <renzhijie2@huawei.com>,
 linux-kernel@vger.kernel.org
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

If CONFIG_REGMAP_SLIMBUS is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
will be failed, like this:

sound/soc/codecs/wcd934x.o: In function `wcd934x_codec_probe':
wcd934x.c:(.text+0x3310): undefined reference to `__regmap_init_slimbus'
make: *** [vmlinux] Error 1

Add select REGMAP_SLIMBUS to config SND_SOC_WCD934X.

Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 444cee829a26..e3b90c425faf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1757,6 +1757,7 @@ config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
 	depends on COMMON_CLK
 	depends on SLIMBUS
+	select REGMAP_SLIMBUS
 	select SND_SOC_WCD_MBHC
 	depends on MFD_WCD934X || COMPILE_TEST
 	help
-- 
2.17.1

