Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442CC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:37:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A9C21655
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D7ZFpq5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A9C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 581EA1654;
	Fri, 20 Dec 2019 16:36:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 581EA1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856258;
	bh=9ptimXZcW+YASG/QNyRfDD6jkdmEg+M7e5igCDpZBto=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7ZFpq5fpHSwLixi9ez7pFOWL3UPmnHcoPbZDNZKG57zCNNx5gvjEBLgZj+hudxiK
	 7tUF05HDCFAKIywT5+hh4BtkwdhINlxkn5IHU//bf/o5vpxzmH9SV2DkkFyTL0QSaQ
	 ITvery7khHQ2udsHEGpkKtBx0y/UKCeKhuCNobHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EC7DF80273;
	Fri, 20 Dec 2019 16:34:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBB6EF8026A; Fri, 20 Dec 2019 16:34:30 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4823F80257
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:34:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4823F80257
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6F9B1AE37
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:34:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:34:14 +0100
Message-Id: <20191220153415.2740-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191220153415.2740-1-tiwai@suse.de>
References: <20191220153415.2740-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 4/5] ALSA: uapi: Fix typos and header inclusion
	in asound.h
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

The recent changes in uapi/asoundlib.h caused some build errors in
alsa-lib side because of a typo and the new included files.
Basically asound.h is supposed to be usable also on non-Linux systems,
so we've tried to avoid the Linux-specific include files.

This patch is an attempt to recover from those changes.

Fixes: 3ddee7f88aaf ("ALSA: Avoid using timespec for struct snd_pcm_status")
Fixes: 80fe7430c708 ("ALSA: add new 32-bit layout for snd_pcm_mmap_status/control")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index e6a958b8aff1..e7943302359e 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -26,7 +26,9 @@
 
 #if defined(__KERNEL__) || defined(__linux__)
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #else
+#include <endian.h>
 #include <sys/ioctl.h>
 #endif
 
@@ -35,8 +37,6 @@
 #include <time.h>
 #endif
 
-#include <asm/byteorder.h>
-
 /*
  *  protocol version
  */
@@ -471,7 +471,7 @@ enum {
 
 #ifndef __KERNEL__
 /* explicit padding avoids incompatibility between i386 and x86-64 */
-typedef struct { unsigned char pad[sizeof(time_t) - sizeof(int)] __time_pad;
+typedef struct { unsigned char pad[sizeof(time_t) - sizeof(int)]; } __time_pad;
 
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
