Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B95C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:57:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69952081A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vC00aq1S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="upEhUZVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69952081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40107167A;
	Fri, 12 Jun 2020 11:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40107167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591955851;
	bh=UZwGWuGRF1iNmj7UUVKt/2cIy0dLT4yc3dEhsAz+gf4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vC00aq1S42Q+q0buX5yhrS0kbQWHiWXXuvoar4yY5CiaN2LS0h1WXTHSSwaX2Znnt
	 Y8U2OwS+cHSox17DDwfVHiQmozrosErjJaRdHBRpRrIXIecYQ2ytM28OQPBnRa4y7D
	 x2fPhTyiICorBJGG9XQh4Vf66OWPdGmF6JFkv5lk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74F7BF802BE;
	Fri, 12 Jun 2020 11:55:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75D9DF802A7; Fri, 12 Jun 2020 11:55:40 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A1FFF80228
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 11:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A1FFF80228
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="upEhUZVw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A6babGKHdtHIp7qLk4Bj3Mw5rOV5LnNH20rmV3FuRx0=; b=upEhUZVwXdXxWlWPrjrVFwiQY3
 WeEsFELBUQH3QYCsCGTFf5y6680sRs4lR963MavnGbJVjQp0FZ3Ag4YE/c0KrRxxUM8fVwWHF+wgH
 QKHcTWyYH3Hl/eSi68TsAWaBAkL4p9rN7I3EQtt6up6yCenE0t0jSk2Xnf+rvuuX6uWrPzlGcDlBb
 vto+RYFHqSMZs1B6KNxZwQbzLVzVbgoSH9UCmfWHhchsvBOkXMAqXnm+dd4+bbx0of2Y80yBnHggX
 Qek1xZ7qETZCP1JDQSDXCoGqXfdLpCcxFL81+fiq6NTHPxAs66kFFJxQdLG5q19ECKM/wX5xgMbMv
 ozMvTy5Q==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jjgPK-000ATX-JZ; Fri, 12 Jun 2020 10:55:30 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jjgPK-00012v-7Z; Fri, 12 Jun 2020 10:55:30 +0100
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 4/9] dsnoop: The delay presented to snd_pcm_status_delay()
 was incorrect
Date: Fri, 12 Jun 2020 10:55:25 +0100
Message-Id: <20200612095530.3970-4-mark@xwax.org>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <2006121020220.23374@stax.localdomain>
References: <2006121020220.23374@stax.localdomain>
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

This was the original bug that caused me to start looking at the
ring buffer functions.

In the API this is documented as:

  "Delay is distance between current application frame position and
   sound frame position. It's positive and less than buffer size in
   normal situation, negative on playback underrun and greater than
   buffer size on capture overrun. "

Because dsnoop was returning the buffer space available to the hardware
the return value was always quite large, and moved in the wrong
direction.

With this patch, dsnoop now gives results which are comparable to using
the "hw" device directly. My test case was with snd-echo3g (Layla3G).
---
 src/pcm/pcm_local.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 89d4125b..1fa8e61d 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -589,7 +589,7 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_playback_delay(snd_pcm_t *pcm)
 
 static inline snd_pcm_uframes_t snd_pcm_mmap_capture_delay(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_capture_hw_avail(pcm);
+	return snd_pcm_mmap_capture_avail(pcm);
 }
 
 static inline snd_pcm_sframes_t snd_pcm_mmap_delay(snd_pcm_t *pcm)
-- 
2.17.5

