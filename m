Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D8C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:07:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9DB2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sMGPWBQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9DB2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E562A1692;
	Tue, 10 Dec 2019 15:06:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E562A1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986819;
	bh=u2rWEap912StKJwskpWLgeVL0oBt5L6mjVkQB2NDm98=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sMGPWBQt0BIIl4GZnOgppPNR5xNvqNlZ6kh4pjAVQJc5yTYlygPGcw5hEMgri9jqy
	 D23oPXS54wc5UwNSQJWBmH1jrJjAvU7ex6V5T4ZzBt6aamfqHfI1+OPbzpGu6s1UYc
	 sGJtsrQZqEzRDgzJTAoU2d3YzdQWiKQOBfeClhM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3735AF802D2;
	Tue, 10 Dec 2019 14:59:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE284F80252; Tue, 10 Dec 2019 14:59:19 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2E5AF80254
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2E5AF80254
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 29DE6B174;
 Tue, 10 Dec 2019 13:59:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:47 +0100
Message-Id: <20191210135849.15607-13-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [alsa-devel] [PATCH for-5.6 12/14] media: cx18: Drop superfluous
	ioctl PCM ops
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

snd_cx18_pcm_ioctl() does nothing but calling the default handler.
Now PCM core accepts NULL as the default ioctl ops, so let's drop
altogether.

Cc: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/cx18/cx18-alsa-pcm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-alsa-pcm.c b/drivers/media/pci/cx18/cx18-alsa-pcm.c
index 7dec5ce20eb7..bed28b4b41f7 100644
--- a/drivers/media/pci/cx18/cx18-alsa-pcm.c
+++ b/drivers/media/pci/cx18/cx18-alsa-pcm.c
@@ -200,18 +200,6 @@ static int snd_cx18_pcm_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_cx18_pcm_ioctl(struct snd_pcm_substream *substream,
-		     unsigned int cmd, void *arg)
-{
-	struct snd_cx18_card *cxsc = snd_pcm_substream_chip(substream);
-	int ret;
-
-	snd_cx18_lock(cxsc);
-	ret = snd_pcm_lib_ioctl(substream, cmd, arg);
-	snd_cx18_unlock(cxsc);
-	return ret;
-}
-
 static int snd_cx18_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_cx18_card *cxsc = snd_pcm_substream_chip(substream);
@@ -244,7 +232,6 @@ snd_pcm_uframes_t snd_cx18_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_cx18_pcm_capture_ops = {
 	.open		= snd_cx18_pcm_capture_open,
 	.close		= snd_cx18_pcm_capture_close,
-	.ioctl		= snd_cx18_pcm_ioctl,
 	.prepare	= snd_cx18_pcm_prepare,
 	.trigger	= snd_cx18_pcm_trigger,
 	.pointer	= snd_cx18_pcm_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
