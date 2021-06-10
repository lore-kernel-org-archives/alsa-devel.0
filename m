Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8EAC47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 11:10:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BAF6128A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 11:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BAF6128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D7FE1776;
	Thu, 10 Jun 2021 13:09:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D7FE1776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623323440;
	bh=clMpL0heM+DMkrmuFlffgpobuL8mNq0URhAGXbSmF90=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gJ6zyinCwBzQcaFveQ4/ZzkU3X9i0GufeLhsNFFIqrQzkhoo54AZDCfpl5JiYycqB
	 FaBQTsYsmoPxcZWZPBu/IEW7D463Y/Du1etaILZ+BjWngx+MpEJG0zGB1ZuMfLid5G
	 SS93rFXzZueq0hVO9LyhicMrGSqdthUF5JTKP9hw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32305F800FC;
	Thu, 10 Jun 2021 13:09:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA9DCF80218; Thu, 10 Jun 2021 13:09:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F78CF800FC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 13:09:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F78CF800FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="l9Hvs3C/"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="eKCZdYcY"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EBEB31FD37
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623323375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HN0Z8IZNOc1T0Shw8cWFPYGgTN2klet4Y8k2o6zj92w=;
 b=l9Hvs3C/ERzPD6QJ3+zhc9prBHM+OfRfSRG6dfZJmg8PAVO0I2ZXnvVR4Y/uI1Ji9rDJuM
 IyeRH46nsEVKMku32nIYmKJwnyRcNxlVG3GffzIK/mNSHYB3vstTlidREwEPp48grSMZXR
 rkNO6+1+8Ocogqsag9gedkGN2hPtREY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623323375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HN0Z8IZNOc1T0Shw8cWFPYGgTN2klet4Y8k2o6zj92w=;
 b=eKCZdYcYZb4NGRwqePHmAWU2eid5vqD4pI3m4Q3VHGPrmxfGdDjRfxhCVHUVmv5X8DPpTO
 yCGM6IDBBU9xpGDg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id DB604A3B8B;
 Thu, 10 Jun 2021 11:09:35 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: core: Fix build error due to missing PAGE_SIZE
Date: Thu, 10 Jun 2021 13:09:35 +0200
Message-Id: <20210610110935.10393-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The recent refactoring of memalloc stuff removed the inclusion of
asm/page.h for simplicity, but it turned out this caused a compile
error due the lack of PAGE_SIZE definition on some architectures.
Do a partial revert for recovering from that.

Fixes: 37af81c5998f ("ALSA: core: Abstract memory alloc helpers")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202106101858.PfXMMuAa-lkp@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 1918c60f1f35..44d87775b352 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -9,8 +9,9 @@
 #ifndef __SOUND_MEMALLOC_H
 #define __SOUND_MEMALLOC_H
 
+#include <asm/page.h>
+
 struct device;
-struct page;
 struct vm_area_struct;
 
 /*
-- 
2.26.2

