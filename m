Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8396C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:46:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335FC21D7D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XJNj4s0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335FC21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 578AA178C;
	Fri,  3 Jan 2020 09:46:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 578AA178C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578041210;
	bh=s3v/DO1zoB/OcCbS+8BpdVu9fveFBKl+V/5COFGs5/k=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XJNj4s0rEZRvHBX7Z6B3NYrg7nqPfGMa82yG38KpQ7cTLsmdPbbgALgVoO1dv2Xqh
	 djHORQTcry5ui5RS0PxbXvV+EsQoAMxkJTI/qZVh5WSfqUbmytR6N5183ccOZzDXBN
	 vz8KGzEmF7lecqPZlVtHh6jhkM8+J77GbLiwUuVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B8CFF804B2;
	Fri,  3 Jan 2020 09:19:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 700F1F80393; Fri,  3 Jan 2020 09:18:41 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 470B7F802BD
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 470B7F802BD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B7052B280
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:21 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:59 +0100
Message-Id: <20200103081714.9560-44-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 43/58] ALSA: dummy: Constify snd_pcm_ops
	definitions
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

The snd_pcm_ops items defined in snd-dummy driver can be gracefully
declared as const.  Let's mark them for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index cec682a7b88d..46fa60e7f722 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -644,7 +644,7 @@ static struct page *dummy_pcm_page(struct snd_pcm_substream *substream,
 	return virt_to_page(dummy_page[substream->stream]); /* the same page */
 }
 
-static struct snd_pcm_ops dummy_pcm_ops = {
+static const struct snd_pcm_ops dummy_pcm_ops = {
 	.open =		dummy_pcm_open,
 	.close =	dummy_pcm_close,
 	.hw_params =	dummy_pcm_hw_params,
@@ -653,7 +653,7 @@ static struct snd_pcm_ops dummy_pcm_ops = {
 	.pointer =	dummy_pcm_pointer,
 };
 
-static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
+static const struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.open =		dummy_pcm_open,
 	.close =	dummy_pcm_close,
 	.hw_params =	dummy_pcm_hw_params,
@@ -670,7 +670,7 @@ static int snd_card_dummy_pcm(struct snd_dummy *dummy, int device,
 			      int substreams)
 {
 	struct snd_pcm *pcm;
-	struct snd_pcm_ops *ops;
+	const struct snd_pcm_ops *ops;
 	int err;
 
 	err = snd_pcm_new(dummy->card, "Dummy PCM", device,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
