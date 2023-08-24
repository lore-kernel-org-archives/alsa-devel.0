Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00611C6FA8F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:23:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBE78850;
	Fri, 25 Aug 2023 00:22:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBE78850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692915820;
	bh=Rsq6LbokrG9yUrvfrk9XViqSiyr+gDuK1fhNac0AhKM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hq2Xnh4twpLLWfcm9r4dAfmo3NuEhMwKElWrUlQk4cNHlY5mG3TExh21SRCtfznFw
	 J9t8w5D6ZAxy5faSERYkDWBtmF263jTkENA5z2C6iMjZVj5rj0nq7XGV6XjQU+wiko
	 xUZV1v03qydaEY7ienhcnps2L1eQITmWha5eQMz8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D5C9F80564; Thu, 24 Aug 2023 23:33:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D144AF8055A;
	Thu, 24 Aug 2023 23:33:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0543F80553; Thu, 24 Aug 2023 23:33:38 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6259BF8023B
	for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2023 23:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6259BF8023B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TT6gDkQa
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso3007275ad.3
        for <alsa-devel@alsa-project.org>;
 Thu, 24 Aug 2023 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692912807; x=1693517607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3uKbFFBfhWdvtp+fEuTUhhcE3DTbcQhgoCyma8Q9dY=;
        b=TT6gDkQaaqRsw4pTa7K9yz+bW53OC66qGLfu3wPcxEv4IiqpbCf5kwETe0dvXoic1G
         lmIVl5iYxN8r/2pYh6gL36G2HXrAxuFl72ALTaZhvFWI+FJNKoyZ+/Ie+Hb2H5PKVe7U
         wqCppoDrPMhvZnkP0evagPWo5wxWuOvEWtXuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912807; x=1693517607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3uKbFFBfhWdvtp+fEuTUhhcE3DTbcQhgoCyma8Q9dY=;
        b=DSOxd8LlxyrIMXM08WtSuiJ7ZydM4H7QqToRjVk44norBsHemcH8zQ3reizIYZycyZ
         rRNaI+9XQ/ZvdU6c/9jSXmWfUuzEmuplVsZL0JYubZzycyDVzlHC6mSlp8TYvby+uN/k
         sDFGm6qz+URJOLCYgpNZVq3f2oJEAWJWks5bfI/akY6g3GSxum03ad7W2/KQIEoMmPKG
         GSQNLpQOrvt/nf3gxCZN96ThnF9kdO+AMLFx2Ivb2A3KFiyWeCYFxgfmMPBhuRCFUS/L
         FRzMzmheFqH2L8II7BZ0sRhcghXNcWp+cIsB0y2AsUMttu/V0aPRXk2vw8yQYhnY3mnL
         fpQQ==
X-Gm-Message-State: AOJu0YxP8e50hKNXUW+WGkRI7gpvNsr470seU90p1mWAi/qVBkVfDDdb
	I0Z9eM1ZiGn10t3CrvJDnrNwMd5NZteeTi5QLg==
X-Google-Smtp-Source: 
 AGHT+IH6akG48JueJnQQoVTAdzD/BP2oASFs4/vGeDs+7iy+PACQ4QplVZFV97vAOBw4BYaqzGmb+Q==
X-Received: by 2002:a17:902:c94e:b0:1c0:b17a:7554 with SMTP id
 i14-20020a170902c94e00b001c0b17a7554mr5557220pla.64.1692912807258;
        Thu, 24 Aug 2023 14:33:27 -0700 (PDT)
Received: from localhost ([2620:15c:9d:4:133d:5d74:91c4:bbb1])
        by smtp.gmail.com with UTF8SMTPSA id
 t11-20020a170902a5cb00b001bfd92ec592sm109022plq.292.2023.08.24.14.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 14:33:26 -0700 (PDT)
From: cujomalainey@chromium.org
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	ethan.geller@gmail.com,
	Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH 1/2] ucm: docs: Add EchoReferenceDev
Date: Thu, 24 Aug 2023 14:33:11 -0700
Message-ID: <20230824213312.1258499-1-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JFOBKRMOJZRQAG4D6MNC2SYIMY7BHQO2
X-Message-ID-Hash: JFOBKRMOJZRQAG4D6MNC2SYIMY7BHQO2
X-MailFrom: cujomalainey@chromium.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFOBKRMOJZRQAG4D6MNC2SYIMY7BHQO2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Curtis Malainey <cujomalainey@chromium.org>

Sometimes userspace may want to use a reference channel to cancel echos
when using video chat, this value identifies the device which carries
that channel.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index e5d4fd68..3c7c0a26 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -376,6 +376,15 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   - CaptureMicInfoFile
  *      - json file with the microphone array placement and type description
  *        (e.g. output from nhlt-dmic-info)
+ *   - EchoReferenceDev
+ *	- The name of a section device that provides some sort of reference
+ *	  to the current section device. This can be a echo taken as a
+ *	  reference or as IV data from a smart amp. The device should be
+ *	  opened immediately after this device and closed right before this
+ *	  device. This is meant to support hardware features such as smart
+ *	  amps or hardware offloaded processing where the host still needs
+ *	  to open the channel. The audio server should open the reference
+ *	  device with the same parameters it opens the source device with.
  *   - EDIDFile
  *      - Path to EDID file for HDMI devices
  *   - JackCTL
-- 
2.42.0.rc1.204.g551eb34607-goog

