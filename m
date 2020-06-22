Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E975C4345E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:21:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7E82078E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KqMHX+L1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="tG2MOl6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7E82078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48FFF1676;
	Mon, 22 Jun 2020 15:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48FFF1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592831976;
	bh=wHyx1TGVP38dUWoAxHZ+sQRhm7kAYBZ2n11ZYYM8jO0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqMHX+L1pBGm21juUKyctisEwyy+gw6MIl9g2F1YV3PnNDCj3lQIYYXPVWvdMXvIk
	 ApituVnFndP3DTuWI+JTRsHbFZA5OAjnSOA7FCgGbcOA+jCy0hS/FCDRB1D5tgR/kz
	 GZkXEgz7KsTJ29j/SbYEG8tqcVOBg6V6+2tNy7d8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 429B1F802DF;
	Mon, 22 Jun 2020 15:16:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31658F802A9; Mon, 22 Jun 2020 15:15:35 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B24DDF80246
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 15:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B24DDF80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="tG2MOl6i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FqFcdVXAN5JBUgEknrPa10Y/3ae8nehSFUXYLeq6PEI=; b=tG2MOl6ideoIfUem/7r4VJx1je
 H7kRvrIw7ED4m4VBYN85TZQo+P0mxE52boz84cKVb1BrB90DRKUB+6WLuXvVUi2ZkvfmVut2+rRk2
 ABz7Bg2qaM1gTJE4Lvjv15V8zl0hRAcxsZONz3dMlPPGNTLkdNFnYw5giC8dBIvzs3F15zApUXPEC
 RY8yKWUudWndUVZ9hasIIylidj3u/2OiReWicy6vJR7+ezB9TlJ5N6S7zhvuHml1SiScFRDspm1sy
 lKN+DOrjFepyoWoUqoMUOuY9rcIMCoaqtcTNoDaGn8jWpiPsk9KWP36nhWnL2hLfoD1wp5S8vTIAt
 LYcqSuVQ==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jnMI7-000BwM-Hy; Mon, 22 Jun 2020 14:15:15 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jnMI7-000668-5V; Mon, 22 Jun 2020 14:15:15 +0100
From: Mark Hills <mark@xwax.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 5/9] pcm: Annotate the _delay functions based on findings from
 the previous bug
Date: Mon, 22 Jun 2020 14:15:11 +0100
Message-Id: <20200622131515.23385-5-mark@xwax.org>
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

Signed-off-by: Mark Hills <mark@xwax.org>
---
 src/pcm/pcm_local.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 1fa8e61d..cf018fc0 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -582,11 +582,17 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_hw_offset(snd_pcm_t *pcm)
 	return *pcm->hw.ptr % pcm->buffer_size;
 }
 
+/*
+ * \retval number of frames pending from application to hardware
+ */
 static inline snd_pcm_uframes_t snd_pcm_mmap_playback_delay(snd_pcm_t *pcm)
 {
 	return snd_pcm_mmap_playback_hw_avail(pcm);
 }
 
+/*
+ * \retval number of frames pending from hardware to application
+ */
 static inline snd_pcm_uframes_t snd_pcm_mmap_capture_delay(snd_pcm_t *pcm)
 {
 	return snd_pcm_mmap_capture_avail(pcm);
-- 
2.17.5

