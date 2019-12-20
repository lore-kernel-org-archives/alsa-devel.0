Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A2C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5084F21655
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j2WzDsQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5084F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A99F884F;
	Fri, 20 Dec 2019 16:37:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A99F884F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856289;
	bh=iCvVAZBg1PvRHRB2qtW8miuWCtRcxC2b845+UP2NuYw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j2WzDsQTjMY/u+DSspTZsOMw22pG6BinWfen0bDcoS1uUk2/7Fg1fygH8OFdlVmBN
	 iEaorBYnHmkymiCI07PgfT2mb+BE3WL7SQxKwCHz9kPb7paSoJPJFZgS0ug96l/B9S
	 jKR7AeUnCEs2HDgLLgJ22kaEjO/SrhSGTC6elsVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CACB6F80279;
	Fri, 20 Dec 2019 16:34:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07EA4F8026F; Fri, 20 Dec 2019 16:34:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4C75F80266
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:34:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4C75F80266
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E6E9CAF94
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:34:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:34:15 +0100
Message-Id: <20191220153415.2740-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191220153415.2740-1-tiwai@suse.de>
References: <20191220153415.2740-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5/5] ALSA: uapi: Drop asound.h inclusion from
	asoc.h
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The asound.h isn't always available while asoc.h itself is distributed
in alsa-lib package.  So we need to avoid the unnecessary inclusion of
asound.h from there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asoc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index a74ca232f1fc..6048553c119d 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -17,7 +17,6 @@
 #define __LINUX_UAPI_SND_ASOC_H
 
 #include <linux/types.h>
-#include <sound/asound.h>
 
 /*
  * Maximum number of channels topology kcontrol can represent.
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
