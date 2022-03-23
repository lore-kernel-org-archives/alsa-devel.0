Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2124DC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 661D1170D;
	Wed, 23 Mar 2022 10:13:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 661D1170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648026837;
	bh=IU/crHatmngN2x8n8sFszzi8i5dyhqWfy40w/oKZK1Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XXaGP9Zaisoru/vuyGHeze/PY5f30+vlu0Ii9B/p8IC4wCMX62WUO5Zbc6e5ENqob
	 XiFgKlRVy3RhcOSOFQQhwkR/u7aXKrtk0JgBUA+j7NpQ6RPxXbailmdsuqfIfpyq0I
	 OUE6fC1xMbbd4KGc5eBfUnCEi4wQ5zVWQC9wnYwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC368F80310;
	Wed, 23 Mar 2022 10:12:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16A9CF802DB; Wed, 23 Mar 2022 04:43:16 +0100 (CET)
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1427EF800AA
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2022 04:43:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1427EF800AA
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 11:43:02 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 11:43:01 +0800
From: Haowen Bai <baihaowen@meizu.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: Fix duplicate included module.h/io.h
Date: Wed, 23 Mar 2022 11:42:59 +0800
Message-ID: <1648006979-31031-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Mailman-Approved-At: Wed, 23 Mar 2022 10:12:33 +0100
Cc: alsa-devel@alsa-project.org, Haowen Bai <baihaowen@meizu.com>,
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

Clean up the following includecheck warning:

sound/soc/amd/vangogh/acp5x-mach.c: linux/module.h is included more than once.
sound/soc/amd/vangogh/acp5x-mach.c: linux/io.h is included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 14cf325..cc8316b 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -17,10 +17,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/io.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
-- 
2.7.4

