Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF66C33C99
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FD524672
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lp9GreUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FD524672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAC01185C;
	Sun,  5 Jan 2020 16:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAC01185C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578238309;
	bh=z73+Ial2hzon5B0BnYZ+9YP62cWRSgyNuaTRHS6lvwc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lp9GreUD/pSoxGAvf0p4RjHI/DT8pCNT7n1UpadsN4+cFaLAgXbc4W1v8/2+vIZxi
	 ZFuX8olSwfsVpfuniPWxlzBHmOag0ULItdrTFQpgfDzGJbXP1tpjGHsvMJu95y8ub+
	 pJOe1rOqFjmbR6uNpYvpkxjYrCoz8aw4HHc8OuZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 058C5F805E3;
	Sun,  5 Jan 2020 15:50:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E170DF803F4; Sun,  5 Jan 2020 15:50:03 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F408F802F9
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F408F802F9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1E321B2D2
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:35 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:48:23 +0100
Message-Id: <20200105144823.29547-69-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 68/68] ALSA: sh: Fix compile warning wrt const
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

A long-standing compile warning was seen during build test:
  sound/sh/aica.c: In function 'load_aica_firmware':
  sound/sh/aica.c:521:25: warning: passing argument 2 of 'spu_memload' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/aica.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index f3cd12ff09c3..8fa68432d3c1 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -101,10 +101,10 @@ static void spu_memset(u32 toi, u32 what, int length)
 }
 
 /* spu_memload - write to SPU address space */
-static void spu_memload(u32 toi, void *from, int length)
+static void spu_memload(u32 toi, const void *from, int length)
 {
 	unsigned long flags;
-	u32 *froml = from;
+	const u32 *froml = from;
 	u32 __iomem *to = (u32 __iomem *) (SPU_MEMORY_BASE + toi);
 	int i;
 	u32 val;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
