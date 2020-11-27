Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D98C3E8C5
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 19:24:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DF423A6B
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MXbCK4Ep";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HePpRZtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DF423A6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51016184B;
	Fri, 27 Nov 2020 20:23:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51016184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606505057;
	bh=UA7+ZkWeZvbmJH4gGk4vR//0E4hQWF4r4+3Q/+j5qRo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MXbCK4EpfbU7smGNLbiIwocqa7EMbDzA2aLUSAH1AGPkRv4Pa/V13XR8r6MyiEpmW
	 Zy4XmrXA3YPCBqQx1njfWoe1duyk1LLSBcDg5oIohRPPxtcKxgHAzR85kOTpYppvUh
	 77ZT7TK6K8ggaXetO3AKlMp+Isr6m9ADbsoJEn/E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9C7DF8015A;
	Fri, 27 Nov 2020 20:23:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD2C3F8019D; Fri, 27 Nov 2020 20:23:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18892F800E0
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 20:23:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18892F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="HePpRZtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606505000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=FE1VeygfaaIjZiXkpb2+4qiM4KZKUB7XA3OmjLaRGCo=;
 b=HePpRZtAVswy0yE9nuYCv4kSXHxdkJ9zhqN84IuOsDfdw6+F6dU9XNCrGoatxIQ5Xkesq4
 //pu+UjeDsqYgdwzcaPJI0EQW1c4hB3oMaTc3GI5wv8YlPTy+9nBU9q59Ysli4+JhDxuc5
 ODFDHAl79euyQSMywEtNSFQTRJ06CdI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-hOQvVIK7MlCoa1FwBefI9g-1; Fri, 27 Nov 2020 14:23:18 -0500
X-MC-Unique: hOQvVIK7MlCoa1FwBefI9g-1
Received: by mail-qt1-f198.google.com with SMTP id t22so3775761qtq.2
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 11:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FE1VeygfaaIjZiXkpb2+4qiM4KZKUB7XA3OmjLaRGCo=;
 b=PRN137ox0zfAwiu6IKDitd3tduII2rinXwa99S+WAE4u2BxfMz4Kq4NJa28i3qbqhj
 z/fuOA1UKih2KdbgVYbQ952s98HNbhhEKPOkwyFS9PzkMgMzN2zaDFcFVttoPorVSAIB
 EFiW9Xy/CrGy51j5m772hdcgwgrZiNJLqs9ThePRJxpdpVIsJtem5GhHkp3gV7TvIyTb
 8DxnyUAaHFzwI7gQI4Q1rOqtWGRMb5gyZkgQYmMwoL+1vvej7d+0Ama7GEbVwek40x+q
 ekOr1G8fdYdgZuCfGmcSVVI8st0RmfVj8ZyS+dkny+vjKaXl9W0LKq8JnOWDRe/DBzfn
 mgTg==
X-Gm-Message-State: AOAM533XNq6pgf0yq2Rld2Dm+fpEN/lI55Ep/CfPh30NBbCBBAnC3mjZ
 GlhPSmwmpuQsKZJhjMqwkUgUZkV+idsFfx+YBmZwqUwyoR1/mHH1EaR7DKMlxf1+Dv9YBG7zaT7
 m5oRvqLQShjdTB8v8Cg3X4PI=
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr9740977qtr.341.1606504997738; 
 Fri, 27 Nov 2020 11:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR0qnX4kmZyDLuCqAE19U8+hDWgxoJ8eomxF1lEcQxzP9PivHfRg0Vd3CT64Ey8C9K/NDDZA==
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr9740954qtr.341.1606504997430; 
 Fri, 27 Nov 2020 11:23:17 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id 9sm7231178qkm.81.2020.11.27.11.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 11:23:16 -0800 (PST)
From: trix@redhat.com
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: remove trailing semicolon in macro definition
Date: Fri, 27 Nov 2020 11:23:12 -0800
Message-Id: <20201127192312.2861127-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Cc: Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/sound/hda_codec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 73827b7d17e0..2e8d51937acd 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -344,7 +344,7 @@ snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
 #define snd_hda_get_raw_connections(codec, nid, list, max_conns) \
 	snd_hdac_get_connections(&(codec)->core, nid, list, max_conns)
 #define snd_hda_get_num_raw_conns(codec, nid) \
-	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0);
+	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0)
 
 int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 			  const hda_nid_t **listp);
-- 
2.18.4

