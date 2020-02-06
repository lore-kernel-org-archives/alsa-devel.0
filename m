Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0667AC33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:42:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A7020838
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UQ7Nnz+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A7020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B74B316CB;
	Thu,  6 Feb 2020 17:41:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B74B316CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581007349;
	bh=/taFXuM7BZ64nZyzNFbuQpm9099HvLI1cEsnwCY1Tls=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQ7Nnz+dR2EMJ/+/CXUkdz2h6nX5/ItKz716bLcyD2uEG63NYug003SmOS1wLD502
	 7oxJoDUbnElpgAlktX6zXqVglHdJfqPg52IkB51qR5slyKcxC7Hnt+2zJGhzXIrj+H
	 yI4rJVcYLeJf5w8EdI5asR0pm8/xSPaZqzm7CFaw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15816F8027D;
	Thu,  6 Feb 2020 17:40:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1160CF80278; Thu,  6 Feb 2020 17:39:56 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3C05F801DB
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3C05F801DB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 254C3AFAA
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 16:39:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:39:41 +0100
Message-Id: <20200206163945.6797-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200206163945.6797-1-tiwai@suse.de>
References: <20200206163945.6797-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 4/8] ALSA: dummy: Use standard macros for
	fixing PCM format cast
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

Simplify the code with the new macros for PCM format type iterations.
This fixes the sparse warnings nicely:
  sound/drivers/dummy.c:906:25: warning: restricted snd_pcm_format_t degrades to integer
  sound/drivers/dummy.c:908:25: warning: incorrect type in argument 1 (different base types)
  sound/drivers/dummy.c:908:25:    expected restricted snd_pcm_format_t [usertype] format
  sound/drivers/dummy.c:908:25:    got int [assigned] i

No functional changes, just sparse warning fixes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 02ac3f4e0c02..b5486de08b97 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -901,10 +901,10 @@ static int snd_card_dummy_new_mixer(struct snd_dummy *dummy)
 static void print_formats(struct snd_dummy *dummy,
 			  struct snd_info_buffer *buffer)
 {
-	int i;
+	snd_pcm_format_t i;
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		if (dummy->pcm_hw.formats & (1ULL << i))
+	pcm_for_each_format(i) {
+		if (dummy->pcm_hw.formats & pcm_format_to_bits(i))
 			snd_iprintf(buffer, " %s", snd_pcm_format_name(i));
 	}
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
