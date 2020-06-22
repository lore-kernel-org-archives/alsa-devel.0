Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1EC43458
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:21:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FDE20760
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UDYBXDP5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="v8183TzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FDE20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0AB016DE;
	Mon, 22 Jun 2020 15:17:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0AB016DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592831930;
	bh=dvQIQwPtrE3Is3/5G1/W0lX7v95Je2Mj0rKDOyj4g7c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDYBXDP5nyv/2u+XYXItDpU1epJW1WjyyrDwYWsrrWxuQKhxc06LPBMulc1BU7wg1
	 6GRxG3OztSzwsKmDvhxUxUp6eTnGgobvqqYi0d6COEm4sS1nbGA3GK9IRGzVPWhDVd
	 WLE69wc2LAgk47o9ch7jxmVB4+SyWXrub+Lcuabg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0895AF802D2;
	Mon, 22 Jun 2020 15:16:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F0C4F801DB; Mon, 22 Jun 2020 15:15:35 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7990F80162
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 15:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7990F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="v8183TzI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KjxRTpjsOx14lhh+BLgwsTDvD1d6N5d26/Jt4B88mgw=; b=v8183TzIPBjsZTgaF8sMW6PLMI
 JviwD8DmQbn/loz68WZa6v20bMQOUVLMBfg1Vl2+YW1lUrLNw8n2zUpyHJvGZgFWBAlH5hVeqCJ3W
 ZO4TOgRY3pHR+Qglbu8FJBcm6zmTvrMZhVFcaS6ff/roKDTOwcjqPUh9KUzUTvADIaF0BmttZ5/AC
 +uuaJvdFRUdNzepWS8/LZBAfTwKelRdhBFOGFUrOXkM1bPbx+SpMtwe/DBB63xQDq+F87RCJmyPs+
 f+ikVAu/3bb8iuuplMZeO5Pr6ILHcNWDEGzlxI9dr8MQ0oASmW1wWD2TUspk9ITAeL6FU3PL/HZnZ
 0ts8fNXQ==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jnMI7-000BwN-IM; Mon, 22 Jun 2020 14:15:15 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jnMI7-00066D-5s; Mon, 22 Jun 2020 14:15:15 +0100
From: Mark Hills <mark@xwax.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 6/9] dsnoop: The stop threshold was not implemented correctly
Date: Mon, 22 Jun 2020 14:15:12 +0100
Message-Id: <20200622131515.23385-6-mark@xwax.org>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <2006221356390.20421@stax.localdomain>
References: <2006221356390.20421@stax.localdomain>
Cc: alsa-devel@alsa-project.org
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

The previous implementation would mean that stop_threshold behaved
erratically. The intent is to detect that the buffer is too full,
and stop.

In practice, I don't think this was a bug in practice for applications
which don't adjust the stop_threshold. The line above catches those cases.

Signed-off-by: Mark Hills <mark@xwax.org>
---
 src/pcm/pcm_dsnoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index c64df381..790d944c 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -165,7 +165,7 @@ static int snd_pcm_dsnoop_sync_ptr(snd_pcm_t *pcm)
 	// printf("sync ptr diff = %li\n", diff);
 	if (pcm->stop_threshold >= pcm->boundary)	/* don't care */
 		return 0;
-	if ((avail = snd_pcm_mmap_capture_hw_avail(pcm)) >= pcm->stop_threshold) {
+	if ((avail = snd_pcm_mmap_capture_avail(pcm)) >= pcm->stop_threshold) {
 		gettimestamp(&dsnoop->trigger_tstamp, pcm->tstamp_type);
 		dsnoop->state = SND_PCM_STATE_XRUN;
 		dsnoop->avail_max = avail;
-- 
2.17.5

