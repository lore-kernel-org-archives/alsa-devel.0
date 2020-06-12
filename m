Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEDC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:58:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3041D20835
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JGocM5uV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="A1iZ6PEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3041D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0A9B167C;
	Fri, 12 Jun 2020 11:57:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0A9B167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591955890;
	bh=zfg2WyJ0DZ74Ei9f+F54Jxz8pIxctGaJdAdvct1tBVA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGocM5uVFF1Zoj1hcNP6t/o8emR69g+MqMDrotWdaaproAEwd8SS5t2W7F67pm1hp
	 yoqNpKmTWHF7RYdeTlg5c1mAglLmHjhg2cNiJjfbkD5KiYoJBU7XwlHoaMfMEE66om
	 +2/C9JNGngibwO/AixMtVt0xLyHYbbOeIsJtcqME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EBCEF802DB;
	Fri, 12 Jun 2020 11:55:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82146F80058; Fri, 12 Jun 2020 11:55:40 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6633F8024A
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 11:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6633F8024A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="A1iZ6PEo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lsV5MuVRMYQN26g3KXblJKqMUTI4fZ8wmu/xyqSYSxI=; b=A1iZ6PEobBceNBNPEN92oKJ3nQ
 c89SkXMwhqMVvaMLbxWuRkgsRlBvkvjSdOWEfcb8i1HgqgK/a4i2CxISCeHj/F9aK8tgB1IDxyBkM
 zvImWjftW/unsM+kuJXJGA6r+b0l5BiCHpLSKlXtYn/k/lS1xiuVIQdVViJG0AHGE3AJc6zT6FFR+
 20xdI90HSl4nzmdyuXQQBTvCYt8/g2HF7lD+/BtNPjtwTrA1bydXXSPsGaadTH8NukeaJdBNq6pep
 j+xptAO7E/jGUM/unM7A+XGV/cDMqwEV7YsgM+ptLiy8PxBtSlJ/i3aKuixhIgM0gMCLR/rymabWv
 2Ze2hS1g==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jjgPK-000ATY-Ik; Fri, 12 Jun 2020 10:55:30 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jjgPK-000130-7w; Fri, 12 Jun 2020 10:55:30 +0100
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 5/9] pcm: Annotate the _delay functions based on findings
 from the previous bug
Date: Fri, 12 Jun 2020 10:55:26 +0100
Message-Id: <20200612095530.3970-5-mark@xwax.org>
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

