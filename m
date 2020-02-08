Return-Path: <SRS0=oFba=34=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA8EC35242
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9A9227BF
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q7f5QuVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9A9227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 659A3169C;
	Sat,  8 Feb 2020 23:34:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 659A3169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581201344;
	bh=mn8kuripCl10teeJ8FgfcTl6bRQ8ypB2JVyJH9O4luM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q7f5QuVRYNK5Vv7hbKWY1vKRYLHZFCZSB3hCiWauohoL3pTNkum6zYUzhiJdflNTP
	 Z+AtvynA2/LZWqozo3ruec2IYKHvacJewoLmrrNuCcH5DLJR4nRr69UnWmYJ6H2LQ5
	 EHUKgm5RC0jRZ11N4FG7L2Fz+jKDLlRCdeN4+nm4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96D5AF8015B;
	Sat,  8 Feb 2020 23:34:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4401EF80162; Sat,  8 Feb 2020 23:34:51 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6ED9BF8012F
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2020 23:34:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6ED9BF8012F
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1j0YgV-0001jM-Q3; Sat, 08 Feb 2020 22:34:43 +0000
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Date: Sat,  8 Feb 2020 22:34:43 +0000
Message-Id: <20200208223443.38047-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: ali5451: remove redundant variable
	capture_flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Colin Ian King <colin.king@canonical.com>

Variable capture_flag is only ever assigned values, it is never read
and hence it is redundant. Remove it.

Addresses-Coverity ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ali5451/ali5451.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 4f524a9dbbca..4462375d2d82 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1070,7 +1070,7 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 {
 	struct snd_ali *codec = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
-	unsigned int what, whati, capture_flag;
+	unsigned int what, whati;
 	struct snd_ali_voice *pvoice, *evoice;
 	unsigned int val;
 	int do_start;
@@ -1088,7 +1088,7 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	what = whati = capture_flag = 0;
+	what = whati = 0;
 	snd_pcm_group_for_each_entry(s, substream) {
 		if ((struct snd_ali *) snd_pcm_substream_chip(s) == codec) {
 			pvoice = s->runtime->private_data;
@@ -1110,8 +1110,6 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 					evoice->running = 0;
 			}
 			snd_pcm_trigger_done(s, substream);
-			if (pvoice->mode)
-				capture_flag = 1;
 		}
 	}
 	spin_lock(&codec->reg_lock);
-- 
2.25.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
