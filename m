Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E376FC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Nov 2022 06:13:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A6051663;
	Thu, 17 Nov 2022 07:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A6051663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668665633;
	bh=3KqtH/gImUYxAD5iD0P+DgGbnypiQUAhmlGg7g6zLk4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cg8XF0r24rIF/ofEbdoXTmkk8IdD5XJp9RU0j8GFZlGl5bG5juYs1jt7aLuMlV0Ib
	 7O3/CB9Kv/zZt8sH0cxwmEOW0gislK++bs5SjS6okY4pP5FdNawWTREvfUx+chnRSS
	 WFeU1ZxmM2Ajl+O4SGBcNY5phqBSC2GZMpq/Ux/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9F37F800B8;
	Thu, 17 Nov 2022 07:13:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBC61F800B8; Thu, 17 Nov 2022 07:13:01 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B9FFF800B8
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 07:12:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B9FFF800B8
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCV225hjWz15MdB;
 Thu, 17 Nov 2022 14:12:26 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:12:48 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>,
 <venkataprasad.potturu@amd.com>, <Vsujithkumar.Reddy@amd.com>,
 <ckeepax@opensource.cirrus.com>, <nathan@kernel.org>, <error27@gmail.com>,
 <AjitKumar.Pandey@amd.com>, <cuigaosheng1@huawei.com>
Subject: [PATCH] ASoC: amd: acp: Fix possible UAF in acp_dma_open
Date: Thu, 17 Nov 2022 14:12:48 +0800
Message-ID: <20221117061248.3018292-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org
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

Smatch report warning as follows:

sound/soc/amd/acp/acp-platform.c:199 acp_dma_open() warn:
  '&stream->list' not removed from list

If snd_pcm_hw_constraint_integer() fails in acp_dma_open(),
stream will be freed, but stream->list will not be removed from
adata->stream_list, then list traversal may cause UAF.

Fix by removeing it from adata->stream_list before free().

Fixes: 7929985cfe36 ("ASoC: amd: acp: Initialize list to store acp_stream during pcm_open")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 sound/soc/amd/acp/acp-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 85a81add4ef9..275e0428eec4 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -196,6 +196,9 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
 		dev_err(component->dev, "set integer constraint failed\n");
+		spin_lock_irq(&adata->acp_lock);
+		list_del(&stream->list);
+		spin_unlock_irq(&adata->acp_lock);
 		kfree(stream);
 		return ret;
 	}
-- 
2.25.1

