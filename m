Return-Path: <SRS0=JTXi=ZJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE4C432C0
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Nov 2019 08:56:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECC320729
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Nov 2019 08:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t+KXOVm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECC320729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED94F1691;
	Sun, 17 Nov 2019 09:55:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED94F1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573981004;
	bh=7UzljhI8/kZg/k4EJWB/ukFgcQHLW2t7nPYH+oCMeuY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+KXOVm+/Thz2HES5feqm0tRM1Z7Z/xn5Dqgiy9HkLs1hakhEqQtENkiU4QThy01A
	 O15JS0D/zd/UBUo/gN/eMFUTDhStJF3QQW7Un1+D6H8cz4+Hdkqb11mTSab4IhBQzj
	 1NtlEug2S2/xh5O+MNf5Vec7S6j/oMZRCPtieEGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55E85F80147;
	Sun, 17 Nov 2019 09:53:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E5C0F8013F; Sun, 17 Nov 2019 09:53:28 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A481FF80139
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2019 09:53:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A481FF80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 113FCB22E
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2019 08:53:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun, 17 Nov 2019 09:53:05 +0100
Message-Id: <20191117085308.23915-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191117085308.23915-1-tiwai@suse.de>
References: <20191117085308.23915-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5/8] ALSA: pcm: Move PCM_RUNTIME_CHECK() macro
	into local header
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

It should be used only in the PCM core code locally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h    | 2 --
 sound/core/pcm_local.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 253d15c61ce2..25563317782c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1336,8 +1336,6 @@ static inline void snd_pcm_limit_isa_dma_size(int dma, size_t *max)
 					 (IEC958_AES1_CON_PCM_CODER<<8)|\
 					 (IEC958_AES3_CON_FS_48000<<24))
 
-#define PCM_RUNTIME_CHECK(sub) snd_BUG_ON(!(sub) || !(sub)->runtime)
-
 const char *snd_pcm_format_name(snd_pcm_format_t format);
 
 /**
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index 5565e1c4196a..384efd002984 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -72,4 +72,6 @@ struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream,
 				    unsigned long offset);
 #endif
 
+#define PCM_RUNTIME_CHECK(sub) snd_BUG_ON(!(sub) || !(sub)->runtime)
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
