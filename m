Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB563C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:00:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CF4207D8
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h+oMBRQg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="wapVHtT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CF4207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03003167C;
	Fri, 12 Jun 2020 12:00:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03003167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591956050;
	bh=Fxe86MBpTdJn+EHN1AjtURIaClha1M4VT8FnSGXzj4U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+oMBRQgYNoWa/UhjnkkSaXjnm5cyMKp5jNYInj29uKV0q1sXHytpxk5naE9BwCBz
	 0OOWqhBR0dDBMDd5iudCEWHM4HXJYb2kL4hYF7S49az6HiZGdGALZJK/y/Ywj3xuIT
	 u/lnxcDV0H5BQVWNqXMSA1kqJc5OObFWN3VZJmfY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E7C2F802F9;
	Fri, 12 Jun 2020 11:55:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD716F802A1; Fri, 12 Jun 2020 11:55:43 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF5ACF802A2
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 11:55:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF5ACF802A2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="wapVHtT9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7WXVw4joOZDSAm6LdL63Tjsu6vuWWgk0atT9x8Ms8yA=; b=wapVHtT9FNGNV3oaGq1seMcan2
 6K7l1bqAOFjjTDFtxQbwLJ8q+ZanqEJ77g+3PQiKrk16ciKf32TN5Oj8WvZav+6h+r2QfL2HxUWVs
 6o3wwhApNN/zRqryibWtXU3/bWxXGRmmWD7dAx+TIdRc12Qm+jnmzf//s3gqdKNX14qibSKN+NqM9
 Bs1jpfNKrNGOtVsJi/pSjteZBxResQGKXgf37QYoIZ4RkcYvQQM6uoqZ5yibYstYsUJQSTKCtaXWj
 ObA6Mfhpp+5gVF7ALk72LkbpfqEU0Ag6yyALVArf3qQ61LcRlEkzuANjhIq1ltATA0qt9+oCc/I4B
 Sil4xaJQ==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jjgPK-000ATc-K0; Fri, 12 Jun 2020 10:55:30 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jjgPK-00013K-9C; Fri, 12 Jun 2020 10:55:30 +0100
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 9/9] pcm: Annotate the _avail functions
Date: Fri, 12 Jun 2020 10:55:30 +0100
Message-Id: <20200612095530.3970-9-mark@xwax.org>
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

I took time to understand these functions in the context of the
rest of the code, which would have been a lot quicker with a comment
like this.
---
 src/pcm/pcm_local.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index cf018fc0..aae58ed3 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -480,6 +480,13 @@ static inline int snd_pcm_check_error(snd_pcm_t *pcm, int err)
 	return err;
 }
 
+/**
+ * \retval number of frames available to the application for playback
+ *
+ * This is how far ahead the hardware position in the ring buffer is,
+ * compared to the application position. ie. for playback it's the
+ * number of frames in the empty part of the ring buffer.
+ */
 static inline snd_pcm_uframes_t __snd_pcm_playback_avail(snd_pcm_t *pcm,
 							 const snd_pcm_uframes_t hw_ptr,
 							 const snd_pcm_uframes_t appl_ptr)
@@ -498,6 +505,13 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
 	return __snd_pcm_playback_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
 }
 
+/*
+ * \retval number of frames available to the application for capture
+ *
+ * This is how far ahead the hardware position in the ring buffer is
+ * compared to the application position.  ie. for capture, it's the
+ * number of frames in the filled part of the ring buffer.
+ */
 static inline snd_pcm_uframes_t __snd_pcm_capture_avail(snd_pcm_t *pcm,
 							const snd_pcm_uframes_t hw_ptr,
 							const snd_pcm_uframes_t appl_ptr)
@@ -529,11 +543,21 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_avail(snd_pcm_t *pcm)
 	return __snd_pcm_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
 }
 
+/*
+ * \retval number of frames available to the hardware for playback
+ *
+ * ie. the filled part of the ring buffer
+ */
 static inline snd_pcm_sframes_t snd_pcm_mmap_playback_hw_avail(snd_pcm_t *pcm)
 {
 	return pcm->buffer_size - snd_pcm_mmap_playback_avail(pcm);
 }
 
+/*
+ * \retval number of frames available to the hardware for capture
+ *
+ * ie. the empty part of the ring buffer.
+ */
 static inline snd_pcm_sframes_t snd_pcm_mmap_capture_hw_avail(snd_pcm_t *pcm)
 {
 	return pcm->buffer_size - snd_pcm_mmap_capture_avail(pcm);
-- 
2.17.5

