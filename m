Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D38C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:39:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B412222C2
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p7K6rkXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B412222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BB5915F8;
	Fri, 20 Dec 2019 16:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BB5915F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856394;
	bh=TnQvjeknN631V5Cxp4X/QhuyISMmZIzF/khQnD472kg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p7K6rkXau4kt6QoyMryaSl4nkx0Rgh3Yv2a1ui7JeGZXRDsASMLop3iQNNtMElSdv
	 L/T9HV3OJp9VLRVWuCy+j7iZDfP7ATW7O2frIbhca7YH+LaYF8NQmwRWFjdP8YI0ft
	 fm7H1DJfIdoKIyQq8e+wcwZcmtFl94zTsjwPYJd8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D4FF8014F;
	Fri, 20 Dec 2019 16:39:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BE79F8022C; Fri, 20 Dec 2019 16:39:02 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51B79F80059
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:38:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51B79F80059
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E0C12AE35
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:38:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:38:57 +0100
Message-Id: <20191220153857.3331-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191220153857.3331-1-tiwai@suse.de>
References: <20191220153857.3331-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH alsa-lib 2/2] type_compat: Add missing __s64
	and __u64 definitions for non-Linux
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

Just for the case without Linux-compatible definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/type_compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/type_compat.h b/include/sound/type_compat.h
index d4790c1f0e64..5b765f447e2e 100644
--- a/include/sound/type_compat.h
+++ b/include/sound/type_compat.h
@@ -9,9 +9,11 @@
 typedef uint8_t __u8;
 typedef uint16_t __u16;
 typedef uint32_t __u32;
+typedef uint64_t __u64;
 typedef int8_t __s8;
 typedef int16_t __s16;
 typedef int32_t __s32;
+typedef int64_t __s64;
 
 #include <endian.h>
 #include <byteswap.h>
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
