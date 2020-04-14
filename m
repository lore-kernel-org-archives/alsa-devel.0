Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F677C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:47:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52E42074D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZcTiSDhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52E42074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A3EC169F;
	Tue, 14 Apr 2020 09:47:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A3EC169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586850477;
	bh=A11Wv9VssJuVLpNEHJy5X67K8GiJPaig3G5xzTwhDz4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZcTiSDhIcHCeAY4BrXLH+ZKz1z5WVjWGvSWpo5WMjYZepneatrGo/ZlSnqxK7fNE7
	 gvx5M7cc6cv7l85tx3MatnaeAwT/7C49XNZ0DEGNm1mQ2QkkHPlK18Jnda0pvnhWJS
	 aTweQUZ38hcHl463iM+vsm3WbYPp6rUBOykUYyFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52125F802C3;
	Tue, 14 Apr 2020 09:42:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE79CF8013D; Tue, 14 Apr 2020 08:21:29 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77627F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 08:21:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77627F800B9
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2E0436A96C7C1ED8F159;
 Tue, 14 Apr 2020 14:21:12 +0800 (CST)
Received: from fedora-aep.huawei.cmm (10.175.113.49) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 14:21:03 +0800
From: yangerkun <yangerkun@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [RFC v2] ALSA: control: fix a error handling exist in snd_ctl_elem_add
Date: Tue, 14 Apr 2020 14:51:09 +0800
Message-ID: <20200414065109.6923-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 14 Apr 2020 09:41:46 +0200
Cc: alsa-devel@alsa-project.org, yangerkun@huawei.com
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

CVE-2020-11725 report that 'count = info->owner' may result a
SIZE_OVERFLOW. 'info->owner' represent a pid, and actually, we should
use info->count.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v1->v2: reword the patch head

diff --git a/sound/core/control.c b/sound/core/control.c
index aa0c0cf182af..c77ca7f39637 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1431,7 +1431,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		return -ENOMEM;
 
 	/* Check the number of elements for this userspace control. */
-	count = info->owner;
+	count = info->count;
 	if (count == 0)
 		count = 1;
 
-- 
2.21.1

