Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D30C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 08:47:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3812332A
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3812332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C69CC16E3;
	Wed,  9 Dec 2020 09:46:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C69CC16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607503667;
	bh=I141ZwciZDfAqrlDTIgYV4yoPau8+Amw29x2wWVmbG8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbruCBydpQd/y4a+uNnhIxFhUtuZ6m5G+t6zUZ39dsnUb7/XEMJjp+wbrY5LrwK+4
	 rKeBQYXxyCNTGleGvkuTrauS5/ns10M8xY7A996FdAUyJrzcr3BK8MLYR8lndyxauj
	 4zfc0LGqLqyNbPCzzUAjmzW0yG0hw3nc/zES7PRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F38C6F8021D;
	Wed,  9 Dec 2020 09:46:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B697F8021D; Wed,  9 Dec 2020 09:46:06 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A107F8020D
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 09:45:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A107F8020D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 36109AE3A
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 08:45:56 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: pcm: oss: Fix potential out-of-bounds shift
Date: Wed,  9 Dec 2020 09:45:52 +0100
Message-Id: <20201209084552.17109-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201209084552.17109-1-tiwai@suse.de>
References: <20201209084552.17109-1-tiwai@suse.de>
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

syzbot spotted a potential out-of-bounds shift in the PCM OSS layer
where it calculates the buffer size with the arbitrary shift value
given via an ioctl.

Add a range check for avoiding the undefined behavior.
As the value can be treated by a signed integer, the max shift should
be 30.

Reported-by: syzbot+df7dc146ebdd6435eea3@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 327ec42a36b0..de1917484647 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1935,11 +1935,15 @@ static int snd_pcm_oss_set_subdivide(struct snd_pcm_oss_file *pcm_oss_file, int
 static int snd_pcm_oss_set_fragment1(struct snd_pcm_substream *substream, unsigned int val)
 {
 	struct snd_pcm_runtime *runtime;
+	int fragshift;
 
 	runtime = substream->runtime;
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
-	runtime->oss.fragshift = val & 0xffff;
+	fragshift = val & 0xffff;
+	if (fragshift >= 31)
+		return -EINVAL;
+	runtime->oss.fragshift = fragshift;
 	runtime->oss.maxfrags = (val >> 16) & 0xffff;
 	if (runtime->oss.fragshift < 4)		/* < 16 */
 		runtime->oss.fragshift = 4;
-- 
2.26.2

