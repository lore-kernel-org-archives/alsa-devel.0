Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C32C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Apr 2022 02:10:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89312169E;
	Mon, 11 Apr 2022 04:09:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89312169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649643018;
	bh=ln+MPM5vCcXW/wrOLqKOoOd2rhjXeqqVEQ0tbIqHnhg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aseqCrNDydFKSSMDOjRvtgSvkpFeut5FaJ/3/zQNa5H69Ukri7bAfGQVUU4ME+j2u
	 mlCMKq/xlCgARG9mspHgWMM1wQ5ZQRY1gDzR+YFYyOm++KcyfMj/0Vld61hzdhcqVQ
	 BdH3vWeVJY9qY+qDiK61gUhGcJqjH6fGqTiDFnhQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00026F80249;
	Mon, 11 Apr 2022 04:09:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6785DF80279; Mon, 11 Apr 2022 04:09:25 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAE5FF8011C
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2022 04:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAE5FF8011C
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcC2H6qNyz1HBJm;
 Mon, 11 Apr 2022 10:08:39 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 10:09:12 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
 <spujar@nvidia.com>, <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tegra186_asrc: mark runtime-pm functions as
 __maybe_unused
Date: Mon, 11 Apr 2022 10:09:08 +0800
Message-ID: <20220411020908.580-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
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

sound/soc/tegra/tegra186_asrc.c:90:12: error: ‘tegra186_asrc_runtime_resume’ defined but not used [-Werror=unused-function]
 static int tegra186_asrc_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/tegra/tegra186_asrc.c:80:12: error: ‘tegra186_asrc_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int tegra186_asrc_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark these functions as __maybe_unused to avoid this kind of warning.

Fixes: a2df8c2d5b36 ("ASoC: tegra: Add Tegra186 based ASRC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/tegra/tegra186_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra186_asrc.c b/sound/soc/tegra/tegra186_asrc.c
index 3c1e20cbb319..9f12faaa609d 100644
--- a/sound/soc/tegra/tegra186_asrc.c
+++ b/sound/soc/tegra/tegra186_asrc.c
@@ -77,7 +77,7 @@ static void tegra186_asrc_lock_stream(struct tegra186_asrc *asrc,
 		     1);
 }
 
-static int tegra186_asrc_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra186_asrc_runtime_suspend(struct device *dev)
 {
 	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
 
@@ -87,7 +87,7 @@ static int tegra186_asrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra186_asrc_runtime_resume(struct device *dev)
+static int __maybe_unused tegra186_asrc_runtime_resume(struct device *dev)
 {
 	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
 	int id;
-- 
2.17.1

