Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB24C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:55:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE5220715
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="msQmpJP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE5220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 610971831;
	Fri, 22 Nov 2019 18:54:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 610971831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574445303;
	bh=eRf/OpqkS1LayJ6tE4oOfSWU/0ggEEAIed27TlxaPBg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msQmpJP0Ck6Hc0nfDBnUUhxn45Xd/L1fm4OMFz76al1CTD9kmjfBwcpJKoVWvnP83
	 K/OVvkaP2xY+0O0DD8XA9yYzZUrg8DMDTXkDSRU7AoGkpLXlqOD9dyTWbSQyQx/XXU
	 sRlqqk12fFvqV+x869POpsl8nlOO3udH6kRQfw0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E129EF80157;
	Fri, 22 Nov 2019 18:53:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69B81F80159; Fri, 22 Nov 2019 18:53:19 +0100 (CET)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61E08F8013F
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 18:53:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61E08F8013F
IronPort-SDR: XTC+PDTauJzQLksOhMEFskb9GRYfuuglO/upcsJqtF8HIUaxREnP1bSXWqXg3FLnNKbzyHH/2t
 eRAYYXwsQx4uvGHocLsdID9f2qzYZhM/nBMb8/rhAH8f4+HjMuqsd7bwHlRVv4x0zoAuzvg5jH
 YUyQwUFFAxrMvlycFN553ORmGS+hGOaIDEnKZv7D4PKCdNY55CpB5jGlO4q+AoFGKWMbFBDpSF
 23QZcpZ0mnGM25Rxq7kX5Ki7oB8LtKF06l7pzVzBDffCDc4NHthx4OrolTdKCP9EsN3Hu8/cI9
 g6k=
X-IronPort-AV: E=Sophos;i="5.69,230,1571731200"; d="scan'208";a="43373736"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 22 Nov 2019 09:53:15 -0800
IronPort-SDR: 2gCvD/dQEOuAHYexa/Y5xnz/L+2hxKOQnlRoNmnKdX8n+7SX1wRjZJ9js11Z1yXmCbCUJJ1RO7
 h5rdzTNVMa/xLwc0d7woUuf4VqFyQHjfNugZF4wuQXkYhtucY5g+FWXorbGYYHDzSHtO4G47vj
 nycLJlCNZt1jGZ0GG8OqmLzg2T3xBIW950ppdf4xb4hfit5QrHrlchnmgsmjddr8WAYSt+kYhH
 FTl9vhrSXQHQHPH1pT0kYZSlVP7DHdtaTqSml6MFZwLienqXlrUhqD3QyEjOTaFSbOks6Pbfil
 8tw=
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timo Wischer
 <twischer@de.adit-jv.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Fri, 22 Nov 2019 11:52:18 -0600
Message-ID: <20191122175218.17187-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122175218.17187-1-andrew_gabbasov@mentor.com>
References: <20191122175218.17187-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-09.mgc.mentorg.com (139.181.222.9) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Subject: [alsa-devel] [PATCH 2/2] ALSA: aloop: Avoid unexpected timer event
	callback tasklets
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

loopback_snd_timer_close_cable() function waits until all
scheduled tasklets are completed, but the timer is closed after that
and can generate more event callbacks, scheduling new tasklets,
that will not be synchronized with cable closing.
Move tasklet_kill() call to be executed after snd_timer_close()
call to avoid such case.

Fixes: 26c53379f98d ("ALSA: aloop: Support selection of snd_timer instead of jiffies")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 6408932f5f72..0ebfbe70db00 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -302,15 +302,16 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 	if (!cable->snd_timer.instance)
 		return 0;
 
-	/* wait till drain tasklet has finished if requested */
-	tasklet_kill(&cable->snd_timer.event_tasklet);
-
 	/* will only be called from free_cable() when other stream was
 	 * already closed. Other stream cannot be reopened as long as
 	 * loopback->cable_lock is locked. Therefore no need to lock
 	 * cable->lock;
 	 */
 	snd_timer_close(cable->snd_timer.instance);
+
+	/* wait till drain tasklet has finished if requested */
+	tasklet_kill(&cable->snd_timer.event_tasklet);
+
 	snd_timer_instance_free(cable->snd_timer.instance);
 	memset(&cable->snd_timer, 0, sizeof(cable->snd_timer));
 
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
