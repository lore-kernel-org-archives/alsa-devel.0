Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46267C001DE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 12:07:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D302D152F;
	Tue, 25 Jul 2023 14:06:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D302D152F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690286823;
	bh=J+tBGuQ0eU9onlKlCOCPlRcHCX8QbZAC8Axq0IXaty4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JfMZ7GFHo5ka56L8pGue8d21KBoyywOwvBhiJ58rOJlSA4QA7wxzFlOjKiswAK3Zt
	 ozzYjgKL8MJd45aLU4URJ3tKlSU7T/V6B3Tpd7QleEDYnJVizJawYqmQwWY+2QhLUM
	 IdHUlJ65LQHKc0ZPBbMPTOwQwbP+GZnTCHYd/5To=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9B02F800C7; Tue, 25 Jul 2023 14:05:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A9EDF802E8;
	Tue, 25 Jul 2023 14:05:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 380DEF8019B; Tue, 25 Jul 2023 14:05:42 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B71EF800C7;
	Tue, 25 Jul 2023 14:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B71EF800C7
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9Fxq4LlczCrJq;
	Tue, 25 Jul 2023 20:01:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 20:05:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 20:05:13 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <sound-open-firmware@alsa-project.org>, <alsa-devel@alsa-project.org>
CC: <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
	<peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <daniel.baluta@nxp.com>,
	<kai.vehmanen@linux.intel.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] ASoC: SOF: ipc3-dtrace: Switch to memdup_user_nul()
 helper
Date: Tue, 25 Jul 2023 20:02:47 +0800
Message-ID: <20230725120247.509422-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Message-ID-Hash: X34NAB3B33GNN5FMO6BMIEFGIA6ZRPR2
X-Message-ID-Hash: X34NAB3B33GNN5FMO6BMIEFGIA6ZRPR2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X34NAB3B33GNN5FMO6BMIEFGIA6ZRPR2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use memdup_user_nul() helper instead of open-coding to
simplify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/sof/ipc3-dtrace.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index 35da85a45a9a..bd07f0472efd 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -196,15 +196,9 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 		return -EINVAL;
 	}
 
-	string = kmalloc(count + 1, GFP_KERNEL);
-	if (!string)
-		return -ENOMEM;
-
-	if (copy_from_user(string, from, count)) {
-		ret = -EFAULT;
-		goto error;
-	}
-	string[count] = '\0';
+	string = memdup_user_nul(from, count);
+	if (IS_ERR(string))
+		return PTR_ERR(string);
 
 	ret = trace_filter_parse(sdev, string, &num_elems, &elems);
 	if (ret < 0)
-- 
2.25.1

