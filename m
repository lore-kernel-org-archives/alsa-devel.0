Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A8C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 06:28:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76CBE15C3;
	Mon, 25 Jul 2022 08:27:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76CBE15C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658730508;
	bh=3/8+Ab0XNi6QKfyElDxG4egDmLpUkNURjxV4cLNde8k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ctn8crzLZXLRZ5NlEFLKLMTK8kU585OK2x6BvTzSN6YeCoyq454bZyl1tYoEwDU/d
	 l0sIoYgbG90BC8G9UhYjuWh3d3g11EH51jEEeKkIU7Pj8AlLGsw1FhPKmyNe9q6r56
	 R+AqS8xMQPXlVmG8P6PPMKV8bniqfAJgSRVXWnDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D800F80563;
	Mon, 25 Jul 2022 08:25:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 759F0F80128; Mon, 25 Jul 2022 04:38:36 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F42DF80128
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 04:38:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F42DF80128
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lrkdf58wgz923g;
 Mon, 25 Jul 2022 10:34:30 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 10:38:17 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 10:38:16 +0800
From: Ren Zhijie <renzhijie2@huawei.com>
To: <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
 <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <sbinding@opensource.cirrus.com>,
 <vitalyr@opensource.cirrus.com>
Subject: [PATCH -next] ALSA: hda: cs35l41: Fix build error unused-function
Date: Mon, 25 Jul 2022 10:36:11 +0800
Message-ID: <20220725023611.57055-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 25 Jul 2022 08:25:50 +0200
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Ren Zhijie <renzhijie2@huawei.com>, linux-kernel@vger.kernel.org,
 arnd@arndb.de
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

If CONFIG_PM_SLEEP is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

sound/pci/hda/cs35l41_hda.c:583:12: error: ‘cs35l41_runtime_resume’ defined but not used [-Werror=unused-function]
 static int cs35l41_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
sound/pci/hda/cs35l41_hda.c:565:12: error: ‘cs35l41_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int cs35l41_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [sound/pci/hda/cs35l41_hda.o] Error 1

commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,
deprecate old ones"), add new marco RUNTIME_PM_OPS to fix this unused-function problem.

Fixes: 1873ebd30cc8 ("ALSA: hda: cs35l41: Support Hibernation during Suspend")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 28798d5c1cf1..93cf039abb02 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1439,7 +1439,7 @@ void cs35l41_hda_remove(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 const struct dev_pm_ops cs35l41_hda_pm_ops = {
-	SET_RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
 
-- 
2.17.1

