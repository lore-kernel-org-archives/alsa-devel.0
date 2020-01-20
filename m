Return-Path: <SRS0=II5U=3J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C15C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:46:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE70208E4
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sK/mE7Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE70208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DD771674;
	Mon, 20 Jan 2020 13:45:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DD771674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579524383;
	bh=AEJUsS6JbPgQ3dd34SrkwVUwSPaHH4lF5UL6iCFhbKU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sK/mE7DfkwfUHWZZ/YofEjS7LZrySfEr0d7KDaCdJBgc0eX+dM9lJVbcJiJVBgbHR
	 CaWTNVK2bAzpS8JhuCpyu162MSn/Zpf/twCPGWNqpnMLigXmkvkrWR7o/ziDHLKMTy
	 0QlZD96r3QxAxLgqhPNacwSJKkJeG3Mx67RzAoBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42394F8022D;
	Mon, 20 Jan 2020 13:44:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEF91F80249; Mon, 20 Jan 2020 13:44:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10F6AF8013E
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2020 13:44:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10F6AF8013E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1BD2BAF42;
 Mon, 20 Jan 2020 12:44:30 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 20 Jan 2020 13:44:23 +0100
Message-Id: <20200120124423.11862-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200120124423.11862-1-tiwai@suse.de>
References: <20200120124423.11862-1-tiwai@suse.de>
Cc: Keyon Jie <yang.jie@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/2] ALSA: hda: No preallocation on x86
	platforms
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

Like many other drivers, HD-audio drivers also do PCM buffer
preallocation to assure the buffer pages allocated at the early boot
stage.  This step is useful for platforms that may fail to allocate
the PCM hardware buffers -- which is mostly for either large
continuous pages or with the specific DMA mask (like emu10k1).

OTOH, when a buffer is allocated as SG-buffer and the DMA mask is
either 32 or 64 bits, the allocation almost never fails unless it hits
the real OOM situation.  In such a case, we don't need the
preallocation inevitably unlike the cases above.

That said, we may drop the preallocation for HD-audio that does
allocate via SG-buffers, and the patch achieves it.

However, there is one caveat: the buffer allocation behavior depends
on CONFIG_SND_DMA_SGBUF, and it falls back to the continuous pages
when it's not set.  And, currently this SG buffer allocation is
enabled only on x86 platforms.  So, covering those fall-outs, the
patch adjusts CONFIG_SND_HDA_PREALLOC_SIZE depending on the condition,
and keeps the old behavior as-is for non-x86 platforms.

On x86, the kconfig item is no longer adjustable but always set to
zero for disabling the preallocation.  You can still enable the
preallocation via procfs interface at any time later, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index b0c88fe040ee..4ca6b09056f3 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -21,14 +21,16 @@ config SND_HDA_EXT_CORE
        select SND_HDA_CORE
 
 config SND_HDA_PREALLOC_SIZE
-	int "Pre-allocated buffer size for HD-audio driver"
+	int "Pre-allocated buffer size for HD-audio driver" if !SND_DMA_SGBUF
 	range 0 32768
-	default 64
+	default 0 if SND_DMA_SGBUF
+	default 64 if !SND_DMA_SGBUF
 	help
 	  Specifies the default pre-allocated buffer-size in kB for the
 	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
 	  for systems using PulseAudio.  The default 64 is chosen just
 	  for compatibility reasons.
+	  On x86 systems, the default is zero as we need no preallocation.
 
 	  Note that the pre-allocation size can be changed dynamically
 	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
