Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEAC2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:34:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747B321835
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="md6XDt8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747B321835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B3D1696;
	Thu, 23 Jan 2020 21:33:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B3D1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579811689;
	bh=MFsa8CF7PzpzC6damTRs1SFBLc2Xl08ay8OSWDG2BFA=;
	h=In-Reply-To:References:To:From:Date:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=md6XDt8gU5Os2PkSZE0GWcFNiO6knL5U3cqr/5/xDkcWt2NwsVMXIbt/Wdtb1BIKA
	 rnLvBXM5rdHnamEINjH0C/XdubV/48lqdMAFDuYXMVmJE0pXQEQAz4dSvDQ7hmJrfO
	 SN9/6LoxcAXsKzcROXwKedwgps5cQnNvCWUfkxAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66AEAF801ED;
	Thu, 23 Jan 2020 21:33:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40BDAF8021C; Thu, 23 Jan 2020 21:33:10 +0100 (CET)
Received: from herc.mirbsd.org (herc.mirbsd.org
 [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACBA9F800BA
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 21:33:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACBA9F800BA
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
 by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 00NKWSf5025689
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 23 Jan 2020 20:32:30 GMT
Received: (from tg@localhost)
 by herc.mirbsd.org (8.14.9/8.14.5/Submit) id 00NKWSiV008357;
 Thu, 23 Jan 2020 20:32:28 GMT
Message-Id: <202001232032.00NKWSiV008357@herc.mirbsd.org>
X-Authentication-Warning: herc.mirbsd.org: tg set sender to t.glaser@tarent.de
 using -f
In-Reply-To: <alpine.DEB.2.22.394.2001232123580.6327@tglase-nb.lan.tarent.de>
References: <alpine.DEB.2.22.394.2001232123580.6327@tglase-nb.lan.tarent.de>
 <alpine.DEB.2.21.1911202147000.2011@tglase.lan.tarent.de>
 <s5hzhgpsl7b.wl-tiwai@suse.de>
 <alpine.DEB.2.21.1911211536340.23653@tglase-nb.lan.tarent.de>
 <s5hmuco3unv.wl-tiwai@suse.de>
 <157133531799.6063.9249463816269134459.reportbug@tglase.lan.tarent.de>
To: alsa-devel@alsa-project.org
From: mirabilos <t.glaser@tarent.de>
Date: Thu, 23 Jan 2020 21:20:57 +0100
Cc: 870396@bugs.debian.org
Subject: [alsa-devel] [PATCH 2/3] pcm: explicitly cast time types to types
 printf can handle
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

Signed-off-by: mirabilos <tg@debian.org>
---
 src/pcm/pcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1064044c..eb53311c 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2329,11 +2329,11 @@ int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t *out)
 {
 	assert(status);
 	snd_output_printf(out, "  state       : %s\n", snd_pcm_state_name((snd_pcm_state_t) status->state));
-	snd_output_printf(out, "  trigger_time: %ld.%06ld\n",
-			  status->trigger_tstamp.tv_sec,
-			  status->trigger_tstamp.tv_nsec / 1000);
-	snd_output_printf(out, "  tstamp      : %ld.%06ld\n",
-		status->tstamp.tv_sec, status->tstamp.tv_nsec / 1000);
+	snd_output_printf(out, "  trigger_time: %lld.%06ld\n",
+			  (long long)status->trigger_tstamp.tv_sec,
+			  (long)status->trigger_tstamp.tv_nsec / 1000L);
+	snd_output_printf(out, "  tstamp      : %lld.%06ld\n",
+		(long long)status->tstamp.tv_sec, (long)status->tstamp.tv_nsec / 1000L);
 	snd_output_printf(out, "  delay       : %ld\n", (long)status->delay);
 	snd_output_printf(out, "  avail       : %ld\n", (long)status->avail);
 	snd_output_printf(out, "  avail_max   : %ld\n", (long)status->avail_max);
-- 
2.25.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
