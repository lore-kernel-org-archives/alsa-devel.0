Return-Path: <SRS0=1LS8=F2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E8C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 14:59:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7315A229CA
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 14:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7315A229CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41CF81725;
	Tue, 22 Dec 2020 15:58:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41CF81725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608649185;
	bh=NSz6+iByvAfYjsaQMWvCLpIU3gZpHyhHqp0N8MdDX5M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzllhQC9qf7xokOptN93gLksjh/DukU6NGgFwpXaR4Au8Svn86OInppM2j82ZBGM6
	 2fFPmxBk2yclj6ZiJQMu7sJeVgmbffzutfxBzu8d3wtU7665/VdX0ssrpdaJfg6Ps/
	 mPepDvJLkVhY+KEkaKTzA3f5U/Xcowri8C+X+cF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC403F80234;
	Tue, 22 Dec 2020 15:58:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 123D4F80264; Tue, 22 Dec 2020 15:58:08 +0100 (CET)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFCA3F80232
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 15:58:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFCA3F80232
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="Plz+/TET"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mbklorwlc4Pzgs74b9AZxhoXGQZM101QXiRy1oGM+m8=; b=Plz+/TET1vWAds7+wa3pJFQCbq
 jKU5A4PdQTLUIIgem/4tvdFtCRzsrnRDAjnOJoGWkdr3ag9IEpShm0zrcPEjMv002kdU0Y09Klew6
 OVohoEadnMijVQViFpYDHhePcJT5520/vU25eFxD+tFd0jKWuCKuh1vn6E8bSPiLakVzIa/evAJwP
 9Us/TRE200mvRYTgCYJS8/rQdIwPKIkGBPAbK9LHCPghNX0PURvwEBx8z71XkFOikCdK57CQjL3bQ
 mPnWOiOpT5xKqb7XwShHIzW6XgrgDB2OpON36+1jh2d3fZbkR5GzUuBcS14t0pVR3d+s/78GY6iOr
 /WR5z0gQ==;
Received: from c83-254-143-147.bredband.comhem.se ([83.254.143.147]
 helo=localhost.localdomain)
 by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <coding@diwic.se>)
 id 1krj6q-00FQMk-4f; Tue, 22 Dec 2020 15:57:56 +0100
From: David Henningsson <coding@diwic.se>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 1/2] pcm: Add snd_pcm_audio_tstamp_type_t constants
Date: Tue, 22 Dec 2020 15:57:27 +0100
Message-Id: <20201222145728.9368-2-coding@diwic.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145728.9368-1-coding@diwic.se>
References: <20201222145728.9368-1-coding@diwic.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: coding@diwic.se
Cc: David Henningsson <coding@diwic.se>, Alex Moon <alex.r.moon@gmail.com>
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

These are mostly a copy-paste from the kernel headers. But since functions
snd_pcm_audio_tstamp_config make use of these they should be added to the
public API as well.

Reported-by: Alex Moon <alex.r.moon@gmail.com>
Signed-off-by: David Henningsson <coding@diwic.se>
---
 include/pcm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/pcm.h b/include/pcm.h
index 5b078231..cf1eea8b 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -350,6 +350,20 @@ typedef enum _snd_pcm_tstamp_type {
 	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 } snd_pcm_tstamp_type_t;
 
+typedef enum _snd_pcm_audio_tstamp_type {
+	/**
+	 * first definition for backwards compatibility only,
+	 * maps to wallclock/link time for HDAudio playback and DEFAULT/DMA time for everything else
+	 */
+	SND_PCM_AUDIO_TSTAMP_TYPE_COMPAT = 0,
+	SND_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 1,           /**< DMA time, reported as per hw_ptr */
+	SND_PCM_AUDIO_TSTAMP_TYPE_LINK = 2,	           /**< link time reported by sample or wallclock counter, reset on startup */
+	SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE = 3,	   /**< link time reported by sample or wallclock counter, not reset on startup */
+	SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED = 4,    /**< link time estimated indirectly */
+	SND_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED = 5, /**< link time synchronized with system time */
+	SND_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
+} snd_pcm_audio_tstamp_type_t;
+
 typedef struct _snd_pcm_audio_tstamp_config {
 	/* 5 of max 16 bits used */
 	unsigned int type_requested:4;
-- 
2.25.1

