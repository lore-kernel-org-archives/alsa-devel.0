Return-Path: <SRS0=QuHl=MW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D762C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 09:04:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1AF61008
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 09:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D1AF61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C4E7183B;
	Fri, 30 Jul 2021 11:03:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C4E7183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627635846;
	bh=CUtfXi60lJCmO6YC3kSYUWEyykXCiUxQ5Ay0gCwdDiU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MYGRmrx2Oju9Ahk1Hy+NxmTsD8RqmHuqYFCUX4FtPu2fRg6NAT4iiiugNYxpyI8in
	 R9DBmA34lQYUQbMaOUdaasDotKeoFLwr9peNNC17plk3hs8FR/Gfk+fjWFE3ZOPytZ
	 hx5ZFNCRb9rn6Vb6oJH69+miTxqPLJrpazpDggiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D329AF80212;
	Fri, 30 Jul 2021 11:03:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D870F80253; Fri, 30 Jul 2021 11:03:14 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34755F8019B
 for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2021 11:03:06 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1088CA003F;
 Fri, 30 Jul 2021 11:03:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1088CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1627635785; bh=esDYRbz6AalQmhVyKPdaKQ9dA13PxErSDR/m1A34si4=;
 h=From:To:Cc:Subject:Date:From;
 b=mz/iHq08wy95u48V76l+wfaHKNNSArXTzG7wJLw5dBUY8qeHOhp+NbN2IdufWHeR8
 I0AsKi+DC4IiZJfDxshMX+00y38/jWwaSsfVVKCFOr9v/9sOI76VkbiJEiv1TsGS75
 Ll2xSAjqJOOmM2bHb/zBavL6scknnh33BDKRDdcM=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 30 Jul 2021 11:03:00 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: pcm - fix mmap capability check for the snd-dummy driver
Date: Fri, 30 Jul 2021 11:02:54 +0200
Message-Id: <20210730090254.612478-1-perex@perex.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org
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

The snd-dummy driver (fake_buffer configuration) uses the ops->page
callback for the mmap operations. Allow mmap for this case, too.

Cc: <stable@vger.kernel.org>
Fixes: c4824ae7db41 ("ALSA: pcm: Fix mmap capability check")
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 6a2971a7e6a1..09c0e2a6489c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -246,7 +246,7 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
 
-	if (substream->ops->mmap)
+	if (substream->ops->mmap || substream->ops->page)
 		return true;
 
 	switch (substream->dma_buffer.dev.type) {
-- 
2.31.1
