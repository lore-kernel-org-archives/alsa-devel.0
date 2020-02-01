Return-Path: <SRS0=KyRj=3V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F4C35246
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Feb 2020 08:06:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5745220679
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Feb 2020 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Caw9lCeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5745220679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 996CB167E;
	Sat,  1 Feb 2020 09:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 996CB167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580544388;
	bh=wX/DGmzAuuOkUu+3EoFmKTHNt7WapDSqVyTq7HpD3ME=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Caw9lCeK77a128DMFNjY3OijX1TrO7c2aHU5bj3phPSxoQu/xDFvzxDvuH8uzhbHQ
	 Xb8XHqyDN29MzIWUPQaJZqj8Bg8QkG4RF2W4K+ENY/R3GUXdD91kXeFnWBfoTeULzK
	 ASTYrvqwJp/Dv8+8M/WYr98AvqqC+EtkVZ0twV44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D9BBF80082;
	Sat,  1 Feb 2020 09:05:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A2B8F801F8; Sat,  1 Feb 2020 09:05:36 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB11DF80082
 for <alsa-devel@alsa-project.org>; Sat,  1 Feb 2020 09:05:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB11DF80082
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 44BC0AE2A
 for <alsa-devel@alsa-project.org>; Sat,  1 Feb 2020 08:05:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sat,  1 Feb 2020 09:05:30 +0100
Message-Id: <20200201080530.22390-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200201080530.22390-1-tiwai@suse.de>
References: <20200201080530.22390-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 3/3] ALSA: dummy: Fix PCM format loop in proc
	output
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

The loop termination for iterating over all formats should contain
SNDRV_PCM_FORMAT_LAST, not less than it.

Fixes: 9b151fec139d ("ALSA: dummy - Add debug proc file")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index da0bd8960b3c..02ac3f4e0c02 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -903,7 +903,7 @@ static void print_formats(struct snd_dummy *dummy,
 {
 	int i;
 
-	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (dummy->pcm_hw.formats & (1ULL << i))
 			snd_iprintf(buffer, " %s", snd_pcm_format_name(i));
 	}
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
